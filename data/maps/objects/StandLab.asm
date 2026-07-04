	map_attributes StandLab, STAND_LAB

StandLab_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, STAND, 1, 42
	warp_event  4,  7, STAND, 1, 43

	def_bg_events

	def_object_events
	object_event  2,  3, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

StandLab_Blocks::
INCBIN "maps/StandLab.blk"
