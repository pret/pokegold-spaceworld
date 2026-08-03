	map_attributes OldCityPokecenterTimeMachine, OLD_CITY_POKECENTER_TIME_MACHINE
	
	object_const_def
	const OLD_CITY_POKECENTER_TIME_MACHINE_TIME_CAPSULE_RECEPTIONIST

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

OldCityPokecenterTimeMachine_ScriptLoader:
	call SetBitsForTimeCapsuleRequestIfNotLinked
	ld hl, OldCityPokecenterTimeMachineScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

	map_generic_script_pointers
	map_generic_script
	map_generic_npc_ids

OldCityPokecenterTimeMachineSignPointers:
	dw MapDefaultText

OldCityPokecenterTimeMachine_TextPointers:
	dw OldCityPokecenterTimeMachineText1

OldCityPokecenterTimeMachineText1:
	xor a
	ld [wTempByteValue], a
	callfar Link_Receptionist_Intro
	ret
