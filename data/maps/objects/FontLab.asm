INCLUDE "constants.asm"

SECTION "data/maps/objects/FontLab.asm", ROMX

	map_attributes FontLab, FONT_LAB, 0

FontLab_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, FONT, 5, 46
	warp_event  4,  7, FONT, 5, 47

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  5, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontLab_Blocks::
INCBIN "maps/FontLab.blk"
