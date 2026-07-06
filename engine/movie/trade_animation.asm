DEF TRADEANIM_RIGHT_ARROW EQU '▶' ; $ed
DEF TRADEANIM_LEFT_ARROW  EQU '▼' ; $ee

; TradeAnim_TubeAnimJumptable.Jumptable indexes
	const_def
	const TRADEANIMSTATE_0 ; 0
	const TRADEANIMSTATE_1 ; 1
	const TRADEANIMSTATE_2 ; 2
	const TRADEANIMSTATE_3 ; 3
DEF TRADEANIMJUMPTABLE_LENGTH EQU const_value

MACRO add_tradeanim
\1_TradeCmd:
	dw \1
ENDM

MACRO tradeanim
	db (\1_TradeCmd - DoTradeAnimation.Jumptable) / 2
ENDM

TradeAnimation:
	ld hl, wPlayerTrademonSenderName
	ld de, wOTTrademonSenderName
	call LinkTradeAnim_LoadTradePlayerNames
	ld hl, wPlayerTrademonSpecies
	ld de, wOTTrademonSpecies
	call LinkTradeAnim_LoadTradeMonSpecies
	ld de, .script
	jr RunTradeAnimScript

.script
	tradeanim TradeAnim_SetupGivemonScroll
	tradeanim TradeAnim_ShowGivemonData
	tradeanim TradeAnim_DoGivemonScroll
	tradeanim TradeAnim_Wait80
	tradeanim TradeAnim_Poof
	tradeanim TradeAnim_RockingBall
	tradeanim TradeAnim_EnterLinkTube1
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_BulgeThroughTube
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_TextboxScrollStart
	tradeanim TradeAnim_TubeToOT1
	tradeanim TradeAnim_SentToOTText
	tradeanim TradeAnim_ScrollOutRight

	tradeanim TradeAnim_OTSendsText1
	tradeanim TradeAnim_OTBidsFarewell
	tradeanim TradeAnim_ScrollOutRight
	tradeanim TradeAnim_TubeToPlayer1
	tradeanim TradeAnim_EnterLinkTube1
	tradeanim TradeAnim_DropBall
	tradeanim TradeAnim_ExitLinkTube
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_ShowGetmonData
	tradeanim TradeAnim_Poof
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_FrontpicScrollStart
	tradeanim TradeAnim_Wait80
	tradeanim TradeAnim_TextboxScrollStart
	tradeanim TradeAnim_TakeCareOfText
	tradeanim TradeAnim_ScrollOutRight
	tradeanim TradeAnim_End

TradeAnimationPlayer2:
	ld hl, wOTTrademonSenderName
	ld de, wPlayerTrademonSenderName
	call LinkTradeAnim_LoadTradePlayerNames
	ld hl, wOTTrademonSpecies
	ld de, wPlayerTrademonSpecies
	call LinkTradeAnim_LoadTradeMonSpecies
	ld de, .script
	jr RunTradeAnimScript

.script
	tradeanim TradeAnim_OTSendsText2
	tradeanim TradeAnim_OTBidsFarewell
	tradeanim TradeAnim_ScrollOutRight
	tradeanim TradeAnim_TubeToOT1
	tradeanim TradeAnim_EnterLinkTube1
	tradeanim TradeAnim_DropBall
	tradeanim TradeAnim_ExitLinkTube
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_ShowGetmonData
	tradeanim TradeAnim_Poof
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_FrontpicScrollStart
	tradeanim TradeAnim_Wait80
	tradeanim TradeAnim_TextboxScrollStart
	tradeanim TradeAnim_TakeCareOfText
	tradeanim TradeAnim_ScrollOutRight

	tradeanim TradeAnim_SetupGivemonScroll
	tradeanim TradeAnim_ShowGivemonData
	tradeanim TradeAnim_DoGivemonScroll
	tradeanim TradeAnim_Wait80
	tradeanim TradeAnim_Poof
	tradeanim TradeAnim_RockingBall
	tradeanim TradeAnim_EnterLinkTube1
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_BulgeThroughTube
	tradeanim TradeAnim_WaitAnim
	tradeanim TradeAnim_TextboxScrollStart
	tradeanim TradeAnim_TubeToPlayer1
	tradeanim TradeAnim_SentToOTText
	tradeanim TradeAnim_ScrollOutRight
	tradeanim TradeAnim_End

