INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoRedsHouse.asm", ROMX

	map_attributes KantoRedsHouse, KANTO_REDS_HOUSE, 0

KantoRedsHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 21, 47
	warp_event  5,  7, KANTO, 21, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_SUPER_NERD, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_TEACHER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoRedsHouse_Blocks::
INCBIN "maps/KantoRedsHouse.blk"
