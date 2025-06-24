INCLUDE "constants.asm"

SECTION "data/maps/objects/SugarHouse.asm", ROMX

	map_attributes SugarHouse, SUGAR_HOUSE, 0

SugarHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3, 15, SUGAR, 1, 82
	warp_event  4, 15, SUGAR, 1, 83

	def_bg_events

	def_object_events
	object_event  3,  5, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  4,  5, SPRITE_TWIN, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  1, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SugarHouse_Blocks::
INCBIN "maps/SugarHouse.blk"
