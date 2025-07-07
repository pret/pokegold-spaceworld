INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoHouse.asm", ROMX

	map_attributes FontoHouse, FONTO_HOUSE, 0

FontoHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, FONTO, 3, 47
	warp_event  5,  7, FONTO, 3, 47

	def_bg_events

	def_object_events
	object_event  8,  4, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_WALK_Y, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

FontoHouse_Blocks::
INCBIN "maps/FontoHouse.blk"
