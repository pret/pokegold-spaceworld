include "constants.asm"

SECTION "Silent Lab P1", ROMX[$4BBC], BANK[$34]

SilentLabP1ScriptLoader:: ; 4BBC
	ld hl, SilentLabP1ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentLabP1ScriptPointers: ; 4BC6
	dw SilentLabP1Script1 
	dw SilentLabP1NPCIDs1 
	
	dw SilentLabP1Script2 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script3 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script4 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Conversation1 
	dw SilentLabP1NPCIDs2 
	
	dw SilentLabP1Script6 
	dw SilentLabP1NPCIDs3 
	
	dw SilentLabP1Script7 
	dw SilentLabP1NPCIDs4 
	
	dw SilentLabP1Script8 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script9 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script10 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script11 
	dw SilentLabP1NPCIDs5 
	
	dw SilentLabP1Script12 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script13 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script14 
	dw SilentLabP1NPCIDs6 
	
	dw SilentLabP1Script15 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script16 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script17 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script18 
	dw SilentLabP1NPCIDs7 
	
	dw SilentLabP1Script19 
	dw SilentLabP1NPCIDs9 
	
SilentLabP1NPCIDs1: ; 4C12
	db $02
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs2: ; 4C16
	db $00 
	db $02 
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs3: ; 4C1C
	db $02 
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs4: ; 4C21
	db $04 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs5: ; 4C25
	db $01 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs6: ; 4C2E
	db $01 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $FF 
SilentLabP1NPCIDs7: ; 4C35
	db $00 
	db $05 
	db $06 
	db $07 
	db $08 
	db $FF 
SilentLabP1NPCIDs8: ; 4C3B (unused?)
	db $00 
	db $03 
	db $05 
	db $06 
	db $07 
	db $08 
	db $09 
	db $0A 
	db $FF 
SilentLabP1NPCIDs9: ; 4C44
	db $00 
	db $07 
	db $08 
	db $FF
	
SilentLabP1TextPointers1:: ; 4C48
	dw SilentLabP1Text4 
	dw SilentLabP1Text7 
	dw SilentLabP1Text10 
	dw SilentLabP1Text11 
	dw SilentLabP1TextString20 
	dw SilentLabP1Text12 
	dw SilentLabP1Text13 
	dw SilentLabP1Text14 
	dw SilentLabP1Text15 
	dw SilentLabP1Text16 
	dw SilentLabP1Text16 
	
SilentLabP1Script1: ; 4C5E
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs1
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1MoveDown: ; 4C6C
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ldh a, [hJoyState]
	bit 6, a
	jp z, SetFFInAccumulator
	call SilentLabP1Text3
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentLabP1Movement1
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret
	
SilentLabP1Movement1: ; 4CA2
	db $06, $32
	
SilentLabP1Script2: ; 4CA4
	ld a, 2
	ld [wMapScriptNumber], a
	ret
	
SilentLabP1Script3: ; 4CAA
	ld a, 6
	call Function17f9
	ld a, 0
	call Function186a
	ld b, 6
	ld c, 0
	call StartFollow
	ld hl, SilentLabP1Movement2
	ld a, 6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 3
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement2: ; 4CD3
	db 09, 09, 09, 09, 09, 09, 09, 09, 09, 05, 07, 01, $32
	
SilentLabP1Script4: ; 4CE0
	call Function1828
	ld a, 4
	ld [wMapScriptNumber], a 
	ret
	
SilentLabP1Conversation1: ; 4CE9
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString20
	call OpenTextbox
	ld hl, SilentLabP1TextString4
	call OpenTextbox
	ld a, 4
	ld d, UP
	call SetObjectFacing
	ld hl, SilentLabP1TextString28
	call OpenTextbox
	ld hl, SilentLabP1TextString5
	call OpenTextbox
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString29
	call OpenTextbox
	ld hl, SilentLabP1TextString7
	call OpenTextbox
	call SilentLabP1Script5
	ret
	
SilentLabP1Script5: ; 4D26
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 2
	call Function17f9
	ld a, 2
	ld hl, SilentLabP1Movement3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 5
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement3: ; 4D48
	db 9, 5, $33
	