RunTradeAnimScript:
	ld hl, wTradeAnimAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, wStateFlags
	ld a, [hl]
	push af
	res SPRITE_UPDATES_DISABLED_F, [hl]
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]
	call .TradeAnimLayout
.anim_loop
	call DoTradeAnimation
	jr nc, .anim_loop
	pop af
	ld [wOptions], a
	pop af
	ld [wStateFlags], a
	ret

.TradeAnimLayout:
	xor a
	ld [wJumptableIndex], a
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	call DisableLCD
	callfar ClearSpriteAnims
	hlbgcoord 0, 0
	ld bc, STARTOF(VRAM) + SIZEOF(VRAM) - vBGMap0
	ld a, '　'
	call ByteFill
	ld hl, TradeGameBoyGFX
	ld de, vChars2 tile $31
	ld bc, tile $31
	ld a, BANK(TradeGameBoyGFX)
	call FarCopyData
	ld hl, TradeArrowRightGFX
	ld de, vChars0 tile TRADEANIM_RIGHT_ARROW
	ld bc, 1 tiles
	ld a, BANK(TradeArrowRightGFX)
	call FarCopyData
	ld hl, TradeArrowLeftGFX
	ld de, vChars0 tile TRADEANIM_LEFT_ARROW
	ld bc, 1 tiles
	ld a, $0A
	call FarCopyData
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $07
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call EnableLCD
	call LoadTradeBallAndCableGFX
	ld a, [wPlayerTrademonSpecies]
	ld de, vChars0
	call TradeAnim_GetFrontpic
	ld a, [wOTTrademonSpecies]
	ld de, vChars0 tile $31
	call TradeAnim_GetFrontpic
	ld a, [wPlayerTrademonSpecies]
	ld de, wPlayerTrademonSpeciesName
	call TradeAnim_GetNickname
	ld a, [wOTTrademonSpecies]
	ld de, wOTTrademonSpeciesName
	call TradeAnim_GetNickname
	call TradeAnim_NormalPals
	ret

DoTradeAnimation:
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .finished
	call .DoTradeAnimCommand
	callfar PlaySpriteAnimations
	ld hl, wFrameCounter2
	inc [hl]
	call DelayFrame
	and a
	ret

.finished
	call LoadFont
	scf
	ret

.DoTradeAnimCommand:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	add_tradeanim TradeAnim_AdvanceScriptPointer
	add_tradeanim TradeAnim_ShowGivemonData
	add_tradeanim TradeAnim_ShowGetmonData
	add_tradeanim TradeAnim_EnterLinkTube1
	add_tradeanim TradeAnim_EnterLinkTube2
	add_tradeanim TradeAnim_ExitLinkTube
	add_tradeanim TradeAnim_TubeToOT1
	add_tradeanim TradeAnim_TubeToOT2
	add_tradeanim TradeAnim_TubeToOT3
	add_tradeanim TradeAnim_TubeToOT4
	add_tradeanim TradeAnim_TubeToOT5
	add_tradeanim TradeAnim_TubeToOT6
	add_tradeanim TradeAnim_TubeToOT7
	add_tradeanim TradeAnim_TubeToOT8
	add_tradeanim TradeAnim_TubeToPlayer1
	add_tradeanim TradeAnim_TubeToPlayer2
	add_tradeanim TradeAnim_TubeToPlayer3
	add_tradeanim TradeAnim_TubeToPlayer4
	add_tradeanim TradeAnim_TubeToPlayer5
	add_tradeanim TradeAnim_TubeToPlayer6
	add_tradeanim TradeAnim_TubeToPlayer7
	add_tradeanim TradeAnim_TubeToPlayer8
	add_tradeanim TradeAnim_SentToOTText
	add_tradeanim TradeAnim_OTBidsFarewell
	add_tradeanim TradeAnim_TakeCareOfText
	add_tradeanim TradeAnim_OTSendsText1
	add_tradeanim TradeAnim_OTSendsText2
	add_tradeanim TradeAnim_SetupGivemonScroll
	add_tradeanim TradeAnim_DoGivemonScroll
	add_tradeanim TradeAnim_FrontpicScrollStart
	add_tradeanim TradeAnim_TextboxScrollStart
	add_tradeanim TradeAnim_ScrollOutRight
	add_tradeanim TradeAnim_ScrollOutRight2
	add_tradeanim TradeAnim_Wait80
	add_tradeanim TradeAnim_RockingBall
	add_tradeanim TradeAnim_DropBall
	add_tradeanim TradeAnim_WaitAnim
	add_tradeanim TradeAnim_Poof
	add_tradeanim TradeAnim_BulgeThroughTube
	add_tradeanim TradeAnim_End

