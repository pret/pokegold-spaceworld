INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoGreensHouse1F.asm", ROMX

	map_attributes KantoGreensHouse1F, KANTO_GREENS_HOUSE_1F, 0

KantoGreensHouse1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, KANTO, 22, 42
	warp_event  3,  7, KANTO, 22, 42
	warp_event  7,  1, KANTO_GREENS_HOUSE_2F, 1, 14

	def_bg_events

	def_object_events
	object_event  5,  3, SPRITE_0F, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoGreensHouse1F_Blocks::
INCBIN "maps/KantoGreensHouse1F.blk"
