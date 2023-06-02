INCLUDE "constants.asm"

SECTION "engine/movie/oak_speech.asm", ROMX

DemoStart::
	ld de, OakPic
	lb bc, BANK(OakPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeechDemo
	call PrintText
	call GBFadeOutToWhite
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call MovePicLeft
	ld a, %11010000
	ldh [rOBP0], a
	call DemoSetUpPlayer
	jp IntroCleanup

GameStart::
	ld de, OakPic
	lb bc, BANK(OakPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech1
	call PrintText
	call GBFadeOutToWhite
	call ClearTileMap
	ld a, DEX_YADOKING
	ld [wCurSpecies], a
	ld [wMonDexIndex], a
	call GetMonHeader
	hlcoord 6, 4
	hlcoord 6, 4
	call PrepMonFrontpic
	call MovePicLeft
	ld hl, OakSpeech2
	call PrintText
	ld a, DEX_YADOKING
	call PlayCry
	ld hl, OakSpeech3
	call PrintText
	call GBFadeOutToWhite
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call MovePicLeft
	ld hl, OakSpeech4
	call PrintText
	call ChoosePlayerName
	call GBFadeOutToWhite
	call ClearTileMap
	ld de, RivalPic
	lb bc, BANK(RivalPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech5
	call PrintText
	call ChooseRivalName
	call GBFadeOutToWhite
	call ClearTileMap
	ld de, OakPic
	lb bc, BANK(OakPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call FadeInIntroPic
	ld hl, OakSpeech6
	call PrintText
	callba SetClockDialog
	call Function04ac
	call GBFadeOutToWhite
	call ClearTileMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), $00
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
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
	ld de, SFX_ESCAPE_ROPE
	call PlaySFX
	pop af
	call Bankswitch
	ld c, $04
	call DelayFrames

IntroCleanup::
	ld de, ShrinkPic1
	lb bc, BANK(ShrinkPic1), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld c, $04
	call DelayFrames
	ld de, ShrinkPic2
	lb bc, BANK(ShrinkPic2), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld c, $14
	call DelayFrames
	hlcoord 6, 5
	ld b, $07
	ld c, $07
	call ClearBox
	ld c, $14
	call DelayFrames
	call LoadStartingSprites
	call LoadFontExtra
	ld c, $32
	call DelayFrames
	call GBFadeOutToWhite
	call ClearTileMap
	call Function0502
	ld a, $00
	ld [wd638], a
	ld [wd637], a

OverworldStart::
	call SetUpGameEntry
	ld hl, wDebugFlags
	bit CONTINUED_F, [hl]
	call z, Function15b5
	ld hl, wd4a9
	set 0, [hl]
	jp Function2a85

SetUpGameEntry::
	ld a, $04
	ld [wd65e], a
	ld a, $F2
	ldh [hMapEntryMethod], a
	ld hl, wDebugFlags
	bit CONTINUED_F, [hl] ; if we loaded a game
	ret nz
	ld a, $F1
	ldh [hMapEntryMethod], a
	ld a, $00
	ld [wDefaultSpawnPoint], a
	ld hl, GameStartPlacement
	ld de, wMapGroup
	ld bc, wd65e - wMapGroup
	call CopyBytes
	ret

GameStartPlacement::
	db $01 ; map group
	db MAP_PLAYER_HOUSE_2F ; map
	dwcoord 15, 45 ; screen anchor
	db $04 ; metatile x
	db $04 ; metatile y
	db $00 ; in-metatile x
	db $01 ; in-metatile y

DebugSetUpPlayer::
	call SetPlayerNamesDebug
	ld a, $0F
	ld [wd15d], a
	ld a, $42
	ld [wd15e], a
	ld a, $3F
	ld [wd15f], a
	ld a, $FF ; give all badges
	ld [wJohtoBadges], a
	ld [wKantoBadges], a
	call GiveRandomJohto
	ld a, $03
	call AddRandomPokemonToBox
	call FillTMs
	ld de, DebugBagItems
	call FillBagWithList
	ld hl, wPokedexOwned
	call DebugFillPokedex
	ld hl, wPokedexSeen
	call DebugFillPokedex
	ld hl, wAnnonDex
	ld [hl], $01
	call Function40fd
	ret

DebugFillPokedex::
	ld b, $1F
	ld a, $FF
.loop
	ld [hl+], a
	dec b
	jr nz, .loop
	ld [hl], $07
	ret

FillBagWithList::
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
	call ReceiveItem
	jr .loop
.yump
	ret

DebugBagItems::
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

GiveRandomPokemon::
	and a
	ret z
.loop
	push af
	call RandomUnder246
	ld b, $0A
	call GivePokemon
	pop af
	dec a
	jr nz, .loop
	ret

GiveRandomJohto::
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
	ld [wPartyMon1 + 1], a
	ret

GiveKantoStarters::
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

GivePokemon::
	ld [wMonDexIndex], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, $10
	call Predef
	ret

AddRandomPokemonToBox:
	and a
	ret z
.loop
	push af
	xor a
	ld [wca44], a
	call RandomUnder246
	ld [wcdd7], a
	ld a, $05
	ld [wCurPartyLevel], a
	callab AddPokemonToBox
	ld a, [wcdd7]
	ld [wMonDexIndex], a
	callab Functiondd5c
	pop af
	dec a
	jr nz, .loop
	ret

RandomUnder246::
.loop
	call Random
	and a
	jr z, .loop
	cp $F6
	jr nc, .loop
	ret

FillTMs::
	ld b, $39
	ld a, $01
	ld hl, wTMsHMs
.loop
	ld [hl+], a
	dec b
	jr nz, .loop
	ret

DebugGiveKeyItems::
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

DebugKeyItemsList::
	db ITEM_TM_HOLDER
	db ITEM_BALL_HOLDER
	db ITEM_BAG
	db ITEM_BICYCLE
	db $FF

DemoSetUpPlayer::
	ld hl, wPlayerName
	ld de, DemoPlayerName
	call CopyString
	ld hl, wRivalName
	ld de, DemoRivalName
	call CopyString
	call Function40fd
	ld de, DemoItemList
	call FillBagWithList
	call GiveRandomJohto
	ret

DemoItemList::
	db ITEM_POKE_BALL, $05
	db ITEM_POTION, $0A
	db ITEM_FULL_HEAL, $0A
	db ITEM_STIMULUS_ORB, $01
	db ITEM_FOCUS_ORB, $01
	db $FF

DemoPlayerName::
	db "サトシ@"

DemoRivalName::
	db "シゲル@"

OakSpeechDemo::
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

OakSpeech1::
	text "いやあ　またせた！"

	para "ポケット　モンスターの　せかいへ"
	line "ようこそ！"

	para "わたしの　なまえは　オーキド"

	para "みんなからは　#　はかせと"
	line "したわれて　おるよ"
	prompt

OakSpeech2::
	text "きみも　もちろん"
	line "しっているとは　おもうが"

	para "この　せかいには"
	line "ポケット　モンスターと　よばれる"
	cont "いきもの　たちが"
	cont "いたるところに　すんでいる！"
	prompt

OakSpeech3::
	text "その　#　という　いきものを"
	line "ひとは　ぺットに　したり"
	cont "しょうぶに　つかったり"
	cont "そして・・・"

	para "わたしは　この　#の"
	line "けんきゅうを　してる　というわけだ"
	prompt

OakSpeech4::
	text "では　はじめに　きみの　なまえを"
	line "おしえて　もらおう！"
	prompt

OakSpeech5::
	text "そして　この　しょうねんは"
	line "きみの　おさななじみであり"
	cont"ライバルである"

	para "・・・えーと？"
	line "なまえは　なんて　いったかな？"
	prompt

OakSpeech6::
	text "さて　きみの　きねんすべき"
	line "たびだちのひを"
	cont "きろくしておこう！"

	para "じかんも　なるべく　せいかくにな！"
	prompt

OakSpeech7::
	text "<PLAYER>！"

	para "いよいよ　これから"
	line "きみの　ものがたりの　はじまりだ！"

	para "ゆめと　ぼうけんと！"
	line "ポケット　モンスターの　せかいへ！"

	para "レッツ　ゴー！"
	done

SetPlayerNamesDebug::
	ld hl, DebugPlayerName
	ld de, wPlayerName
	call CopyNameDebug
	ld hl, DebugRivalName
	ld de, wRivalName

CopyNameDebug:
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ret

DebugPlayerName:
	db "コージ@"

DebugRivalName:
	db "レッド@"

ChoosePlayerName::
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
	callba NamingScreen
	ld a, [wPlayerName]
	cp "@"
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, $4D10
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
.farjump
	ld hl, ChoosePlayerNameEndText
	call PrintText
	ret

ChoosePlayerNameEndText:
	text "ふむ・・・"
	line "<PLAYER>　と　いうんだな！"
	prompt

PlayerNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw PlayerNameMenuData
	db 01 ; initial selection

PlayerNameMenuData:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db 04 ; items
	db "じぶんできめる@"
	db "ゴールド@"
	db "サトシ@"
	db "ジャック@"
	db 3 ; x offset for the title string
	db "なまえこうほ@"

ChooseRivalName::
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
	callba NamingScreen
	ld a, [wRivalName]
	cp "@"
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, $4BD4
	ld bc, $1200
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
.farjump
	ld hl, ChooseRivalNameEndText
	call PrintText
	ret

ChooseRivalNameEndText:
	text "そうか　そうだったな"
	line "<RIVAL>　という　なまえだ"
	prompt

RivalNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw RivalNameMenuData
	db 01 ; initial selection

RivalNameMenuData:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db 04 ; items
	db "じぶんできめる@"
	db "シルバー@"
	db "シゲル@"
	db "ジョン@"
	db 3
	db "なまえこうほ@"

MomNamePrompt::
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
	callba NamingScreen
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

MomNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .MomNameMenuData
	db 01 ; initial selection

.MomNameMenuData:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db 04 ; items
	db "じぶんで　きめる@"
	db "おかあさん@"
	db "ママ@"
	db "かあちゃん@"
	db 3
	db "なまえこうほ@"

NamingWindow::
	; loads the menu header put into hl
	call LoadMenuHeader
	call VerticalMenu
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	call CloseWindow
	ret

SaveCustomName::
	ld hl, wStringBuffer2
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ret

PanPortraitRight::
	hlcoord 5, 4
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

PanPortraitLeft::
	hlcoord 12, 4
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

MenuCallSettings::
	call SettingsScreen
	ret

FadeInIntroPic:
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

MovePicLeft:
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

IntroDisplayPicCenteredOrUpperRight::
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
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, DOUBLESPRITEBUFFERSIZE
	call CopyBytes
	call CloseSRAM
	ld de, VRAM_Begin + $1000
	call InterlaceMergeSpriteBuffers
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	ld bc, $0707
	predef PlaceGraphic
	ret

LoadStartingSprites:
	ld de, GoldSpriteGFX
	lb bc, BANK(GoldSpriteGFX), $0C
	ld hl, VRAM_Begin
	call Request2bpp
	ld hl, wShadowOAM
	ld de, GameStartSprites
	ld c, $04
.loop
	ld a, [de]
	inc de
	ld [hl+], a
	ld a, [de]
	inc de
	ld [hl+], a
	ld a, [de]
	inc de
	ld [hl+], a
	xor a
	ld [hl+], a
	dec c
	jr nz, .loop
	ret

GameStartSprites:
	db $50, $48, $00
	db $50, $50, $01
	db $58, $48, $02
	db $58, $50, $03
