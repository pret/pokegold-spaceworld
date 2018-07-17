INCLUDE "constants.asm"

SECTION "data/maps/attributes/SilentHill.asm", ROMX
	map_attributes SilentHill, SILENT_HILL, NORTH | WEST | EAST
	connection north, PrinceRoute, PRINCE_ROUTE, 0, 0, 10
	connection west, Route1P1, ROUTE_1_P1, 0, 0, 9
	connection east, RouteSilentEast, ROUTE_SILENT_EAST, 0, 0, 9

SilentHill_MapEvents::
	dw $4000 ; unknown

	db 5 ; warp events
	warp_event 5, 4, 1, PLAYER_HOUSE_1F, wOverworldMapBlocks + 51
	warp_event 13, 4, 1, SILENT_HILL_POKECENTER, wOverworldMapBlocks + 55
	warp_event 3, 12, 1, SILENT_HILL_HOUSE, wOverworldMapBlocks + 114
	warp_event 14, 11, 1, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 104
	warp_event 15, 11, 2, SILENT_HILL_LAB_FRONT, wOverworldMapBlocks + 104

	db 5 ; bg events
	bg_event 8, 4, 0, 1
	bg_event 14, 4, 0, 2
	bg_event 16, 5, 0, 3
	bg_event 10, 11, 0, 4
	bg_event 6, 12, 0, 5

	db 4 ; person events
	object_event 6, 10, SPRITE_SILVER, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 6, 9, SPRITE_BLUE, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 8, 6, SPRITE_TEACHER, SLOW_STEP_DOWN, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10, 13, SPRITE_SUPER_NERD, SLOW_STEP_DOWN, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHill_Blocks:: INCBIN "maps/blk/SilentHill.blk"
