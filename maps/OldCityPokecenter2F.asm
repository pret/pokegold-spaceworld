	map_attributes OldCityPokecenter2F, OLD_CITY_POKECENTER_2F

	object_const_def
	object_const 2F_TRADE_RECEPTIONIST
	object_const 2F_BATTLE_RECEPTIONIST
	object_const 2F_GRAMPS
	object_const TIME_CAPSULE_RECEPTIONIST

OldCityPokecenter2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  0,  7, OLD_CITY_POKECENTER_1F, 3, 57
	warp_event  5,  0, OLD_CITY_POKECENTER_TRADE, 1, 17
	warp_event  9,  0, OLD_CITY_POKECENTER_BATTLE, 1, 19
	warp_event 13,  2, OLD_CITY_POKECENTER_TIME_MACHINE, 1, 35

	def_bg_events
	bg_event  1,  1, 1

	def_object_events
	object_event  5,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  2, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  2,  3, SPRITE_GRAMPS, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 13,  3, SPRITE_LINK_RECEPTIONIST, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenter2F_Blocks::
INCBIN "maps/OldCityPokecenter2F.blk"

OldCityPokecenter2F_ScriptLoader:
	call SetBitsForTimeCapsuleRequestIfNotLinked
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_script
	map_generic_npcids

OldCityPokecenter2FSignPointers:
	dw MapDefaultText

OldCityPokecenter2F_TextPointers:
	dw OldCityPokecenter2FText1
	dw OldCityPokecenter2FText2
	dw OldCityPokecenter2FText3
	dw OldCityPokecenter2FText4

OldCityPokecenter2FText1:
	ld a, $01
	ld [wTempByteValue], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callfar Link_Receptionist_Intro
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText2:
	ld a, $02
	ld [wTempByteValue], a
	ld hl, wJoypadFlags
	set 5, [hl]
	callfar Link_Receptionist_Intro
	ld hl, wJoypadFlags
	res 5, [hl]
	ret

OldCityPokecenter2FText3:
	ld hl, OldCityPokecenter2FTextString3
	call OpenTextbox
	ret

OldCityPokecenter2FTextString3:
	text "おりゃ！"
	done

OldCityPokecenter2FText4:
	ld hl, OldCityPokecenter2FTextString4
	call OpenTextbox
	callfar CheckTimeCapsuleCompatibility
	jr c, .done
	ld a, OLD_CITY_POKECENTER_2F_TIME_CAPSULE_RECEPTIONIST
	call DeleteMapObject
	jr .done
; unreferenced, replaced by the above 3 lines.
	ld hl, OldCityPokecenter2FMovement1
	ld a, OLD_CITY_POKECENTER_2F_TIME_CAPSULE_RECEPTIONIST
	call LoadMovementDataPointer_KeepStateFlags
	ld hl, NULL
	nop
.done
	ret

OldCityPokecenter2FTextString4:
	text "うしろにあるのは"
	line "タイムマシンです"
	done

; Supposed to be wMovementObject, wMovementDataBank, wMovementDataAddr in order.
OldCityPokecenter2FMovementDataPointer_Old:
	db OLD_CITY_POKECENTER_2F_TIME_CAPSULE_RECEPTIONIST
	db BANK(OldCityPokecenter2FMovement1)
	dw OldCityPokecenter2FMovement1

OldCityPokecenter2FMovement1:
	slow_step RIGHT
	step_end
