INCLUDE "constants.asm"

SECTION "engine/dumps/bank03.asm@Functionc9c1", ROMX

_Functionc9c1:
	xor a
	ld bc, $0020 ; presumably size of wCurrMapInlineTrainers
	ld hl, wCurrMapInlineTrainers
	call ByteFill
	ld de, wMap2Object
	ld a, 2 ; skip the player
.loop
	push af
	push de
	ld hl, MAPOBJECT_PALETTE
	add hl, de
	ld a, [hl]
	cp 0
	jr nz, .skip

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .skip
	call .check_inline_trainer

.skip
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.check_inline_trainer
	jp CheckInlineTrainer