TradeAnim_IncrementJumptableIndex:
	ld hl, wJumptableIndex
	inc [hl]
	ret

TradeAnim_AdvanceScriptPointer:
	ld hl, wTradeAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	ld [wJumptableIndex], a
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

TradeAnim_End:
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

TradeAnim_TubeToOT1:
	ld a, TRADEANIM_RIGHT_ARROW
	call TradeAnim_PlaceTrademonStatsOnTubeAnim
	ld a, [wLinkTradeSendmonSpecies]
	ld [wTempIconSpecies], a
	xor a
	depixel 5, 11, 4, 0
	ld b, $0
	jr TradeAnim_InitTubeAnim

TradeAnim_TubeToPlayer1:
	ld a, TRADEANIM_LEFT_ARROW
	call TradeAnim_PlaceTrademonStatsOnTubeAnim
	ld a, [wLinkTradeGetmonSpecies]
	ld [wTempIconSpecies], a
	ld a, TRADEANIMSTATE_2
	depixel 9, 18, 4, 4
	ld b, $4
TradeAnim_InitTubeAnim:
	push bc
	push de
	push bc
	push de

	push af
	call DisableLCD
	callfar ClearSpriteAnims
	hlbgcoord 20, 3
	ld bc, 12
	ld a, $60
	call ByteFill
	pop af

	call TradeAnim_TubeAnimJumptable

	xor a
	ldh [hSCX], a
	ld a, $07
	ldh [hWX], a
	ld a, $70
	ldh [hWY], a
	call EnableLCD
	call LoadTradeBubbleGFX

	pop de
	ld a, SPRITE_ANIM_OBJ_TRADEMON_ICON
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	pop bc
	ld [hl], b

	pop de
	ld a, SPRITE_ANIM_OBJ_TRADEMON_BUBBLE
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	pop bc
	ld [hl], b

	call WaitBGMap
	ld a, %11100100 ; 3,2,1,0
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a

	call TradeAnim_IncrementJumptableIndex
	ld a, 92
	ld [wFrameCounter], a
	ret

TradeAnim_TubeToOT2:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	cp $50
	ret nz
	ld a, TRADEANIMSTATE_1
	call TradeAnim_TubeAnimJumptable
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToOT3:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	cp $a0
	ret nz
	ld a, TRADEANIMSTATE_2
	call TradeAnim_TubeAnimJumptable
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToOT4:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	add $2
	ldh [hSCX], a
	and a
	ret nz
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToPlayer3:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	cp $B0
	ret nz
	ld a, TRADEANIMSTATE_1
	call TradeAnim_TubeAnimJumptable
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToPlayer4:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	cp $60
	ret nz
	xor a ; TRADEANIMSTATE_0
	call TradeAnim_TubeAnimJumptable
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToPlayer5:
	call TradeAnim_FlashBGPals
	ldh a, [hSCX]
	sub $2
	ldh [hSCX], a
	and a
	ret nz
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToOT6:
TradeAnim_TubeToPlayer6:
	ld a, 128
	ld [wFrameCounter], a
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeToOT8:
TradeAnim_TubeToPlayer8:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call DisableLCD
	callfar ClearSpriteAnims
	hlbgcoord 0, 0
	ld bc, STARTOF(VRAM) + SIZEOF(VRAM) - vBGMap0
	ld a, '　'
	call ByteFill
	xor a
	ldh [hSCX], a
	ld a, $90
	ldh [hWY], a
	call EnableLCD
	call LoadTradeBallAndCableGFX
	call WaitBGMap
	call TradeAnim_NormalPals
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_TubeToOT5:
TradeAnim_TubeToOT7:
TradeAnim_TubeToPlayer2:
TradeAnim_TubeToPlayer7:
	call TradeAnim_FlashBGPals
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret

