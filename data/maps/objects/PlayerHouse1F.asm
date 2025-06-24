INCLUDE "constants.asm"

SECTION "data/maps/objects/PlayerHouse1F.asm", ROMX

	map_attributes PlayerHouse1F, PLAYER_HOUSE_1F, 0

PlayerHouse1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6,  7, SILENT_HILL, 1, 48
	warp_event  7,  7, SILENT_HILL, 1, 48
	warp_event  9,  0, PLAYER_HOUSE_2F, 1, 16

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  4,  1, 4
	bg_event  5,  1, 5

	def_object_events
	object_event  7,  3, SPRITE_MOM, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

PlayerHouse1F_Blocks::
INCBIN "maps/PlayerHouse1F.blk"
