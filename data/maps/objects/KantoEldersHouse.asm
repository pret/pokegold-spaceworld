INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoEldersHouse.asm", ROMX

	map_attributes KantoEldersHouse, KANTO_ELDERS_HOUSE, 0

KantoEldersHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 23, 47
	warp_event  5,  7, KANTO, 23, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_GRANNY, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoEldersHouse_Blocks::
INCBIN "maps/KantoEldersHouse.blk"
