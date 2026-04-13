INCLUDE "constants.asm"

SECTION "data/maps/objects/FontHouse.asm", ROMX

	map_attributes FontHouse, FONT_HOUSE, 0

FontHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, FONT, 3, 47
	warp_event  5,  7, FONT, 3, 47

	def_bg_events

	def_object_events
	object_event  8,  4, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

FontHouse_Blocks::
INCBIN "maps/FontHouse.blk"