.done:
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_TubeAnimJumptable:
	maskbits TRADEANIMJUMPTABLE_LENGTH
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .Zero, .One, .Two, .Zero

.Zero:
	call TradeAnim_BlankTilemap
	hlcoord 9, 3
	ld [hl], $5B
	inc hl
	ld bc, 10
	ld a, $60
	call ByteFill
	hlcoord 3, 2
	call TradeAnim_CopyTradeGameBoyTilemap
	ret

.One:
	call TradeAnim_BlankTilemap
	hlcoord 0, 3
	ld bc, SCREEN_WIDTH
	ld a, $60
	call ByteFill
	ret

.Two:
	call TradeAnim_BlankTilemap
	hlcoord 0, 3
	ld bc, $11
	ld a, $60
	call ByteFill
	hlcoord 17, 3
	ld a, $5d
	ld [hl], a

	ld a, $61
	ld de, SCREEN_WIDTH
	ld c, $3
.loop:
	add hl, de
	ld [hl], a
	dec c
	jr nz, .loop

	add hl, de
	ld a, $5F
	ldd [hl], a
	ld a, $5B
	ld [hl], a
	hlcoord 10, 6
	call TradeAnim_CopyTradeGameBoyTilemap
	ret

TradeAnim_CopyTradeGameBoyTilemap:
	ld de, TradeGameBoyTilemap
	lb bc, 8, 6
	call TradeAnim_CopyBoxFromDEtoHL
	ret

TradeAnim_PlaceTrademonStatsOnTubeAnim:
	push af
	call ClearBGPalettes
	call WaitForAutoBgMapTransfer
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call ClearTileMap
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	ld a, '─'
	call ByteFill
	hlcoord 1, 2
	ld de, wLinkPlayer1Name
	call PlaceString
	hlcoord 14, 2
	ld de, wLinkPlayer2Name
	call PlaceString
	hlcoord 7, 2
	ld bc, 6
	pop af
	call ByteFill
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call ClearTileMap
	ret

TradeAnim_EnterLinkTube1:
	call ClearTileMap
	call WaitForAutoBgMapTransfer
	ld a, $a0
	ldh [hSCX], a
	call DelayFrame
	hlcoord 8, 2
	ld de, TradeLinkTubeTilemap
	lb bc, 3, 12
	call TradeAnim_CopyBoxFromDEtoHL
	call WaitBGMap
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_EnterLinkTube2:
	ldh a, [hSCX]
	and a
	jr z, .done
	add $4
	ldh [hSCX], a
	ret

.done:
	ld c, $50
	call DelayFrames
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_ExitLinkTube:
	ldh a, [hSCX]
	cp $a0
	jr z, .done
	sub $4
	ldh [hSCX], a
	ret

.done:
	call ClearTileMap
	xor a
	ldh [hSCX], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_SetupGivemonScroll:
	ld a, $87
	ldh [hWX], a
	ld a, $80
	ldh [hSCX], a
	ld a, $50
	ldh [hWY], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_DoGivemonScroll:
	ldh a, [hWX]
	cp $7
	jr z, .done
	sub $4
	ldh [hWX], a
	ldh a, [hSCX]
	sub $4
	ldh [hSCX], a
	ret

.done
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hSCX], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_FrontpicScrollStart:
	ld a, $7
	ldh [hWX], a
	ld a, $50
	ldh [hWY], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_TextboxScrollStart:
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_ScrollOutRight:
	call WaitForAutoBgMapTransfer
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call WaitBGMap
	ld a, $7
	ldh [hWX], a
	xor a
	ldh [hWY], a
	call DelayFrame
	call WaitForAutoBgMapTransfer
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call ClearTileMap
	call TradeAnim_IncrementJumptableIndex
	ret

TradeAnim_ScrollOutRight2:
	ldh a, [hWX]
	cp $a1
	jr nc, .done
	inc a
	inc a
	ldh [hWX], a
	ret

