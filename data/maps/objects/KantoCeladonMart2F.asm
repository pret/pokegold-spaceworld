INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonMart2F.asm", ROMX

	map_attributes KantoCeladonMart2F, KANTO_CELADON_MART_2F, 0

KantoCeladonMart2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 12,  0, KANTO_CELADON_MART_3F, 1, 21
	warp_event 15,  0, KANTO_CELADON_MART_1F, 3, 22
	warp_event  2,  0, KANTO_CELADON_ELEVATOR, 1, 16

	def_bg_events

	def_object_events
	object_event 14,  5, SPRITE_CLERK, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  5, SPRITE_LASS, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart2F_Blocks::
INCBIN "maps/KantoCeladonMart2F.blk"
