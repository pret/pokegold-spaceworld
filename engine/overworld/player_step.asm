INCLUDE "constants.asm"

SECTION "engine/overworld/player_step.asm", ROMX

; TODO: How does this differ from _HandlePlayerStep, aside from where it's called from?
_HandlePlayerStep_Limited:
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .start
	bit PLAYERSTEP_STOP_F, a
	jr nz, .update_player_coords
	bit PLAYERSTEP_CONTINUE_F, a
	jr nz, HandlePlayerStep_Finish
	ret

.start
	jr ._start

.unreferenced_d4fa
	call UpdatePlayerCoords
	callfar EmptyFunction8261

._start
	ld a, 4
	ld [wHandlePlayerStep], a
	ldh a, [hOverworldFlashlightEffect]
	and a
	jr nz, .update_overworld_map
	call UpdateOverworldMap_Old
	jr HandlePlayerStep_Finish

.update_overworld_map
	call UpdateOverworldMap
	jr HandlePlayerStep_Finish

.update_player_coords
	call UpdatePlayerCoords
	jr HandlePlayerStep_Finish

UpdatePlayerCoords:
	ld a, [wPlayerStepDirection]
	and a
	jr nz, .check_step_down
	ld hl, wYCoord
	inc [hl]
	ret

.check_step_down
	cp UP
	jr nz, .check_step_left
	ld hl, wYCoord
	dec [hl]
	ret

.check_step_left
	cp LEFT
	jr nz, .check_step_right
	ld hl, wXCoord
	dec [hl]
	ret

.check_step_right
	cp RIGHT
	ret nz
	ld hl, wXCoord
	inc [hl]
	ret

HandlePlayerStep_Finish:
	call HandlePlayerStep
	ld a, [wPlayerStepVectorX]
	ld d, a
	ld a, [wPlayerStepVectorY]
	ld e, a
	call ScrollNPCs
	call ScrollMinorObjects
	ldh a, [hSCX]
	add d
	ldh [hSCX], a
	ldh a, [hSCY]
	add e
	ldh [hSCY], a
	ret

ScrollNPCs:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit CENTERED_OBJECT_F, [hl]
	jr nz, .skip

	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
.skip
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

ScrollMinorObjects:
	ld bc, wMinorObjects
	ld a, 1
.loop
	ldh [hMapObjectIndex], a
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [wCenteredObject]
	inc a
	cp [hl]
	jr z, .skip
	ld hl, MINOR_OBJECT_X_POS
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, MINOR_OBJECT_Y_POS
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a

.skip
	ld hl, MINOR_OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_MINOR_OBJECTS + 1
	jr nz, .loop
	ret

HandlePlayerStep::
	ld hl, wHandlePlayerStep
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	add a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw RefreshTiles
	dw Functionc9c1
	dw BufferScreen
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail

.fail
	ret

Functionc9c1:
	callfar _Functionc9c1
	ret

UpdateOverworldMap_Old:
	ld a, [wPlayerStepDirection]
	and a ; DOWN
	jr z, .step_down
	cp UP
	jr z, .step_up
	cp LEFT
	jr z, .step_left
	cp RIGHT
	jr z, .step_right
	ret

.step_down
	call ScrollOverworldMapDown
	call LoadMapPart
	call ScheduleSouthRowRedraw
	ret

.step_up
	call ScrollOverworldMapUp
	call LoadMapPart
	call ScheduleNorthRowRedraw
	ret

.step_left
	call ScrollOverworldMapLeft
	call LoadMapPart
	call ScheduleWestColumnRedraw
	ret
	
.step_right
	call ScrollOverworldMapRight
	call LoadMapPart
	call ScheduleEastColumnRedraw
	ret

ScrollOverworldMapDown:
	ld a, [wBGMapAnchor]
	add BG_MAP_WIDTH * 2
	ld [wBGMapAnchor], a
	jr nc, .no_overflow
	ld a, [wBGMapAnchor + 1]
	inc a
	and %11
	or HIGH(vBGMap0)
	ld [wBGMapAnchor + 1], a
.no_overflow
	ld hl, wMetatileNextY
	inc [hl]
	ld a, [hl]
	cp 2
	jr nz, .done
	ld [hl], 0
	call .ScrollMapDataDown
.done
	ret

.ScrollMapDataDown:
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 3 * 2 ; surrounding tiles
	add [hl]
	ld [hli], a
	ret nc
	inc [hl]
	ret

ScrollOverworldMapUp:
	ld a, [wBGMapAnchor]
	sub BG_MAP_WIDTH * 2
	ld [wBGMapAnchor], a
	jr nc, .not_underflowed
	ld a, [wBGMapAnchor+1]
	dec a
	and %11
	or HIGH(vBGMap0)
	ld [wBGMapAnchor+1], a
.not_underflowed
	ld hl, wMetatileNextY
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done_up
	ld [hl], 1
	call .ScrollMapDataUp
.done_up
	ret

.ScrollMapDataUp:
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 3 * 2
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ret nc
	dec [hl]
	ret

ScrollOverworldMapLeft:
	ld a, [wBGMapAnchor]
	ld e, a
	and ~(BG_MAP_WIDTH - 1)
	ld d, a
	ld a, e
	sub 2
	maskbits BG_MAP_WIDTH - 1
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done_left
	ld [hl], 1
	call .ScrollMapDataLeft
.done_left
	ret

.ScrollMapDataLeft:
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	sub 1
	ld [hli], a
	ret nc
	dec [hl]
	ret

