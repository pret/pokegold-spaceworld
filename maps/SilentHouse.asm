include "constants.asm"

SECTION "maps/SilentHouse.asm", ROMX

SilentHouseScriptLoader:: ; 4839
	ld hl, SilentHouseScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHouseScriptPointers: ; 4843
	dw SilentHouseScript1
	dw SilentHouseNPCIDs1 
	dw SilentHouseScript2 
	dw SilentHouseNPCIDs2 
	dw SilentHouseScript3 
	dw SilentHouseNPCIDs1 
	
SilentHouseScript1: ; 484F
	ld hl, SilentHouseNPCIDs1
	ld de, SilentHouseTextPointers1
	call CallMapTextSubroutine
	ret
	
SilentHouseScript2: ; 4859
	ld hl, SilentHouseNPCIDs2
	ld de, SilentHouseTextPointers1
	call CallMapTextSubroutine
	ret
	
SilentHouseScript3: ; 4863
	ld hl, SilentHouseNPCIDs1
	ld de, SilentHouseTextPointers1
	call CallMapTextSubroutine
	ret
	
SilentHouseNPCIDs1: 
	db 0
	db $FF
	
SilentHouseNPCIDs2: 
	db 0
	db 1
	db $FF
	
SilentHouseTextPointers1:: ; 4872
	dw SilentHouseNPCText1 
	dw Function38bd 
	dw Function3899 
	dw Function38b4 
	dw Function38ab 
	dw Function38cf 
	
SilentHouseNPCText1: ; 487E
	ld hl, wd41a
	bit 6, [hl]
	jr nz, .jump
	ld hl, SilentHouseTextString1
	call OpenTextbox
	ret

.jump
; 488C
	call RefreshScreen
	callab Function1477D
	call Function1fea
	ret
	
SilentHouseTextString1: ; 489B
	text "おや？　<RIVAL>あてに　メールが"
	line "とどいている　ようだ"
	cont "よんでみる？@"
	db $08
	
SilentHouseNPCText2: ; 48BD (unused due to typo in the text pointers?)
	call YesNoBox
	jr c, .jump
	ld hl, wd41a
	set 6, [hl]
	ld hl, SilentHouseTextString2
	call PrintText
	call Function3036
	ret
.jump
	ld hl, SilentHouseTextString3
	call PrintText
	call Function3036
	ret
	
SilentHouseTextString2: ; 48DB
	text "とつぜん　メールを　さしあげる"
	line "しつれいを　おゆるしあれ"
	
	para "じつは　きみに　どうしても"
	line "わたしたい　ものが　あるのじゃが"
	cont "うけとって　もらえんかのう"
	cont "ポケモンけんきゅうしゃ　オーキド"
	done
	
SilentHouseTextString3: ; 4937
	text "ひとのメールは"
	line "みちゃ　いけないよな<⋯⋯>"
	done
	
SilentHouseTextPointers2:: ; 494C
	dw SilentHouseNPCText3 
	dw SilentHouseNPCText4
	
SilentHouseNPCText3: ; 4950
	ld hl, SilentHouseTextString4
	call OpenTextbox
	ret
	
SilentHouseTextString4: ; 4957
	text "このまえ　かわったいろの"
	line "ポッポを　みかけたわ"
	done
	
SilentHouseNPCText4: ; 4970
	ld hl, wd41e
	bit 2, [hl]
	jr nz, .jump
	ld hl, wd41e
	set 2, [hl]
	ld hl, SilentHouseTextString5
	call OpenTextbox
	call WaitBGMap
	ld hl, SilentHouseTextString6
	jr .skip
.jump
	ld hl, SilentHouseTextString7
.skip
	call OpenTextbox
	ret
	
SilentHouseTextString5: ; 4991
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
	
SilentHouseTextString6: ; 4A29
	text "もし　オールドにいくなら"
	line "マサキって　やつに　あうといい"
	
	para "おれの　ともだちで"
	line "すごい　ポケモン　マニアだ！"
	cont "きっと　おまえの"
	cont "てだすけを　してくれるぜ"
	done
	
SilentHouseTextString7: ; 4A76
	text "ケン『<PLAYER>"
	line "オーキドはかせに　みこまれて"
	cont "ポケモンずかんを　つくるんだって？"
	cont "すごいじゃないか　がんばれよ"
	done
	
; 4AAC