.done:
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	call WaitBGMap
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_ShowGivemonData:
	call ShowPlayerTrademonStats
	call TradeAnim_ShowGivemonFrontpic
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_ShowGetmonData:
	call ShowOTTrademonStats
	call TradeAnim_ShowGetmonFrontpic
	call TradeAnim_AdvanceScriptPointer
	ret

TradeAnim_GetFrontpic:
	push de
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData
	pop de
	call LoadMonFrontSprite
	ret

TradeAnim_GetNickname:
	push de
	ld [wTempByteValue], a
	call GetPokemonName
	ld hl, wStringBuffer1
	pop de
	ld bc, $0006
	call CopyBytes
	ret

TradeAnim_ShowGivemonFrontpic:
	ld de, vChars0
	jr TradeAnim_ShowFrontpic

TradeAnim_ShowGetmonFrontpic:
	ld de, vChars0 tile $31
TradeAnim_ShowFrontpic:
	ld hl, vChars2
	lb bc, 10, $31
	call Request2bpp
	call WaitForAutoBgMapTransfer
	call TradeAnim_BlankTilemap
	hlcoord 7, 2
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	call WaitBGMap
	ret

TradeAnim_Wait80:
	ld c, $50
	call DelayFrames
	call TradeAnim_AdvanceScriptPointer
	ret

ShowPlayerTrademonStats::
	call TrademonStats_MonTemplate
	ld de, wPlayerTrademonSpecies
	call TrademonStats_PrintSpeciesNumber
	ld de, wPlayerTrademonSpeciesName
	call TrademonStats_PrintSpeciesName
	ld de, wPlayerTrademonOTName
	call TrademonStats_PrintOTName
	ld de, wPlayerTrademonID
	call TrademonStats_PrintTrademonID
	call TrademonStats_WaitBGMap
	ret

ShowOTTrademonStats:
	call TrademonStats_MonTemplate
	ld de, wOTTrademonSpecies
	call TrademonStats_PrintSpeciesNumber
	ld de, wOTTrademonSpeciesName
	call TrademonStats_PrintSpeciesName
	ld de, wOTTrademonOTName
	call TrademonStats_PrintOTName
	ld de, wOTTrademonID
	call TrademonStats_PrintTrademonID
	call TrademonStats_WaitBGMap
	ret

TrademonStats_MonTemplate:
	call WaitForAutoBgMapTransfer
	call TradeAnim_BlankTilemap
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	hlcoord 5, 0
	ld b, 6
	ld c, 9
	call DrawTextBox
	hlcoord 6, 0
	ld de, .OTMonData
	call PlaceString
	ret

.OTMonData:
	db   "──・．"
	next ""
	next "おや／"
	next "』・．@"

TrademonStats_WaitBGMap:
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress + 1], a
	ret

TrademonStats_PrintSpeciesNumber:
	hlcoord 10, 0
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	ret

TrademonStats_PrintSpeciesName:
	hlcoord 6, 2
	call PlaceString
	ret

TrademonStats_PrintOTName:
	hlcoord 9, 4
	call PlaceString
	ret

TrademonStats_PrintTrademonID:
	hlcoord 9, 6
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNumber
	ret

TradeAnim_RockingBall:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_TRADE_POKE_BALL
	call InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, 64
	ld [wFrameCounter], a
	ret

TradeAnim_DropBall:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_TRADE_POKE_BALL
	call InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $dc
	call TradeAnim_AdvanceScriptPointer
	ld a, 56
	ld [wFrameCounter], a
	ret

TradeAnim_Poof:
	depixel 10, 11, 4, 0
	ld a, SPRITE_ANIM_OBJ_TRADE_POOF
	call InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, 16
	ld [wFrameCounter], a
	ret

TradeAnim_BulgeThroughTube:
	ld a, %11100100 ; 3,2,1,0
	ldh [rOBP0], a
	depixel 5, 11
	ld a, SPRITE_ANIM_OBJ_TRADE_TUBE_BULGE
	call InitSpriteAnimStruct
	call TradeAnim_AdvanceScriptPointer
	ld a, 128
	ld [wFrameCounter], a
	ret

