INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonMart1F.asm", ROMX

	map_attributes KantoCeladonMart1F, KANTO_CELADON_MART_1F, 0

KantoCeladonMart1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 13,  7, KANTO, 6, 63
	warp_event 14,  7, KANTO, 7, 64
	warp_event 15,  0, KANTO_CELADON_MART_2F, 2, 22
	warp_event  2,  0, KANTO_CELADON_ELEVATOR, 2, 16

	def_bg_events

	def_object_events
	object_event  7,  1, SPRITE_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart1F_Blocks::
INCBIN "maps/KantoCeladonMart1F.blk"
