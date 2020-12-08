INCLUDE "constants.asm"

; BattleTransitionJumptable.Jumptable indexes
BATTLETRANSITION_WAVY             EQU $01
BATTLETRANSITION_WIPE             EQU $08
BATTLETRANSITION_SCANLINE         EQU $0F
BATTLETRANSITION_SPIN             EQU $16
BATTLETRANSITION_SCATTER          EQU $1D

BATTLETRANSITION_FINISH           EQU $24
BATTLETRANSITION_END              EQU $80

BATTLETRANSITION_BLACK  EQU $ff

SECTION "engine/battle/battle_transitions.asm", ROMX

DoBattleTransition:	; 23:44be
	ld a, %11100011
	ldh [rLCDC], a
	call .InitGFX

.loop	; 44c5
	ld a, [wJumptableIndex]
	bit 7, a	; BATTLETRANSITION_END?
	jr nz, .done
	call BattleTransitionJumptable
	call DelayFrame
	jr .loop

.done
	ld a, $FF
	ldh [rBGP], a	; cut to black
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ldh [hSCY], a
	ld a, %10100011
	ldh [rLCDC], a
	ret

.InitGFX:
	callba ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	call ConvertTrainerBattlePokeballTilesTo2bpp
	call WaitBGMap

	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call WipeLYOverrides
	ret

ConvertTrainerBattlePokeballTilesTo2bpp:
	ld hl, wOverworldMapBlocks
	ld bc, $28 tiles
.loop
	ld [hl], BATTLETRANSITION_BLACK
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop

	ld de, wOverworldMapBlocks
	hlbgcoord 0, 0, vBGMap0
	ld b, BANK(@)
	ld c, $28
	call Request2bpp

	ld de, .BlackTile
	ldh a, [hOverworldFlashlightEffect]
	and a
	jr z, .skip
	ld de, .GreyTile
.skip
	ld hl, vChars0 tile BATTLETRANSITION_BLACK
	ld b, BANK(@)
	ld c, $01
	call Request2bpp
	ret

.BlackTile:
	rept 16
	db $ff
	endr

.GreyTile:
	rept 8
	db $00, $ff
	endr

BattleTransitionJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable ; 456c
	dw StartTrainerBattle_DetermineWhichAnimation ; 00

; Wavy outro
	dw StartTrainerBattle_LoadPokeBallGraphics ; 01
	dw StartTrainerBattle_SetUpBGMap ; 02
	dw StartTrainerBattle_Flash ; 03
	dw StartTrainerBattle_Flash ; 04
	dw StartTrainerBattle_Flash ; 05
	dw StartTrainerBattle_SetUpForWavyOutro ; 06
	dw StartTrainerBattle_SineWave ; 07

; Wipe outro - unused
	dw StartTrainerBattle_LoadPokeBallGraphics ; 08
	dw StartTrainerBattle_SetUpBGMap ; 09
	dw StartTrainerBattle_Flash ; 0a
	dw StartTrainerBattle_Flash ; 0b
	dw StartTrainerBattle_Flash ; 0c
	dw StartTrainerBattle_SetUpForWipeOutro ; 0d
	dw StartTrainerBattle_WipeOutro ; 0e

; Scanline outro
	dw StartTrainerBattle_LoadPokeBallGraphics ; 0f
	dw StartTrainerBattle_SetUpBGMap ; 10
	dw StartTrainerBattle_Flash ; 11
	dw StartTrainerBattle_Flash ; 12
	dw StartTrainerBattle_Flash ; 13
	dw StartTrainerBattle_SetUpForScanlineOutro ; 14
	dw StartTrainerBattle_Scanlines ; 15

; Spin clockwise
	dw StartTrainerBattle_LoadPokeBallGraphics ; 16
	dw StartTrainerBattle_SetUpBGMap ; 17
	dw StartTrainerBattle_Flash ; 18
	dw StartTrainerBattle_Flash ; 19
	dw StartTrainerBattle_Flash ; 1a
	dw StartTrainerBattle_SetUpForSpinOutro ; 1b
	dw StartTrainerBattle_SpinToBlack ; 1c

; Random scatter
	dw StartTrainerBattle_LoadPokeBallGraphics ; 1d
	dw StartTrainerBattle_SetUpBGMap ; 1e
	dw StartTrainerBattle_Flash ; 1f
	dw StartTrainerBattle_Flash ; 20
	dw StartTrainerBattle_Flash ; 21
	dw StartTrainerBattle_SetUpForRandomScatterOutro ; 22
	dw StartTrainerBattle_SpeckleToBlack ; 23

	dw StartTrainerBattle_Finish ; 24

StartTrainerBattle_DetermineWhichAnimation:
	ldh a, [hVBlankCounter]
	and a, %00000011
	ld e, a
	ld d, 0
	ld hl, .StartingPoints
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.StartingPoints	;45c6
	db BATTLETRANSITION_WAVY
	db BATTLETRANSITION_SCATTER
	db BATTLETRANSITION_SCANLINE
	db BATTLETRANSITION_SPIN

