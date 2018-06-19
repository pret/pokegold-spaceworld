INCLUDE "constants.asm"

SECTION "Main Menu", ROMX[$53CC], BANK[$01]

MainMenu:: ; 01:53CC
	ld hl, wd4a9 
	res 0, [hl]
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFontExtra
	call LoadFont
	call ClearWindowData
	call Function5388
	ld hl, wce60
	bit 0, [hl]
	jr nz, .setMenuContinue
	xor a
	jr .skip
.setMenuContinue
	ld a, M_CONTINUE
.skip
	ldh a, [hJoyState]
	and D_DOWN | B_BUTTON | A_BUTTON
	cp D_DOWN | B_BUTTON | A_BUTTON
	jr nz, .setMenuPlay
	ld a, M_SET_TIME
	jr .triggerMenu
.setMenuPlay
	ld a, M_PLAY_GAME
.triggerMenu
	ld [wWhichIndexSet], a
	ld hl, MainMenuHeader
	call LoadMenuHeader
	call OpenMenu
	call CloseWindow
	jp c, TitleSequenceStart
	ld hl, MainMenuJumptable
	ld a, [wMenuSelection]
	jp CallJumptable

MainMenuHeader: ; 01:5418
	db $40
	menu_coords 0, 0, 13, 7
	dw .MenuData
	db 1 ; default option

.MenuData: ; 01:5420
	db $80
	db 0 ; items
	dw MainMenuItems
	db $8a, $1f
	dw .Strings

.Strings: ; 01:5428
	db "つづきから　はじめる@"
	db "さいしょから　はじめる@"
	db "せっていを　かえる@"
	db "#を　あそぶ@"
	db "じかんセット@"

MainMenuJumptable: ; 01:5457
	dw MainMenuOptionContinue
	dw StartNewGame
	dw MenuCallSettings
	dw StartNewGame
	dw MainMenuOptionSetTime

MainMenuItems:

NewGameMenu:
	db 2
	db NEW_GAME
	db OPTION
	db -1

ContinueMenu:
	db 3
	db CONTINUE
	db NEW_GAME
	db OPTION
	db -1

PlayPokemonMenu:
	db 2
	db PLAY_POKEMON
	db OPTION
	db -1

PlayPokemonSetTimeMenu:
	db 3
	db PLAY_POKEMON
	db OPTION
	db SET_TIME
	db -1

MainMenuOptionSetTime:: ; 5473
	callab SetTime
	ret

MainMenuOptionContinue:: ;547C
	callab Function14624
	call DisplayContinueGameInfo
.loop
	call ClearJoypad
	call GetJoypad
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jr nz, .escape
	bit B_BUTTON_F, a
	jp nz, MainMenu
	jr .loop
.escape
	call $5397 ; todo
	call $53B0 ; todo
	ld hl, wDebugFlags
	res DEBUG_FIELD_F, [hl]
	set 2, [hl]
	set 3, [hl]
	ldh a, [hJoyState]
	bit SELECT_F, a
	jr z, .skip
	set 1, [hl]
.skip
	call ClearBGPalettes
	call ClearTileMap
	ld c, $0A
	call DelayFrames
	jp OverworldStart ; todo

DisplayContinueGameInfo:: ; 54BF
	xor a
	ldh [hBGMapMode], a
	hlcoord 4, 7
	ld b, $08
	ld c, $0D
	call DrawTextBox
	hlcoord 5, 9
	ld de, PlayerInfoText
	call PlaceString
	hlcoord 13, 9
	ld de, wPlayerName
	call PlaceString
	hlcoord 14, 11
	call PrintNumBadges
	hlcoord 13, 13
	call PrintNumOwnedMons
	hlcoord 12, 15
	call PrintPlayTime
	ld a, $01
	ldh [hBGMapMode], a
	ld c, $1E
	call DelayFrames
	ret

PrintNumBadges:: ;54FA
	push hl
	ld hl, wd163 ; badges?
	ld b, $01
	call CountSetBits
	pop hl
	ld de, wCountSetBitsResult
	ld bc, $0102 ; flags and constants for this? 1 byte source, 2 digit display
	jp PrintNumber

