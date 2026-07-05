StartBattle::
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .battle_intro

	ld a, [wTempWildMonSpecies]
	and a
	jr z, .battle_intro

	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a

.battle_intro
	ld a, [wTimeOfDayPal]
	push af
	ld hl, wTextboxFlags
	ld a, [hl]
	push af
	res TEXT_DELAY_F, [hl]
	ldh a, [hMapAnims]
	ld [wMapAnimsBackup], a
	call PlayBattleMusic
	call ShowLinkBattleParticipants
	call ClearBattleRAM
	ld a, [wOtherTrainerClass]
	and a
	jr nz, .trainer

	call InitEnemyWildmon
	jr .back_up_bgmap2
.trainer
	call InitEnemyTrainer

.back_up_bgmap2
	ld b, 0
	call GetSGBLayout
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call InitBattleDisplay
	call BattleStartMessage
	xor a
	ldh [hBGMapMode], a
	call EmptyBattleTextbox
	hlcoord 9, 7
	lb bc, 5, 10
	call ClearBox
	hlcoord 1, 0
	lb bc, 4, 10
	call ClearBox
	call ClearSprites
	ld a, [wBattleMode]
	cp WILD_BATTLE
	call z, UpdateEnemyHUD
	call DoBattle
	call ExitBattle
	pop af
	ld [wTextboxFlags], a
	pop af
	ld [wTimeOfDayPal], a
	ld a, [wMapAnimsBackup]
	ldh [hMapAnims], a
	scf
	ret

InitEnemyTrainer:
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	callfar ReadTrainerParty

	; RIVAL's first mon has no held item
	ld a, [wTrainerClass]
	cp TRAINER_RIVAL
	jr nz, .ok
	xor a
	ld [wOTPartyMon1Item], a

.ok
	call GetTrainerPic
	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ld a, -1
	ld [wCurOTMon], a
	ld a, TRAINER_BATTLE
	ld [wBattleMode], a
	ret

InitEnemyWildmon:
	ld a, 1
	ld [wBattleMode], a
	call LoadEnemyMon
	ld hl, wEnemyMonDVs
	predef GetUnownLetter
	ld de, vFrontPic
	call LoadMonFrontSprite
	xor a
	ld [wTrainerClass], a
	ldh [hGraphicStartTile], a
	hlcoord 12, 0
	lb bc, 7, 7
	predef PlaceGraphic
	ret

GetTrainerPic:
	ld a, [wEnemyTrainerGraphicsPointer]
	ld e, a
	ld a, [wEnemyTrainerGraphicsPointer + 1]
	ld d, a
	ld a, BANK("Trainer Pics")
	call UncompressSpriteFromDE
	ld de, vFrontPic
	ln a, 7, 7
	ld c, a
	jp LoadUncompressedSpriteData

; Fill wBoxAlignment-aligned box width b height c
; with iterating tile starting from hGraphicStartTile at hl.
PlaceGraphic:
	ld de, SCREEN_WIDTH

	ld a, [wSpriteFlipped]
	and a
	jr nz, .right

	ldh a, [hGraphicStartTile]

.x1
	push bc
	push hl

.y1
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y1

	pop hl
	inc hl
	pop bc
	dec b
	jr nz, .x1
	ret

.right
	push bc
	ld b, 0
	dec c
	add hl, bc
	pop bc

	ldh a, [hGraphicStartTile]
.x2
	push bc
	push hl

.y2
	ld [hl], a
	add hl, de
	inc a
	dec c
	jr nz, .y2

	pop hl
	dec hl
	pop bc
	dec b
	jr nz, .x2
	ret

LoadMonBackPic:
	ld a, [wTempBattleMonSpecies]
	ld [wCurPartySpecies], a
	hlcoord 1, 5
	ld b, 7
	ld c, 8
	call ClearBox
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	ld hl, vBackPic
	predef_jump GetMonBackpic

; Old back sprite scaling code from Red & Green.
Old_ScaleSpriteByTwo:
	ld de, sSpriteBuffer1 + (4*4*8) - 5          ; last byte of input data, last 4 rows already skipped
	ld hl, sSpriteBuffer0 + SPRITEBUFFERSIZE - 1 ; end of destination buffer
	call ScaleLastSpriteColumnByTwo              ; last tile column is special case
	call ScaleFirstThreeSpriteColumnsByTwo       ; scale first 3 tile columns
	ld de, sSpriteBuffer2 + (4*4*8) - 5          ; last byte of input data, last 4 rows already skipped
	ld hl, sSpriteBuffer1 + SPRITEBUFFERSIZE - 1 ; end of destination buffer
	call ScaleLastSpriteColumnByTwo              ; last tile column is special case

