INCLUDE "constants.asm"

SECTION "scripts/SilentHillHouse.asm", ROMX

SilentHillHouse_ScriptLoader::
	ld hl, SilentHillHouseScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillHouseScriptPointers:
	dw SilentHillHouseScript1
	dw SilentHillHouseNPCIDs1
	dw SilentHillHouseScript2
	dw SilentHillHouseNPCIDs2
	dw SilentHillHouseScript3
	dw SilentHillHouseNPCIDs1

SilentHillHouseScript1:
	ld hl, SilentHillHouseNPCIDs1
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillHouseScript2:
	ld hl, SilentHillHouseNPCIDs2
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillHouseScript3:
	ld hl, SilentHillHouseNPCIDs1
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillHouseNPCIDs1:
	db 0
	db $FF

SilentHillHouseNPCIDs2:
	db 0
	db 1
	db $FF

SilentHillHouseTextPointers2::
	dw SilentHillHouseNPCText1
	dw Function38bd
	dw Function3899
	dw Function38b4
	dw Function38ab
	dw Function38cf

SilentHillHouseNPCText1:
	ld hl, wd41a
	bit 6, [hl]
	jr nz, .jump
	ld hl, SilentHillHouseTextString1
	call OpenTextbox
	ret

.jump
	call RefreshScreen
	callfar PokemonCenterPC
	call ScreenCleanup
	ret

SilentHillHouseTextString1:
	text "おや？　<RIVAL>あてに　メールが"
	line "とどいている　ようだ"
	cont "よんでみる？@"
	db $08

SilentHillHouseNPCText2: ; (unused due to typo in the text pointers?)
	call YesNoBox
	jr c, .jump
	ld hl, wd41a
	set 6, [hl]
	ld hl, SilentHillHouseTextString2
	call PrintText
	call Function3036
	ret
.jump
	ld hl, SilentHillHouseTextString3
	call PrintText
	call Function3036
	ret

SilentHillHouseTextString2:
	text "とつぜん　メールを　さしあげる"
	line "しつれいを　おゆるしあれ"

	para "じつは　きみに　どうしても"
	line "わたしたい　ものが　あるのじゃが"
	cont "うけとって　もらえんかのう"
	cont "ポケモンけんきゅうしゃ　オーキド"
	done

SilentHillHouseTextString3:
	text "ひとのメールは"
	line "みちゃ　いけないよな<⋯⋯>"
	done

SilentHillHouse_TextPointers::
	dw SilentHillHouseNPCText3
	dw SilentHillHouseNPCText4

SilentHillHouseNPCText3:
	ld hl, SilentHillHouseTextString4
	call OpenTextbox
	ret

SilentHillHouseTextString4:
	text "このまえ　かわったいろの"
	line "ポッポを　みかけたわ"
	done

SilentHillHouseNPCText4:
	ld hl, wd41e
	bit 2, [hl]
	jr nz, .jump
	ld hl, wd41e
	set 2, [hl]
	ld hl, SilentHillHouseTextString5
	call OpenTextbox
	call WaitBGMap
	ld hl, SilentHillHouseTextString6
	jr .skip
.jump
	ld hl, SilentHillHouseTextString7
.skip
	call OpenTextbox
	ret

SilentHillHouseTextString5:
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

SilentHillHouseTextString6:
	text "もし　オールドにいくなら"
	line "マサキって　やつに　あうといい"

	para "おれの　ともだちで"
	line "すごい　ポケモン　マニアだ！"
	cont "きっと　おまえの"
	cont "てだすけを　してくれるぜ"
	done

SilentHillHouseTextString7:
	text "ケン『<PLAYER>"
	line "オーキドはかせに　みこまれて"
	cont "ポケモンずかんを　つくるんだって？"
	cont "すごいじゃないか　がんばれよ"
	done
