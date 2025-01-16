INCLUDE "constants.asm"

; BattleTransitionJumptable.Jumptable indexes
DEF BATTLETRANSITION_WAVY        EQU $01
DEF BATTLETRANSITION_WIPE_UNUSED EQU $08
DEF BATTLETRANSITION_SCANLINE    EQU $0f
DEF BATTLETRANSITION_SPIN        EQU $16
DEF BATTLETRANSITION_SCATTER     EQU $1d
DEF BATTLETRANSITION_FINISH      EQU $24
DEF BATTLETRANSITION_END         EQU $80

DEF BATTLETRANSITION_BLACK EQU $ff


SECTION "engine/battle/battle_transitions.asm", ROMX

DoBattleTransition:
	ld a, %11100011
	ldh [rLCDC], a
	call .InitGFX

.loop
	ld a, [wJumptableIndex]
	bit 7, a ; BATTLETRANSITION_END?
	jr nz, .done
	call BattleTransitionJumptable
	call DelayFrame
	jr .loop

.done
	ld a, %11111111
	ldh [rBGP], a ; cut to black
	xor a
	ldh [hLCDCPointer], a
	ldh [hLYOverrideStart], a
	ldh [hLYOverrideEnd], a
	ldh [hSCY], a
	ld a, %10100011
	ldh [rLCDC], a
	ret

.InitGFX:
	farcall ReanchorBGMap_NoOAMUpdate
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
	jr z, .got_tile
	ld de, .GrayTile
.got_tile
	ld hl, vChars0 tile BATTLETRANSITION_BLACK
	ld b, BANK(@)
	ld c, 1
	call Request2bpp
	ret

.BlackTile:
rept 8
	dw `33333333
endr

.GrayTile:
rept 8
	dw `22222222
endr

BattleTransitionJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw StartTrainerBattle_DetermineWhichAnimation ; 00

	; BATTLETRANSITION_WAVY
	dw StartTrainerBattle_LoadPokeBallGraphics ; 01
	dw StartTrainerBattle_SetUpBGMap ; 02
	dw StartTrainerBattle_Flash ; 03
	dw StartTrainerBattle_Flash ; 04
	dw StartTrainerBattle_Flash ; 05
	dw StartTrainerBattle_SetUpForWavyOutro ; 06
	dw StartTrainerBattle_SineWave ; 07

	; BATTLETRANSITION_WIPE_UNUSED
	dw StartTrainerBattle_LoadPokeBallGraphics ; 08
	dw StartTrainerBattle_SetUpBGMap ; 09
	dw StartTrainerBattle_Flash ; 0a
	dw StartTrainerBattle_Flash ; 0b
	dw StartTrainerBattle_Flash ; 0c
	dw StartTrainerBattle_SetUpForWipeOutro ; 0d
	dw StartTrainerBattle_WipeOutro ; 0e

	; BATTLETRANSITION_SCANLINE
	dw StartTrainerBattle_LoadPokeBallGraphics ; 0f
	dw StartTrainerBattle_SetUpBGMap ; 10
	dw StartTrainerBattle_Flash ; 11
	dw StartTrainerBattle_Flash ; 12
	dw StartTrainerBattle_Flash ; 13
	dw StartTrainerBattle_SetUpForScanlineOutro ; 14
	dw StartTrainerBattle_Scanlines ; 15

	; BATTLETRANSITION_SPIN
	dw StartTrainerBattle_LoadPokeBallGraphics ; 16
	dw StartTrainerBattle_SetUpBGMap ; 17
	dw StartTrainerBattle_Flash ; 18
	dw StartTrainerBattle_Flash ; 19
	dw StartTrainerBattle_Flash ; 1a
	dw StartTrainerBattle_SetUpForSpinOutro ; 1b
	dw StartTrainerBattle_SpinToBlack ; 1c

	; BATTLETRANSITION_SCATTER
	dw StartTrainerBattle_LoadPokeBallGraphics ; 1d
	dw StartTrainerBattle_SetUpBGMap ; 1e
	dw StartTrainerBattle_Flash ; 1f
	dw StartTrainerBattle_Flash ; 20
	dw StartTrainerBattle_Flash ; 21
	dw StartTrainerBattle_SetUpForRandomScatterOutro ; 22
	dw StartTrainerBattle_SpeckleToBlack ; 23

	; BATTLETRANSITION_FINISH
	dw StartTrainerBattle_Finish ; 24