PrintNumOwnedMons:: ; 550D
	push hl
	ld hl, wPokedexOwned
	ld b, $20 ; flag_array NUM_POKEMON?
	call CountSetBits
	pop hl
	ld de, wCountSetBitsResult
	ld bc, $0103 ; 1 byte, 3 digit
	jp PrintNumber

PrintPlayTime:: ; 5520
	ld de, hRTCHours
	ld bc, $0103 ; 1 byte, 3 digit
	call PrintNumber
	ld [hl], "："
	inc hl
	ld de, hRTCMinutes
	ld bc, $8102 ; PRINTNUM_LEADINGZEROS, 1 byte, 2 digit
	jp PrintNumber

PlayerInfoText:
	db   "しゅじんこう"
	next "もっているバッジ　　　　こ"
	next "#ずかん　　　　ひき"
	next "プレイじかん"
	text_end
	
StartNewGame:: ; 555C
	ld de, MUSIC_NONE
	call PlayMusic
	ld de, MUSIC_OAK_INTRO
	call PlayMusic
	call LoadFontExtra
	xor a
	ldh [hBGMapMode], a
	callba Function52f9
	call ClearTileMap
	call ClearWindowData
	xor a
	ldh [hMapAnims], a
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jp z, DemoStart
	call DebugSetUpPlayer
	jp IntroCleanup
	
DemoStart:: ; 558D
	ld de, $4BD4 ; maybe this should be a macro - b is bank, de is address, c is flag
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeechDemo
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, $4D10
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call MovePicLeft
	ld a, $D0 ; todo
	ldh [rOBP0], a
	call DemoSetUpPlayer
	jp IntroCleanup
	
GameStart:: ; 55BB
	ld de, $4BD4
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech1
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld a, $C8 ;  pokemon preview ID
	ld [$CB5B], a
	ld [$CD78], a
	call GetMonHeader
	ld hl, $C2F6
	ld hl, $C2F6
	call PrepMonFrontpic
	call MovePicLeft
	ld hl, OakSpeech2
	call PrintText
	ld a, $C8 ; this should be a constant methinks
	call PlayCry
	ld hl, OakSpeech3
	call PrintText
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, $4D10
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call MovePicLeft
	ld hl, OakSpeech4
	call PrintText
	call ChoosePlayerName
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, $4ab7
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech5
	call PrintText
	call ChooseRivalName
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, $4BD4
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech6
	call PrintText
	callba SetClockDialog
	call Function04ac
	call RotateThreePalettesRight
	call ClearTileMap
	ld de, $4D10
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call RotateThreePalettesLeft
	ld hl, OakSpeech7
	call PrintText
	ldh a, [hROMBank]
	push af
	ld a, $20
	ld [wMusicFade], a
	ld de, MUSIC_NONE
	ld a, e
	ld [wMusicFadeIDLow], a
	ld a, d
	ld [wMusicFadeIDHigh], a
	ld de, $000B ; should be a constant - shrink noise?
	call PlaySFX
	pop af
	call Bankswitch
	ld c, $04
	call DelayFrames
	
IntroCleanup:: ; 568E
	ld de, $4743
	ld bc, $0400
	call IntroDisplayPicCenteredOrUpperRight
	ld c, $04
	call DelayFrames
	ld de, $479D
	ld bc, $0400
	call IntroDisplayPicCenteredOrUpperRight
	ld c, $14
	call DelayFrames
	ld hl, $C30A
	ld b, $07
	ld c, $07
	call ClearBox
	ld c, $14
	call DelayFrames
	call $5D5D
	call LoadFontExtra
	ld c, $32
	call DelayFrames
	call RotateThreePalettesRight
	call ClearTileMap
	call Function0502
	ld a, $00
	ld [wd638], a
	ld [wd637], a
	
