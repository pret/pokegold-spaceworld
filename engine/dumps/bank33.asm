INCLUDE "constants.asm"

SECTION "engine/dumps/bank33.asm", ROMX

QueueBattleAnimation:
	ld hl, wActiveAnimObjects
	ld e, NUM_BATTLE_ANIM_STRUCTS
.loop
	ld a, [hl]
	and a
	jr z, .done
	ld bc, BATTLEANIMSTRUCT_LENGTH
	add hl, bc
	dec e
	jr nz, .loop
	scf
	ret

.done
	ld c, l
	ld b, h
	ld hl, wLastAnimObjectIndex
	inc [hl]
	call InitBattleAnimation
	ret

DeinitBattleAnimation:
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

InitBattleAnimation:
	ld a, [wBattleObjectTempID]
	ld e, a
	ld d, 0
	ld hl, BattleAnimObjects
rept BATTLEANIMOBJ_LENGTH
	add hl, de
endr
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_INDEX
	add hl, bc
	ld a, [wLastAnimObjectIndex]
	ld [hli], a ; BATTLEANIMSTRUCT_INDEX
	ld a, [de]
	inc de
	ld [hli], a ; BATTLEANIMSTRUCT_OAMFLAGS
	ld a, [de]
	inc de
	ld [hli], a ; BATTLEANIMSTRUCT_FIX_Y
	ld a, [de]
	inc de
	ld [hli], a ; BATTLEANIMSTRUCT_FRAMESET_ID
	ld a, [de]
	inc de
	ld [hli], a ; BATTLEANIMSTRUCT_FUNCTION
	ld a, [de]
	call GetBattleAnimTileOffset
	ld [hli], a ; BATTLEANIMSTRUCT_TILEID
	ld a, [wBattleObjectTempXCoord]
	ld [hli], a ; BATTLEANIMSTRUCT_XCOORD
	ld a, [wBattleObjectTempYCoord]
	ld [hli], a ; BATTLEANIMSTRUCT_YCOORD
	xor a
	ld [hli], a ; BATTLEANIMSTRUCT_XOFFSET
	ld [hli], a ; BATTLEANIMSTRUCT_YOFFSET
	ld a, [wBattleObjectTempParam]
	ld [hli], a ; BATTLEANIMSTRUCT_PARAM
	xor a
	ld [hli], a ; BATTLEANIMSTRUCT_DURATION
	dec a
	ld [hli], a ; BATTLEANIMSTRUCT_FRAME
	xor a
	ld [hli], a ; BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	ld [hli], a ; BATTLEANIMSTRUCT_VAR1
	ld [hl], a  ; BATTLEANIMSTRUCT_VAR2
	ret

BattleAnimOAMUpdate:
	call InitBattleAnimBuffer
	call GetBattleAnimFrame
	cp oamwait_command
	jr z, .done
	cp oamdelete_command
	jr z, .delete

	push af
	ld hl, wBattleAnimTempOAMFlags
	ld a, [wBattleAnimTempFrameOAMFlags]
	xor [hl]
	and PRIORITY | Y_FLIP | X_FLIP
	ld [hl], a
	pop af

	push bc
	call GetBattleAnimOAMPointer
	ld a, [wBattleAnimTempTileID]
	add [hl] ; tile offset
	ld [wBattleAnimTempTileID], a
	inc hl
	ld a, [hli] ; oam data length
	ld c, a
	ld a, [hli] ; oam data pointer
	ld h, [hl]
	ld l, a
	ld a, [wBattleAnimOAMPointerLo]
	ld e, a
	ld d, HIGH(wShadowOAM)

.loop
	; Y Coord
	ld a, [wBattleAnimTempYCoord]
	ld b, a
	ld a, [wBattleAnimTempYOffset]
	add b
	ld b, a
	call .XFlip
	add b
	ld [de], a

	; X Coord
	inc hl
	inc de
	ld a, [wBattleAnimTempXCoord]
	ld b, a
	ld a, [wBattleAnimTempXOffset]
	add b
	ld b, a
	call .YFlip
	add b
	ld [de], a

	; Tile ID
	inc hl
	inc de
	ld a, [wBattleAnimTempTileID]
	add BATTLEANIM_BASE_TILE
	add [hl]
	ld [de], a

	; Attributes
	inc hl
	inc de
	call .UpdateAttributes
	ld [de], a

	inc hl
	inc de
	ld a, e
	ld [wBattleAnimOAMPointerLo], a
	cp LOW(wShadowOAMEnd)
	jr nc, .exit_set_carry
	dec c
	jr nz, .loop
	pop bc
	jr .done

.delete
	call DeinitBattleAnimation

.done
	and a
	ret

.exit_set_carry
	pop bc
	scf
	ret

; This and the other two subroutines below it are kind of pointless to have as subroutines,
; as they only get run once... which is likely why they were merged into the main function in the final game.
.XFlip:
	push hl
	ld a, [hl]
	ld hl, wBattleAnimTempOAMFlags
	bit OAM_Y_FLIP, [hl]
	jr z, .no_yflip
	add $8
	xor $ff
	inc a
