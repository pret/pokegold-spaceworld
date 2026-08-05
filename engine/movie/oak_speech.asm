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

GameStart:: ; unreferenced
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
	ld [wCurPartySpecies], a
	call GetBaseData
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
	farcall SetClockDialog
	call SetClock
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
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
	ld de, SFX_ESCAPE_ROPE
	call PlaySFX
	pop af
	call Bankswitch
	ld c, 4
	call DelayFrames

IntroCleanup::
	ld de, ShrinkPic1
	lb bc, BANK(ShrinkPic1), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld c, 4
	call DelayFrames
	ld de, ShrinkPic2
	lb bc, BANK(ShrinkPic2), $00
	call IntroDisplayPicCenteredOrUpperRight
	ld c, 20
	call DelayFrames
	hlcoord 6, 5
	ld b, 7
	ld c, 7
	call ClearBox
	ld c, 20
	call DelayFrames
	call LoadStartingSprites
	call LoadFontExtra
	ld c, 50
	call DelayFrames
	call GBFadeOutToWhite
	call ClearTileMap
	call StartRTC
	ld a, MAPSTATUS_MAIN
	ld [wLastMapStatus], a
	ld [wMapStatus], a

OverworldStart::
	call SetUpGameEntry
	ld hl, wDebugFlags
	bit CONTINUED_F, [hl]
	call z, SpawnPlayer
	ld hl, wGameModeFlags
	set 0, [hl]
	jp OverworldLoop

SetUpGameEntry::
	ld a, $04
	ld [wUnusedGameEntryByte], a
	ld a, MAPSETUP_CONTINUE
	ldh [hMapEntryMethod], a
	ld hl, wDebugFlags
	bit CONTINUED_F, [hl] ; if we loaded a game
	ret nz
	ld a, MAPSETUP_NEW_GAME
	ldh [hMapEntryMethod], a
	ld a, SPAWN_POINT_NONE
	ld [wDefaultSpawnPoint], a
	ld hl, GameStartMapLocation
	ld de, wMapGroup
	ld bc, wMapLocationEnd - wMapLocation
	call CopyBytes
	ret

GameStartMapLocation::
	map_id PLAYER_HOUSE_2F ; map
	dw wOverworldMapBlocks + (3 + PLAYER_HOUSE_2F_WIDTH + 3) * (3 + 1) + 3 + 4 ; wOverworldMapAnchor
	db 4, 4 ; player object x, y
	db 0, 1 ; next metatile x, y

DebugSetUpPlayer::
	call SetPlayerNamesDebug
	ld a, HIGH(DEBUG_MONEY >> 8)
	ld [wMoney], a
	ld a, HIGH(DEBUG_MONEY)
	ld [wMoney + 1], a
	ld a, LOW(DEBUG_MONEY)
	ld [wMoney + 2], a
	ld a, %11111111 ; give all badges
	ld [wJohtoBadges], a
	ld [wKantoBadges], a
	call GiveRandomJohtoStarter
	ld a, 3 ; count
	call AddRandomPokemonToBox
	call FillTMs
	ld de, DebugBagItems
	call FillBagWithList
	ld hl, wPokedexCaught
	call DebugFillPokedex
	ld hl, wPokedexSeen
	call DebugFillPokedex
	ld hl, wUnownDex
	ld [hl], TRUE
	call SetDemoEventFlags
	ret

DebugFillPokedex::
	ld b, NUM_POKEMON / 8
	ld a, %11111111
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld [hl], (1 << (NUM_POKEMON % 8)) - 1 ; %00000111
	ret

FillBagWithList::
	ld hl, wNumBagItems
.loop
	ld a, [de]
	cp -1
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

INCLUDE "data/debug/debug_items.asm"

GiveRandomPokemon::
	and a
	ret z
.loop
	push af
	call RandomSpecies_RaiEnSuiOrUnder
	ld b, 10 ; level
	call GivePokemon
	pop af
	dec a
	jr nz, .loop
	ret

GiveRandomJohtoStarter::
	; Pick a random number from 1 to 3
.loop
	call Random
	and %11
	jr z, .loop
	; Convert that into an index for a Johto starter
	dec a
	ld b, a
	add a, a
	add a, b
	add a, NUM_KANTO_POKEMON + 1
	ld b, 8 ; level
	call GivePokemon
	ld a, ITEM_BERRY
	ld [wPartyMon1 + 1], a
	ret

GiveKantoStarters:: ; unreferenced
	ld a, DEX_VENUSAUR
	ld b, 32
	call GivePokemon
	ld a, DEX_CHARIZARD
	ld b, 36
	call GivePokemon
	ld a, DEX_BLASTOISE
	ld b, 36
	call GivePokemon
	ret

