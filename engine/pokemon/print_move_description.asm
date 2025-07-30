INCLUDE "constants.asm"

SECTION "engine/pokemon/print_move_description.asm", ROMX

PrintMoveDescription::
	push hl
	ld hl, MoveDescriptions
	ld a, [wSelectedItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/moves/descriptions.inc"
