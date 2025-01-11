INCLUDE "constants.asm"

SECTION "scripts/PlayerHouse2F.asm", ROMX

PlayerHouse2F_ScriptLoader::
	ld hl, PlayerHouse2FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

PlayerHouse2FScriptPointers:
	dw PlayerHouse2FScript1
	dw PlayerHouse2FNPCIDs1
	dw PlayerHouse2FScript2
	dw PlayerHouse2FNPCIDs2

PlayerHouse2F_TextPointers::
	dw PlayerHouse2FText1
	dw PlayerHouse2FDollText

PlayerHouse2FNPCIDs1:
	db 0
	db 1
	db $FF

PlayerHouse2FNPCIDs2:
	db 1
	db $FF

PlayerHouse2FSignPointers:
	dw Function3899
	dw PlayerHouse2FRadioText
	dw PlayerHouse2FComputerText
	dw Function3899
	dw PlayerHouse2FN64Text

PlayerHouse2FScript1:
	call PlayerHouse2PositionCheck
	ret z
	ld hl, PlayerHouse2FNPCIDs1
	ld de, PlayerHouse2FSignPointers
	call CallMapTextSubroutine
	ret nz
	ret

PlayerHouse2PositionCheck:
	ld hl, wd41a
	bit 0, [hl]
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ld a, [wXCoord]
	cp 9
	ret nz
	ld hl, wJoypadFlags
	set 6, [hl]
	ld a, LEFT
	ld d, 0
	call SetObjectFacing
	ld hl, PlayerHouse2FTextString2
	call OpenTextbox
	call PlayerHouse2FMovePlayer
	call ClearAccumulator
	ret

PlayerHouse2FMovePlayer:
	ld a, 0
	ld hl, Movement
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ret

Movement:
	db $08
	db $04
	db $32

PlayerHouse2FScript2:
	ld hl, PlayerHouse2FNPCIDs2
	ld de, PlayerHouse2FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse2FText1:
	ld hl, wd41a
	bit 3, [hl]
	jr nz, .jump
	ld hl, PlayerHouse2FTextString1
	call OpenTextbox
	ld hl, wd41a
	set 3, [hl]
	ld c, 3
	call DelayFrames
.jump
	ld hl, PlayerHouse2FTextString2
	call OpenTextbox
	ret

PlayerHouse2FDollText:
	ld hl, PlayerHouse2FTextString3
	call OpenTextbox
	ret

PlayerHouse2FRadioText:
	ld hl, PlayerHouse2FTextString9
	call OpenTextbox
	ret

PlayerHouse2FComputerText:
	ld hl, wd41a
	bit 0, [hl]
	jr nz, .jump
	ld hl, PlayerHouse2FTextString5
	call OpenTextbox
	ret

.jump
	call RefreshScreen
	callfar PokemonCenterPC
	call Function1fea
	ret

PlayerHouse2FCheckEmail:
	call YesNoBox
	jr c, .jump2
	ld hl, wd41a
	set 0, [hl]
	ld hl, PlayerHouse2FTextString6
	call PrintText
	ret

.jump2
	ld hl, PlayerHouse2FTextString7
	call PrintText
	ret

PlayerHouse2FN64Text:
	ld hl, PlayerHouse2FTextString4
	call OpenTextbox
	ret

PlayerHouse2FTextString1:
	text "ケン『おっ　おまえの　うでで"
	line "ひかりかがやく　そのとけいは⋯⋯"
	cont "<PLAYER>も　ついに"
	cont "トレーナーギアを　かったのか！"

	para "すごいじゃないか！"
	line "でも　かったばかりじゃ　じかんしか"
	cont "わからないだろ？"
	cont "あとで　マップが"
	cont "みられるように　してやるよ！"
	cont "おまえ　どうせ"
	cont "あそびに　いくんだろう？"

	para "ざんねんながら　おふくろは"
	line "かいものに　いってるから"
	cont "おこづかいを　もらおうなんて"
	cont "きょうは　むり　だぜ！"
	done

PlayerHouse2FTextString2:
	text "そうだ　おまえの　パソコンに"
	line "メールが　とどいていたな"
	cont "でかけるんなら"
	cont "メールぐらい　よんでおけよ"
	done

PlayerHouse2FTextString3:
	text "クりスマスに　カントーの"
	line "しんせきに　プレゼント"
	cont "してもらった　にんぎょうだ"
	done

PlayerHouse2FTextString4:
	text "ニンテンドウ６４を　してる！"
	cont "⋯⋯　⋯⋯　さてと！"
	cont "そろそろ　そとに　あそびに"
	cont "でかけるか！"
	done

PlayerHouse2FTextString5:
	text "<PLAYER>は"
	line "パソコンの　スイッチを　いれた！"

	para "おや？　<PLAYER>あてに"
	line "メールが　とどいている　ようだ"
	cont "よんでみる？@"

	db $08

	call PlayerHouse2FCheckEmail
	call Function3036
	ret

PlayerHouse2FTextString6:
	text "とつぜん　メールを　さしあげる"
	line "しつれいを　おゆるしあれ"

	para "じつは　きみに　どうしても"
	line "わたしたい　ものが　あるのじゃが"
	cont "うけとって　もらえんかのう"
	cont "ポケモンけんきゅうしゃ　オーキド"
	done

PlayerHouse2FTextString7:
	text "あとで"
	line "よもっと<⋯⋯>"
	done

PlayerHouse2FTextString8: ; (unused?)
	text "しんはつばい　トレーナーギア！"
	line "ポケモントレーナーの　ための"
	cont "さいせんたんの　とけい　です"

	para "じかんが　わかるのは　あたりまえ"
	line "カセットを　ついかすれば"
	cont "ばしょも　わかる！　"
	cont "でんわが　かけられる！"

	para "とどめは"
	line "ラジオを　きくことができる！"

	para "もうしこみさきは⋯⋯"
	line "⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯⋯"
	cont "シルフの　ホームぺージだ"
	done

PlayerHouse2FTextString9:
	text "<PLAYER>は"
	line "ラジオのスイッチを　おした！"

	para "ジェイ　オー　ピー　エム"
	line "こちらは"
	cont "#　ほうそうきょく　です"

	para "#ニュースを　おおくりします"
	line "<⋯⋯>　#の　せかいてきな"
	cont "けんきゅうしゃ　オーキドはかせが"
	cont "カントー　から"
	cont "すがたを　けしました"
	cont "あらたな　けんきゅうの　ばしょを"
	cont "もとめて　いどうした　との"
	cont "みかたも　ありますが"
	cont "なんらかの　じけんに　まきこまれた"
	cont "かのうせいも　あり"
	cont "かんけいしゃは　とても"
	cont "しんぱい　しています"

	para "<⋯⋯><⋯⋯>いじょう"
	line "#ニュースでした"

	para "<⋯⋯><⋯⋯><⋯⋯><⋯⋯><⋯⋯><⋯⋯>"
	line "それでは　ひきつづき"
	cont "おんがくを　おたのしみ　ください"
	done
