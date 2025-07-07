INCLUDE "constants.asm"

SECTION "data/maps/objects/FontoLab.asm", ROMX

	map_attributes FontoLab, FONTO_LAB, 0

FontoLab_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, FONTO, 5, 46
	warp_event  4,  7, FONTO, 5, 47

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  8,  5, SPRITE_SCIENTIST, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

FontoLab_Blocks::
INCBIN "maps/FontoLab.blk"
