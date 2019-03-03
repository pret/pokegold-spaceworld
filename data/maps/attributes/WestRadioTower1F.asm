INCLUDE "constants.asm"

SECTION "data/maps/attributes/WestRadioTower1F.asm", ROMX
	map_attributes WestRadioTower1F, WEST_RADIO_TOWER_1F, 0

WestRadioTower1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 2, 7, 3, WEST, wOverworldMapBlocks + 42
	warp_event 3, 7, 4, WEST, wOverworldMapBlocks + 42
	warp_event 7, 0, 2, WEST_RADIO_TOWER_2F, wOverworldMapBlocks + 14

	db 2 ; bg events
	bg_event 5, 0, 0, 1
	bg_event 0, 1, 0, 2

	db 3 ; person events
	object_event 6, 6, SPRITE_RECEPTIONIST, SLOW_STEP_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 2, 3, SPRITE_SUPER_NERD, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 7, 4, SPRITE_ROCKER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

WestRadioTower1F_Blocks:: INCBIN "maps/blk/WestRadioTower1F.blk"