OverworldStart::
	call SetUpGameEntry
	ld hl, wDebugFlags
	bit 2, [hl] ; ?
	call z, Function15b5
	ld hl, wd4a9
	set 0, [hl]
	jp Function2a85
	
SetUpGameEntry:: ; 56E8
	ld a, $04
	ld [wd65e], a
	ld a, $F2
	ldh [hMapEntryMethod], a
	ld hl, wDebugFlags
	bit 2, [hl] ; ?
	ret nz
	ld a, $F1
	ldh [hMapEntryMethod], a
	ld a, $00
	ld [wDebugWarpSelection], a
	ld hl, GameStartPlacement
	ld de, wMapGroup
	ld bc, $0008
	call CopyBytes
	ret
	
GameStartPlacement:: ; 570D
	db $01 ; map group 
	db $09 ; map
	dw $C633 ; screen anchor - should be coords
	db $04 ; metatile x
	db $04 ; metatile y
	db $00 ; in-metatile x
	db $01 ; in-metatile y
	
DebugSetUpPlayer:: ; 5715
	call SetPlayerNamesDebug
	ld a, $0F
	ld [wd15d], a
	ld a, $42
	ld [wd15e], a
	ld a, $3F
	ld [wd15f], a
	ld a, $FF
	ld [wd163], a
	ld [wd164], a
	call GiveRandomJohto
	ld a, $03
	call Function57eb
	call FillTMs
	ld de, DebugBagItems
	call FillBagWithList
	ld hl, wPokedexOwned
	call DebugFillPokedex
	ld hl, wPokedexSeen
	call DebugFillPokedex
	ld hl, wAnnonDex
	ld [hl], $01
	call $40FD ; todo
	ret
 
DebugFillPokedex:: ; 5755
	ld b, $1F
	ld a, $FF
.loop
	ld [hl+], a
	dec b
	jr nz, .loop 
	ld [hl], $07
	ret
	
FillBagWithList:: ; 5760
	ld hl, wNumBagItems
.loop
	ld a, [de]
	cp $FF
	jr z, .yump
	ld [wCurItem], a
	inc de
	ld a, [de] 
	inc de
	ld [wItemQuantity], a
	call AddItemToInventory
	jr .loop
.yump
	ret
	
DebugBagItems:: ; 5777
	db ITEM_IMPORTANT_BAG, $01 
	db ITEM_BAG, $01 
	db ITEM_TM_HOLDER, $01 
	db ITEM_BALL_HOLDER, $01 
	db ITEM_BICYCLE, $01 
	db ITEM_MAIL, $06 
	db ITEM_ULTRA_BALL, $1E 
	db ITEM_POKE_BALL, $63 
	db ITEM_POTION, $1E 
	db ITEM_RARE_CANDY, $14 
	db ITEM_MOON_STONE, $63 
	db ITEM_FULL_HEAL, $63 
	db ITEM_PROTEIN, $63 
	db ITEM_QUICK_NEEDLE, $63 
	db ITEM_SNAKESKIN, $63 
	db ITEM_KINGS_ROCK, $63 
	db ITEM_FLEE_FEATHER, $63 
	db ITEM_FOCUS_ORB, $63 
	db ITEM_SHARP_SCYTHE, $63 
	db ITEM_DETECT_ORB, $63 
	db $FF
	
Function57A0 ; 57A0
	and a
	ret z
.loop
	push af
	call RandomOver246
	ld b, $0A
	call GivePokemon
	pop af
	dec a
	jr nz, .loop
	ret
 
GiveRandomJohto::  ; 57B0
.loop  
	call Random
	and $03
	jr z, .loop
	dec a
	ld b, a
	add a, a
	add a, b
	add a, $98 ; maybe should be a constant - 152, aka the number of kanto pokes
	ld b, $08
	call GivePokemon
	ld a, $8D
	ld [wd6b3], a
	ret
  
GiveKantoStarters:: ; 57C8
	ld a, $03
	ld b, $20
	call GivePokemon
	ld a, $06
	ld b, $24
	call GivePokemon
	ld a, $09
	ld b, $24
	call GivePokemon
	ret
	
