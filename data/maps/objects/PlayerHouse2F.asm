INCLUDE "constants.asm"

SECTION "data/maps/objects/PlayerHouse2F.asm", ROMX

	map_attributes PlayerHouse2F, PLAYER_HOUSE_2F, 0

PlayerHouse2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  9,  0, PLAYER_HOUSE_1F, 3, 16

	def_bg_events
	bg_event  1,  1, 1
	bg_event  2,  1, 2
	bg_event  3,  1, 3
	bg_event  5,  1, 4
	bg_event  7,  2, 5

	def_object_events
	object_event  8,  1, SPRITE_ROCKER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  1, SPRITE_CLEFAIRY, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse2F_Blocks::
INCBIN "maps/PlayerHouse2F.blk"
