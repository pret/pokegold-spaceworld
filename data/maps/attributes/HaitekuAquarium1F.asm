INCLUDE "constants.asm"

SECTION "data/maps/attributes/HaitekuAquarium1F.asm", ROMX
	map_attributes HaitekuAquarium1F, HAITEKU_AQUARIUM_1F, 0

HaitekuAquarium1F_MapEvents::
	dw $4000 ; unknown

	db 3 ; warp events
	warp_event 12, 7, 8, HAITEKU, wOverworldMapBlocks + 63
	warp_event 13, 7, 9, HAITEKU, wOverworldMapBlocks + 63
	warp_event 0, 7, 1, HAITEKU_AQUARIUM_2F, wOverworldMapBlocks + 57

	db 0 ; bg events

	db 3 ; person events
	object_event 15, 5, SPRITE_RECEPTIONIST, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 12, 2, SPRITE_YOUNGSTER, SLOW_STEP_RIGHT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 4, 5, SPRITE_LASS, FACE_UP, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0

HaitekuAquarium1F_Blocks:: INCBIN "maps/blk/HaitekuAquarium1F.blk"