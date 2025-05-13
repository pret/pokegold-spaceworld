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

; Data from CC80F to CCB97 (905 bytes)
BattleAnimObjects:
	db $01, $FF, $00, $00, $01, $01, $FF, $01, $00, $01, $01, $FF, $02, $00, $01, $01
	db $90, $00, $00, $01, $01, $90, $01, $00, $01, $01, $90, $02, $00, $01, $01, $FF
	db $03, $00, $01, $01, $FF, $04, $1B, $01, $01, $FF, $05, $00, $01, $01, $FF, $06
	db $00, $01, $01, $90, $07, $09, $01, $01, $AA, $10, $10, $03, $01, $90, $0E, $04
	db $03, $01, $90, $0F, $03, $03, $01, $90, $10, $08, $03, $01, $90, $0F, $0A, $03
	db $01, $90, $11, $03, $03, $01, $90, $12, $08, $0A, $01, $90, $13, $00, $0A, $01
	db $90, $14, $01, $0A, $21, $78, $16, $0B, $06, $00, $00, $09, $12, $0B, $00, $00
	db $09, $13, $0B, $01, $90, $18, $00, $08, $01, $FF, $18, $00, $08, $01, $90, $1D
	db $06, $0C, $01, $B4, $1F, $38, $0C, $01, $90, $08, $00, $07, $01, $A0, $08, $00
	db $07, $01, $FF, $19, $07, $09, $01, $FF, $1A, $07, $09, $01, $B0, $1B, $36, $09
	db $01, $B0, $84, $36, $21, $01, $90, $21, $0C, $0D, $00, $00, $23, $0D, $0D, $01
	db $90, $24, $0E, $0E, $61, $80, $27, $0F, $04, $01, $B4, $2A, $00, $04, $01, $40
	db $2B, $11, $0F, $61, $98, $2C, $00, $10, $61, $98, $2D, $09, $10, $01, $B8, $2E
	db $00, $0A, $01, $B8, $2F, $00, $0A, $01, $B8, $30, $14, $11, $01, $90, $21, $14
	db $0D, $21, $B0, $31, $00, $05, $21, $B0, $32, $00, $05, $21, $B0, $33, $00, $05
	db $21, $90, $34, $15, $05, $21, $90, $36, $00, $05, $21, $90, $37, $03, $08, $21
	db $90, $38, $00, $05, $21, $90, $39, $03, $08, $21, $90, $3A, $16, $02, $01, $90
	db $3C, $17, $02, $21, $FF, $3E, $00, $02, $21, $FF, $3F, $00, $02, $21, $FF, $40
	db $00, $02, $21, $FF, $41, $00, $02, $21, $FF, $42, $00, $02, $01, $88, $43, $18
	db $12, $01, $88, $44, $00, $12, $21, $B8, $45, $19, $13, $21, $FF, $46, $00, $14
	db $21, $FF, $47, $00, $14, $21, $FF, $48, $1A, $14, $21, $FF, $49, $1A, $14, $21
	db $98, $4A, $01, $14, $21, $80, $4B, $00, $11, $01, $88, $4C, $1C, $12, $21, $B0
	db $4D, $1D, $15, $01, $B0, $51, $1E, $11, $21, $FF, $52, $1F, $16, $21, $FF, $54
	db $1F, $16, $21, $68, $56, $20, $06, $21, $90, $59, $21, $0E, $21, $90, $5C, $02
	db $17, $01, $90, $5D, $22, $11, $61, $88, $5F, $00, $10, $61, $88, $2D, $09, $10
	db $21, $88, $60, $00, $18, $21, $80, $60, $00, $18, $21, $50, $61, $23, $19, $01
	db $80, $63, $24, $19, $01, $80, $66, $25, $19, $01, $50, $1C, $00, $0C, $21, $A8
	db $67, $26, $1A, $21, $A8, $68, $00, $1A, $21, $90, $69, $01, $1A, $21, $90, $6D
	db $28, $19, $21, $90, $6A, $27, $1B, $00, $00, $6F, $29, $1C, $21, $48, $70, $29
	db $1C, $21, $48, $6F, $29, $1C, $21, $78, $6F, $2A, $1C, $61, $90, $71, $2B, $1D
	db $61, $90, $72, $2C, $1D, $01, $48, $73, $2D, $1E, $01, $90, $74, $06, $15, $01
	db $FF, $75, $2E, $19, $01, $90, $75, $02, $19, $01, $80, $30, $2F, $11, $01, $78
	db $76, $2A, $23, $01, $80, $77, $30, $1F, $01, $90, $77, $02, $1F, $01, $FF, $77
	db $00, $1F, $01, $80, $78, $08, $23, $21, $90, $79, $00, $1F, $01, $FF, $7A, $31
	db $11, $01, $88, $7A, $31, $11, $21, $88, $7B, $32, $20, $21, $98, $7C, $00, $04
	db $21, $80, $7D, $00, $18, $01, $80, $21, $2F, $0D, $01, $B0, $7E, $33, $12, $01
	db $80, $7F, $2F, $08, $21, $A0, $6F, $34, $1C, $21, $A0, $74, $35, $15, $21, $B0
	db $80, $33, $14, $01, $88, $81, $37, $11, $01, $88, $85, $00, $22, $01, $88, $86
	db $00, $22, $01, $90, $87, $39, $1F, $01, $80, $30, $3A, $11, $21, $90, $34, $00
	db $05, $A1, $88, $88, $3B, $13, $01, $80, $76, $25, $23, $01, $98, $10, $34, $03
	db $01, $A8, $0F, $3C, $03, $21, $68, $89, $29, $1F, $21, $B0, $8A, $00, $1F, $21
	db $80, $8C, $00, $1F, $21, $50, $8D, $00, $1F, $21, $40, $24, $40, $0E, $21, $A8
	db $8E, $41, $1F, $21, $88, $8F, $3E, $1F, $21, $88, $93, $3E, $1F, $21, $90, $97
	db $3D, $1F, $21, $90, $98, $00, $1F, $21, $90, $78, $3D, $23, $01, $FF, $99, $2E
	db $19, $21, $A0, $74, $02, $15, $21, $A0, $99, $35, $19, $21, $70, $8B, $3F, $1F
	db $01, $90, $15, $08, $0A, $01, $90, $11, $02, $03, $01, $80, $7F, $42, $08, $01
	db $90, $9A, $00, $1B, $21, $A0, $9B, $35, $23, $21, $80, $9C, $23, $25, $21, $80
	db $9D, $25, $25, $21, $80, $9C, $00, $25, $21, $80, $9E, $00, $25, $61, $80, $9F
	db $3A, $23, $21, $80, $A0, $16, $23, $21, $70, $78, $43, $23, $21, $C0, $A2, $01
	db $25, $21, $40, $A3, $44, $24, $01, $80, $A4, $00, $24, $01, $80, $A5, $00, $24
	db $01, $88, $43, $45, $12, $21, $FF, $A6, $00, $02, $21, $FF, $A7, $00, $02, $01
	db $90, $2B, $08, $0F, $21, $90, $A8, $02, $05, $21, $40, $9C, $11, $25, $61, $90
	db $A9, $46, $23, $00, $00, $24, $47, $0E, $01, $80, $AA, $00, $24, $21, $B8, $AB
	db $48, $13, $21, $90, $AC, $44, $13, $01, $A8, $05, $00, $01, $01, $90, $24, $43
	db $0E, $01, $88, $AD, $00, $17, $01, $A8, $AE, $49, $01, $21, $90, $AF, $01, $11
	db $21, $00, $B0, $4A, $04, $00, $00, $B3, $00, $26, $00, $00, $B4, $00, $27, $00
	db $00, $B5, $00, $26, $00, $00, $B6, $00, $27

INCLUDE "engine/battle_anims/framesets.inc"
