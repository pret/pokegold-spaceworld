INCLUDE "constants.asm"

SECTION "data/maps/objects/Baadon.asm", ROMX

	map_attributes Baadon, BAADON, NORTH | SOUTH | EAST
	connection north, FontoRoute4, FONTO_ROUTE_4, 0
	connection south, BaadonRoute1, BAADON_ROUTE_1, 0
	connection east, BaadonRoute2, BAADON_ROUTE_2, 0

Baadon_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  4, BAADON_MART, 1, 50
	warp_event 15,  4, BAADON_POKECENTER_1F, 1, 56
	warp_event  4,  9, BAADON_HOUSE_1, 1, 83
	warp_event  3, 13, BAADON_WALLPAPER_HOUSE, 1, 114
	warp_event  9, 13, BAADON_HOUSE_2, 1, 117
	warp_event 14, 15, BAADON_LEAGUE_1F, 1, 136
	warp_event 15, 15, BAADON_LEAGUE_1F, 2, 136
	warp_event  8,  5, FONTO_ROUTE_GATE_2, 1, 53
	warp_event  9,  5, FONTO_ROUTE_GATE_2, 2, 53

	def_bg_events
	bg_event  4,  4, 1
	bg_event 16,  4, 2
	bg_event 11, 10, 3
	bg_event  6, 14, 4

	def_object_events
	object_event 14,  8, SPRITE_SUPER_NERD, SPRITEMOVEFN_RANDOM_WALK_XY, 2, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  9, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 2, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 14, SPRITE_TWIN, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Baadon_Blocks::
INCBIN "maps/Baadon.blk"
