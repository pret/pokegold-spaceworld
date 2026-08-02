	map_attributes Route2Gate2F, ROUTE_2_GATE_2F

	object_const_def
	object_const LASS
	object_const TWIN

Route2Gate2F_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  0, ROUTE_2_GATE_1F, 5, 13

	def_bg_events
	bg_event  1,  0, 1
	bg_event  3,  0, 2

	def_object_events
	object_event  3,  3, SPRITE_LASS, SPRITEMOVEFN_RANDOM_WALK_XY, 1, 1, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  4, SPRITE_TWIN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

Route2Gate2F_Blocks::
INCBIN "maps/Route2Gate2F.blk"

Route2Gate2F_ScriptLoader::
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_npcids

Route2Gate2FSignPointers:
	dw Route2Gate2FTextSign1
	dw Route2Gate2FTextSign2
Route2Gate2F_TextPointers::
	dw Route2Gate2FTextNPC1
	dw Route2Gate2FTextNPC2

	map_generic_script

Route2Gate2FTextNPC1:
	ld hl, Route2Gate2FTextString1
	call OpenTextbox
	ret

Route2Gate2FTextNPC2:
	ld hl, Route2Gate2FTextString2
	call OpenTextbox
	ret

Route2Gate2FTextSign1:
	ld hl, Route2Gate2FTextString3
	call OpenTextbox
	ret

Route2Gate2FTextSign2:
	ld hl, Route2Gate2FTextString4
	call OpenTextbox
	ret

Route2Gate2FTextString1:
	text "ガンテツさんって　しってる？"

	para "ガンテツさんに"
	line "きに　いられるように　なれば"
	cont "トレーナーとして　たいしたもの　よ"
	done

Route2Gate2FTextString2:
	text "あなた　かんこうで　きたの？"
	line "なら　ざんねんね"

	para "オールドシティの"
	line "ごじゅうのとう　は"
	cont "だれでも　はいれる　って"
	cont "ものじゃないわ"
	done

Route2Gate2FTextString3:
	text "<PLAYER>は"
	line "ぼうえんきょうを　のぞいた！"

	para "むむむ！"
	line "たかーい　とう　が　みえる！"
	done

Route2Gate2FTextString4:
	text "<PLAYER>は"
	line "ぼうえんきょうを　のぞいた！"

	para "むむ？"
	line "ながーい　かわ　が　みえる"
	done