StartTrainerBattle_Finish:
	call ClearSprites
	ld a, BATTLETRANSITION_END
	ld [wJumptableIndex], a
	ret

StartTrainerBattle_NextScene:
	ld hl, wJumptableIndex
	inc [hl]
	ret

StartTrainerBattle_SetUpBGMap:
	call StartTrainerBattle_NextScene
	xor a
	ld [wcb5f], a
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_Flash:
	call .DoFlashAnimation
	ret nc
	call StartTrainerBattle_NextScene
	ret

.DoFlashAnimation:
	ld hl, wcb5f
	ld a, [hl]
	inc [hl]
	srl a
	ld e, a
	ld d, $00
	ld hl, .pals
	add hl, de
	ld a, [hl]
	cp %00000001
	jr z, .done
	ldh [rBGP], a
	and a
	ret
.done
	xor a
	ld [wcb5f], a
	scf
	ret
.pals
	db $f9, $fe, $ff, $fe, $f9, $e4, $90, $40, $00, $40, $90, $e4, $01

StartTrainerBattle_SetUpForWavyOutro:
	call StartTrainerBattle_NextScene
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hLYOverrideEnd], a
	xor a
	ld [wcb5f], a
	ld [wcb60], a
	ret
StartTrainerBattle_SineWave:
	ld a, [wcb5f]
	cp $60
	jr nc, .end
	call .DoSineWave
	ret
.end
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.DoSineWave:
	ld hl, wcb60
	ld a, [hl]
	inc [hl]
	ld hl, wcb5f
	ld d, [hl]
	add [hl]
	ld [hl], a
	ld a, SCREEN_HEIGHT_PX
	ld bc, wLYOverrides
	ld e, 0
.loop
	push af
	push de
	ld a, e
	call StartTrainerBattle_DrawSineWave
	ld [bc], a
	inc bc
	pop de
	ld a, e
	add $02
	ld e, a
	pop af
	dec a
	jr nz, .loop
	ret

StartTrainerBattle_SetUpForWipeOutro:
	call StartTrainerBattle_NextScene
	ld a, LOW(rSCY)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hLYOverrideEnd], a
	xor a
	ld [wcb5f], a
	ld a, SCREEN_HEIGHT_PX + 1
	ldh [hSCY], a
	ret

StartTrainerBattle_WipeOutro:
	ld hl, wcb5f
	ld a, [hl]
	cp $48
	jr nc, .end
	inc [hl]
	srl a
	ld e, a
	ld d, $00
	ld hl, wLYOverrides
	add hl, de
	call Func4692
	ret
.end
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

Func4692:
	ld c, $04
	ld de, $0024
	ld b, $91
.loop
	ld a, b
	sub l
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ld hl, $c691
	ld [hl], $91
	ret

StartTrainerBattle_SetUpForScanlineOutro:
	call StartTrainerBattle_NextScene
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ld [wcb5f], a
	call WipeLYOverrides
	ret

StartTrainerBattle_Scanlines:
	ld hl, wcb5f
	ld a, [hl]
	cp $50
	jr nc, .finished
	inc [hl]
	ld e, a
	xor -1	; switch scroll direction
	inc a
	ld d, a
	call .SplitEvenOdd
	ret
.finished
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.SplitEvenOdd:
	ld hl, wLYOverrides
	ld c, $48
.loop
	ld [hl], e
	inc hl
	ld [hl], d
	inc hl
	dec c
	jr nz, .loop
	ret

StartTrainerBattle_SetUpForSpinOutro:
	call StartTrainerBattle_NextScene
	xor a
	ld [wcb5f], a
	ret

StartTrainerBattle_SpinToBlack:
	xor a
	ldh [hBGMapMode], a
	ld a, [wcb5f]
	ld e, a
	ld d, 0
	ld hl, .data4723
rept 5
	add hl, de
endr
	ld a, [hli]
	cp -1
	jr z, .end
	ld [wcb60], a
	call .load
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	ld hl, wcb5f
	inc [hl]
	ret
.end
	ld a, $01
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.data4723
	db $00, $cb, $47, $19, $c3
	db $00, $d1, $47, $dc, $c2
	db $00, $db, $47, $a1, $c2
	db $00, $ed, $47, $a5, $c2
	db $00, $fb, $47, $a9, $c2
	db $01, $fb, $47, $aa, $c2
	db $01, $ed, $47, $ae, $c2
	db $01, $db, $47, $b2, $c2
	db $01, $d1, $47, $ef, $c2
	db $01, $cb, $47, $2a, $c3
	db $03, $cb, $47, $8e, $c3
	db $03, $d1, $47, $cb, $c3
	db $03, $db, $47, $06, $c4
	db $03, $ed, $47, $02, $c4
	db $03, $fb, $47, $fe, $c3
	db $02, $fb, $47, $fd, $c3
	db $02, $ed, $47, $f9, $c3
	db $02, $db, $47, $f5, $c3
	db $02, $d1, $47, $b8, $c3
	db $02, $cb, $47, $7d, $c3
	db -1

