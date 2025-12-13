INCLUDE "constants.asm"

SECTION "scripts/SilentHillLabFront.asm", ROMX

SilentHillLabFront_ScriptLoader::
	ld hl, SilentHillLabFrontScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillLabFrontScriptPointers:
	dw SilentHillLabFrontScript1
	dw SilentHillLabFrontNPCIDs1

	dw SilentHillLabFrontScript2
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript3
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript4
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontConversation1
	dw SilentHillLabFrontNPCIDs2

	dw SilentHillLabFrontScript6
	dw SilentHillLabFrontNPCIDs3

	dw SilentHillLabFrontScript7
	dw SilentHillLabFrontNPCIDs4

	dw SilentHillLabFrontScript8
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript9
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript10
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript11
	dw SilentHillLabFrontNPCIDs5

	dw SilentHillLabFrontScript12
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript13
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript14
	dw SilentHillLabFrontNPCIDs6

	dw SilentHillLabFrontScript15
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript16
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript17
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript18
	dw SilentHillLabFrontNPCIDs7

	dw SilentHillLabFrontScript19
	dw SilentHillLabFrontNPCIDs9

SilentHillLabFrontNPCIDs1:
	db $02
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs2:
	db $00
	db $02
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs3:
	db $02
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs4:
	db $04
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs5:
	db $01
	db $03
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs6:
	db $01
	db $03
	db $05
	db $06
	db $07
	db $08
	db $FF
SilentHillLabFrontNPCIDs7:
	db $00
	db $05
	db $06
	db $07
	db $08
	db $FF
SilentHillLabFrontNPCIDs8: ; (unused?)
	db $00
	db $03
	db $05
	db $06
	db $07
	db $08
	db $09
	db $0A
	db $FF
SilentHillLabFrontNPCIDs9:
	db $00
	db $07
	db $08
	db $FF

SilentHillLabFront_TextPointers::
	dw SilentHillLabFrontText4
	dw SilentHillLabFrontText7
	dw SilentHillLabFrontText10
	dw SilentHillLabFrontText11
	dw SilentHillLabFrontTextString20
	dw SilentHillLabFrontText12
	dw SilentHillLabFrontText13
	dw SilentHillLabFrontText14
	dw SilentHillLabFrontText15
	dw SilentHillLabFrontText16
	dw SilentHillLabFrontText16

SilentHillLabFrontScript1:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs1
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveDown:
	ld a, [wXCoord]
	cp 4
	ret nz
	ld a, [wYCoord]
	cp 1
	ret nz
	ldh a, [hJoyState]
	bit 6, a
	jp z, xor_a_dec_a
	call SilentHillLabFrontText3
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call FreezeAllOtherObjects
	ld a, 0
	ld hl, SilentHillLabFrontMovement1
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

SilentHillLabFrontMovement1:
	slow_step LEFT
	step_end

SilentHillLabFrontScript2:
	ld a, 2
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontScript3:
	ld a, 6
	call FreezeAllOtherObjects
	ld a, 0
	call UnfreezeObject
	ld b, 6
	ld c, 0
	call StartFollow
	ld hl, SilentHillLabFrontMovement2
	ld a, 6
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 3
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement2:
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	step UP
	slow_step UP
	slow_step RIGHT
	turn_head UP
	step_end

SilentHillLabFrontScript4:
	call FreezeAllObjects
	ld a, 4
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontConversation1:
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString20
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ld a, 4
	ld d, UP
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString5
	call OpenTextbox
	ld a, 4
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString29
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString7
	call OpenTextbox
	call SilentHillLabFrontScript5
	ret

SilentHillLabFrontScript5:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 2
	call FreezeAllOtherObjects
	ld a, 2
	ld hl, SilentHillLabFrontMovement3
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 5
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement3:
	step UP
	slow_step UP
	remove_object

SilentHillLabFrontScript6:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 4
	call FreezeAllOtherObjects
	ld a, 4
	ld hl, SilentHillLabFrontMovement4
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 6
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement4:
	big_step UP
	big_step UP
	big_step RIGHT
	big_step UP
	big_step UP
	remove_object

SilentHillLabFrontScript7:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call FreezeAllOtherObjects
	ld a, 0
	ld hl, SilentHillLabFrontMovement5
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 7
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement5:
	step UP
	step UP
	step UP
	slow_step UP
	step_end

