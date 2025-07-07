INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoRocketHouse.asm", ROMX

	map_attributes FontoRocketHouse, FONTO_ROCKET_HOUSE, 0

FontoRocketHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  7, FONTO, 1, 63
	warp_event 13,  7, FONTO, 1, 63

	def_bg_events

	def_object_events
	object_event  5,  4, SPRITE_36, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  2, SPRITE_ROCKET_F, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  2, SPRITE_36, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12,  2, SPRITE_PIDGEY, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoRocketHouse_Blocks::
INCBIN "maps/FontoRocketHouse.blk"
