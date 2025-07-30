INCLUDE "constants.asm"

SECTION "engine/items/update_item_description.asm", ROMX

UpdateItemDescription::
	ld a, [wMenuSelection]
	ld [wSelectedItem], a
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call DrawTextBox
	decoord 1, 14
	callfar PrintItemDescription
	ret
