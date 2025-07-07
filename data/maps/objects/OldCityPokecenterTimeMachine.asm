INCLUDE "constants.asm"

SECTION "data/maps/objects/OldCityPokecenterTimeMachine.asm", ROMX

	map_attributes OldCityPokecenterTimeMachine, OLD_CITY_POKECENTER_TIME_MACHINE, 0

OldCityPokecenterTimeMachine_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  2,  7, OLD_CITY_POKECENTER_2F, 4, 58
	warp_event  3,  7, OLD_CITY_POKECENTER_2F, 4, 58

	def_bg_events
	bg_event 15,  3, 1

	def_object_events
	object_event 13,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterTimeMachine_Blocks::
INCBIN "maps/OldCityPokecenterTimeMachine.blk"
