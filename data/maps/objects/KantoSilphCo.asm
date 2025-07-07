INCLUDE "constants.asm"

SECTION "data/maps/objects/KantoSilphCo.asm", ROMX

	map_attributes KantoSilphCo, KANTO_SILPH_CO, 0

KantoSilphCo_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  6, 15, KANTO, 11, 148
	warp_event  7, 15, KANTO, 12, 148

	def_bg_events

	def_object_events
	object_event  2,  2, SPRITE_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 22,  1, SPRITE_OFFICER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

KantoSilphCo_Blocks::
INCBIN "maps/KantoSilphCo.blk"