SilentLabP1Script6: ; 4D4B
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 4
	call Function17f9
	ld a, 4
	ld hl, SilentLabP1Movement4
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 6
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret

SilentLabP1Movement4: ; 4D6D
	db $0D, $0D, $0F, $0D, $0D, $33
	
SilentLabP1Script7: ; 4D73
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentLabP1Movement5
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 7
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement5: ; 4D95
	db 09, 09, 09, 05, $32
	
SilentLabP1Script8: ; 4D9A
	ld a, 3
	call Function1989
	ld a, 5
	call Function1989
	ld hl, wJoypadFlags
	set 4, [hl] 
	ld a, 0 
	call Function17f9 
	ld a, 0 
	ld hl, SilentLabP1Movement6
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 8
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement6: ; 4DC6
	db 8, 8, 8, $0A, 6, $32
	
SilentLabP1Script9: ; 4DCC
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	call Function197e
	ld a, 5
	ld hl, SilentLabP1Movement7
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 9
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement7: ; 4DF3
	db $08, $08, $08, $08, $0A, $06, $32
	
SilentLabP1Script10: ; 4DFA
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentLabP1TextString21
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld a, 3
	call Function17f9
	ld a, 3
	call Function197e
	ld a, 3
	ld hl, SilentLabP1Movement8
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0A
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement8: ; 4E3C
	db $08, $04, $32
	
SilentLabP1Script11: ; 4E3F
	ld hl, SilentLabP1TextString8
	call OpenTextbox
	ld hl, SilentLabP1TextString9
	call OpenTextbox
	ld a, $0B
	call Function1617
	ld a, $0C
	call Function1617
	ld hl, SilentLabP1TextString10
	call OpenTextbox
	ld hl, SilentLabP1TextString15
	call OpenTextbox
	ld hl, wd41c
	set 4, [hl]
	call Function20f8
	ld a, $0B
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentLabP1Script12: ; 4E72
	call SilentLabP1MoveDown
	ret z
	call SilentLabP1RivalMovePokemon
	ret z
	ld hl, SilentLabP1NPCIDs6
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1RivalMovePokemon: ; 4E84
	ld a, [wYCoord]
	cp 8
	ret nz
	ld hl, SilentLabP1Movement9
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, SilentLabP1Movement10
.jump	
	push hl
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	pop hl
	ld a, 5
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0C
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret
	
SilentLabP1Movement9: ; 4EDE
	db $08, $0B, $0B, $08, $08, $04, $32
	
SilentLabP1Movement10: ; 4EC5
	db $08, $0B, $08, $08, $04, $32
	
SilentLabP1Script13: ; 4ECB
	ld hl, SilentLabP1TextString17
	call OpenTextbox
	call GetLabPokemon
	ld hl, wc5ed
	set 7, [hl]
	ld a, 8
	ld [wd637], a
	ld a, $0D
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
GetLabPokemon: ; 4EE7
	ld hl, LabPokemon
	ld a, [wd266]
	ld b, a
.loop
	ld a, [hl+]
	cp b
	jr nz, .jump
	ld a, [hl]
	ld [wce05], a
	ld a, 9
	ld [wce02], a
	ret
.jump
	inc hl
	jr .loop
	
LabPokemon: ; 4EFF
	db DEX_KURUSU 
	db 1 
	db DEX_HAPPA 
	db 2 
	db DEX_HONOGUMA 
	db 3 
	
SilentLabP1Script14: ; 4F05
	ld hl, SilentLabP1TextString19
	ld a, [wcd5d]
	and a
	jr nz, .skip
	ld hl, SilentLabP1TextString18
.skip
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call Function17f9
	ld a, 5
	ld hl, SilentLabP1Movement11
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $0E
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP1Movement11: ; 4F36
	db $04, $08, $08, $08, $33
	
