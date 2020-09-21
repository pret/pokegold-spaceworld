INCLUDE "constants.asm"

SECTION "data/maps/objects/BaadonWallpaperHouse.asm", ROMX

	map_attributes BaadonWallpaperHouse, BAADON_WALLPAPER_HOUSE, 0

BaadonWallpaperHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 2, 7, 4, BAADON, wOverworldMapBlocks + 42
	warp_event 3, 7, 4, BAADON, wOverworldMapBlocks + 42

	db 0 ; bg events

	db 0 ; person events

BaadonWallpaperHouse_Blocks::
INCBIN "maps/BaadonWallpaperHouse.blk"