TradeAnim_AnimateTrademonInTube:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .InitTimer
	dw .WaitTimer1
	dw .MoveRight
	dw .MoveDown
	dw .MoveUp
	dw .MoveLeft
	dw .WaitTimer2

.JumptableNext:
	ld hl, SPRITEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

.InitTimer:
	call .JumptableNext
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $80
	ret

.WaitTimer1:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	call .JumptableNext

.MoveRight:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $94
	jr nc, .done_move_right
	inc [hl]
	ret

.done_move_right
	call .JumptableNext

.MoveDown:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $4c
	jr nc, .done_move_down
	inc [hl]
	ret

.done_move_down
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

.MoveUp:
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $2c
	jr z, .done_move_up
	dec [hl]
	ret

.done_move_up
	call .JumptableNext

.MoveLeft:
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	jr z, .done_move_left
	dec [hl]
	ret

.done_move_left
	call .JumptableNext
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $80
	ret

.WaitTimer2:
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], $0
	ret

TradeAnim_SentToOTText:
	ld a, [wLinkMode]
	cp LINK_TIMECAPSULE
	jr z, .time_capsule
	ld hl, .MonNameSentToText
	call PrintText
	ld c, 189
	call DelayFrames
	ld hl, .MonWasSentToText
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 128
	call DelayFrames
	call TradeAnim_AdvanceScriptPointer
	ret

.time_capsule:
	ld hl, .MonWasSentToText
	call PrintText
	call TradeAnim_Wait80Frames
	call TradeAnim_AdvanceScriptPointer
	ret

.MonWasSentToText:
	text_from_ram wPlayerTrademonSpeciesName
	text "は　ぶじ"
	line "@"
	text_from_ram wOTTrademonSenderName
	text "に　ひきとられました"
	done

.MonNameSentToText:
	text_start
	done

TradeAnim_OTBidsFarewell:
	ld hl, .BidsFarewellToMonText
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .MonNameBidsFarewellText
	call PrintText
	call TradeAnim_Wait80Frames
	call TradeAnim_AdvanceScriptPointer
	ret

.BidsFarewellToMonText:
	text_from_ram wOTTrademonSenderName
	text "が"
	line "なごりを　おしみながら"
	done

.MonNameBidsFarewellText:
	text_from_ram wOTTrademonSpeciesName
	text "を"
	line "おくってきます"
	done

TradeAnim_TakeCareOfText:
	call WaitForAutoBgMapTransfer
	hlcoord 0, 10
	ld bc, 8 * SCREEN_WIDTH
	ld a, '　'
	call ByteFill
	call WaitBGMap
	ld hl, .TakeGoodCareOfMonText
	call PrintText
	call TradeAnim_Wait80Frames
	call TradeAnim_AdvanceScriptPointer
	ret

.TakeGoodCareOfMonText:
	text_from_ram wOTTrademonSpeciesName
	text "を"
	line "かわいがってやってください"
	done

TradeAnim_OTSendsText1:
	ld hl, .ForYourMonSendsText
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .OTSendsText
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 14
	call DelayFrames
	call TradeAnim_AdvanceScriptPointer
	ret

.ForYourMonSendsText:
	text_from_ram wPlayerTrademonSenderName
	text "が"
	line "@"
	text_from_ram wPlayerTrademonSpeciesName
	text "を　おくったかわりに"
	done

.OTSendsText:
	text_from_ram wOTTrademonSenderName
	text "は"
	line "@"
	text_from_ram wOTTrademonSpeciesName
	text "を　くれます"
	done

TradeAnim_OTSendsText2:
	ld hl, .WillTradeText
	call PrintText
	call TradeAnim_Wait80Frames
	ld hl, .ForYourMonWillTradeText
	call PrintText
	call TradeAnim_Wait80Frames
	ld c, 14
	call DelayFrames
	call TradeAnim_AdvanceScriptPointer
	ret

.WillTradeText:
	text "これから"
	line "@"
	text_from_ram wOTTrademonSenderName
	text "の@"
	text_from_ram wOTTrademonSpeciesName
	text "と"
	done

