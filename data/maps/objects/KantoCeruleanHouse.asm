INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeruleanHouse.asm", ROMX

	map_attributes KantoCeruleanHouse, KANTO_CERULEAN_HOUSE, 0

KantoCeruleanHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, KANTO, 1, 47
	warp_event  5,  7, KANTO, 1, 47

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeruleanHouse_Blocks::
INCBIN "maps/KantoCeruleanHouse.blk"