SilentLabP1Script15: ; 4F3B
	call Function20f8
	ld a, $0F
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentLabP1Script16: ; 4F47
	call SilentLabP1MoveDown
	ret z
	call SilentLabP1MoveRivalLeave
	ret z
	ld hl, SilentLabP1NPCIDs7
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1MoveRivalLeave: ; 4F59
	ld a, [wYCoord]
	cp $0B
	ret nz
	ld hl, Movememt12+1
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, Movememt12
.jump
	push hl
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 8
	call Function17f9
	pop hl
	ld a, 8
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, $10
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	call ClearAccumulator
	ret
	
Movememt12:; 4F93
	db $07, $07, $07, $05, $32
	
SilentLabP1Script17: ; 4F98
	ld hl, SilentLabP1TextString23
	call OpenTextbox
	ld hl, wd41d
	set 2, [hl]
	ld hl, wNumBagItems
	ld a, 5
	ld [wCurItem], a
	ld a, 6
	ld [wItemQuantity], a
	call AddItemToInventory
	call Function20f8
	ld a, $11
	ld [wMapScriptNumber], a
	ret
	
SilentLabP1Script18: ; 4FBC
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs7
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1Script19: ; 4FCA
	call SilentLabP1MoveDown
	ret z
	ld hl, SilentLabP1NPCIDs9
	ld de, SilentLabP1TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP1TextPointers2: ; 4FD8
	dw SilentLabP1Text1
	dw SilentLabP1Text2 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw Function3899 
	dw SilentLabP1Text3 
	
SilentLabP1Text1: ; 4FF6
	ld hl, SilentLabP1TextString1
	call OpenTextbox
	ret
	
SilentLabP1TextString1: ; 4FFD
	text "パソコンを　みると"
	line "なんと　メールが　きていた！"
	
	para "<⋯⋯>　<⋯⋯>　<⋯⋯>"
	line "オーキドはかせ！"
	cont "あなたが　ゆくえふめいに"
	cont "なっていると　せけんは"
	cont "おおさわぎ　です！"
	
	para "それは　そうと"
	line "はかせ　から　みつけるように"
	cont "たのまれた　れいの#"
	cont "みつけるどころか"
	cont "まだ　てがかりも"
	cont "つかむことが　できません"
	
	para "やはり　あいつは"
	line "かくうの　#なのでは"
	cont "ないでしょうか<⋯⋯>"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>じょしゅより"
	done
	
SilentLabP1Text2: ; 50B3
	ld hl, wd39d
	bit 0, [hl]
	set 0, [hl]
	jr z, .jump
	res 0, [hl]
	ld hl, SilentLabP1TextString2A
	jr .skip
.jump
	ld hl, SilentLabP1TextString2B
.skip
	call OpenTextbox
	ret
	
SilentLabP1TextString2A: ; 50CA
	text "スタート　ボタンを　プシュ！"
	line "おすと　メニューが　ひらくなり"
	done
	
SilentLabP1TextString2B: ; 50EA
	text "セーブするには　#　レポート"
	line "こまめに　かくと　いいなり"
	done
	
SilentLabP1Text3: ; 5108
	ld hl, SilentLabP1TextString3
	call OpenTextbox
	ret
	
SilentLabP1TextString3: ; 510F
	text "カギが　かかっている"
	done
	
SilentLabP1Text4: ; 511B
	ld a, [wMapScriptNumber]
	cp $0E
	jp nc, SilentLabP1Text7
	ld hl, SilentLabP1TextString4
	call OpenTextbox
	ret
	
SilentLabP1TextString4: ; 512A
	text "オーキド『ごくろうさん！"
	done
	
SilentLabP1TextString5: ; 5138
	text "オーキド『そうとも！"
	line "わしが　オーキドじゃ！"
	cont "じじいで　わるかったな！"
	
	para "おまえたち　ふたりは"
	line "この　オーキドが　よんだのじゃ！"
	
	para "すこし　わしの　はなしを"
	line "きいては　くれんか？@"
	db $08
	
SilentLabP1Text6: ; 5192
	call YesNoBox
	jr c, .jump
.loop
	ld hl, SilentLabP1TextString6A
	call PrintText
	call Function3036
	ret

.jump
	ld hl, SilentLabP1TextString6B
	call PrintText
	call YesNoBox
	jr c, .jump
	jr .loop
	
