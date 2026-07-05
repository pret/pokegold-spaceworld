PrintMonTypes::
; Print one or both types of [wCurSpecies]
; on the stats screen at hl.

	push hl
	call GetBaseData
	pop hl

	push hl
	ld a, [wMonHType1]
	call .Print

	ld a, [wMonHType1]
	ld b, a
	ld a, [wMonHType2]
	cp b
	pop hl
	jr z, .hide_type_2
	ld bc, SCREEN_WIDTH * 2
	add hl, bc

.Print
	push hl
	jr PrintType

.hide_type_2
	ld a, '　'
	ld bc, SCREEN_WIDTH - 3
	add hl, bc
	ld [hl], a
	inc bc
	add hl, bc
	ld bc, PLAYER_NAME_LENGTH - 1
	jp ByteFill

PrintMoveType::
; Print the type of move b at hl.

	push hl
	ld a, b
	dec a
	ld bc, MOVE_LENGTH
	ld hl, Moves
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	ld a, [wStringBuffer1 + MOVE_TYPE]

PrintType::
; Print type a to stack pointer.
	add a
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl

	jp PlaceString

GetTypeName::
; Copy the name of type [wMoveGrammar] to wStringBuffer1.

	ld a, [wMoveGrammar]
	ld hl, TypeNames
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld bc, TYPE_NAME_LENGTH
	jp CopyBytes

INCLUDE "data/types/names.asm"
