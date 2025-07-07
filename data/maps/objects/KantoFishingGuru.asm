INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoFishingGuru.asm", ROMX

	map_attributes KantoFishingGuru, KANTO_FISHING_GURU, 0

KantoFishingGuru_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, KANTO, 28, 46
	warp_event  4,  7, KANTO, 28, 47

	def_bg_events

	def_object_events
	object_event  4,  3, SPRITE_FISHING_GURU, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoFishingGuru_Blocks::
INCBIN "maps/KantoFishingGuru.blk"
