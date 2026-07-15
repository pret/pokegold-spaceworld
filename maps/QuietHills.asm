	map_attributes QuietHills, QUIET_HILLS

QuietHills_MapEvents::
	dw $4000 ; unknown

	object_const_def
	object_const ROCKER
	object_const 2F_BATTLE_RECEPTIONIST
	object_const 2F_GRAMPS
	object_const TIME_CAPSULE_RECEPTIONIST

	def_warp_events
	warp_event 49, 28, ROUTE_1, 1, 490
	warp_event 49, 29, ROUTE_1, 1, 490
	warp_event 49, 30, ROUTE_1, 2, 521
	warp_event 49, 31, ROUTE_1, 2, 521
	warp_event  4,  0, ROUTE_2, 3, 34
	warp_event  5,  0, ROUTE_2, 3, 34
	warp_event  6,  0, ROUTE_2, 3, 35
	warp_event  7,  0, ROUTE_2, 4, 35
	warp_event  8,  0, ROUTE_2, 4, 36
	warp_event  9,  0, ROUTE_2, 4, 36

	def_bg_events
	bg_event  9,  2, 1
	bg_event 47, 28, 2

	def_object_events
	object_event 41, 28, SPRITE_ROCKER, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  9,  7, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event 41, 19, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_LEFT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0
	object_event 27, 14, SPRITE_FISHER, SPRITEMOVEFN_RANDOM_SPIN, 0, 0, -1, -1, 0, 0, 0, 2, 0, 0
	object_event 36, 16, SPRITE_TEACHER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 5, 0, 0
	object_event  9, 25, SPRITE_YOUNGSTER, SPRITEMOVEFN_TURN_RIGHT, 0, 0, -1, -1, 0, 0, 0, 4, 0, 0

QuietHills_Blocks::
INCBIN "maps/QuietHills.blk"

QuietHills_ScriptLoader::
	map_generic_scriptloader
	map_generic_scriptpointers
	map_generic_npcids

QuietHillsSignPointers:
	dw QuietHillsSignpost1
	dw QuietHillsSignpost2

QuietHills_TextPointers:
	dw QuietHillsText1
	dw QuietHillsTrainer2
	dw QuietHillsTrainer3
	dw QuietHillsTrainer4
	dw QuietHillsTrainer5
	dw QuietHillsTrainer6

	map_generic_script

QuietHillsText1:
	ld hl, QuietHillsText1String
	call OpenTextbox
	ret

QuietHillsTrainer2:
	ld hl, wQuietHillsFlags
	bit 1, [hl]
	jr nz, .Trainer2Won
	ld hl, QuietHillsTrainer2EncounterString
	call OpenTextbox
	ld hl, wQuietHillsFlags
	set 1, [hl]
if DEF(_GOLD)
	ld a, TRAINER_SCHOOLBOY
	ld [wOtherTrainerClass], a
	ld a, SCHOOLBOY_TETSUYA
endc
if DEF(_SILVER)
	ld a, TRAINER_SPORTSMAN
	ld [wOtherTrainerClass], a
	ld a, SPORTSMAN_TETSUJI
endc
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer2Won ;Already won
	ld hl, QuietHillsTrainer2WonString
	call OpenTextbox
	ret

QuietHillsTrainer3:
	ld hl, wQuietHillsFlags
	bit 2, [hl]
	jr nz, .Trainer3Won
	ld hl, QuietHillsTrainer3EncounterString
	call OpenTextbox
	ld hl, wQuietHillsFlags
	set 2, [hl]
if DEF(_GOLD)
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_JUNICHI
endc
if DEF(_SILVER)
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_KEN
endc
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer3Won ;Already won
	ld hl, QuietHillsTrainer3WonString
	call OpenTextbox
	ret

QuietHillsTrainer4:
	ld hl, wQuietHillsFlags
	bit 3, [hl]
	jr nz, .Trainer4Won
	ld hl, QuietHillsTrainer4EncounterString
	call OpenTextbox
	ld hl, wQuietHillsFlags
	set 3, [hl]
if DEF(_GOLD)
	ld a, TRAINER_FIREBREATHER
	ld [wOtherTrainerClass], a
	ld a, FIREBREATHER_AKITO
endc
if DEF(_SILVER)
	ld a, TRAINER_FISHER
	ld [wOtherTrainerClass], a
	ld a, FISHER_HISASHI
endc
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer4Won ;Already won
	ld hl, QuietHillsTrainer4WonString
	call OpenTextbox
	ret

QuietHillsTrainer5:
	ld hl, wQuietHillsFlags
	bit 4, [hl]
	jr nz, .Trainer5Won
	ld hl, QuietHillsTrainer5EncounterString
	call OpenTextbox
	ld hl, wQuietHillsFlags
	set 4, [hl]
if DEF(_GOLD)
	ld a, TRAINER_BEAUTY
	ld [wOtherTrainerClass], a
	ld a, BEAUTY_MEGUMI
endc
if DEF(_SILVER)
	ld a, TRAINER_LASS
	ld [wOtherTrainerClass], a
	ld a, LASS_HIZUKI
endc
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer5Won ;Already won
	ld hl, QuietHillsTrainer5WonString
	call OpenTextbox
	ret

