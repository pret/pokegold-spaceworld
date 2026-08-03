	map_attributes KantoOaksLab, KANTO_OAKS_LAB

KantoOaksLab_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, KANTO, 24, 42
	warp_event  4,  7, KANTO, 25, 43

	def_bg_events

	def_object_events
	object_event  3,  2, SPRITE_NANAMI, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoOaksLab_Blocks::
INCBIN "maps/KantoOaksLab.blk"

	map_dummy_text_pointers
