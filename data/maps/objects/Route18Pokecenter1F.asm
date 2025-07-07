INCLUDE "constants.asm"

SECTION "data/maps/objects/Route18Pokecenter1F.asm", ROMX

	map_attributes Route18Pokecenter1F, ROUTE_18_POKECENTER_1F, 0

Route18Pokecenter1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, ROUTE_18, 3, 59
	warp_event  6,  7, ROUTE_18, 3, 60
	warp_event  0,  7, ROUTE_18_POKECENTER_2F, 1, 57

	def_bg_events

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_LASS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route18Pokecenter1F_Blocks::
INCBIN "maps/Route18Pokecenter1F.blk"
