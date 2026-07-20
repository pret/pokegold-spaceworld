	map_attributes Route1Gate1F, ROUTE_1_GATE_1F

Route1Gate1F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, ROUTE_2, 1, 47
	warp_event  5,  7, ROUTE_2, 2, 47
	warp_event  4,  0, OLD_CITY, 12, 14
	warp_event  5,  0, OLD_CITY, 13, 14
	warp_event  1,  0, ROUTE_1_GATE_2F, 1, 12

	def_bg_events

	def_object_events
	object_event  6,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  1,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route1Gate1F_Blocks::
INCBIN "maps/Route1Gate1F.blk"

Route1Gate1F_ScriptLoader::
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_npcids

Route1Gate1FSignPointers:
	dw MapDefaultText ;no signs
Route1Gate1F_TextPointers::
	dw Route1Gate1FText1
	dw Route1Gate1FText2

	map_generic_script

Route1Gate1FText1:
	ld hl, Route1Gate1FText1String
	call OpenTextbox
	ret

Route1Gate1FText2:
	ld hl, Route1Gate1FText2String
	call OpenTextbox
	ret

Route1Gate1FText1String:
	text "このゲートを　ぬけると"
	line "すぐに　オールドシティ　です"
	done

Route1Gate1FText2String:
	text "オールドシティには"
	line "あの　ゆうめいな"
	cont "ごじゅうのとう　が　あるの"

	para "いってみたこと　ある？"
	done
