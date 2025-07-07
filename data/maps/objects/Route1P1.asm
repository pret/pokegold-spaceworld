INCLUDE "constants.asm"

SECTION "data/maps/objects/Route1P1.asm", ROMX

	map_attributes Route1P1, ROUTE_1_P1, WEST | EAST
	connection west, Route1P2, ROUTE_1_P2, -9
	connection east, SilentHill, SILENT_HILL, 0

Route1P1_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  8,  8, SHIZUKANA_OKA, 2, 110
	warp_event  8,  9, SHIZUKANA_OKA, 3, 110

	def_bg_events
	bg_event 12,  7, 1
	bg_event 20,  8, 2

	def_object_events
	object_event 20,  5, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 18, 12, SPRITE_YOUNGSTER, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

Route1P1_Blocks::
INCBIN "maps/Route1P1.blk"