StartTrainerBattle_DetermineWhichAnimation:
; Picks an arbitrary animation depending on [hVBlankCounter] % 4.
	ldh a, [hVBlankCounter]
	and a, %11
	ld e, a
	ld d, 0
	ld hl, .StartingPoints
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

.StartingPoints:
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
	ld [wBattleTransitionCounter], a
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_Flash:
	call .DoFlashAnimation
	ret nc
	call StartTrainerBattle_NextScene
	ret

.DoFlashAnimation:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	inc [hl]
	srl a
	ld e, a
	ld d, 0
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
	ld [wBattleTransitionCounter], a
	scf
	ret

.pals:
	dc 3, 3, 2, 1
	dc 3, 3, 3, 2
	dc 3, 3, 3, 3
	dc 3, 3, 3, 2
	dc 3, 3, 2, 1
	dc 3, 2, 1, 0
	dc 2, 1, 0, 0
	dc 1, 0, 0, 0
	dc 0, 0, 0, 0
	dc 1, 0, 0, 0
	dc 2, 1, 0, 0
	dc 3, 2, 1, 0
	dc 0, 0, 0, 1

StartTrainerBattle_SetUpForWavyOutro:
	call StartTrainerBattle_NextScene
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hLYOverrideEnd], a
	xor a
	ld [wBattleTransitionCounter], a
	ld [wBattleTransitionSineWaveOffset], a
	ret

StartTrainerBattle_SineWave:
	ld a, [wBattleTransitionCounter]
	cp $60
	jr nc, .end
	call .DoSineWave
	ret

.end
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.DoSineWave:
	ld hl, wBattleTransitionSineWaveOffset
	ld a, [hl]
	inc [hl]
	ld hl, wBattleTransitionCounter
	ld d, [hl]
	add [hl]
	ld [hl], a
	ld a, wLYOverridesEnd - wLYOverrides
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
	add 2
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
	ld [wBattleTransitionCounter], a
	ld a, SCREEN_HEIGHT_PX + 1
	ldh [hSCY], a
	ret

StartTrainerBattle_WipeOutro:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	cp $48
	jr nc, .end
	inc [hl]
	srl a
	ld e, a
	ld d, 0
	ld hl, wLYOverrides
	add hl, de
	call .DoWipeOutro
	ret

.end
	ld a, BATTLETRANSITION_FINISH
	ld [wJumptableIndex], a
	ret

.DoWipeOutro:
	ld c, 4
	ld de, SCREEN_HEIGHT_PX / 4
	ld b, SCREEN_HEIGHT_PX + 1
.loop
	ld a, b
	sub l
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ld hl, wLYOverridesEnd + 1
	ld [hl], SCREEN_HEIGHT_PX + 1
	ret

StartTrainerBattle_SetUpForScanlineOutro:
	call StartTrainerBattle_NextScene
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ld [wBattleTransitionCounter], a
	call WipeLYOverrides
	ret

StartTrainerBattle_Scanlines:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	cp $50
	jr nc, .end
	inc [hl]
	ld e, a
	xor $ff ; switch scroll direction
	inc a
	ld d, a
	call .SplitEvenOdd
	ret

.end
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
	ld [wBattleTransitionCounter], a
	ret

StartTrainerBattle_SpinToBlack:
	xor a
	ldh [hBGMapMode], a
	ld a, [wBattleTransitionCounter]
	ld e, a
	ld d, 0
	ld hl, .spin_quadrants
rept 5
	add hl, de
endr
	ld a, [hli]
	cp -1
	jr z, .end
	ld [wBattleTransitionSpinQuadrant], a
	call .load
	ld a, 1
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	ld hl, wBattleTransitionCounter
	inc [hl]
	ret

.end
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

; quadrants
	const_def
	const UPPER_LEFT
	const UPPER_RIGHT
	const LOWER_LEFT
	const LOWER_RIGHT