.ForYourMonWillTradeText:
	text_from_ram wPlayerTrademonSenderName
	text "の@"
	text_from_ram wPlayerTrademonSpeciesName
	text "を"
	line "こうかんします！"
	done

TradeAnim_Wait80Frames:
	ld c, 80
	call DelayFrames
	ret

TradeAnim_BlankTilemap:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, '　'
	call ByteFill
	ret

TradeAnim_CopyBoxFromDEtoHL:
.row
	push bc
	push hl
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

TradeAnim_NormalPals:
	ld a, [wSGB]
	and a
	ld a, %11100100 ; 3,2,1,0
	jr z, .not_sgb
	ld a, $F0
.not_sgb:
	ldh [rOBP0], a
	ld a, %11100100 ; 3,2,1,0
	ldh [rBGP], a
	ret

LinkTradeAnim_LoadTradePlayerNames:
	push de
	ld de, wLinkPlayer1Name
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	pop hl
	ld de, wLinkPlayer2Name
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ret

LinkTradeAnim_LoadTradeMonSpecies:
	ld a, [hl]
	ld [wLinkTradeSendmonSpecies], a
	ld a, [de]
	ld [wLinkTradeGetmonSpecies], a
	ret

TradeAnim_FlashBGPals:
	ld a, [wFrameCounter2]
	and $7
	ret nz
	ldh a, [rBGP]
	xor %00111100
	ldh [rBGP], a
	ret

LoadTradeBallAndCableGFX:
	ld de, AnimObjPokeBallGFX
	ld hl, vChars0 tile $62
	lb bc, BANK(AnimObjPokeBallGFX), 6
	call Request2bpp
	ld de, AnimObjSmokeGFX
	ld hl, vChars0 tile $68
	lb bc, BANK(AnimObjSmokeGFX), $C
	call Request2bpp
	ld de, TradeCableGFX
	ld hl, vChars0 tile $74
	lb bc, BANK(TradeCableGFX), 4
	call Request2bpp
	ld a, $08
	ld hl, wSpriteAnimDict
	ldi [hl], a
	ld [hl], $62
	ret

LoadTradeBubbleGFX:
	ld e, MONICON_TRADE
	callfar LoadMenuMonIcon
	ld de, TradeBubbleGFX
	ld hl, vChars0 tile $72
	lb bc, BANK(TradeBubbleGFX), 4
	call Request2bpp
	ld a, $08
	ld hl, wSpriteAnimDict
	ldi [hl], a
	ld [hl], $62
	ret

TradeAnim_WaitAnim:
	ld hl, wFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	ret

.done:
	call TradeAnim_AdvanceScriptPointer
	ret

DebugTrade: ; unreferenced
	ld hl, .DebugTradeData

	ld a, [hli]
	ld [wPlayerTrademonSpecies], a
	ld de, wPlayerTrademonSenderName
	ld c, MON_NAME_LENGTH + 2
.loop1
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop1

	ld a, [hli]
	ld [wOTTrademonSpecies], a
	ld de, wOTTrademonSenderName
	ld c, MON_NAME_LENGTH + 2
.loop2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop2
	ret

MACRO debugtrade
; species, ot name, ot id
	db DEX_\1
	dname \2, MON_NAME_LENGTH
	dw \3
ENDM

.DebugTradeData:
	debugtrade VENUSAUR,  "ゲーフリ",  $0123
	debugtrade CHARIZARD, "クリーチャ", $0456 ; Creatures Inc.

TradeGameBoyTilemap:  INCBIN "gfx/trade/game_boy.tilemap" ; 6x8
TradeLinkTubeTilemap: INCBIN "gfx/trade/link_cable.tilemap" ; 12x3

TradeArrowRightGFX:   INCBIN "gfx/trade/arrow_right.2bpp"
TradeArrowLeftGFX:    INCBIN "gfx/trade/arrow_left.2bpp"
TradeGameBoyGFX:      INCBIN "gfx/trade/game_boy.2bpp"
TradeLinkCableGFX:    INCBIN "gfx/trade/link_cable.2bpp"
TradeCableGFX:        INCBIN "gfx/trade/cable.2bpp"
TradeBubbleGFX:       INCBIN "gfx/trade/bubble.2bpp"
