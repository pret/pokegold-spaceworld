	map_attributes SilentHillPokecenter, SILENT_HILL_POKECENTER

SilentHillPokecenter_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  5,  7, SILENT_HILL, 2, 59
	warp_event  6,  7, SILENT_HILL, 2, 60

	def_bg_events
	bg_event 13,  1, 1

	def_object_events
	object_event  5,  1, SPRITE_NURSE, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 14,  6, SPRITE_GENTLEMAN, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_COOLTRAINER_M, SPRITEMOVEFN_RANDOM_WALK_X, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  1, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event 10,  1, SPRITE_RHYDON, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillPokecenter_Blocks::
INCBIN "maps/SilentHillPokecenter.blk"

SilentHillPokecenter_ScriptLoader::
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_script

	dw SilentHillPokecenterNPCIDs

	map_generic_npcids

SilentHillPokecenterSignPointers:
	dw SilentHillPokecenterPCText

SilentHillPokecenterPCText:
	ld hl, SilentHillPokecenterTextString1
	call OpenTextbox
	ret

SilentHillPokecenterTextString1:
	text "げんざい　ちょうせいちゅうです"
	done

SilentHillPokecenter_TextPointers::
	dw SilentHillPokecenterNPCText1
	dw SilentHillPokecenterNPCText2
	dw SilentHillPokecenterNPCText3
	dw SilentHillPokecenterNPCText4
	dw SilentHillPokecenterNPCText5

SilentHillPokecenterNPCText1:
	ld hl, SilentHillPokecenterTextString2
	call OpenTextbox
	ret

SilentHillPokecenterTextString2:
	text "もうしわけありませんが"
	line "ただいま　しゅうりちゅう　でして"

	para "かいふくは　できません"

	para "まちから　でるときは"
	line "じゅうぶんに　おきをつけ　ください"
	done

SilentHillPokecenterNPCText2:
	ld hl, SilentHillPokecenterTextString3
	call OpenTextbox
	ret

SilentHillPokecenterTextString3:
	text "あそこに　ある　パソコンは"
	line "トレーナー　だったら"
	cont "いつでも　むりょうで"
	cont "つかうことが　できるよ"
	cont "きが　きいてるよな！"
	done

SilentHillPokecenterNPCText3:
	ld hl, SilentHillPokecenterTextString4
	call OpenTextbox
	ret

SilentHillPokecenterTextString4:
	text "いま　じゅんびちゅうの"
	line "きかいは　すごいらしいよ"

	para "なんでも　ときを　こえて"
	line "ポケモンが　こうかん　できるって！"

	para "ほんとかな？"
	done

SilentHillPokecenterNPCText4:
	ld hl, SilentHillPokecenterTextString5
	call OpenTextbox
	ret

SilentHillPokecenterTextString5:
	text "こいつ　ヘルガー"
	line "いままでにない　タイプの　ポケモンさ"
	done

SilentHillPokecenterNPCText5:
	ld hl, SilentHillPokecenterTextString6
	call OpenTextbox
	ret

SilentHillPokecenterTextString6:
	text "ヘルガー『ぐるるうー"
	done
