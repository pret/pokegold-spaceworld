	map_attributes SlowpokeWellMain, SLOWPOKE_WELL_MAIN

SlowpokeWellMain_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

SlowpokeWellMain_Blocks::
INCBIN "maps/SlowpokeWellMain.blk"

	map_dummy_text_pointers_old
