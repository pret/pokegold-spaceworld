INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoHouse.asm", ROMX

	map_attributes FontoHouse, FONTO_HOUSE, 0

FontoHouse_MapEvents::
	dw $4000 ; unknown

	db 2 ; warp events
	warp_event 4, 7, 3, FONTO, wOverworldMapBlocks + 47
	warp_event 5, 7, 3, FONTO, wOverworldMapBlocks + 47

	db 0 ; bg events

	db 1 ; person events
	object_event 8, 4, SPRITE_GENTLEMAN, FACE_RIGHT, 0, 1, -1, -1, 0, 0, 0, 0, 0, 0

FontoHouse_Blocks::
INCBIN "maps/FontoHouse.blk"
