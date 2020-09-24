INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGreensHouse2F.asm", ROMX

	map_attributes KantoGreensHouse2F, KANTO_GREENS_HOUSE_2F, 0

KantoGreensHouse2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  7,  1, KANTO_GREENS_HOUSE_1F, 3, 14

	def_bg_events

	def_object_events

KantoGreensHouse2F_Blocks::
INCBIN "maps/KantoGreensHouse2F.blk"
