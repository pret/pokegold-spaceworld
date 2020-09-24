INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoUnusedArea.asm", ROMX

	map_attributes KantoUnusedArea, KANTO_UNUSED_AREA, 0

KantoUnusedArea_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

KantoUnusedArea_Blocks::
INCBIN "maps/KantoUnusedArea.blk"
