	map_attributes NewtypeSailorHouse, NEWTYPE_SAILOR_HOUSE

NewtypeSailorHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, NEWTYPE, 4, 47
	warp_event  5,  7, NEWTYPE, 4, 47

	def_bg_events

	def_object_events
	object_event  6,  3, SPRITE_CAPTAIN, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

NewtypeSailorHouse_Blocks::
INCBIN "maps/NewtypeSailorHouse.blk"

	map_dummy_text_pointers
