	map_attributes CaveMinecarts7, CAVE_MINECARTS_7

CaveMinecarts7_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts7_Blocks::
INCBIN "maps/CaveMinecarts7.blk"

	map_dummy_text_pointers_old
