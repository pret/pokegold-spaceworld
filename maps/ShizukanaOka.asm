include "constants.asm"

SECTION "maps/ShizukanaOka.asm", ROMX

ShizukanaOkaScriptLoader:: ; 564B
	ld hl, ShizukanaOkaScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

ShizukanaOkaScriptPointers:
	dw ShizukanaOkaScript
	dw ShizukanaOkaNPCIDs

ShizukanaOkaNPCIDs: ; 5659
	db 0
	db 1
	db 2
	db 3
	db 4
	db 5
	db $FF

ShizukanaOkaSignPointers:
	dw ShizukanaOkaSignpost1 ;574b
	dw ShizukanaOkaSignpost2 ;5744

ShizukanaOkaTextPointers: ;5664
	dw ShizukanaOkaText1 ;567a
	dw ShizukanaOkaTrainer2 ;5681
	dw ShizukanaOkaTrainer3 ;56A8
	dw ShizukanaOkaTrainer4 ;56cf
	dw ShizukanaOkaTrainer5 ;56f6
	dw ShizukanaOkaTrainer6 ;571d

ShizukanaOkaScript: ;5670
	ld hl, ShizukanaOkaNPCIDs
	ld de, ShizukanaOkaSignPointers
	call CallMapTextSubroutine
	ret

ShizukanaOkaText1: ;567a
	ld hl, ShizukanaOkaText1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer2: ;5681
	ld hl, $D3A5
	bit 1, [hl]
	jr nz, .Trainer2Won
	ld hl, ShizukanaOkaTrainer2EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 1, [hl]
	ld a, TRAINER_SCHOOLBOY
	ld [wce02], a
	ld a, SCHOOLBOY_TETSUYA
	ld [wce05], a
	call Function38d8
	ret
.Trainer2Won ;Already won
	ld hl, ShizukanaOkaTrainer2WonString
	call OpenTextbox
	ret
	
ShizukanaOkaTrainer3: ;56A8
	ld hl, wd3a5
	bit 2, [hl]
	jr nz, .Trainer3Won
	ld hl, ShizukanaOkaTrainer3EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 2, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wce02], a
	ld a, BUG_CATCHER_BOY_JUNICHI
	ld [wce05], a
	call Function38d8
	ret
.Trainer3Won ;Already won
	ld hl, ShizukanaOkaTrainer3WonString
	call OpenTextbox
	ret
	
ShizukanaOkaTrainer4: ;56CF
	ld hl, wd3a5
	bit 3, [hl]
	jr nz, .Trainer4Won
	ld hl, ShizukanaOkaTrainer4EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 3, [hl]
	ld a, TRAINER_FIREBREATHER
	ld [wce02], a
	ld a, FIREBREATHER_AKITO
	ld [wce05], a
	call Function38d8
	ret
.Trainer4Won ;Already won
	ld hl, ShizukanaOkaTrainer4WonString
	call OpenTextbox
	ret
	
ShizukanaOkaTrainer5: ;56F6
	ld hl, wd3a5
	bit 4, [hl]
	jr nz, .Trainer5Won
	ld hl, ShizukanaOkaTrainer5EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 4, [hl]
	ld a, TRAINER_BEAUTY
	ld [wce02], a
	ld a, BEAUTY_MEGUMI
	ld [wce05], a
	call Function38d8
	ret
.Trainer5Won ;Already won
	ld hl, ShizukanaOkaTrainer5WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer6: ;571D
	ld hl, wd3a5
	bit 5, [hl]
	jr nz, .Trainer6Won
	ld hl, ShizukanaOkaTrainer6EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 5, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wce02], a
	ld a, BUG_CATCHER_BOY_SOUSUKE
	ld [wce05], a
	call Function38d8
	ret
.Trainer6Won ;Already won
	ld hl, ShizukanaOkaTrainer6WonString
	call OpenTextbox
	ret
	
ShizukanaOkaSignpost2: ;5744
	ld hl, ShizukanaOkaSignpost2String
	call OpenTextbox
	ret
	
ShizukanaOkaSignpost1: ;574b
	ld hl, ShizukanaOkaSignpost1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer6EncounterString: ; 2f:5752
	text "ねえ　ねえ　みてよ"
	para "これ　ぜったい"
	line "しんしゅの　ポケモン　だよ！"
	done

	text "まだ　ポケモンの　とくちょう"
	line "わかってないから　しかたないよ"
	done

ShizukanaOkaTrainer6WonString: ; 2f:5794
	text "あたらしい　ポケモンだけでなく"
	line "あたらしい　タイプも"
	cont "みつかったって　うわさだよ"
	done

ShizukanaOkaTrainer5EncounterString: ; 2f:57be
	text "いい　てんきねー"
	line "あなた　ちょうしは　いかが？"
	done

	text "なにするニャー"
	line "⋯⋯なにいってるのかしら　あたし"
	done

ShizukanaOkaTrainer5WonString: ; 2f:57f1
	text "なんで　こうなるの？"
	line "さんぽしてた　だけなのに@@"

ShizukanaOkaTrainer4EncounterString: ; 2f:580b
	text "こんなところで"
	line "ひを　ふく　れんしゅう！"
	done

	text "あちち　しっぱいだー"
	done

ShizukanaOkaTrainer4WonString: ; 2f:582d
	text "よるになると　くらくなるから"
	line "こどもは　はやく　かえりなさい！"
	para "おれ？"
	line "おれは　ひをふくから　だいじょうぶ"
	done

ShizukanaOkaTrainer3EncounterString: ; 2f:5864
	text "むしポケモンの　ことなら"
	line "だれよりも　くわしいよ"
	done

	text "パラパラー"
	done

ShizukanaOkaTrainer3WonString: ; 2f:5885
	text "ポケモンずかんを　つくるんだって？"
	line "ちょっと　みせてよ"
	para "へー"
	line "タイプべつに　ポケモン　さがせるんだ"
	done

ShizukanaOkaTrainer2EncounterString: ; 2f:58b8
	text "いっとくけど"
	line "きみよりも　べんきょう　してるから"
	cont "きみよりも　つよいよ　ぜったい！"
	done

	text "な　なぜなんだ？"
	done

ShizukanaOkaTrainer2WonString: ; 2f:58ed
	text "おかしいよ⋯⋯"
	line "まいにち　ポケモンの　べんきょうを"
	cont "きちんと　してるのに　まけるなんて"
	done

ShizukanaOkaText1String: ; 2f:591a
	text "この　おかの　ポケモンは　よわい！"
	line "だから　ここで　しゅぎょう　している"
	cont "トレーナーも　おおいよ"
	para "みんな　バトルが　すきだから"
	line "うでだめしを　するといい"
	done

ShizukanaOkaSignpost2String: ; 2f:5968
	text "しずかな　おか"
	line "サイレントヒル　は　こちら"
	done

ShizukanaOkaSignpost1String: ; 2f:597f
	text "しずかな　おか"
	line "オールドシティ　は　こちら"
	done