; quadrant bits
DEF RIGHT_QUADRANT_F EQU 0 ; bit set in UPPER_RIGHT and LOWER_RIGHT
DEF LOWER_QUADRANT_F EQU 1 ; bit set in LOWER_LEFT and LOWER_RIGHT

.spin_quadrants:
MACRO spin_quadrant
	db \1
	dw \2
	dwcoord \3, \4
ENDM
	spin_quadrant UPPER_LEFT,  .wedge1,  1,  6
	spin_quadrant UPPER_LEFT,  .wedge2,  0,  3
	spin_quadrant UPPER_LEFT,  .wedge3,  1,  0
	spin_quadrant UPPER_LEFT,  .wedge4,  5,  0
	spin_quadrant UPPER_LEFT,  .wedge5,  9,  0
	spin_quadrant UPPER_RIGHT, .wedge5, 10,  0
	spin_quadrant UPPER_RIGHT, .wedge4, 14,  0
	spin_quadrant UPPER_RIGHT, .wedge3, 18,  0
	spin_quadrant UPPER_RIGHT, .wedge2, 19,  3
	spin_quadrant UPPER_RIGHT, .wedge1, 18,  6
	spin_quadrant LOWER_RIGHT, .wedge1, 18, 11
	spin_quadrant LOWER_RIGHT, .wedge2, 19, 14
	spin_quadrant LOWER_RIGHT, .wedge3, 18, 17
	spin_quadrant LOWER_RIGHT, .wedge4, 14, 17
	spin_quadrant LOWER_RIGHT, .wedge5, 10, 17
	spin_quadrant LOWER_LEFT,  .wedge5,  9, 17
	spin_quadrant LOWER_LEFT,  .wedge4,  5, 17
	spin_quadrant LOWER_LEFT,  .wedge3,  1, 17
	spin_quadrant LOWER_LEFT,  .wedge2,  0, 14
	spin_quadrant LOWER_LEFT,  .wedge1,  1, 11
	db -1

.load:
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
	ld [hl], BATTLETRANSITION_BLACK
	ld a, [wBattleTransitionSpinQuadrant]
	bit RIGHT_QUADRANT_F, a
	jr z, .leftside
	inc hl
	jr .okay1
.leftside
	dec hl
.okay1
	dec c
	jr nz, .loop1
	pop hl
	ld a, [wBattleTransitionSpinQuadrant]
	bit LOWER_QUADRANT_F, a
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
	ld a, [wBattleTransitionSpinQuadrant]
	bit RIGHT_QUADRANT_F, a
	jr z, .leftside2
	dec hl
	jr .okay2
.leftside2
	inc hl
.okay2
	dec c
	jr nz, .loop2
	jr .loop

.wedge1: db 2, 3, 5, 4, 9, -1
.wedge2: db 1, 1, 2, 2, 4, 2, 4, 2, 3, -1
.wedge3: db 2, 1, 3, 1, 4, 1, 4, 1, 4, 1, 3, 1, 2, 1, 1, 1, 1, -1
.wedge4: db 4, 1, 4, 0, 3, 1, 3, 0, 2, 1, 2, 0, 1, -1
.wedge5: db 4, 0, 3, 0, 3, 0, 2, 0, 2, 0, 1, 0, 1, 0, 1, -1

StartTrainerBattle_SetUpForRandomScatterOutro:
	call StartTrainerBattle_NextScene
	ld a, $10
	ld [wBattleTransitionCounter], a
	ld a, 1
	ldh [hBGMapMode], a
	ret

StartTrainerBattle_SpeckleToBlack:
	ld hl, wBattleTransitionCounter
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
	cp SCREEN_HEIGHT
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

; If the tile has already been blacked out,
; sample a new tile
	ld a, [hl]
	cp BATTLETRANSITION_BLACK
	jr z, .y_loop
	ld [hl], BATTLETRANSITION_BLACK
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
; Loading is done bit by bit
	and a
	jr z, .done
	sla a
	jr nc, .no_load
	ld [hl], BATTLETRANSITION_BLACK
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

	ld a, 1
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
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

StartTrainerBattle_DrawSineWave:
	calc_sine_wave