.no_yflip
	pop hl
	ret

.YFlip:
	push hl
	ld a, [hl]
	ld hl, wBattleAnimTempOAMFlags
	bit OAM_X_FLIP, [hl]
	jr z, .no_xflip
	add $8
	xor $ff
	inc a
.no_xflip
	pop hl
	ret

.UpdateAttributes:
	ld a, [wBattleAnimTempOAMFlags]
	ld b, a
	ld a, [hl]
	xor b
	and PRIORITY | Y_FLIP | X_FLIP
	ld b, a
	ld a, [hl]
	and OBP_NUM
	or b
	ret

InitBattleAnimBuffer:
	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	ld a, [hl]

	and PRIORITY
	ld [wBattleAnimTempOAMFlags], a
	xor a
	ld [wBattleAnimTempFrameOAMFlags], a
	ld hl, BATTLEANIMSTRUCT_FIX_Y
	add hl, bc
	ld a, [hl]
	ld [wBattleAnimTempFixY], a
	ld hl, BATTLEANIMSTRUCT_TILEID
	add hl, bc
	ld a, [hli]
	ld [wBattleAnimTempTileID], a
	ld a, [hli]
	ld [wBattleAnimTempXCoord], a
	ld a, [hli]
	ld [wBattleAnimTempYCoord], a
	ld a, [hli]
	ld [wBattleAnimTempXOffset], a
	ld a, [hli]
	ld [wBattleAnimTempYOffset], a

	ldh a, [hBattleTurn]
	and a
	ret z

	ld hl, BATTLEANIMSTRUCT_OAMFLAGS
	add hl, bc
	ld a, [hl]
	ld [wBattleAnimTempOAMFlags], a
	bit BATTLEANIMSTRUCT_OAMFLAGS_FIX_COORDS_F, [hl]
	ret z

	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hli]
	ld d, a
	ld a, (-10 * TILE_WIDTH) + 4
	sub d
	ld [wBattleAnimTempXCoord], a
	ld a, [hli]
	ld d, a
	ld a, [wBattleAnimTempFixY]
	cp $ff
	jr nz, .check_kinesis_softboiled_milkdrink

	ld a, 5 * TILE_WIDTH
	add d
	jr .done

; The changes for these animations were seemingly expanded upon for the final game
.check_kinesis_softboiled_milkdrink
	sub d
.done
	ld [wBattleAnimTempYCoord], a
	ld a, [hli]
	xor $ff
	inc a
	ld [wBattleAnimTempXOffset], a
	ret

GetBattleAnimTileOffset:
	push hl
	push bc
	ld hl, wBattleAnimTileDict
	ld b, a
	ld c, NUM_BATTLEANIMTILEDICT_ENTRIES
.loop
	ld a, [hli]
	cp b
	jr z, .load
	inc hl
	dec c
	jr nz, .loop
	xor a
	jr .done

.load
	ld a, [hl]
.done
	pop bc
	pop hl
	ret

_ExecuteBGEffects:
	callfar ExecuteBGEffects
	ret

_QueueBGEffect:
	callfar QueueBGEffect
	ret

SECTION "engine/dumps/bank33.asm@ReinitBattleAnimFrameset", ROMX

ReinitBattleAnimFrameset:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], 0
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], -1
	ret

GetBattleAnimFrame:
.loop
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_frame
	dec [hl]
	call .GetPointer
	ld a, [hli]
	push af
	jr .okay

.next_frame
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	inc [hl]
	call .GetPointer
	ld a, [hli]
	cp oamrestart_command
	jr z, .restart
	cp oamend_command
	jr z, .repeat_last

	push af
	ld a, [hl]
	push hl
	and ~(Y_FLIP << 1 | X_FLIP << 1)
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a
	pop hl
.okay
	ld a, [hl]
	and Y_FLIP << 1 | X_FLIP << 1 ; The << 1 is compensated in the "oamframe" macro
	srl a
	ld [wBattleAnimTempFrameOAMFlags], a
	pop af
	ret

.repeat_last
	xor a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a

	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	dec [hl]
	dec [hl]
	jr .loop

.restart
	xor a
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], a

	dec a
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], a
	jr .loop

.GetPointer:
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, BattleAnimFrameData
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ret

GetBattleAnimOAMPointer:
	ld l, a
	ld h, 0
	ld de, BattleAnimOAMData
	add hl, hl
	add hl, hl
	add hl, de
	ret

LoadBattleAnimGFX:
	push hl
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, AnimObjGFX
	add hl, de
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	push bc
	call Request2bpp
	pop bc
	ret

BattleAnimFrameData:
	dw Frameset_HitBig

SECTION "engine/dumps/bank33.asm@Frames", ROMX

Frameset_HitBig:
	oamframe BATTLE_ANIM_OAMSET_00,  6
	oamdelete

SECTION "engine/dumps/bank33.asm@BattleAnimOamData", ROMX

INCLUDE "data/battle_anims/oam.inc"

INCLUDE "data/battle_anims/object_gfx.inc"