ScaleFirstThreeSpriteColumnsByTwo:
	ld b, $3 ; 3 tile columns
.columnLoop
	ld c, 4*8 - 4 ; $1c, 4 tiles minus 4 unused rows
.columnInnerLoop
	push bc
	ld a, [de]
	ld bc, -(7*8)+1       ; -$37, scale lower nybble and seek to previous output column
	call ScalePixelsByTwo
	ld a, [de]
	dec de
	swap a
	ld bc, 7*8+1-2        ; $37, scale upper nybble and seek back to current output column and to the next 2 rows
	call ScalePixelsByTwo
	pop bc
	dec c
	jr nz, .columnInnerLoop
	dec de
	dec de
	dec de
	dec de
	ld a, b
	ld bc, -7*8 ; -$38, skip one output column (which has already been written along with the current one)
	add hl, bc
	ld b, a
	dec b
	jr nz, .columnLoop
	ret

ScaleLastSpriteColumnByTwo:
	ld a, 4*8 - 4 ; $1c, 4 tiles minus 4 unused rows
	ldh [hSpriteInterlaceCounter], a
	ld bc, -1
.columnInnerLoop
	ld a, [de]
	dec de
	swap a                    ; only high nybble contains information
	call ScalePixelsByTwo
	ldh a, [hSpriteInterlaceCounter]
	dec a
	ldh [hSpriteInterlaceCounter], a
	jr nz, .columnInnerLoop
	dec de                    ; skip last 4 rows of new column
	dec de
	dec de
	dec de
	ret

; scales the given 4 bits in a (4x1 pixels) to 2 output bytes (8x2 pixels)
; hl: destination pointer
; bc: destination pointer offset (added after the two bytes have been written)
ScalePixelsByTwo:
	push hl
	and $f
	ld hl, DuplicateBitsTable
	add l
	ld l, a
	jr nc, .noCarry
	inc h
.noCarry
	ld a, [hl]
	pop hl
	ld [hld], a ; write output byte twice to make it 2 pixels high
	ld [hl], a
	add hl, bc   ; add offset
	ret

DuplicateBitsTable:
FOR n, 16
	db (n & 1) * 3 + (n & 2) * 6 + (n & 4) * 12 + (n & 8) * 24
ENDR

ClearBattleRAM:
	xor a
	ld [wBattlePlayerAction], a
	ld [wBattleResult], a

	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a

	ld [wMenuScrollPosition], a
	ld [wCriticalHit], a
	ld [wBattleMonSpecies], a
	ld [wBattleParticipantsNotFainted], a
	ld [wCurBattleMon], a
	ld [wBattleEnded], a
	ld [wTimeOfDayPal], a
	ld [wEnemyTurnsTaken], a

	ld hl, wPlayerHPPal
	ld [hli], a
	ld [hl], a

	ld hl, wBattleMonDVs
	ld [hli], a
	ld [hl], a

	ld hl, wEnemyMonDVs
	ld [hli], a
	ld [hl], a

; Clear the entire BattleMons area
	ld hl, wEnemyMoveStruct
	ld bc, wBattleEnd - wBattle
	xor a
	call ByteFill

	call ClearWindowData

	ld hl, hBGMapAddress
	xor a
	ld [hli], a
	ld [hl], HIGH(vBGMap0)
	ld a, (LCDC_DEFAULT & ~(1 << rLCDC_WINDOW_TILEMAP))
	ldh [rLCDC], a
	ld a, [wMapId]
	cp $d9 ; SAFARI_ZONE_EAST
	jr c, .return
	cp $dd ; SAFARI_ZONE_CENTER_REST_HOUSE
	jr nc, .return
	ld a, 2
	ld [wBattleType], a
.return
	ret

ExitBattle:
	call IsLinkBattle
	jr nz, .HandleEndOfBattle
	call ShowLinkBattleParticipantsAfterEnd
	jr .CheckEvolution

.HandleEndOfBattle
	ld a, [wBattleResult]
	and a
	jr nz, .CleanUpBattleRAM
	; WIN
	call CheckPayDay

