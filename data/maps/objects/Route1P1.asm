INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1P1.asm", ROMX

	map_attributes Route1P1, ROUTE_1_P1, WEST | EAST
	connection west, Route1P2, ROUTE_1_P2, -3, 6, 12
	connection east, SilentHill, SILENT_HILL, 0, 0, 9

Route1P1_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 8, 8, 2, SHIZUKANA_OKA, wOverworldMapBlocks + 110
	warp_event 8, 9, 3, SHIZUKANA_OKA, wOverworldMapBlocks + 110

	db 2 ; bg events
	bg_event 12, 7, 0, 1
	bg_event 20, 8, 0, 2

	db 2 ; person events
	object_event 20, 5, SPRITE_SUPER_NERD, SLOW_STEP_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 12, SPRITE_YOUNGSTER, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Route1P1_Blocks::
INCBIN "maps/Route1P1.blk"
