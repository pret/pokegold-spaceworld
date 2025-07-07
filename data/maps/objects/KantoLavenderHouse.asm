INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoLavenderHouse.asm", ROMX

	map_attributes KantoLavenderHouse, KANTO_LAVENDER_HOUSE, 0

KantoLavenderHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 5, 47
	warp_event  5,  7, KANTO, 5, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_POKEFAN_M, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_POKEFAN_F, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoLavenderHouse_Blocks::
INCBIN "maps/KantoLavenderHouse.blk"