SilentHillLabFrontScript8:
	ld a, 3
	call SetObjectLowPriority
	ld a, 5
	call SetObjectLowPriority
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call FreezeAllOtherObjects
	ld a, 0
	ld hl, SilentHillLabFrontMovement6
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 8
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement6:
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	slow_step LEFT
	step_end

SilentHillLabFrontScript9:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call FreezeAllOtherObjects
	ld a, 5
	call ResetObjectLowPriority
	ld a, 5
	ld hl, SilentHillLabFrontMovement7
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, 9
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement7:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step LEFT
	slow_step LEFT
	step_end

SilentHillLabFrontScript10:
	ld a, 5
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillLabFrontTextString21
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
	call FreezeAllOtherObjects
	ld a, 3
	call ResetObjectLowPriority
	ld a, 3
	ld hl, SilentHillLabFrontMovement8
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, $0A
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement8:
	step DOWN
	slow_step DOWN
	step_end

SilentHillLabFrontScript11:
	ld hl, SilentHillLabFrontTextString8
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString9
	call OpenTextbox
	ld a, $0B
	call ApplyDeletionToMapObject
	ld a, $0C
	call ApplyDeletionToMapObject
	ld hl, SilentHillLabFrontTextString10
	call OpenTextbox
	ld hl, SilentHillLabFrontTextString15
	call OpenTextbox
	ld hl, wd41c
	set 4, [hl]
	call Function20f8
	ld a, $0B
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

SilentHillLabFrontScript12:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontRivalMovePokemon
	ret z
	ld hl, SilentHillLabFrontNPCIDs6
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontRivalMovePokemon:
	ld a, [wYCoord]
	cp 8
	ret nz
	ld hl, SilentHillLabFrontMovement9
	ld a, [wXCoord]
	cp 3
	jr z, .jump
	cp 4
	ret nz
	ld hl, SilentHillLabFrontMovement10
.jump
	push hl
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call FreezeAllOtherObjects
	pop hl
	ld a, 5
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, $0C
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

SilentHillLabFrontMovement9:
	step DOWN
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	slow_step DOWN
	step_end

SilentHillLabFrontMovement10:
	step DOWN
	step RIGHT
	step DOWN
	step DOWN
	slow_step DOWN
	step_end

SilentHillLabFrontScript13:
	ld hl, SilentHillLabFrontTextString17
	call OpenTextbox
	call GetLabPokemon
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, MAPSTATUS_START_TRAINER_BATTLE
	ld [wMapStatus], a
	ld a, $0D
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

GetLabPokemon:
	ld hl, LabPokemon
	ld a, [wd266]
	ld b, a
.loop
	ld a, [hl+]
	cp b
	jr nz, .jump
	ld a, [hl]
	ld [wOtherTrainerID], a
	ld a, 9
	ld [wOtherTrainerClass], a
	ret
.jump
	inc hl
	jr .loop

LabPokemon:
	db DEX_KURUSU
	db 1
	db DEX_HAPPA
	db 2
	db DEX_HONOGUMA
	db 3

SilentHillLabFrontScript14:
	ld hl, SilentHillLabFrontTextString19
	ld a, [wBattleResult]
	and a
	jr nz, .skip
	ld hl, SilentHillLabFrontTextString18
.skip
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 5
	call FreezeAllOtherObjects
	ld a, 5
	ld hl, SilentHillLabFrontMovement11
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, $0E
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabFrontMovement11:
	slow_step DOWN
	step DOWN
	step DOWN
	step DOWN
	remove_object

SilentHillLabFrontScript15:
	call Function20f8
	ld a, $0F
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

SilentHillLabFrontScript16:
	call SilentHillLabFrontMoveDown
	ret z
	call SilentHillLabFrontMoveRivalLeave
	ret z
	ld hl, SilentHillLabFrontNPCIDs7
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontMoveRivalLeave:
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
	call FreezeAllOtherObjects
	pop hl
	ld a, 8
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set 7, [hl]
	ld a, $10
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	call xor_a
	ret

Movememt12:
	slow_step RIGHT
	slow_step RIGHT
	slow_step RIGHT
	slow_step UP
	step_end

