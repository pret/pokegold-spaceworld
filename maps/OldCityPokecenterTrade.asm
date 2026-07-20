	map_attributes OldCityPokecenterTrade, OLD_CITY_POKECENTER_TRADE

OldCityPokecenterTrade_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, OLD_CITY_POKECENTER_2F, 2, 47
	warp_event  5,  7, OLD_CITY_POKECENTER_2F, 2, 47

	def_bg_events

	def_object_events
	object_event  3,  3, SPRITE_GOLD, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

OldCityPokecenterTrade_Blocks::
INCBIN "maps/OldCityPokecenterTrade.blk"

; unreferenced
	ret

OldCityPokecenterTrade_ScriptLoader:
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_script
	map_generic_npcids

OldCityPokecenterTradeSignPointers:
	dw MapDefaultText

OldCityPokecenterTrade_TextPointers:
	dw OldCityPokecenterTradeText1

OldCityPokecenterTradeText1:
	ld hl, wJoypadFlags
	set 5, [hl]
	ld hl, OldCityPokecenterTradeTextString1
	call OpenTextbox
	ld hl, wJoypadFlags
	res 5, [hl]
	callfar StartLinkCommunications
	ret

OldCityPokecenterTradeTextString1:
	text "ちょっとまってね！@"
	text_exit
	text_exit
	text_exit
	text_end