GivePokemon:: ; 57DE
	ld [wMonDexIndex], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, $10
	call Predef
	ret
	
Function57eb ; 57EB
	and a
	ret z
.loop
	push af
	xor a
	ld [wca44], a
	call RandomOver246
	ld [wcdd7], a
	ld a, $05
	ld [wCurPartyLevel], a
	callab Function3e043
	ld a, [wcdd7]
	ld [wMonDexIndex], a
	callab Functiondd5c
	pop af
	dec a
	jr nz, .loop
	ret
	
RandomOver246:: ; 5818
.loop	
	call Random
	and a
	jr z, .loop
	cp $F6
	jr nc, .loop
	ret

FillTMs:: ; 5823
	ld b, $39
	ld a, $01
	ld hl, wTMsHMs
.loop
	ld [hl+], a
	dec b
	jr nz, .loop
	ret
	
DebugGiveKeyItems:: ; 582F
	ld hl, DebugKeyItemsList
	ld de, wKeyItems
	ld c, $FF
.loop
	inc c
	ld a, [hl+]
	ld [de], a
	inc de
	cp $FF
	jr nz, .loop
	ld a, c
	ld [wNumKeyItems], a
	ret

DebugKeyItemsList:: ; 5844
	db ITEM_TM_HOLDER
	db ITEM_BALL_HOLDER
	db ITEM_BAG
	db ITEM_BICYCLE
	db $FF
	
DemoSetUpPlayer:: ; 5849
	ld hl, wPlayerName
	ld de, DemoPlayerName
	call CopyString
	ld hl, wRivalName
	ld de, DemoRivalName
	call CopyString
	call $40FD
	ld de, DemoItemList
	call FillBagWithList
	call GiveRandomJohto
	ret
	
DemoItemList:: ; 5868
	db ITEM_POKE_BALL, $05 
	db ITEM_POTION, $0A 
	db ITEM_FULL_HEAL, $0A 
	db ITEM_STIMULUS_ORB, $01 
	db ITEM_FOCUS_ORB, $01 
	db $FF
	
DemoPlayerName:: ; 5873
	db "サトシ@"
	
DemoRivalName:: ; 5877
	db "シゲル@"
	
OakSpeechDemo:: ; 587B
	text "ようこそ" 
	line "ポケット　モンスターの　せかいへ！"
	cont "ごぞんじ　わしが　オーキドじゃ！"
	
	para "きょう　きみに　きてもらったのは"
	line "ほかでもない"
	cont "あたらしい　ずかんづくりを"
	cont "てつだって　ほしいのじゃ！"
	
	para "もちろん"
	line "きみの　パートナーとなる　ポケモンと"
	cont "りュックは　ようい　しておる"
	
	para "りュックの　なかには"
	line "キズぐすりと"
	cont "モンスターボールが"
	cont "はいっておるから　あんしんじゃ！"
	
	para "すでに　きみの　ライバルは"
	line "しゅっぱつ　しとる"
	
	para "まけないよう　がんばって　くれい！"
	prompt
	
OakSpeech1:: ; 5956
	text "いやあ　またせた！"
	
	para "ポケット　モンスターの　せかいへ"
	line "ようこそ！"
	
	para "わたしの　なまえは　オーキド"
	
	para "みんなからは　#　はかせと"
	line "したわれて　おるよ"
	prompt
	
OakSpeech2:: ; 599F
	text "きみも　もちろん"
	line "しっているとは　おもうが"
	
	para "この　せかいには"
	line "ポケット　モンスターと　よばれる"
	cont "いきもの　たちが"
	cont "いたるところに　すんでいる！"
	prompt
	
OakSpeech3:: ; 59E8
	text "その　#　という　いきものを"
	line "ひとは　ぺットに　したり"
	cont "しょうぶに　つかったり"
	cont "そして・・・"
	
	para "わたしは　この　#の"
	line "けんきゅうを　してる　というわけだ"
	prompt
	
OakSpeech4:: ; 5A35
	text "では　はじめに　きみの　なまえを"
	line "おしえて　もらおう！"
	prompt
	
