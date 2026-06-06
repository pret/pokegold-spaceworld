INCLUDE "constants.asm"

SECTION "scripts/SilentHills.asm", ROMX

SilentHills_ScriptLoader::
	ld hl, SilentHillsScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillsScriptPointers:
	dw SilentHillsScript
	dw SilentHillsNPCIDs

SilentHillsNPCIDs:
	db 0
	db 1
	db 2
	db 3
	db 4
	db 5
	db $FF

SilentHillsSignPointers:
	dw SilentHillsSignpost1
	dw SilentHillsSignpost2

SilentHills_TextPointers:
	dw SilentHillsText1
	dw SilentHillsTrainer2
	dw SilentHillsTrainer3
	dw SilentHillsTrainer4
	dw SilentHillsTrainer5
	dw SilentHillsTrainer6

SilentHillsScript:
	ld hl, SilentHillsNPCIDs
	ld de, SilentHillsSignPointers
	call CallMapTextSubroutine
	ret

SilentHillsText1:
	ld hl, SilentHillsText1String
	call OpenTextbox
	ret

SilentHillsTrainer2:
	ld hl, $D3A5
	bit 1, [hl]
	jr nz, .Trainer2Won
	ld hl, SilentHillsTrainer2EncounterString
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
	ld hl, SilentHillsTrainer2WonString
	call OpenTextbox
	ret

SilentHillsTrainer3:
	ld hl, wd3a5
	bit 2, [hl]
	jr nz, .Trainer3Won
	ld hl, SilentHillsTrainer3EncounterString
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
	ld hl, SilentHillsTrainer3WonString
	call OpenTextbox
	ret

SilentHillsTrainer4:
	ld hl, wd3a5
	bit 3, [hl]
	jr nz, .Trainer4Won
	ld hl, SilentHillsTrainer4EncounterString
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
	ld hl, SilentHillsTrainer4WonString
	call OpenTextbox
	ret

SilentHillsTrainer5:
	ld hl, wd3a5
	bit 4, [hl]
	jr nz, .Trainer5Won
	ld hl, SilentHillsTrainer5EncounterString
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
	ld hl, SilentHillsTrainer5WonString
	call OpenTextbox
	ret

SilentHillsTrainer6:
	ld hl, wd3a5
	bit 5, [hl]
	jr nz, .Trainer6Won
	ld hl, SilentHillsTrainer6EncounterString
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
	ld hl, SilentHillsTrainer6WonString
	call OpenTextbox
	ret

SilentHillsSignpost2:
	ld hl, SilentHillsSignpost2String
	call OpenTextbox
	ret

SilentHillsSignpost1:
	ld hl, SilentHillsSignpost1String
	call OpenTextbox
	ret

SilentHillsTrainer6EncounterString:
	text "ねえ　ねえ　みてよ"

	para "これ　ぜったい"
	line "しんしゅの　ポケモン　だよ！"
	done

	text "まだ　ポケモンの　とくちょう"
	line "わかってないから　しかたないよ"
	done

SilentHillsTrainer6WonString:
	text "あたらしい　ポケモンだけでなく"
	line "あたらしい　タイプも"
	cont "みつかったって　うわさだよ"
	done

SilentHillsTrainer5EncounterString:
	text "いい　てんきねー"
	line "あなた　ちょうしは　いかが？"
	done

	text "なにするニャー"
	line "⋯⋯なにいってるのかしら　あたし"
	done

SilentHillsTrainer5WonString:
	text "なんで　こうなるの？"
	line "さんぽしてた　だけなのに@@"

SilentHillsTrainer4EncounterString:
	text "こんなところで"
	line "ひを　ふく　れんしゅう！"
	done

	text "あちち　しっぱいだー"
	done

SilentHillsTrainer4WonString:
	text "よるになると　くらくなるから"
	line "こどもは　はやく　かえりなさい！"

	para "おれ？"
	line "おれは　ひをふくから　だいじょうぶ"
	done

SilentHillsTrainer3EncounterString:
	text "むしポケモンの　ことなら"
	line "だれよりも　くわしいよ"
	done

	text "パラパラー"
	done

SilentHillsTrainer3WonString:
	text "ポケモンずかんを　つくるんだって？"
	line "ちょっと　みせてよ"

	para "へー"
	line "タイプべつに　ポケモン　さがせるんだ"
	done

SilentHillsTrainer2EncounterString:
	text "いっとくけど"
	line "きみよりも　べんきょう　してるから"
	cont "きみよりも　つよいよ　ぜったい！"
	done

	text "な　なぜなんだ？"
	done

SilentHillsTrainer2WonString:
	text "おかしいよ⋯⋯"
	line "まいにち　ポケモンの　べんきょうを"
	cont "きちんと　してるのに　まけるなんて"
	done

SilentHillsText1String:
	text "この　おかの　ポケモンは　よわい！"
	line "だから　ここで　しゅぎょう　している"
	cont "トレーナーも　おおいよ"

	para "みんな　バトルが　すきだから"
	line "うでだめしを　するといい"
	done

SilentHillsSignpost2String:
	text "しずかな　おか"
	line "サイレントヒル　は　こちら"
	done

SilentHillsSignpost1String:
	text "しずかな　おか"
	line "オールドシティ　は　こちら"
	done
