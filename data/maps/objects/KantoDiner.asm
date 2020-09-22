INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoDiner.asm", ROMX

	map_attributes KantoDiner, KANTO_DINER, 0

KantoDiner_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 16, 47
	warp_event  5,  7, KANTO, 16, 47

	def_bg_events

	def_object_events

KantoDiner_Blocks::
INCBIN "maps/KantoDiner.blk"