.load
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop
	push hl
	ld a, [de]
	ld c, a
	inc de
.loop1
	ld [hl], $ff
	ld a, [wcb60]
	bit 0, a
	jr z, .leftside
	inc hl
	jr .okay1
.leftside
	dec hl
.okay1
	dec c
	jr nz, .loop1
	pop hl
	ld a, [wcb60]
	bit 1, a
	ld bc, SCREEN_WIDTH
	jr z, .upper
	ld bc, -SCREEN_WIDTH
.upper
	add hl, bc
	ld a, [de]
	inc de
	cp -1
	ret z
	and a
	jr z, .loop
	ld c, a
.loop2
	ld a, [wcb60]
	bit 0, a
	jr z, .leftside2
	dec hl
	jr .okay2
.leftside2
	inc hl
.okay2
	dec c
	jr nz, .loop2
	jr .loop

.wedge1 db 2, 3, 5, 4, 9, -1
.wedge2 db 1, 1, 2, 2, 4, 2, 4, 2, 3, -1
.wedge3 db 2, 1, 3, 1, 4, 1, 4, 1, 4, 1, 3, 1, 2, 1, 1, 1, 1, -1
.wedge4 db 4, 1, 4, 0, 3, 1, 3, 0, 2, 1, 2, 0, 1, -1
.wedge5 db 4, 0, 3, 0, 3, 0, 2, 0, 2, 0, 1, 0, 1, 0, 1, -1

StartTrainerBattle_SetUpForRandomScatterOutro:
	call StartTrainerBattle_NextScene
	ld a, $10
	ld [wcb5f], a
	ld a, 1
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_SpeckleToBlack:
	ld hl, wcb5f
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld c, 12
.loop
	push bc
	call .BlackOutRandomTile
	pop bc
	dec c
	jr nz, .loop
	ret

.done
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.BlackOutRandomTile:
.y_loop
	call Random
	cp $12
	jr nc, .y_loop
	ld b, a

.x_loop
	call Random
	cp SCREEN_WIDTH
	jr nc, .x_loop
	ld c, a
	hlcoord 0, -1
	ld de, SCREEN_WIDTH
	inc b

.row_loop
	add hl, de
	dec b
	jr nz, .row_loop
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .y_loop
	ld [hl], $ff
	ret

StartTrainerBattle_LoadPokeBallGraphics:
	xor a
	ldh [hBGMapMode], a
	hlcoord 2, 1
	ld de, .PokeBallTransition
	ld b, SCREEN_WIDTH - 4
.tile_loop
	push hl
	ld c, 2
.row_loop
	push hl
	ld a, [de]
	inc de
.col_loop
	and a
	jr z, .done
	sla a
	jr nc, .no_load
	ld [hl], $ff
.no_load
	inc hl
	jr .col_loop
.done
	pop hl
	push bc
	ld bc, (SCREEN_WIDTH - 4) / 2
	add hl, bc
	pop bc
	dec c
	jr nz, .row_loop
	pop hl
	push bc
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .tile_loop
	ld a, $01
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call StartTrainerBattle_NextScene
	ret
.PokeBallTransition:
	; 16x16 overlay of a Poke Ball
pusho
opt b.X ; . = 0, X = 1
	bigdw %................
	bigdw %......XXXX......
	bigdw %....XXXXXXXX....
	bigdw %...XXXXXXXXXX...
	bigdw %..XXXXXXXXXXXX..
	bigdw %..XXXXXXXXXXXX..
	bigdw %.XXXXXX..XXXXXX.
	bigdw %.XXXXX....XXXXX.
	bigdw %.X....X..X....X.
	bigdw %.X.....XX.....X.
	bigdw %..X..........X..
	bigdw %..X..........X..
	bigdw %...X........X...
	bigdw %....XX....XX....
	bigdw %......XXXX......
	bigdw %................
popo

WipeLYOverrides:
	ld hl, wLYOverrides
	xor a
	ld c, SCREEN_HEIGHT_PX
.wipe
	ld [hli], a
	dec c
	jr nz, .wipe
	ret

StartTrainerBattle_DrawSineWave:
	calc_sine_wave .sine_table
.sine_table
	dw $0000
	dw $0019
	dw $0032
	dw $004A
	dw $0062
	dw $0079
	dw $008E
	dw $00A2
	dw $00B5
	dw $00C6
	dw $00D5
	dw $00E2
	dw $00ED
	dw $00F5
	dw $00FB
	dw $00FF
	dw $0100
	dw $00FF
	dw $00FB
	dw $00F5
	dw $00ED
	dw $00E2
	dw $00D5
	dw $00C6
	dw $00B5
	dw $00A2
	dw $008E
	dw $0079
	dw $0062
	dw $004A
	dw $0032
	dw $0019