QuietHillsTrainer6:
	ld hl, wQuietHillsFlags
	bit 5, [hl]
	jr nz, .Trainer6Won
	ld hl, QuietHillsTrainer6EncounterString
	call OpenTextbox
	ld hl, wQuietHillsFlags
	set 5, [hl]
if DEF(_GOLD)
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_SOUSUKE
endc
if DEF(_SILVER)
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_KENJI
endc
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer6Won ;Already won
	ld hl, QuietHillsTrainer6WonString
	call OpenTextbox
	ret

QuietHillsSignpost2:
	ld hl, QuietHillsSignpost2String
	call OpenTextbox
	ret

QuietHillsSignpost1:
	ld hl, QuietHillsSignpost1String
	call OpenTextbox
	ret

if DEF(_GOLD)

QuietHillsTrainer6EncounterString:
	text "ねえ　ねえ　みてよ"

	para "これ　ぜったい"
	line "しんしゅの　ポケモン　だよ！"
	done

	text "まだ　ポケモンの　とくちょう"
	line "わかってないから　しかたないよ"
	done

QuietHillsTrainer6WonString:
	text "あたらしい　ポケモンだけでなく"
	line "あたらしい　タイプも"
	cont "みつかったって　うわさだよ"
	done

QuietHillsTrainer5EncounterString:
	text "いい　てんきねー"
	line "あなた　ちょうしは　いかが？"
	done

	text "なにするニャー"
	line "⋯⋯なにいってるのかしら　あたし"
	done

QuietHillsTrainer5WonString:
	text "なんで　こうなるの？"
	line "さんぽしてた　だけなのに@@"

QuietHillsTrainer4EncounterString:
	text "こんなところで"
	line "ひを　ふく　れんしゅう！"
	done

	text "あちち　しっぱいだー"
	done

QuietHillsTrainer4WonString:
	text "よるになると　くらくなるから"
	line "こどもは　はやく　かえりなさい！"

	para "おれ？"
	line "おれは　ひをふくから　だいじょうぶ"
	done

QuietHillsTrainer3EncounterString:
	text "むしポケモンの　ことなら"
	line "だれよりも　くわしいよ"
	done

	text "パラパラー"
	done

QuietHillsTrainer3WonString:
	text "ポケモンずかんを　つくるんだって？"
	line "ちょっと　みせてよ"

	para "へー"
	line "タイプべつに　ポケモン　さがせるんだ"
	done

QuietHillsTrainer2EncounterString:
	text "いっとくけど"
	line "きみよりも　べんきょう　してるから"
	cont "きみよりも　つよいよ　ぜったい！"
	done

	text "な　なぜなんだ？"
	done

QuietHillsTrainer2WonString:
	text "おかしいよ⋯⋯"
	line "まいにち　ポケモンの　べんきょうを"
	cont "きちんと　してるのに　まけるなんて"
	done

endc

if DEF(_SILVER)

QuietHillsTrainer6EncounterString:
	text "じゃーん！"
	line "みたことない　ポケモン"
	cont "だいはっけん"
	done

	text "ほかの　ポケモンも"
	line "つかまえて　おくべきだったー"
	done

QuietHillsTrainer6WonString:
	text "きみの　ポケモンも　みたことないな"
	line "ね　こうかん　しない？"
	done

QuietHillsTrainer5EncounterString:
	text "ねーねー　あたしと"
	line "ポケモンしょうぶ　しよーよー"
	done

	text "やーん"
	done

QuietHillsTrainer5WonString:
	text "よるになると　くらくなるじゃない？"
	line "あるいてても　まわりが"
	cont "よくわからなくて　こわいわ"
	done

QuietHillsTrainer4EncounterString:
	text "きみ！"

	para "おこらないから"
	line "いけが　あるところを　おしえなさい！"
	done

	text "みずが　ちかくに　ないと⋯⋯"
	done

QuietHillsTrainer4WonString:
	text "どうして　おじさんは"
	line "こんなところに　いるんだ？"
	done

QuietHillsTrainer3EncounterString:
	text "ポケモンは　はじめたばかり？"
	line "それやったら　まけへんで"
	done

	text "うわ　なんでやねん"
	done

QuietHillsTrainer3WonString:
	text "なんか　すっげー　くやしいわ"
	done

QuietHillsTrainer2EncounterString:
	text "ここは　ひろくて"
	line "トレーニングに　さいてきだ"

	para "なんのって　もちろん"
	line "ポケモンの　トレーニングだよ！"
	done

	text "れ　れんしゅう　ぶそくか⋯⋯"
	done

QuietHillsTrainer2WonString:
	text "よーし　はしる　ぞー"
	done

endc

QuietHillsText1String:
	text "この　おかの　ポケモンは　よわい！"
	line "だから　ここで　しゅぎょう　している"
	cont "トレーナーも　おおいよ"

	para "みんな　バトルが　すきだから"
	line "うでだめしを　するといい"
	done

QuietHillsSignpost2String:
	text "しずかな　おか"
	line "サイレントヒル　は　こちら"
	done

QuietHillsSignpost1String:
	text "しずかな　おか"
	line "オールドシティ　は　こちら"
	done
