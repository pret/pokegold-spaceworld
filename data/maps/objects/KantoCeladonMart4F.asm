INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonMart4F.asm", ROMX

	map_attributes KantoCeladonMart4F, KANTO_CELADON_MART_4F, 0

KantoCeladonMart4F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, KANTO_CELADON_MART_5F, 1, 21
	warp_event 15,  0, KANTO_CELADON_MART_3F, 2, 22
	warp_event  2,  0, KANTO_CELADON_ELEVATOR, 1, 16

	def_bg_events

	def_object_events
	object_event 14,  5, SPRITE_MEDIUM, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  5, SPRITE_MEDIUM, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_MEDIUM, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart4F_Blocks::
INCBIN "maps/KantoCeladonMart4F.blk"