.CheckEvolution
	xor a
	ld [wForceEvolution], a
	predef EvolveAfterBattle

.CleanUpBattleRAM:
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld [wBattleMode], a
	ld [wBattleType], a
	ld [wAttackMissed], a
	ld [wTempWildMonSpecies], a
	ld [wOtherTrainerClass], a
	ld [wFailedToFlee], a
	ld [wNumFleeAttempts], a
	ld [wBattleEnded], a
	ld hl, wPartyMenuCursor
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld [wMenuScrollPosition], a
	ld hl, wPlayerSubStatus1
	ld b, wEnemyFuryCutterCount - wPlayerSubStatus1
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ld hl, wPokedexMenuFlags
	set 0, [hl]
	call WaitSFX

	ld a, $e3
	ldh [rLCDC], a
	ld hl, wToolgearFlags
	res HIDE_TOOLGEAR_F, [hl]
	call ClearPalettes
	ret

CheckPayDay:
	ld hl, wPayDayMoney
	ld a, [hli]
	or [hl]
	inc hl
	or [hl]
	ret z

	ld a, [wBattleMonItem]
	ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_AMULET_COIN
	jr nz, AddBattleMoneyToAccount

	ld hl, wPayDayMoney + 2
	sla [hl]
	dec hl
	rl [hl]
	dec hl
	rl [hl]
	jr nc, AddBattleMoneyToAccount

	ld a, $ff
	ld [hli], a
	ld [hli], a
	ld [hl], a

AddBattleMoneyToAccount:
	ld hl, wPayDayMoney + 2
	ld de, wMoney + 2
	ld c, 3
	and a
.loop
	ld a, [de]
	adc [hl]
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .loop
	ld hl, BattleText_PlayerPickedUpPayDayMoney
	call PrintText
	ret

BattleText_PlayerPickedUpPayDayMoney:
	text "<PLAYER>は　@"
	deciram wPayDayMoney, 3, 6
	text "円"
	line "ひろった！"
	prompt

ShowLinkBattleParticipantsAfterEnd:
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Status
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld a, [wEnemyMonStatus]
	ld [hl], a
	call ClearTileMap
	call _ShowLinkBattleParticipants
	ld a, [wBattleResult]
	cp LOSE
	ld de, .YouWin
	jr c, .store_result
	ld de, .YouLose
	jr z, .store_result
	ld de, .Draw

.store_result
	hlcoord 6, 8
	call PlaceString
	ld c, 200
	call DelayFrames
	ret

.YouWin:
	db "あなたの　かち@"

.YouLose:
	db "あなたの　まけ@"

.Draw:
	db "　　ひきわけ@"

PlayBattleMusic:
	push hl
	push de
	push bc
	xor a
	ld [wMusicFade], a
	ld de, 0
	call PlayMusic
	call DelayFrame
	call MaxVolume
; plays vs. gym leader music regardless of the battle type
	ld de, MUSIC_LEADER_BATTLE
	call PlayMusic
	pop bc
	pop de
	pop hl
	ret

InitBattleDisplay:
	call GetTrainerBackpic
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call DrawTextBox
	hlcoord 1, 5
	lb bc, 3, 7
	call ClearBox
	call DisableLCD
	call LoadFont
	call Call_LoadBattleFontsHPBar
	ld hl, vBGMap0
	lb bc, 4, 0
	ld a, '　'
	call ByteFill
	call LoadMapTimeOfDay.PushAttrMap
	call EnableLCD
	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ldh [rWY], a
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	call BattleIntroSlidingPics
	ld a, 1
	ldh [hBGMapMode], a
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	xor a
	ldh [hWY], a
	ldh [rWY], a
	call WaitBGMap
	ld b, SGB_BATTLE_COLORS
	call GetSGBLayout
	call HideSprites
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a
	ldh [hSCX], a
	ret

BattleIntroSlidingPics:
	ld b, $70
	ld c, $90
	ld a, c
	ldh [hSCX], a
	call DelayFrame
	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
.loop1
	push bc
	ld h, b
	ld l, $40
	call .subfunction2
	ld h, 0
	ld l, $60
	call .subfunction2
	call .subfunction1
	pop bc
	ld a, c
	ldh [hSCX], a
	inc b
	inc b
	dec c
	dec c
	jr nz, .loop1
	ret

