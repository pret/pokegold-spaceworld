	map_attributes RivalHouse, RIVAL_HOUSE

RivalHouse_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  4,  7, SILENT_HILL, 3, 47
	warp_event  5,  7, SILENT_HILL, 3, 47

	def_bg_events
	bg_event  0,  1, 1
	bg_event  4,  1, 2
	bg_event  5,  1, 3
	bg_event  9,  1, 4
	bg_event  8,  1, 5
	bg_event  2,  0, 6

	def_object_events
	object_event  5,  3, SPRITE_SILVERS_SISTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  4, SPRITE_ROCKER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

RivalHouse_Blocks::
INCBIN "maps/RivalHouse.blk"

RivalHouse_ScriptLoader::
	map_generic_scriptloader

RivalHouseScriptPointers::
	dw RivalHouseScript1
	dw RivalHouseNPCIDs1
	dw RivalHouseScript2
	dw RivalHouseNPCIDs2
	dw RivalHouseScript3
	dw RivalHouseNPCIDs1

RivalHouseScript1:
	ld hl, RivalHouseNPCIDs1
	ld de, RivalHouseTextPointers2
	call CallMapTextSubroutine
	ret

RivalHouseScript2:
	ld hl, RivalHouseNPCIDs2
	ld de, RivalHouseTextPointers2
	call CallMapTextSubroutine
	ret

RivalHouseScript3: ; This could have just been a multidefinition
	ld hl, RivalHouseNPCIDs1
	ld de, RivalHouseTextPointers2
	call CallMapTextSubroutine
	ret

RivalHouseNPCIDs1:
	db 0
	db $FF

RivalHouseNPCIDs2:
	db 0
	db 1
	db $FF

RivalHouseTextPointers2::
	dw RivalHouseNPCText1
	dw RivalHouseTVScript
	dw PokemonBooksScript
	dw RivalHouseSinkScript
	dw RivalHouseStoveScript
	dw RivalHouseWindowScript

RivalHouseNPCText1:
	CheckEvent RIVAL_HOUSE_READ_RIVAL_EMAIL
	jr nz, .jump
	ld hl, RivalHouseTextString1
	call OpenTextbox
	ret

.jump
	call ReanchorMap
	callfar PokemonCenterPC
	call CloseText
	ret

RivalHouseTextString1:
	text "おや？　<RIVAL>あてに　メールが"
	line "とどいている　ようだ"
	cont "よんでみる？@"

	start_asm
	call YesNoBox
	jr c, .jump
	SetEvent RIVAL_HOUSE_READ_RIVAL_EMAIL
	ld hl, RivalHouseTextString2
	call PrintText
	call TextAsmEnd
	ret
.jump
	ld hl, RivalHouseTextString3
	call PrintText
	call TextAsmEnd
	ret

RivalHouseTextString2:
	text "とつぜん　メールを　さしあげる"
	line "しつれいを　おゆるしあれ"

	para "じつは　きみに　どうしても"
	line "わたしたい　ものが　あるのじゃが"
	cont "うけとって　もらえんかのう"
	cont "ポケモンけんきゅうしゃ　オーキド"
	done

RivalHouseTextString3:
	text "ひとのメールは"
	line "みちゃ　いけないよな<⋯⋯>"
	done

RivalHouse_TextPointers::
	dw RivalHouseNPCText3
	dw RivalHouseNPCText4

RivalHouseNPCText3:
	ld hl, RivalHouseTextString4
	call OpenTextbox
	ret

RivalHouseTextString4:
	text "このまえ　かわったいろの"
	line "ポッポを　みかけたわ"
	done

RivalHouseNPCText4:
	CheckEvent RIVAL_HOUSE_GOT_POKEGEAR_MAP
	jr nz, .jump
	SetEvent RIVAL_HOUSE_GOT_POKEGEAR_MAP
	ld hl, RivalHouseTextString5
	call OpenTextbox
	call WaitBGMap
	ld hl, RivalHouseTextString6
	jr .skip
.jump
	ld hl, RivalHouseTextString7
.skip
	call OpenTextbox
	ret

RivalHouseTextString5:
	text "ケン『ななな"
	line "なんだ　<PLAYER>　じゃないか！"

	para "おれは　ちょっと　あのー"
	line"がっこうの　しゅくだいを"
	cont "おしえに　きてるんだ！"

	para "えっ　マップ？"
	line "そうか　そんな　やくそくも　してたな"
	cont "わかった"
	cont "トレーナーギアを　かしてみな"

	para "スロットに　マップの　カセットを　"
	line "さしこんでっと⋯⋯"
	cont "よし　これで　マップが　みれるぞ！"
	done

RivalHouseTextString6:
	text "もし　オールドにいくなら"
	line "マサキって　やつに　あうといい"

	para "おれの　ともだちで"
	line "すごい　ポケモン　マニアだ！"
	cont "きっと　おまえの"
	cont "てだすけを　してくれるぜ"
	done

RivalHouseTextString7:
	text "ケン『<PLAYER>"
	line "オーキドはかせに　みこまれて"
	cont "ポケモンずかんを　つくるんだって？"
	cont "すごいじゃないか　がんばれよ"
	done
