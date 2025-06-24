INCLUDE "constants.asm"

SECTION "data/maps/objects/StandRocketHouse1F.asm", ROMX

	map_attributes StandRocketHouse1F, STAND_ROCKET_HOUSE_1F, 0

StandRocketHouse1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, STAND, 6, 58
	warp_event  3,  7, STAND, 6, 58
	warp_event 15,  1, STAND_ROCKET_HOUSE_2F, 1, 22

	def_bg_events

	def_object_events
	object_event 11,  4, SPRITE_36, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse1F_Blocks::
INCBIN "maps/StandRocketHouse1F.blk"