OakSpeech5:: ; 5A52
	text "そして　この　しょうねんは"
	line "きみの　おさななじみであり"
	cont"ライバルである"
	
	para "・・・えーと？"
	line "なまえは　なんて　いったかな？"
	prompt
	
OakSpeech6:: ; 5A8F
	text "さて　きみの　きねんすべき"
	line "たびだちのひを"
	cont "きろくしておこう！"
	
	para "じかんも　なるべく　せいかくにな！"
	prompt
	
OakSpeech7:: ; 5AC2
	text "<PLAYER>！"
	
	para "いよいよ　これから"
	line "きみの　ものがたりの　はじまりだ！"
	
	para "ゆめと　ぼうけんと！"
	line "ポケット　モンスターの　せかいへ！"
	
	para "レッツ　ゴー！"
	done
	
SetPlayerNamesDebug:: ; 5B07
	ld hl, DebugPlayerName
	ld de, wPlayerName
	call CopyNameDebug
	ld hl, DebugRivalName
	ld de, wRivalName
	
CopyNameDebug:
	ld bc, 0006 ; constant - name length
	call CopyBytes
	ret
	
DebugPlayerName: ; 5B1D
	db "コージ@"
	
DebugRivalName: ; 5B21
	db "レッド@"
	
ChoosePlayerName:: ; 5B25
	call PanPortraitRight
	ld hl, PlayerNameMenuHeader
	call NamingWindow
	ld a, [wMenuCursorY]
	dec a
	jr z, .loop
	ld de, wPlayerName
	call SaveCustomName
	jr .farjump
	
.loop
	ld b, $01
	ld de, wPlayerName
	callba Function113f4
	ld a, [wPlayerName]
	cp "@"
	jr z, .loop
	
	call RotateThreePalettesRight
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, $4D10
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call RotateThreePalettesLeft
.farjump
	ld hl, ChoosePlayerNameEndText
	call PrintText
	ret
	
ChoosePlayerNameEndText: ; 5B6F
	text "ふむ・・・"
	line "<PLAYER>　と　いうんだな！"
	prompt
	
PlayerNameMenuHeader: ; 5B81
	db $40 
	menu_coords 00, 00, 10, 11
	dw $5B89
	db 01 ; initial selection
	
; 5B89
	db "ツオ゛じぶんできめる@"
	
; 5B93
	db "ゴールド@"
	
; 5B98
	db "サトシ@"
	
; 5B9C
	db "ジャック@"
	
; 5BA1
	db "エ゛なまえこうほ@"

ChooseRivalName:: ; 5BA9
	call PanPortraitRight
	ld hl, RivalNameMenuHeader
	call NamingWindow
	ld a, [wMenuCursorY]
	dec a
	jr z, .loop
	ld de, wRivalName
	call SaveCustomName
	jr .farjump
	
.loop
	ld b, $02
	ld de, wRivalName
	callba Function113f4 ; manual text entry box?
	ld a, [wRivalName]
	cp "@"
	jr z, .loop
	
	call RotateThreePalettesRight
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, $4BD4
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call RotateThreePalettesLeft
.farjump
	ld hl, ChooseRivalNameEndText
	call PrintText
	ret
	
ChooseRivalNameEndText: ; 5BF3
	text "そうか　そうだったな"
	line "<RIVAL>　という　なまえだ"
	prompt
	
RivalNameMenuHeader: ; 5C0A
	db $40 
	menu_coords 00, 00, 10, 11
	dw RivalNameMenuData 
	db 01 ; initial selection
	
RivalNameMenuData: ; 5C12
	db $91 
	db 04 ; items
	dw $3C2C 
	db $DE, $33 
	dw $D2B7 
	
	db $D9, $50
	
; 5C1C
	db "シルバー@"
	
; 5C21
	db "シゲル@"
	
; 5C25
	db "ジョン@"
	
; 5C29
	db "エ゛なまえこうほ@"
	