GivePokemon::
	ld [wCurPartySpecies], a
	ld a, b
	ld [wCurPartyLevel], a
	predef TryAddMonToParty
	ret

AddRandomPokemonToBox:
	and a
	ret z
.loop
	push af
	xor a
	ld [wEnemySubStatus5], a
	call RandomSpecies_RaiEnSuiOrUnder
	ld [wTempEnemyMonSpecies], a
	ld a, 5
	ld [wCurPartyLevel], a
	callfar LoadEnemyMon
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	callfar SendMonIntoBox
	pop af
	dec a
	jr nz, .loop
	ret

RandomSpecies_RaiEnSuiOrUnder::
.loop
	call Random
	and a
	jr z, .loop
	cp DEX_SUI + 1
	jr nc, .loop
	ret

FillTMs::
	ld b, NUM_TM_HM
	ld a, 1
	ld hl, wTMsHMs
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret

DebugGiveKeyItems:: ; unreferenced
	ld hl, DebugKeyItemsList
	ld de, wKeyItems
	ld c, -1
.loop
	inc c
	ld a, [hli]
	ld [de], a
	inc de
	cp -1
	jr nz, .loop
	ld a, c
	ld [wNumKeyItems], a
	ret

INCLUDE "data/debug/debug_key_items.asm"

DemoSetUpPlayer::
	ld hl, wPlayerName
	ld de, DemoPlayerName
	call CopyString
	ld hl, wRivalName
	ld de, DemoRivalName
	call CopyString
	call SetDemoEventFlags
	ld de, DemoItemList
	call FillBagWithList
	call GiveRandomJohtoStarter
	ret

INCLUDE "data/demo/demo_items.asm"

INCLUDE "data/demo/demo_names.asm"

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
	cont "リュックは　ようい　しておる"

	para "リュックの　なかには"
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
	line "ひとは　ペットに　したり"
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

INCLUDE "data/debug/debug_names.asm"

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
	ld b, NAME_PLAYER
	ld de, wPlayerName
	farcall NamingScreen
	ld a, [wPlayerName]
	cp '@'
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), 0
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

INCLUDE "data/names/player_names.asm"

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
	ld b, NAME_RIVAL
	ld de, wRivalName
	farcall NamingScreen
	ld a, [wRivalName]
	cp '@'
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, OakPic
	lb bc, BANK(OakPic), 0
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

INCLUDE "data/names/rival_names.asm"

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
	ld b, NAME_MOM
	ld de, wMomsName
	farcall NamingScreen
	ld a, [wMomsName]
	cp '@'
	jr z, .loop

	call ClearPalettes
	call ClearTileMap
	callfar LoadStandingSpritesGFX
	call LoadFontExtra
	call GetMemSGBLayout
	call WaitBGMap
.escape
	ret

INCLUDE "data/names/mom_names.asm"

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
	ld d, 6
	ld e, (SCREEN_WIDTH * 6) + 6
	ld b, d
	ld c, e
	ld d, 0
	add hl, de
.loop
	xor a
	ldh [hBGMapMode], a
	push hl
	push bc
.innerLoop
	;pans all the tiles onscreen to the right one
	ld a, [hli]
	ld [hld], a
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
	ld b, 6
	ld c, (SCREEN_WIDTH * 6) + 6
.loop
	xor a
	ldh [hBGMapMode], a
	push hl
	push bc
.innerloop
	ld a, [hld]
	ld [hli], a
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
	call OptionsMenu
	ret

FadeInIntroPic:
	ld hl, IntroFadePalettes
	ld b, 6
.next
	ld a, [hli]
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
	ld de, vFrontPic
	call InterlaceMergeSpriteBuffers
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	ret

LoadStartingSprites:
	ld de, GoldSpriteGFX
	lb bc, BANK(GoldSpriteGFX), 12
	ld hl, VRAM_Begin
	call Request2bpp
	ld hl, wShadowOAM
	ld de, GameStartSprites
	ld c, 4
.loop
	ld a, [de]
	inc de
	ld [hli], a ; y
	ld a, [de]
	inc de
	ld [hli], a ; x
	ld a, [de]
	inc de
	ld [hli], a ; tile id
	xor a
	ld [hli], a ; attribute
	dec c
	jr nz, .loop
	ret

GameStartSprites:
	;  y    x    tile id
	db $50, $48, $00
	db $50, $50, $01
	db $58, $48, $02
	db $58, $50, $03
