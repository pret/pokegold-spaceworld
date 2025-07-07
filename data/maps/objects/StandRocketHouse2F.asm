INCLUDE "constants.asm"

SECTION "data/maps/objects/StandRocketHouse2F.asm", ROMX

	map_attributes StandRocketHouse2F, STAND_ROCKET_HOUSE_2F, 0

StandRocketHouse2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 15,  1, STAND_ROCKET_HOUSE_1F, 3, 22

	def_bg_events

	def_object_events
	object_event  5,  4, SPRITE_ROCKET_F, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0

StandRocketHouse2F_Blocks::
INCBIN "maps/StandRocketHouse2F.blk"