SilentHillLabFrontScript17:
	ld hl, SilentHillLabFrontTextString23
	call OpenTextbox
	ld hl, wd41d
	set 2, [hl]
	ld hl, wNumBagItems
	ld a, 5
	ld [wCurItem], a
	ld a, 6
	ld [wItemQuantity], a
	call ReceiveItem
	call Function20f8
	ld a, $11
	ld [wMapScriptNumber], a
	ret

SilentHillLabFrontScript18:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs7
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontScript19:
	call SilentHillLabFrontMoveDown
	ret z
	ld hl, SilentHillLabFrontNPCIDs9
	ld de, SilentHillLabFrontTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabFrontTextPointers2:
	dw SilentHillLabFrontText1
	dw SilentHillLabFrontText2
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw SilentHillLabFrontText3

SilentHillLabFrontText1:
	ld hl, SilentHillLabFrontTextString1
	call OpenTextbox
	ret

SilentHillLabFrontTextString1:
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

SilentHillLabFrontText2:
	ld hl, wd39d
	bit 0, [hl]
	set 0, [hl]
	jr z, .jump
	res 0, [hl]
	ld hl, SilentHillLabFrontTextString2A
	jr .skip
.jump
	ld hl, SilentHillLabFrontTextString2B
.skip
	call OpenTextbox
	ret

SilentHillLabFrontTextString2A:
	text "スタート　ボタンを　プシュ！"
	line "おすと　メニューが　ひらくなり"
	done

SilentHillLabFrontTextString2B:
	text "セーブするには　#　レポート"
	line "こまめに　かくと　いいなり"
	done

SilentHillLabFrontText3:
	ld hl, SilentHillLabFrontTextString3
	call OpenTextbox
	ret

SilentHillLabFrontTextString3:
	text "カギが　かかっている"
	done

SilentHillLabFrontText4:
	ld a, [wMapScriptNumber]
	cp $0E
	jp nc, SilentHillLabFrontText7
	ld hl, SilentHillLabFrontTextString4
	call OpenTextbox
	ret

SilentHillLabFrontTextString4:
	text "オーキド『ごくろうさん！"
	done

SilentHillLabFrontTextString5:
	text "オーキド『そうとも！"
	line "わしが　オーキドじゃ！"
	cont "じじいで　わるかったな！"

	para "おまえたち　ふたりは"
	line "この　オーキドが　よんだのじゃ！"

	para "すこし　わしの　はなしを"
	line "きいては　くれんか？@"
	db $08

SilentHillLabFrontText6:
	call YesNoBox
	jr c, .jump
.loop
	ld hl, SilentHillLabFrontTextString6A
	call PrintText
	call Function3036
	ret

.jump
	ld hl, SilentHillLabFrontTextString6B
	call PrintText
	call YesNoBox
	jr c, .jump
	jr .loop

SilentHillLabFrontTextString6A:
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

SilentHillLabFrontTextString6B:
	text "オーキド『そうか<⋯⋯>"
	line "わしに　ひとを　みるめが"
	cont "なかったと　いうことじゃな<⋯⋯>"

	para "いや！"
	line "わしの　ひとを　みるめは"
	cont "まちがっては　おらんはず！"

	para "な？"
	cont "わしの　はなしを　きいてくれるな？"
	done

SilentHillLabFrontTextString7:
	text "オーキド『ふたりとも！"
	line "ちょっと　わしに　ついてこい！"
	done

SilentHillLabFrontText7:
	ld a, [wMapScriptNumber]
	cp $12
	jr z, .jump
	ld hl, SilentHillLabFrontTextString11A
	call OpenTextbox
	ret

.jump
	ld hl, SilentHillLabFrontTextString11B
	call OpenTextbox
	ret

SilentHillLabFrontTextString8:
	text "オーキド『<PLAYER>！<RIVAL>！"
	line "このずかんを"
	cont "おまえたちに　あずける！"
	done

SilentHillLabFrontTextString9:
	text "<PLAYER>は　オーキドから"
	line "#ずかんを　もらった！"
	done

SilentHillLabFrontTextString10:
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

SilentHillLabFrontTextString11A:
	text "オーキド『せかい　じゅうの"
	line "#たちが"
	cont "<PLAYER>を　まって　おるぞー"
	done

SilentHillLabFrontTextString11B:
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

SilentHillLabFrontText8:
	ld hl, SilentHillLabFrontTextString12
	call OpenTextbox
	ret