.subfunction1:
	push bc
	ld hl, wShadowOAMSprite00XCoord
	ld c, $12
	ld de, SPRITEOAMSTRUCT_LENGTH
.loop2
	dec [hl]
	dec [hl]
	add hl, de
	dec c
	jr nz, .loop2
	pop bc
	ret

.subfunction2:
.loop3
	ldh a, [rLY]
	cp l
	jr nz, .loop3
	ld a, h
	ldh [rSCX], a
.loop4
	ldh a, [rLY]
	cp h
	jr z, .loop4
	ret

GetTrainerBackpic:
	ld de, PlayerBacksprite
	ld a, BANK(PlayerBacksprite)
	call UncompressSpriteFromDE
	ld hl, vChars2 tile $31
	predef GetMonBackpic
	ld a, BANK(sSpriteBuffer1)
	call OpenSRAM
	ld hl, vSprites
	ld de, sSpriteBuffer1
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Request2bpp
	call CloseSRAM
	call .LoadTrainerBackpicAsOAM

	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	ret

.LoadTrainerBackpicAsOAM:
	ld hl, wShadowOAMSprite00
	xor a
	ldh [hMapObjectIndex], a
	ld b, 6
	ld e, (SCREEN_WIDTH + 1) * TILE_WIDTH

.outer_loop
	ld c, 3
	ld d, 8 * TILE_WIDTH

.inner_loop
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ldh a, [hMapObjectIndex]
	ld [hli], a
	inc a
	ldh [hMapObjectIndex], a
	inc hl
	ld a, d
	add 1 * TILE_WIDTH
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hMapObjectIndex]
	add 3
	ldh [hMapObjectIndex], a
	ld a, e
	add 1 * TILE_WIDTH
	ld e, a
	dec b
	jr nz, .outer_loop
	ret

PlayerBacksprite:
INCBIN "gfx/trainer/protagonist_back.pic"

Unused_OldManBacksprite:
INCBIN "gfx/trainer/oldman_back.pic"

BattleStartMessage:
	ld a, [wBattleMode]
	dec a
	jr z, .wild

	ld de, SFX_SHINE
	call PlaySFX
	call WaitSFX

	ld c, 20
	call DelayFrames

	callfar Battle_GetTrainerName

	ld hl, WantsToBattleText
	jr .PrintBattleStartText

.wild
	ld a, $f
	ld [wCryTracks], a
	ld a, [wTempEnemyMonSpecies]
	call PlayStereoCry
	ld hl, WildPokemonAppearedText
	ld a, [wAttackMissed]
	and a
	jr z, .PrintBattleStartText
	ld hl, HookedPokemonAttackedText

.PrintBattleStartText:
	push hl
	callfar BattleStart_TrainerHuds
	pop hl
	call PrintText
	ret

WildPokemonAppearedText:
	text "あ！　やせいの"
	line "@"
	text_from_ram wEnemyMonNickname
	text "が　とびだしてきた！"
	prompt

HookedPokemonAttackedText:
	text "つりあげた　@"
	text_from_ram wEnemyMonNickname
	text "が"
	line "とびかかってきた！"
	prompt

WantsToBattleText:
	text_from_ram wOTClassName
	text "の　@"
	text_from_ram wStringBuffer1
	text "が"
	line "しょうぶを　しかけてきた！"
	prompt

ShowLinkBattleParticipants:
	call IsLinkBattle
	jr nz, .ok
	call _ShowLinkBattleParticipants
	call ClearTileMap
.ok
	call DelayFrame
	predef DoBattleTransition
	call Call_LoadBattleFontsHPBar
	ld a, 1
	ldh [hBGMapMode], a
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	ldh [rWY], a
	ldh [hMapAnims], a
	ret

_ShowLinkBattleParticipants:
	call LoadFontExtra
	hlcoord 3, 4
	ld b, 7
	ld c, 12
	call DrawTextBox
	hlcoord 4, 6
	ld de, wPlayerName
	call PlaceString
	hlcoord 4, 10
	ld de, wOTPlayerName
	call PlaceString
	hlcoord 9, 8
	ld a, 'Ｖ'
	ld [hli], a
	ld [hl], 'Ｓ'
	callfar LinkBattle_TrainerHuds
	ld c, 150
	jp DelayFrames

IsLinkBattle:
	push bc
	push af
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	pop bc
	ld a, b
	pop bc
	ret