MomNamePrompt:: ; 5C31
	ld hl, MomNameMenuHeader
	call NamingWindow
	ld a, [wMenuCursorY]
	dec a
	jr z, .loop
	ld de, wMomsName
	call SaveCustomName
	jr .escape
	
.loop
	ld b, $03
	ld de, wMomsName
	callba Function113f4
	ld a, [wMomsName]
	cp "@"
	jr z, .loop
	
	call ClearPalettes
	call ClearTileMap
	callab Function140d9
	call LoadFontExtra
	call GetMemSGBLayout
	call WaitBGMap
.escape
	ret
	
MomNameMenuHeader: ; 5C71
	db $40 ; flags
	menu_coords 00, 00, 10, 11
	dw .MomNameMenuData
	db 01 ; initial selection
	
.MomNameMenuData: ; 5C79
	db $91 
	db 04 ; items
	dw $3C2C 
	db $DE, $33 
	dw $B77F

; 5C81
	db "める@"
	
; 5C84
	db "おかあさん@"

; 5C8A
	db "ママ@"
	
; 5C8D
	db "かあちゃん@"
	
; 5C93
	db "エ゛なまえこうほ@"
	
NamingWindow:: ; 5C9B
	; loads the menu header put into hl
	call LoadMenuHeader
	call VerticalMenu
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	ret
	
SaveCustomName:: ; 5CAC
	ld hl, wcd31
	ld bc, $0006 ; constant, player name length
	call CopyBytes
	ret
	
PanPortraitRight:: ; 5CB6
	ld hl, $C2F5 ; should be a hlcoord i think
	ld d, $06
	ld e, $7E
	ld b, d
	ld c, e
	ld d, $00
	add hl, de
.loop
	xor a
	ldh [hBGMapMode], a
	push hl
	push bc
.innerLoop
	;pans all the tiles onscreen to the right one
	ld a, [hl+]
	ld [hl-], a
	dec hl
	dec c
	jr nz, .innerLoop
	
	call WaitBGMap
	pop bc
	pop hl
	inc hl
	dec b ; passed c - how many tiles right to pan?
	jr nz, .loop
	ret
	
PanPortraitLeft:: ; 5CD7
	ld hl, $C2FC ; hlcoord
	ld b, $06
	ld c, $7E
.loop
	xor a
	ldh [hBGMapMode], a
	push hl
	push bc
.innerloop
	ld a, [hl-]
	ld [hl+], a
	inc hl
	dec c
	jr nz, .innerloop
	
	call WaitBGMap
	pop bc
	pop hl
	inc hl
	dec b
	jr nz, .loop
	ret
	
MenuCallSettings:: ; 5CF3
	call SettingsScreen
	ret
	
FadeInIntroPic: ; 5CF7
	ld hl, IntroFadePalettes
	ld b, 6
.next
	ld a, [hl+]
	ldh [rBGP], a
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .next
	ret
	
IntroFadePalettes:
	db %01010100
	db %10101000
	db %11111100
	db %11111000
	db %11110100
	db %11100100
	
MovePicLeft: ; 5D0E
	ld a, 119
	ldh [hWX], a
	call DelayFrame
	
	ld a, %11100100
	ldh [rBGP], a
.next
	call DelayFrame
	ldh a, [hWX]
	sub 8
	cp $FF
	ret z
	ldh [hWX], a
	jr .next
	
IntroDisplayPicCenteredOrUpperRight:: ; 5D27
; b = bank
; de = address of compressed pic
; c: 0 = centred, non-zero = upper-right
	ld a, c
	and a
	hlcoord 13, 4
	jr nz, .skip
	hlcoord 6, 4
.skip
	push hl
	ld a, b
	call UncompressSpriteFromDE
	ld a, $00
	call OpenSRAM
	ld hl, $A188
	ld de, $A000
	ld bc, $0310
	call CopyBytes
	call CloseSRAM
	ld de, $9000
	call InterlaceMergeSpriteBuffers
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	ld bc, $0707
	; ld a, $1F
	; call Predef
	predef PlaceGraphic
	ret
	
; 5D5D