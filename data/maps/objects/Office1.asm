INCLUDE "constants.asm"

SECTION "data/maps/objects/Office1.asm", ROMX

	map_attributes Office1, OFFICE_1, 0

Office1_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

Office1_Blocks::
INCBIN "maps/Office1.blk"
