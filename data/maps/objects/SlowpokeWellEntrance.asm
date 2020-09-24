INCLUDE "constants.asm"

SECTION "data/maps/objects/SlowpokeWellEntrance.asm", ROMX

	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE, 0

SlowpokeWellEntrance_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

SlowpokeWellEntrance_Blocks::
INCBIN "maps/SlowpokeWellEntrance.blk"
