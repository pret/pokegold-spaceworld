INCLUDE "constants.asm"

SECTION "data/maps/objects/Office3.asm", ROMX

	map_attributes Office3, OFFICE_3, 0

Office3_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Office3_Blocks::
INCBIN "maps/Office3.blk"