SilentHillLabFrontTextString12:
	text "オーキド『よく　きたな！"
	line "#ずかんの"
	cont "ちょうしは　どうかな？"

	para "どれ<⋯⋯>　ちょっと"
	cont "みて　あげようか！"
	done

SilentHillLabFrontText9:
	ld hl, SilentHillLabFrontTextString13
	call OpenTextbox
	ret

SilentHillLabFrontTextString13:
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

SilentHillLabFrontText10:
	ld hl, SilentHillLabFrontTextString14
	call OpenTextbox
	ret

SilentHillLabFrontTextString14:
	text "<RIVAL>『なんだ"
	line "<PLAYER>じゃないか！"
	cont "おれも　ここが"
	cont "あやしいと　おもって　きたんだけど"
	cont "だれも　いないみたいだな<⋯⋯>"
	done

SilentHillLabFrontText11:
	ld hl, SilentHillLabFrontTextString16
	call OpenTextbox
	ret

SilentHillLabFrontTextString15:
	text "<RIVAL>『よっしゃあ！"
	line "じいさん！　おれにまかせな！"
	done

SilentHillLabFrontTextString16:
	text "<RIVAL>『おれが　えらんだ"
	line "#のほうが　つよそうだぜ！"
	cont "こっちに　したかったんじゃないの？"
	done

SilentHillLabFrontTextString17:
	text "<RIVAL>『<PLAYER>！"
	line "せっかく　じいさんに"
	cont "#　もらったんだから"
	cont "<⋯⋯>　ちょっと"
	cont "たたかわせて　みようぜ！"
	done

SilentHillLabFrontTextString18:
	text "<RIVAL>『くっそー！"
	line "こんどは　ぜったい　まけないぞ！"
	done

SilentHillLabFrontTextString19:
	text "<RIVAL>『よーし！"
	line "ほかの　#と　たたかわせて"
	cont "もっと　もっと　つよくしよう！"

	para "そんじゃ　ばいばい！"
	done

SilentHillLabFrontTextString20:
	text "じいちゃん！"
	line "つれてきたよー！"
	done

SilentHillLabFrontTextString21:
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

SilentHillLabFrontText12:
	ld hl, SilentHillLabFrontTextString22
	call OpenTextbox
	ret

SilentHillLabFrontTextString22:
	text "ぼくも　むかし　やったけど"
	line "なかなか　たいへんだよ<⋯⋯>"
	cont "がんばってね！"
	done

SilentHillLabFrontText13:
	ld hl, SilentHillLabFrontTextString24
	call OpenTextbox
	ret

SilentHillLabFrontTextString23:
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

SilentHillLabFrontTextString24:
	text "<⋯⋯>あなたの　かつやく"
	line "いのってるわ"
	done

SilentHillLabFrontText14:
	ld hl, SilentHillLabFrontTextString25
	call OpenTextbox
	ret

SilentHillLabFrontTextString25:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText15:
	ld hl, SilentHillLabFrontTextString26
	call OpenTextbox
	ret

SilentHillLabFrontTextString26:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "わたしは　もちろん"
	line "はかせを　ソンケー　しております"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText16:
	ld hl, SilentHillLabFrontTextString27
	call OpenTextbox
	ret

SilentHillLabFrontTextString27:
	text "なんだろう？"
	line "でんし　てちょう　かな？"
	done

SilentHillLabFrontText17:
	ld hl, SilentHillLabFrontTextString28
	call OpenTextbox
	ret

SilentHillLabFrontTextString28:
	text "<RIVAL>『あのメールを　くれた"
	line "オーキドって　こんな　じじい<⋯⋯>"

	para "あっ　ゴメン"
	line "こんな　じいさん　なのか？"
	cont "ほんもの　はじめて　みたよ！"
	done

SilentHillLabFrontTextString29:
	text "<RIVAL>『<PLAYER>！"
	line "なんだか"
	cont "おもしろく　なってきたな！"
	done

SilentHillLabFrontText18:
	ld hl, SilentHillLabFrontTextString30
	call OpenTextbox
	ret

SilentHillLabFrontTextString30:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done

SilentHillLabFrontText19:
	ld hl, SilentHillLabFrontTextString31
	call OpenTextbox
	ret

SilentHillLabFrontTextString31:
	text "わたしは"
	line "はかせの　じょしゅ　です"

	para "あなた　とは　また　どこかで"
	line "おあい　することに"
	cont "なるような　きがします"
	done
