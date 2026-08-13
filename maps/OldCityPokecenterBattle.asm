	map_attributes OldCityPokecenterBattle, OLD_CITY_POKECENTER_BATTLE

OldCityPokecenterBattle_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, OLD_CITY_POKECENTER_2F, 3, 47
	warp_event  5,  7, OLD_CITY_POKECENTER_2F, 3, 47

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_GOLD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterBattle_Blocks::
INCBIN "maps/PokecenterBattle.blk"

	map_generic_scriptloader
	map_generic_script_pointers
	map_generic_script
	map_generic_npc_ids

OldCityPokecenterBattleSignPointers:
	dw MapDefaultText

OldCityPokecenterBattle_TextPointers:
	dw OldCityPokecenterBattleText1

OldCityPokecenterBattleText1:
	ld hl, wJoypadDisable
	set JOYPAD_DISABLE_CLOSE_TEXTBOX_F, [hl]
	ld hl, OldCityPokecenterBattleTextString1
	call OpenTextbox
	ld hl, wJoypadDisable
	res JOYPAD_DISABLE_CLOSE_TEXTBOX_F, [hl]
	callfar StartLinkCommunications
	ret

OldCityPokecenterBattleTextString1:
	text "ちょっとまってね！@"
	text_exit
	text_end