ScrollOverworldMapRight:
	ld a, [wBGMapAnchor]
	ld e, a
	and ~(BG_MAP_WIDTH - 1)
	ld d, a
	ld a, e
	add 2
	maskbits BG_MAP_WIDTH - 1
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	inc [hl]
	ld a, [hl]
	cp 2
	jr nz, .done_right
	ld [hl], $00
	call .ScrollMapDataRight
.done_right
	ret

.ScrollMapDataRight:
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	add 1
	ld [hli], a
	ret nc
	inc [hl]
	ret

_HandlePlayerStep:
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .update_overworld_map
	bit PLAYERSTEP_STOP_F, a
	jr nz, .update_player_coords
	bit PLAYERSTEP_CONTINUE_F, a
	jp nz, HandlePlayerStep_Finish
	ret

.update_overworld_map
	ld a, 4
	ld [wHandlePlayerStep], a
	call UpdateOverworldMap
	jp HandlePlayerStep_Finish

.update_player_coords
	call UpdatePlayerCoords
	jp HandlePlayerStep_Finish

UpdateOverworldMap:
	ld a, [wPlayerStepDirection]
	and a
	jr z, .step_down
	cp UP
	jr z, .step_up
	cp LEFT
	jr z, .step_left
	cp RIGHT
	jr z, .step_right
	ret

.step_down
	call ScrollOverworldMapDown
	call LoadMapPart
	ld a, 2
	call ScrollOverworldFlashlight
	ret
.step_up
	call ScrollOverworldMapUp
	call LoadMapPart
	ld a, 1
	call ScrollOverworldFlashlight
	ret
.step_left
	call ScrollOverworldMapLeft
	call LoadMapPart
	ld a, 3
	call ScrollOverworldFlashlight
	ret
.step_right
	call ScrollOverworldMapRight
	call LoadMapPart
	ld a, 4
	call ScrollOverworldFlashlight
	ret

ScrollOverworldFlashlight::
	push af
	call .GetFlashlightVariables
	call .GetFlashlightSize
	pop af
	add 2
	ldh [hRedrawRowOrColumnMode], a
	ret

.GetFlashlightVariables:
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ldh a, [hOverworldFlashlightEffect]
	dec a
	swap a  ; * 16
	sla a   ; *  2
	ld e, a
	ld d, 0
	add hl, de
	ld de, .FlashlightColumns
	add hl, de
	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightDst0], a
	ld a, d
	ld [wRedrawFlashlightDst0 + 1], a

	call .GetFlashlightSrc
	ld a, e
	ld [wRedrawFlashlightSrc0], a
	ld a, d
	ld [wRedrawFlashlightSrc0 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightBlackDst0], a
	ld a, d
	ld [wRedrawFlashlightBlackDst0 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightDst1], a
	ld a, d
	ld [wRedrawFlashlightDst1 + 1], a

	call .GetFlashlightSrc
	ld a, e
	ld [wRedrawFlashlightSrc1], a
	ld a, d
	ld [wRedrawFlashlightSrc1 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightBlackDst1], a
	ld a, d
	ld [wRedrawFlashlightBlackDst1 + 1], a
	ret

; The positions of the columns drawn.
; TODO: Wrap these in neat macros.
.FlashlightColumns:
	db $02, $03, $02, $11, $02, $02, $02, $10 ; up
	db $02, $0e, $02, $00, $02, $0f, $02, $01 ; down
	db $03, $02, $11, $02, $02, $02, $10, $02 ; left
	db $0e, $02, $00, $02, $0f, $02, $01, $02 ; right

	db $04, $05, $04, $0f, $04, $04, $04, $0e
	db $04, $0c, $04, $02, $04, $0d, $04, $03
	db $05, $04, $0f, $04, $04, $04, $0e, $04
	db $0c, $04, $02, $04, $0d, $04, $03, $04

	db $06, $07, $06, $0d, $06, $06, $06, $0c
	db $06, $0a, $06, $04, $06, $0b, $06, $05
	db $07, $06, $0d, $06, $06, $06, $0c, $06
	db $0a, $06, $04, $06, $0b, $06, $05, $06

	db $08, $09, $08, $0b, $08, $08, $08, $0a
	db $08, $08, $08, $06, $08, $09, $08, $07
	db $09, $08, $0b, $08, $08, $08, $0a, $08
	db $08, $08, $06, $08, $09, $08, $07, $08

.ReadFlashlightDst:
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	push hl
	push bc
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
.row_loop
	ld a, BG_MAP_WIDTH
	add e
	ld e, a
	jr nc, .no_overflow
	inc d
.no_overflow
	ld a, d
	and %11
	or HIGH(vBGMap0) ; equivalent of add $98
	ld d, a
	dec b
	jr nz, .row_loop
.tile_loop
	ld a, e
	inc a
	maskbits BG_MAP_WIDTH - 1 ; only works if BG_MAP_WIDTH is 2^n
	ld b, a
	ld a, e
	and ~(BG_MAP_WIDTH - 1)
	or b
	ld e, a
	dec c
	jr nz, .tile_loop
	pop bc
	pop hl
	ret

.GetFlashlightSrc:
	push hl
	ld hl, wTileMap
	ld de, SCREEN_WIDTH
.loop
	ld a, b
	and a
	jr z, .last_row
	add hl, de
	dec b
	jr .loop

.last_row
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ret

.GetFlashlightSize:
	ldh a, [hOverworldFlashlightEffect]
	dec a
	ld l, a
	ld h, 0
	ld de, .Sizes
	add hl, de
	ld a, [hl]
	ld [wRedrawFlashlightWidthHeight], a
	ret

.Sizes:
	db 7, 5, 3, 1
