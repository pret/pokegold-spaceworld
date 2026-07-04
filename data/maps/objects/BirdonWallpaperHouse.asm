	map_attributes BirdonWallpaperHouse, BIRDON_WALLPAPER_HOUSE

BirdonWallpaperHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, BIRDON, 4, 42
	warp_event  3,  7, BIRDON, 4, 42

	def_bg_events

	def_object_events

BirdonWallpaperHouse_Blocks::
INCBIN "maps/BirdonWallpaperHouse.blk"
