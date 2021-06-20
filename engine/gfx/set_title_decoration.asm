INCLUDE "constants.asm"

SECTION "engine/gfx/set_title_decoration.asm", ROMX

SetTitleBGDecorationBorder:
	ld de, TitleBGDecorationBorder
	ld hl, vChars2 + $500
	lb bc, BANK(TitleBGDecorationBorder), 9
	call Request2bpp

; top row
	coord hl, 0, 8
	ld b, $50
	call .PlaceRow

; bottom row
	coord hl, 0, 16
	ld b, $54
	call .PlaceRow
	ret

.PlaceRow:
	xor a
	ld c, SCREEN_WIDTH
.loop
	and $03
	or b
	ld [hli], a
	inc a
	dec c
	jr nz, .loop
	ret

