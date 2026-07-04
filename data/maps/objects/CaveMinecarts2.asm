	map_attributes CaveMinecarts2, CAVE_MINECARTS_2

CaveMinecarts2_MapEvents::
	dw $0 ; unknown

	def_warp_events

	def_bg_events

	def_object_events

CaveMinecarts2_Blocks::
INCBIN "maps/CaveMinecarts2.blk"
