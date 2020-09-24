INCLUDE "constants.asm"

SECTION "data/maps/objects/Office2.asm", ROMX

	map_attributes Office2, OFFICE_2, 0

Office2_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Office2_Blocks::
INCBIN "maps/Office2.blk"
