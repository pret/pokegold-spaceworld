INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonMart3F.asm", ROMX

	map_attributes KantoCeladonMart3F, KANTO_CELADON_MART_3F, 0

KantoCeladonMart3F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, KANTO_CELADON_MART_2F, 1, 21
	warp_event 15,  0, KANTO_CELADON_MART_4F, 2, 22
	warp_event  2,  0, KANTO_CELADON_ELEVATOR, 1, 16

	def_bg_events

	def_object_events
	object_event  6,  1, SPRITE_CLERK, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  5, SPRITE_GIRL, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart3F_Blocks::
INCBIN "maps/KantoCeladonMart3F.blk"
