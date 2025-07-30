INCLUDE "constants.asm"

SECTION "engine/items/print_item_description.asm", ROMX

PrintItemDescription::
	push de
	ld hl, ItemDescriptions
	ld a, [wSelectedItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/items/descriptions.inc"