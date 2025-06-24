INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonMart5F.asm", ROMX

	map_attributes KantoCeladonMart5F, KANTO_CELADON_MART_5F, 0

KantoCeladonMart5F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event 13,  0, KANTO_CELADON_MART_4F, 1, 21
	warp_event  2,  0, KANTO_CELADON_ELEVATOR, 1, 16

	def_bg_events

	def_object_events
	object_event 14,  5, SPRITE_CLERK, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  3, SPRITE_RHYDON, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  5, SPRITE_PIDGEY, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoCeladonMart5F_Blocks::
INCBIN "maps/KantoCeladonMart5F.blk"
