	map_attributes SlowpokeWellEntrance, SLOWPOKE_WELL_ENTRANCE

SlowpokeWellEntrance_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

SlowpokeWellEntrance_Blocks::
INCBIN "maps/SlowpokeWellEntrance.blk"

	map_dummy_text_pointers_old