SilentLabP1TextString6A: ; 51AE
	text "オーキド『いまから　１ねんまえ"
	line "わしは　カントーで"
	cont "きみたちの　ような　しょうねんに"
	cont "#の　けんきゅうの　ため"
	cont "#と　ずかんを　わたした"
	
	para "そして　かれらは"
	line "じつに　よくやってくれた！"
	
	para "１５０しゅるいの"
	line "#を　みつけることに"
	cont "せいこう　したのじゃ！"
	cont "が　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	cont "しかし　<⋯⋯>　<⋯⋯>"
	
	para "せかいは　ひろいものじゃ"
	line "そのご　ぜんこく　かくちで"
	cont "あたらしい　#が　ぞくぞくと"
	cont "みつかっておる！"
	
	para "そこで　わしは　カントーから"
	line "ここ　サイレントヒルに"
	cont "けんきゅうの　ばしょを　うつした"
	
	para "ばしょが　かわれば"
	line "あたらしい　#にも"
	cont "であうことが　できるからな"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	
	para "これからも　どんどんと"
	line "けんきゅうを　すすめるが"
	cont "わしも　ごらんのとおりの　おいぼれ"
	cont "まごや　じょしゅたちも　おるが"
	cont "それでも　やはり　かずが　たらん！"
	
	para "<PLAYER>！　<RIVAL>！"
	line "#けんきゅうの　ために"
	cont "ちからを　かして　くれんか！"
	done
	
SilentLabP1TextString6B: ; 5332
	text "オーキド『そうか<⋯⋯>"
	line "わしに　ひとを　みるめが"
	cont "なかったと　いうことじゃな<⋯⋯>"
	
	para "いや！"
	line "わしの　ひとを　みるめは"
	cont "まちがっては　おらんはず！"
	
	para "な？"
	cont "わしの　はなしを　きいてくれるな？"
	done
	
SilentLabP1TextString7: ; 538D
	text "オーキド『ふたりとも！"
	line "ちょっと　わしに　ついてこい！"
	done
	
SilentLabP1Text7: ; 53AA
	ld a, [wMapScriptNumber]
	cp $12
	jr z, .jump
	ld hl, SilentLabP1TextString11A
	call OpenTextbox
	ret

.jump	
	ld hl, SilentLabP1TextString11B
	call OpenTextbox
	ret
	
SilentLabP1TextString8: ; 53BF
	text "オーキド『<PLAYER>！<RIVAL>！"
	line "このずかんを"
	cont "おまえたちに　あずける！"
	done
	
SilentLabP1TextString9: ; 53DE
	text "<PLAYER>は　オーキドから"
	line "#ずかんを　もらった！"
	done
	
SilentLabP1TextString10: ; 53F5
	text "オーキド『この　せかいの　すべての"
	line "#を　きろくした"
	cont "かんぺきな　ずかんを　つくること！"
	cont "それが　わしの　ゆめ　だった！"
	
	para "しかし　しんしゅの　#は"
	cont "ぞくぞくと　みつかっている！"
	
	para "わしに　のこされた"
	line "じかんは　すくない！"
	
	para "そこで　おまえ　たちには"
	line "わしの　かわりに"
	cont "ゆめを　はたして　ほしいのじゃ！"
	
	para "さあ　ふたりとも"
	line "さっそく　しゅっぱつ　してくれい！"
	cont "これは　#の　れきしに　のこる"
	cont "いだいな　しごとじゃー！"
	done
	
SilentLabP1TextString11A: ; 54C3
	text "オーキド『せかい　じゅうの"
	line "#たちが"
	cont "<PLAYER>を　まって　おるぞー"
	done
	
SilentLabP1TextString11B: ; 54E3
	text "オーキド『おう！　<PLAYER>"
	line "どうだ？"
	cont "わしの　あげた　#は<⋯⋯>？"
	
	para "ほう！"
	cont "だいぶ　なついた　みたいだな"
	
	para "おまえには　#トレーナーの"
	line "さいのうが　あるかもしれん"
	cont "これからも　ときどきは"
	cont "わしのところへ　かおを　だせ！"
	
	para "#ずかんの　ぺージが"
	line "きに　なるからな"
	done
	
