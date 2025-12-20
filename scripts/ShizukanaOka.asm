INCLUDE "constants.asm"

SECTION "scripts/ShizukanaOka.asm", ROMX

ShizukanaOka_ScriptLoader::
	ld hl, ShizukanaOkaScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

ShizukanaOkaScriptPointers:
	dw ShizukanaOkaScript
	dw ShizukanaOkaNPCIDs

ShizukanaOkaNPCIDs:
	db 0
	db 1
	db 2
	db 3
	db 4
	db 5
	db $FF

ShizukanaOkaSignPointers:
	dw ShizukanaOkaSignpost1
	dw ShizukanaOkaSignpost2

ShizukanaOka_TextPointers:
	dw ShizukanaOkaText1
	dw ShizukanaOkaTrainer2
	dw ShizukanaOkaTrainer3
	dw ShizukanaOkaTrainer4
	dw ShizukanaOkaTrainer5
	dw ShizukanaOkaTrainer6

ShizukanaOkaScript:
	ld hl, ShizukanaOkaNPCIDs
	ld de, ShizukanaOkaSignPointers
	call CallMapTextSubroutine
	ret

ShizukanaOkaText1:
	ld hl, ShizukanaOkaText1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer2:
	ld hl, $D3A5
	bit 1, [hl]
	jr nz, .Trainer2Won
	ld hl, ShizukanaOkaTrainer2EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 1, [hl]
	ld a, TRAINER_SCHOOLBOY
	ld [wOtherTrainerClass], a
	ld a, SCHOOLBOY_TETSUYA
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer2Won ;Already won
	ld hl, ShizukanaOkaTrainer2WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer3:
	ld hl, wd3a5
	bit 2, [hl]
	jr nz, .Trainer3Won
	ld hl, ShizukanaOkaTrainer3EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 2, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_JUNICHI
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer3Won ;Already won
	ld hl, ShizukanaOkaTrainer3WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer4:
	ld hl, wd3a5
	bit 3, [hl]
	jr nz, .Trainer4Won
	ld hl, ShizukanaOkaTrainer4EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 3, [hl]
	ld a, TRAINER_FIREBREATHER
	ld [wOtherTrainerClass], a
	ld a, FIREBREATHER_AKITO
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer4Won ;Already won
	ld hl, ShizukanaOkaTrainer4WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer5:
	ld hl, wd3a5
	bit 4, [hl]
	jr nz, .Trainer5Won
	ld hl, ShizukanaOkaTrainer5EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 4, [hl]
	ld a, TRAINER_BEAUTY
	ld [wOtherTrainerClass], a
	ld a, BEAUTY_MEGUMI
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer5Won ;Already won
	ld hl, ShizukanaOkaTrainer5WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer6:
	ld hl, wd3a5
	bit 5, [hl]
	jr nz, .Trainer6Won
	ld hl, ShizukanaOkaTrainer6EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 5, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wOtherTrainerClass], a
	ld a, BUG_CATCHER_BOY_SOUSUKE
	ld [wOtherTrainerID], a
	call InitTrainerBattle
	ret
.Trainer6Won ;Already won
	ld hl, ShizukanaOkaTrainer6WonString
	call OpenTextbox
	ret

ShizukanaOkaSignpost2:
	ld hl, ShizukanaOkaSignpost2String
	call OpenTextbox
	ret

ShizukanaOkaSignpost1:
	ld hl, ShizukanaOkaSignpost1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer6EncounterString:
	text "ねえ　ねえ　みてよ"

	para "これ　ぜったい"
	line "しんしゅの　ポケモン　だよ！"
	done

	text "まだ　ポケモンの　とくちょう"
	line "わかってないから　しかたないよ"
	done

ShizukanaOkaTrainer6WonString:
	text "あたらしい　ポケモンだけでなく"
	line "あたらしい　タイプも"
	cont "みつかったって　うわさだよ"
	done

ShizukanaOkaTrainer5EncounterString:
	text "いい　てんきねー"
	line "あなた　ちょうしは　いかが？"
	done

	text "なにするニャー"
	line "⋯⋯なにいってるのかしら　あたし"
	done

ShizukanaOkaTrainer5WonString:
	text "なんで　こうなるの？"
	line "さんぽしてた　だけなのに@@"

ShizukanaOkaTrainer4EncounterString:
	text "こんなところで"
	line "ひを　ふく　れんしゅう！"
	done

	text "あちち　しっぱいだー"
	done

ShizukanaOkaTrainer4WonString:
	text "よるになると　くらくなるから"
	line "こどもは　はやく　かえりなさい！"

	para "おれ？"
	line "おれは　ひをふくから　だいじょうぶ"
	done

ShizukanaOkaTrainer3EncounterString:
	text "むしポケモンの　ことなら"
	line "だれよりも　くわしいよ"
	done

	text "パラパラー"
	done

ShizukanaOkaTrainer3WonString:
	text "ポケモンずかんを　つくるんだって？"
	line "ちょっと　みせてよ"

	para "へー"
	line "タイプべつに　ポケモン　さがせるんだ"
	done

ShizukanaOkaTrainer2EncounterString:
	text "いっとくけど"
	line "きみよりも　べんきょう　してるから"
	cont "きみよりも　つよいよ　ぜったい！"
	done

	text "な　なぜなんだ？"
	done

ShizukanaOkaTrainer2WonString:
	text "おかしいよ⋯⋯"
	line "まいにち　ポケモンの　べんきょうを"
	cont "きちんと　してるのに　まけるなんて"
	done

ShizukanaOkaText1String:
	text "この　おかの　ポケモンは　よわい！"
	line "だから　ここで　しゅぎょう　している"
	cont "トレーナーも　おおいよ"

	para "みんな　バトルが　すきだから"
	line "うでだめしを　するといい"
	done

ShizukanaOkaSignpost2String:
	text "しずかな　おか"
	line "サイレントヒル　は　こちら"
	done

ShizukanaOkaSignpost1String:
	text "しずかな　おか"
	line "オールドシティ　は　こちら"
	done
