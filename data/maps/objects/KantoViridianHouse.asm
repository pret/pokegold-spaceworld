INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoViridianHouse.asm", ROMX

	map_attributes KantoViridianHouse, KANTO_VIRIDIAN_HOUSE, 0

KantoViridianHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 13, 47
	warp_event  5,  7, KANTO, 13, 47

	def_bg_events

	def_object_events
	object_event  7,  3, SPRITE_BUG_CATCHER_BOY, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  5, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoViridianHouse_Blocks::
INCBIN "maps/KantoViridianHouse.blk"
