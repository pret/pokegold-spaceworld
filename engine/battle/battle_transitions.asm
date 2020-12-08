INCLUDE "constants.asm"

SECTION "engine/battle/battle_transitions.asm", ROMX

DoBattleTransition:	; 23:44be
	ld a, %11100011
	ldh [rLCDC], a
	call Func44e6

.loop	; 44c5
	ld a, [wJumptableIndex]
	bit 7, a	; BATTLETRANSITION_END?
	jr nz, .done
	call Func455d
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

Func44e6:
	callba ReanchorBGMap_NoOAMUpdate
	call UpdateSprites
	call Func450c
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
	call Func48c4
	ret

Func450c:
	ld hl, wOverworldMapBlocks
	ld bc, $28 tiles
.loop
	ld [hl], -1
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

	ld de, Data453d
	ldh a, [hOverworldFlashlightEffect]
	and a
	jr z, .skip
	ld de, Data454d
.skip
	ld hl, vChars0 tile $FF
	ld b, BANK(@)
	ld c, $01
	call Request2bpp
	ret

Data453d:
	rept 16
	db $ff
	endr

Data454d:
	rept 8
	db $00, $ff
	endr

Func455d:
	jumptable .Jumptable, wJumptableIndex

.Jumptable	; 456c
	dw Func45b6	; 00

	dw Func4865	; 01	!
	dw Func45d8	; 02
	dw Func45e2	; 03
	dw Func45e2	; 04
	dw Func45e2	; 05
	dw Func4614	; 06
	dw Func462a	; 07

	dw Func4865	; 08
	dw Func45d8	; 09
	dw Func45e2	; 0a
	dw Func45e2	; 0b
	dw Func45e2	; 0c
	dw Func465f	; 0d
	dw Func4676	; 0e

	dw Func4865	; 0f	!
	dw Func45d8	; 10
	dw Func45e2	; 11
	dw Func45e2	; 12
	dw Func45e2	; 13
	dw Func46a6	; 14
	dw Func46b5	; 15

	dw Func4865	; 16	!
	dw Func45d8	; 17
	dw Func45e2	; 18
	dw Func45e2	; 19
	dw Func45e2	; 1a
	dw Func46da	; 1b
	dw Func46e2	; 1c

	dw Func4865	; 1d	!
	dw Func45d8	; 1e
	dw Func45e2	; 1f
	dw Func45e2	; 20
	dw Func45e2	; 21
	dw Func480b	; 22
	dw Func4818	; 23

	dw Func45ca	; 24

Func45b6:
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
	db $01
	db $1D
	db $0F
	db $16

Func45ca:
	call ClearSprites
	ld a, $80	; BATTLE_TRANSITION_END
	ld [wJumptableIndex], a
	ret

Func45d3:
	ld hl, wJumptableIndex
	inc [hl]
	ret

Func45d8:
	call Func45d3
	xor a
	ld [wFlyDestination], a
	ldh [hBGMapMode], a
	ret

Func45e2:
	call Func45ea
	ret nc
	call Func45d3
	ret

Func45ea:
	ld hl, wFlyDestination
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
	ld [wFlyDestination], a
	scf
	ret
.pals
	db $f9, $fe, $ff, $fe, $f9, $e4, $90, $40, $00, $40, $90, $e4, $01

Func4614:
	call Func45d3
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hLYOverrideEnd], a
	xor a
	ld [wFlyDestination], a
	ld [wcb60], a
	ret
Func462a:
	ld a, [wFlyDestination]
	cp $60
	jr nc, .end
	call Func463b
	ret
.end
	ld a, $24
	ld [wJumptableIndex], a
	ret

Func463b:
	ld hl, wcb60
	ld a, [hl]
	inc [hl]
	ld hl, wFlyDestination
	ld d, [hl]
	add [hl]
	ld [hl], a
	ld a, SCREEN_HEIGHT_PX
	ld bc, wLYOverrides	; ly override backups?
	ld e, 0
.loop
	push af
	push de
	ld a, e
	call Func48cf
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

Func465f:
	call Func45d3
	ld a, LOW(rSCY)
	ldh [hLCDCPointer], a
	xor a
	ldh [hLYOverrideStart], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hLYOverrideEnd], a
	xor a
	ld [wFlyDestination], a
	ld a, $91
	ldh [hSCY], a
	ret

Func4676:
	ld hl, wFlyDestination
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
	ld a, $24
	ld [wJumptableIndex], a
	ret

Func4692:
	ld c, $04
	ld de, $0024
	ld b, $91
.jr4699
	ld a, b
	sub l
	ld [hl], a
	add hl, de
	dec c
	jr nz, .jr4699
	ld hl, $c691
	ld [hl], $91
	ret

Func46a6:
	call Func45d3
	ld a, $43
	ldh [hLCDCPointer], a
	xor a
	ld [wFlyDestination], a
	call Func48c4
	ret

Func46b5:
	ld hl, wFlyDestination
	ld a, [hl]
	cp $50
	jr nc, .finished
	inc [hl]
	ld e, a
	xor $ff
	inc a
	ld d, a
	call Func46cd
	ret
.finished
	ld a, $24
	ld [wJumptableIndex], a
	ret


Func46cd:
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

Func46da:
	call Func45d3
	xor a
	ld [wFlyDestination], a
	ret

Func46e2:
	xor a
	ldh [hBGMapMode], a
	ld a, [wFlyDestination]
	ld e, a
	ld d, $00
	ld hl, .data4723
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	cp -1
	jr z, .done
	ld [wcb60], a
	call .load
	ld a, $01
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	ld hl, wFlyDestination
	inc [hl]
	ret
.done
	ld a, $01
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ld a, $24
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

Func480b:
	call Func45d3
	ld a, $10
	ld [wFlyDestination], a
	ld a, $01
	ldh [hBGMapMode], a
	ret

Func4818:
	ld hl, wFlyDestination
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ld c, $0c
.loop
	push bc
	call Func4841
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
	ld a, $24
	ld [wJumptableIndex], a
	ret


Func4841:
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

Func4865:
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
	call Func45d3
	ret
.PokeBallTransition:
	db $00, $00, $03, $c0, $0f, $f0, $1f, $f8, $3f, $fc, $3f, $fc, $7e, $7e, $7c, $3e
	db $42, $42, $41, $82, $20, $04, $20, $04, $10, $08, $0c, $30, $03, $c0, $00, $00

Func48c4:
	ld hl, wLYOverrides
	xor a
	ld c, SCREEN_HEIGHT_PX
.wipe
	ld [hli], a
	dec c
	jr nz, .wipe
	ret

Func48cf:
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