SilentLabP1Text8: ; 5560
	ld hl, SilentLabP1TextString12
	call OpenTextbox
	ret
	
SilentLabP1TextString12: ; 5567
	text "オーキド『よく　きたな！"
	line "#ずかんの"
	cont "ちょうしは　どうかな？"
	
	para "どれ<⋯⋯>　ちょっと"
	cont "みて　あげようか！"
	done
	
SilentLabP1Text9: ; 559A
	ld hl, SilentLabP1TextString13
	call OpenTextbox
	ret
	
SilentLabP1TextString13: ; 55A1
	text "オーキド『<⋯⋯>　おっほんッ！"
	line "よくやったな　<PLAYER>！"
	
	para "ちょっと"
	line "わしに　ついて　きなさい！"
	
	para "<RIVAL>は　すまんが"
	line "そこで　まっていなさい！"
	
	para "<RIVAL>『えー！"
	line "なんだよ　ケチー！"
	
	para "オーキド『<RIVAL>は"
	line "でんせつの　#が"
	cont "ほしかった　だけじゃないのか？"
	cont "<RIVAL>『ギクッ！"
	done
	
SilentLabP1Text10: ; 561A
	ld hl, SilentLabP1TextString14
	call OpenTextbox
	ret
	
SilentLabP1TextString14: ; 5621
	text "<RIVAL>『なんだ"
	line "<PLAYER>じゃないか！"
	cont "おれも　ここが"
	cont "あやしいと　おもって　きたんだけど"
	cont "だれも　いないみたいだな<⋯⋯>"
	done
	
SilentLabP1Text11: ; 5658
	ld hl, SilentLabP1TextString16
	call OpenTextbox
	ret
	
SilentLabP1TextString15: ; 565F
	text "<RIVAL>『よっしゃあ！"
	line "じいさん！　おれにまかせな！"
	done
	
SilentLabP1TextString16: ; 5678
	text "<RIVAL>『おれが　えらんだ"
	line "#のほうが　つよそうだぜ！"
	cont "こっちに　したかったんじゃないの？"
	done
	
SilentLabP1TextString17: ; 56A4
	text "<RIVAL>『<PLAYER>！"
	line "せっかく　じいさんに"
	cont "#　もらったんだから"
	cont "<⋯⋯>　ちょっと"
	cont "たたかわせて　みようぜ！"
	done
	
SilentLabP1TextString18: ; 56D4
	text "<RIVAL>『くっそー！"
	line "こんどは　ぜったい　まけないぞ！"
	done
	
SilentLabP1TextString19: ; 56EE
	text "<RIVAL>『よーし！"
	line "ほかの　#と　たたかわせて"
	cont "もっと　もっと　つよくしよう！"
	
	para "そんじゃ　ばいばい！"
	done
	
SilentLabP1TextString20: ; 571F
	text "じいちゃん！"
	line "つれてきたよー！"
	done
	
SilentLabP1TextString21: ; 5730
	text "ぼくは　かつて"
	line "#トレーナーの　ちょうてんを"
	cont "めざしたことが　あるんだ"
	cont "そのとき　いいきに　なっていた"
	cont "ぼくの　てんぐのはなを"
	cont "へしおった　やつに"
	cont "きみは　どことなく　にている"
	
	para "あいつの　おかげで　ぼくは"
	line "こころを　いれかえて"
	cont "じいさんの　けんきゅうを"
	cont "てつだうように　なったのさ"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	
	para "さあ！"
	line "これが　#ずかんだ！"
	
	para "みつけた　#の　データが"
	line "じどうてきに　かきこまれて"
	cont "ぺージが　ふえて　いく　という"
	cont "とても　ハイテクな　ずかん　だよ！"
	done
	
SilentLabP1Text12: ; 5814
	ld hl, SilentLabP1TextString22
	call OpenTextbox
	ret
	
SilentLabP1TextString22: ; 581B
	text "ぼくも　むかし　やったけど"
	line "なかなか　たいへんだよ<⋯⋯>"
	cont "がんばってね！"
	done
	
