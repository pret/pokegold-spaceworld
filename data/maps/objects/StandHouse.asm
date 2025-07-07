INCLUDE "constants.asm"

SECTION "data/maps/objects/StandHouse.asm", ROMX

	map_attributes StandHouse, STAND_HOUSE, 0

StandHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, STAND, 5, 47
	warp_event  5,  7, STAND, 5, 47

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_SUPER_NERD, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

StandHouse_Blocks::
INCBIN "maps/StandHouse.blk"
