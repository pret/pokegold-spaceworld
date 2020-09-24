INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoCeladonElevator.asm", ROMX

	map_attributes KantoCeladonElevator, KANTO_CELADON_ELEVATOR, 0

KantoCeladonElevator_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  1,  3, KANTO_CELADON_MART_1F, 4, 17
	warp_event  2,  3, KANTO_CELADON_MART_1F, 4, 18

	def_bg_events

	def_object_events

KantoCeladonElevator_Blocks::
INCBIN "maps/KantoCeladonElevator.blk"