SilentLabP1Text13: ; 583F
	ld hl, SilentLabP1TextString24
	call OpenTextbox
	ret
	
SilentLabP1TextString23: ; 5846
	text "ナナミ『さっき　あなたを　"
	line "つれてきた　わかい　おとこのこ<⋯⋯>"
	cont "あれは　わたしの　おとうとなの"
	cont "<⋯⋯>ということは　つまり"
	
	para "そう！"
	line "わたしも　オーキドの　まご　なの！"
	
	para "おじいちゃんは　りっぱな"
	cont "#けんきゅうしゃよ"
	cont "わたしは　おてつだい　できることが"
	cont "とっても　うれしいの！"
	cont "あっ　こんなこと　しられたら"
	cont "おじいちゃん　ちょうしに　のるから"
	cont "ないしょに　しておいてね！"
	
	para "<⋯⋯>おじいちゃん　すっかり"
	line "わすれている　みたいだから"
	
	para "わたしが　かわりに　これを　あげる！"
	line "さいしんがた　#りュックよ"
	
	para "<PLAYER>は"
	line "#りュックを　もらった！"
	
	para "ナナミ『この　りュックには"
	line "モンスターボールを"
	cont "まとめて　いれられる"
	cont "ボールホルダと"
	cont "わざマシンを　まとめて　いれられる"
	cont "わざマシンホルダが　ついているの"
	
	para "モンスターボール　６こと　"
	line "わざマシンひとつは　オマケしておくわ"
	cont "ホルダに　なんにも　はいってないと"
	cont "さびしいもんね！"
	
	para "ねえ　<PLAYER>くン"
	line "あなたの　おかあさんが"
	cont "しんぱいすると　いけないから"
	cont "このまちを　でるまえに"
	cont "かおを　みせに　いってあげてね"
	
	para "<⋯⋯>あなたの　かつやく"
	line "いのっているわ"
	done
	
SilentLabP1TextString24: ; 5A23
	text "<⋯⋯>あなたの　かつやく"
	line "いのってるわ"
	done
	
SilentLabP1Text14: ; 5A36
	ld hl, SilentLabP1TextString25
	call OpenTextbox
	ret
	
SilentLabP1TextString25: ; 5A3D
	text "わたしは"
	line "はかせの　じょしゅ　です"
	
	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"
	
	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
	
SilentLabP1Text15: ; 5A90
	ld hl, SilentLabP1TextString26
	call OpenTextbox
	ret
	
SilentLabP1TextString26: ; 5A97
	text "わたしは"
	line "はかせの　じょしゅ　です"
	
	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"
	
	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
	
SilentLabP1Text16: ; 5AEA
	ld hl, SilentLabP1TextString27
	call OpenTextbox
	ret
	
SilentLabP1TextString27: ; 5AF1
	text "なんだろう？"
	line "でんし　てちょう　かな？"
	done
	
SilentLabP1Text17: ; 5B05
	ld hl, SilentLabP1TextString28
	call OpenTextbox
	ret
	
SilentLabP1TextString28: ; 5B0D
	text "<RIVAL>『あのメールを　くれた"
	line "オーキドって　こんな　じじい<⋯⋯>"
	
	para "あっ　ゴメン"
	line "こんな　じいさん　なのか？"
	cont "ほんもの　はじめて　みたよ！"
	done
	
SilentLabP1TextString29: ; 5B4F
	text "<RIVAL>『<PLAYER>！"
	line "なんだか"
	cont "おもしろく　なってきたな！"
	done
	
SilentLabP1Text18: ; 5B68
	ld hl, SilentLabP1TextString30
	call OpenTextbox
	ret
	
SilentLabP1TextString30: ; 5B6F
	text "わたしは"
	line "はかせの　じょしゅ　です"
	
	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
	
SilentLabP1Text19: ; 5BA7
	ld hl, SilentLabP1TextString31
	call OpenTextbox
	ret
	
SilentLabP1TextString31: ; 5BAE
	text "わたしは"
	line "はかせの　じょしゅ　です"
	
	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
	
; 5BE6