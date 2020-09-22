INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonWallpaperHouse.asm", ROMX

	map_attributes BaadonWallpaperHouse, BAADON_WALLPAPER_HOUSE, 0

BaadonWallpaperHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, BAADON, 4, 42
	warp_event  3,  7, BAADON, 4, 42

	def_bg_events

	def_object_events

BaadonWallpaperHouse_Blocks::
INCBIN "maps/BaadonWallpaperHouse.blk"
