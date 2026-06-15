INCLUDE "constants.asm"

SECTION "engine/games/poker_minigame.asm", ROMX

PokerMinigame:
; Always start off with 256 coins
	ld hl, wCoins
	ld [hl], HIGH(MINIGAME_STARTING_COINS)
	inc hl
	ld [hl], LOW(MINIGAME_STARTING_COINS)

	ld hl, wOptions
	set NO_TEXT_SCROLL_F, [hl]
	call .Init
	call DelayFrame
.Loop:
	call .JumptableLoop
	jr nc, .Loop
	ld hl, wOptions
	res 4, [hl]
	ret

.Init:
	call DisableLCD
	callfar ClearSpriteAnims
	ld b, SGB_POKER
	call GetSGBLayout

	ld hl, PokerGFX
	ld de, vChars2
	ld bc, $70 tiles
	ld a, BANK(PokerGFX)
	call FarCopyData

	ld hl, PointerGFX
	ld de, vSprites
	ld bc, $4 tiles
	ld a, BANK(PointerGFX)
	call FarCopyData

	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill

	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ldh [rWY], a
	ld [wJumptableIndex], a
	ld a, 1
	ldh [hBGMapMode], a

	ld a, $29
	ld hl, wOptionsMenuCursorX
	ld [hli], a
	ld [hl], $00

	ld a, %11100011
	ldh [rLCDC], a

	call PokerMinigame_ShuffleFirstCard

	ld a, %11100100
	ldh [rBGP], a
	ld a, %11100000
	ldh [rOBP0], a
	ret

.JumptableLoop:
	ld a, [wJumptableIndex]
	bit MINIGAME_END_LOOP_F, a
	jr nz, .quit

	call .ExecuteJumptable

	callfar PlaySpriteAnimations

	call .PrintCoinsAndPayout

	call DelayFrame
	and a
	ret

.quit:
	scf
	ret

.PrintCoinsAndPayout:
	hlcoord 5, 1
	ld de, wCoins
	lb bc, PRINTNUM_LEADINGZEROS | 2, 4
	call PrintNumber
	hlcoord 11, 1
	ld de, wPokerCurrentBet
	lb bc, PRINTNUM_LEADINGZEROS | 2, 4
	call PrintNumber
	ret

.UnreferencedPrintTurnNumber:
	hlcoord 0, 0
	ld de, wPokerTurnNumber
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	ret

.ExecuteJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw .InitilizeGame
	dw .StartWait
	dw .Start
	dw .ChangeInit
	dw .Change
	dw .ChangeCard
	dw .CoinHit
	dw .DoubleUpCheck
	dw .DoubleUpInit,
	dw .DoubleUp
	dw .PayoutInit
	dw .Payout
	dw .RetryScreen
	dw .Exit
.Next:
	ld hl, wJumptableIndex
	inc [hl]
	ret

.InitilizeGame:
	xor a
	ld [wPokerPosition], a
	ld [wPokerPreviousCard], a
	ld hl, wPokerCurrentBet
	ld [hli], a
	ld [hl], a
	ld [wPokerWork], a
	ld [wPokerColWork], a

	call PokerMinigame_ClearCards
	call PokerMinigame_ClearColor
	call PokerMinigame_ClearBoard
	call .Next
	ret

.StartWait:
	call PokerMinigame_BetAmount
	jr nc, .StartWait_GetBet

	ld a, POKER_EXIT
	ld [wJumptableIndex], a
	ret

.StartWait_GetBet:
	ld [wPokerWork], a
	call .Next

.Start:
	ld a, [wPokerPreviousCard]
	cp 5
	jr nc, .Start_Next

	call PokerMinigame_GetNextCard
	call PokerMinigame_SetCardNumber
	call PokerMinigame_ReverseCard
	call PokerMinigame_OpenCard
	ld hl, wPokerPreviousCard
	inc [hl]

	ld c, $05
	call DelayFrames
	ret
.Start_Next:
	call PokerMinigame_CheckCards

	call PokerMinigame_GetMatchText
	call PokerMinigame_HudTextbox

	call .Next
	ret

.ChangeInit:
	call PokerMinigame_HudTextbox_DrawCursor
	ldh a, [hJoypadDown]
	and A_BUTTON
	ret z

	ld hl, PokerMinigame_BlankText
	call PrintText

	ld a, [wPokerPayout]
	and a
	jr nz, .ChangeInit_Open

	ld hl, PokerMinigame_InstructionsText
	call PrintText

	call PokerMinigame_ChangeCursor
	ld a, POKER_CHANGE
	ld [wJumptableIndex], a
	ret
.ChangeInit_Open:
	ld a, POKER_COIN_HIT
	ld [wJumptableIndex], a
	ret

.Change:
	call PokerMinigame_ChangeCursor_Change
	ret nc

	call PokerMinigame_ChangeCursor_Class
	xor a
	ld [wPokerPreviousCard], a
	call .Next
.ChangeCard:
	ld a, [wPokerPreviousCard]
	cp 5
	jr nc, .ChangeCard_Next

	ld e, a
	ld d, $00
	ld hl, wPokerSortOrder
	add hl, de
	ld a, [hl]
	and a
	jr z, .ChangeCard_Change
	ld hl, wPokerPreviousCard
	inc [hl]
	jr .ChangeCard
.ChangeCard_Change:
	call PokerMinigame_GetNextCard
	call PokerMinigame_SetCardNumber
	call PokerMinigame_ReverseCard
	call PokerMinigame_OpenCard
	ld hl, wPokerPreviousCard
	inc [hl]
	ret
.ChangeCard_Next:
	call PokerMinigame_CheckCards
	call .Next
	ret

.CoinHit:
	call PokerMinigame_GetPayout
	call PokerMinigame_GetMatchText
	call .Next
	ret

.DoubleUpCheck:
	call PokerMinigame_DoubleUpCheck
	jr nc, .DoubleUpCheck_Next
	ld a, POKER_PAYOUT_INIT
	ld [wJumptableIndex], a
	ret
.DoubleUpCheck_Next:
	call .Next
	ret

.DoubleUpInit:
	call PokerMinigame_ReverseAllCards
	call PokerMinigame_ClearCards
	call .Next
	ret

.DoubleUp:
	call PokerMinigame_DoubleUpMain
	ld a, POKER_DOUBLE_UP_CHECK
	ld [wJumptableIndex], a
	ret

.PayoutInit:
	call PokerMinigame_GetPayoutText
	call .Next
	ret

.Payout:
	ld hl, wBattleTransitionCounter
	ld a, [hl]
	inc [hl]
	and %0000001
	ret z

	ld hl, wPokerCurrentBet
	ld a, [hli]
	ld d, a
	or [hl]
	jr z, .Payout_Next

	ld e, [hl]
	dec de
	ld [hl], e
	dec hl
	ld [hl], d

	ld hl, wCoins
	ld d, [hl]
	inc hl
	ld e, [hl]
	call PokerMinigame_CheckCoinCase
	jr c, .Payout_Complete
	inc de
.Payout_Complete:
	ld [hl], e
	dec hl
	ld [hl], d

	ld a, [wBattleTransitionCounter]
	and %0000111
	ret z
	ld de, SFX_SLOTS_REWARD
	call PlaySFX
	ret
.Payout_Next:
	call .Next
	ret

.RetryScreen:
	call TextboxWaitPressAorB_BlinkCursor
	call PokerMinigame_ReverseAllCards
	call PokerMinigame_YesOrNo
	jr c, .RetryScreen_Exit
	ld a, POKER_INIT
	ld [wJumptableIndex], a
	ret
.RetryScreen_Exit:
	ld a, POKER_EXIT
	ld [wJumptableIndex], a
	ret

.Exit:
	ld hl, wJumptableIndex
	set MINIGAME_END_LOOP_F, [hl]
	ret

PokerMinigame_CheckCoinCase:
	ld a, d
	cp HIGH(MAX_COINS)
	jr c, .Full
	jr z, .NotFull
	jr .Filled

.NotFull:
	ld a, e
	cp LOW(MAX_COINS)
	jr c, .Full
.Filled:
	scf
	ret

.Full:
	and a
	ret

PokerMinigame_GetNextCard:
	ld a, [wPokerCardNumber]
	cp POKER_MAX_CARDS
	call nc, PokerMinigame_ShuffleCards

	ld hl, wPokerCardNumber
	ld e, [hl]
	ld d, $00
	inc [hl]
	ld hl, wPokerAddress
	add hl, de

	ld a, [hl]
	ld [wPokerPosition], a
	ret

PokerMinigame_ShuffleFirstCard:
	xor a
	ld [wPokerCardNumber], a
	ld a, 1
	ld [wPokerTurnNumber], a
	call PokerMinigame_ShuffleCardsMain
	ret
PokerMinigame_ShuffleCards:
	call PokerMinigame_ShuffleCardsMain

	ld hl, wPokerSortOrder
	ld b, 5
	ld c, 0
.CheckLoop:
	call .CheckVisible
	dec b
	jr nz, .CheckLoop
	ld a, c
	ld [wPokerCardNumber], a
	ld hl, wPokerTurnNumber
	ld a, [hl]
	inc a
	cp 40 + 1
	jr c, .Complete
	ld a, 1
.Complete:
	ld [hl], a

	ld hl, PokerMinigame_ShuffleCardsText
	call PrintText
	ld c, $40
	call DelayFrames
	call PokerMinigame_Shuffling
	ret

.CheckVisible:
	ld a, [hli]
	and a
	ret z

	push hl
	push bc

	ld b, 0
	ld hl, wPokerAddress
	add hl, bc
	ld d, [hl]
	ld [hli], a
	ld e, POKER_MAX_CARDS
.CheckVisible_Loop:
	cp [hl]
	jr z, .CheckVisible_Change
	inc hl
	dec e
	jr nz, .CheckVisible_Loop
	jr .CheckVisible_Return
.CheckVisible_Change:
	ld [hl], d
.CheckVisible_Return:
	pop bc
	inc c
	pop hl
	ret

PokerMinigame_ShuffleCardsMain:
	ld hl, wPokerAddress
	ld bc, POKER_MAX_CARDS
	xor a
	call ByteFill
	ld de, wPokerAddress
	ld c, $01
.Loop:
	call Random
	cp POKER_MAX_CARDS
	jr nc, .Loop
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	and a
	jr nz, .Loop
	ld [hl], c
	inc c
	ld a, c
	cp POKER_MAX_CARDS + 1
	jr c, .Loop
	ret

PokerMinigame_SetCardNumber:
	ld a, [wPokerPreviousCard]
	ld e, a
	ld d, $00
	ld hl, wPokerSortOrder
	add hl, de
	ld a, [wPokerPosition]
	ld [hl], a
	ret

PokerMinigame_ClearCards:
	ld hl, wPokerSortOrder
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ret

PokerMinigame_PlaceCards:
	xor a
	ldh [hBGMapMode], a

	push hl
	ld bc, 20 - 4

	ld a, [wPokerPosition]
	and a
	jr z, .Flipped

	ld e, a
	ld d, $00
	ld hl, PokerMinigame_CardData
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl

	ld a, [wPokerPosition]
	dec a
	call PokerMinigame_DataConvert
	and %11110000
	swap a
	add $1B
	ld [hl], a
	inc hl
	ld [hl], $05
	inc hl
	ld [hl], $05
	inc hl
	ld [hl], $06
	inc hl
	add hl, bc

	ld [hl], $10
	inc hl
	ld [hl], e
	inc hl
	ld [hl], $00
	inc hl
	ld [hl], $03
	inc hl
	add hl, bc

	call .Sub
	call .Sub
	call .Sub

	ld [hl], $07
	inc hl
	ld [hl], $08
	inc hl
	ld [hl], $08
	inc hl
	ld [hl], $09
	call WaitBGMap
	ret
.Flipped:
	pop hl
	ld de, PokerMinigame_ReverseData
	ld bc, $0604
.Flipped_Loop:
	push bc
.Flipped_Loop1:
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .Flipped_Loop1
	ld bc, 20 - 4
	add hl, bc
	pop bc
	dec b
	jr nz, .Flipped_Loop
	call WaitBGMap
	ret

.Sub:
	ld a, $04
.Sub_Loop:
	ld [hl], d
	inc hl
	inc d
	dec a
	jr nz, .Sub_Loop
	add hl, bc
	ret

PokerMinigame_ClearBoard:
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld b, 6
.Loop:
	ld c, 20
	ld a, $0C
.Loop1:
	ld [hli], a
	xor 1
	dec c
	jr nz, .Loop1

	ld c, $14
	ld a, $0E
.Loop2:
	ld [hli], a
	xor 1
	dec c
	jr nz, .Loop2
	dec b
	jr nz, .Loop

	hlcoord 5, 0
	ld a, $3C
	ld c, 4
.Loop3:
	ld [hli], a
	inc a
	dec c
	jr nz, .Loop3

	hlcoord 11, 0
	ld a, $4C
	ld c, 4
.Loop4:
	ld [hli], a
	inc a
	dec c
	jr nz, .Loop4
	call PokerMinigame_Shuffling
	call PokerMinigame.PrintCoinsAndPayout
	call WaitBGMap
	ret

PokerMinigame_GetCardPos:
	ld e, a
	ld d, $00
	ld hl, .Table
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret
.Table:
	dw SCREEN_WIDTH * 5 + 2 + wTileMap
	dw SCREEN_WIDTH * 5 + 5 + wTileMap
	dw SCREEN_WIDTH * 5 + 8 + wTileMap
	dw SCREEN_WIDTH * 5 + 11 + wTileMap
	dw SCREEN_WIDTH * 5 + 14 + wTileMap

PokerMinigame_SortCards:
	ld hl, wPokerSortOrder
	ld de, wPokerString
	ld c, 5
.SetLoop:
	ld a, [hli]
	dec a
	ld [de], a
	inc de
	dec c
	jr nz, .SetLoop

	ld b, 4
.MainLoop:
	ld hl, wPokerString
	ld c, b
.Loop:
	ld a, [hli]
	ld d, [hl]
	cp d
	jr c, .Pass

	ld [hld], a
	ld [hl], d
	inc hl
.Pass:
	dec c
	jr nz, .Loop
	dec b
	jr nz, .MainLoop

	ld de, wPokerString
	ld a, 5
.ConvLoop:
	push af
	ld a, [de]
	call PokerMinigame_DataConvert
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .ConvLoop
	ret
PokerMinigame_DataConvert:
	push hl
	push de
	ld e, a
	ld d, $00
	ld hl, PokerMinigame_ConvTable
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

PokerMinigame_CheckCards:
	call PokerMinigame_SortCards

	xor a
	ld [wPokerAllow], a

	call .CheckFiveOfAKind
	ret c
	call .CheckFourOfAKind
	ret c
	call .CheckStraightFlush
	ret c
	call .CheckFullHouse
	ret c
	call .CheckFlush
	ret c
	call .CheckStraight
	ret c
	call .CheckThreeOfAKind
	ret c
	call .CheckTwoPair
	ret c
	call .CheckOnePair
	ret

.CheckFiveOfAKind:
	ld hl, wPokerString
	call .CheckFiveOfAKindSub
	ret nc
	ld a, POKER_PAYOUT_FIVEOFAKIND
	ld [wPokerAllow], a
	scf
	ret

.CheckFourOfAKind:
	ld hl, wPokerString
	call .CheckFourOfAKindSub
	jr c, .CheckFourOfAKind_Match
	ld hl, wPokerString + 1
	call .CheckFourOfAKindSub
	ret nc
.CheckFourOfAKind_Match:
	ld a, POKER_PAYOUT_FOUROFAKIND
	ld [wPokerAllow], a
	scf
	ret

.CheckStraightFlush:
	call .CheckFlushSub
	ret nc
	call .CheckStraightSub
	ret nc
	ld a, POKER_PAYOUT_STRAIGHT_FLUSH
	ld [wPokerAllow], a
	scf
	ret

.CheckFullHouse:
	ld hl, wPokerString
	call .CheckThreeOfAKindSub
	jr nc, .CheckFullHouse_Pattern
	ld hl, wPokerString + 3
	call .CheckOnePairSub
	jr c, .CheckFullHouse_Match
	ret

.CheckFullHouse_Pattern:
	ld hl, wPokerString + 2
	call .CheckThreeOfAKindSub
	ret nc
	ld hl, wPokerString
	call .CheckOnePairSub
	ret nc
.CheckFullHouse_Match:
	ld a, POKER_PAYOUT_FULL_HOUSE
	ld [wPokerAllow], a
	scf
	ret

.CheckFlush:
	call .CheckFlushSub
	ret nc
	ld a, POKER_PAYOUT_FLUSH
	ld [wPokerAllow], a
	scf
	ret

.CheckStraight:
	call .CheckStraightSub
	ret nc
	ld a, POKER_PAYOUT_STRAIGHT
	ld [wPokerAllow], a
	scf
	ret

.CheckThreeOfAKind:
	ld hl, wPokerString
	call .CheckThreeOfAKindSub
	jr c, .CheckThreeOfAKind_Match
	ld hl, wPokerString + 1
	call .CheckThreeOfAKindSub
	jr c, .CheckThreeOfAKind_Match
	ld hl, wPokerString + 2
	call .CheckThreeOfAKindSub
	ret nc
.CheckThreeOfAKind_Match:
	ld a, POKER_PAYOUT_THREEOFAKIND
	ld [wPokerAllow], a
	scf
	ret

.CheckTwoPair:
	ld hl, wPokerString
	call .CheckOnePairSub
	jr nc, .CheckTwoPair_Pattern
	ld hl, wPokerString + 2
	call .CheckOnePairSub
	jr c, .CheckTwoPair_Match
	ld hl, wPokerString + 3
	call .CheckOnePairSub
	jr c, .CheckTwoPair_Match
	ret

.CheckTwoPair_Pattern:
	ld hl, wPokerString + 1
	call .CheckOnePairSub
	ret nc
	ld hl, wPokerString + 3
	call .CheckOnePairSub
	ret nc
.CheckTwoPair_Match:
	ld a, POKER_PAYOUT_TWOPAIR
	ld [wPokerAllow], a
	scf
	ret

.CheckOnePair:
	ld hl, wPokerString
	call .CheckOnePairSub
	jr c, .CheckOnePair_Match
	ld hl, wPokerString + 1
	call .CheckOnePairSub
	jr c, .CheckOnePair_Match
	ld hl, wPokerString + 2
	call .CheckOnePairSub
	jr c, .CheckOnePair_Match
	ld hl, wPokerString + 3
	call .CheckOnePairSub
	ret nc
.CheckOnePair_Match:
	ld a, POKER_PAYOUT_ONEPAIR
	ld [wPokerAllow], a
	scf
	ret

.CheckFiveOfAKindSub:
	ld a, [hli]
	and %00001111
	ld d, a
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFiveOfAKind
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFiveOfAKind
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFiveOfAKind
	ld a, [hl]
	and %00001111
	cp d
	jr nz, .NotFiveOfAKind
	scf
	ret

.NotFiveOfAKind:
	and a
	ret

.CheckFourOfAKindSub:
	ld a, [hli]
	and %00001111
	ld d, a
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFourOfAKind
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFourOfAKind
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotFourOfAKind
	scf
	ret

.NotFourOfAKind:
	and a
	ret

.CheckThreeOfAKindSub:
	ld a, [hli]
	and %00001111
	ld d, a
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotThreeOfAKind
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotThreeOfAKind
	scf
	ret

.NotThreeOfAKind:
	and a
	ret

.CheckOnePairSub:
	ld a, [hli]
	and %00001111
	ld d, a
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotOnePair
	scf
	ret

.NotOnePair:
	and a
	ret

.CheckStraightSub:
	ld hl, wPokerString
	ld a, [hli]
	and %00001111
	ld d, a
	inc d
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotStraight
	inc d
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotStraight
	inc d
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotStraight
	inc d
	ld a, [hli]
	and %00001111
	cp d
	jr nz, .NotStraight
	ld a, $04
	ld [wPokerAllow], a
	scf
	ret

.NotStraight:
	and a
	ret

.CheckFlushSub:
	ld hl, wPokerString
	ld a, [hli]
	and %11110000
	ld d, a
	ld a, [hli]
	and %11110000
	cp d
	jr nz, .NotFlush
	ld a, [hli]
	and %11110000
	cp d
	jr nz, .NotFlush
	ld a, [hli]
	and %11110000
	cp d
	jr nz, .NotFlush
	ld a, [hli]
	and %11110000
	cp d
	jr nz, .NotFlush
	scf
	ret

.NotFlush:
	and a
	ret

PokerMinigame_BetAmount:
	ld hl, PokerMinigame_AskBetText
	call PrintText

	ld hl, PokerMinigame_BetWindow
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c

	ld a, [w2DMenuDataEnd]
	ld hl, .table
	dec a
	ld e, a
	ld d, $00
	add hl, de
	ld c, [hl]

	ld hl, wCoins
	ld a, [hli]
	and a
	jr nz, .CheckBet
	ld a, [hl]
	cp c
	jr nc, .CheckBet
	ld hl, PokerMinigame_NotEnoughCoinsText
	call PrintText
	jr PokerMinigame_BetAmount

.CheckBet:
	ld hl, wCoins + 1
	ld a, [hl]
	sub c
	ld [hld], a
	jr nc, .SetBet
	dec [hl]
.SetBet:
	push bc
	ld de, $0030
	call PlaySFX
	pop bc
	ld a, c
	and a
	ret

.table:
	db 10, 5, 1

PokerMinigame_YesOrNo:
	ld hl, wCoins
	ld a, [hli]
	or [hl]
	jr nz, .menu

	ld hl, PokerMinigame_NoCoinsText
	call PrintText
	ld c, 60
	call DelayFrames
	jr .yes

.menu:
	ld hl, PokerMinigame_ReplayText
	call PrintText

	call YesNoBox
	jr c, .yes
	and a
	ret

.yes:
	scf
	ret

PokerMinigame_DoubleUpCheck:
	ld hl, wPokerCurrentBet
	ld a, [hli]
	or [hl]
	jr z, .dud

	call TextboxWaitPressAorB_BlinkCursor
	ld hl, PokerMinigame_DoubleUpText
	call PrintText

	call YesNoBox
	ret

.dud:
	scf
	ret

PokerMinigame_GetPayout:
	ld a, [wPokerAllow]
	ld e, a
	ld d, 0
	ld hl, .table
	add hl, de
	add hl, de
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld a, [wPokerWork]
	ld hl, 0
	call AddNTimes
	ld a, l
	ld [wPokerCurrentBet + 1], a
	ld a, h
	ld [wPokerCurrentBet], a
	ret
.table:
	dw  0	; Dud (Double UP)
	dw  0	; One Pair
	dw  1	; Two Pair
	dw  2	; Three of a Kind
	dw  4	; Straight
	dw 20	; Flush
	dw 10	; Full House
	dw 80	; Straight Flush
	dw 40	; Four of a Kind
	dw 100	; Five of a Kind

PokerMinigame_HudTextbox:
	hlcoord 11, 12
	ld bc, $0407
	call DrawTextBox

	ld de, .ExchangeText
	hlcoord 13, 14
	call PlaceString
	ld de, .StayAsIsText
	hlcoord 13, 16
	call PlaceString
	xor a
	ld [wPokerPayout], a
	hlcoord 12, 14
	ld [hl], $ED
	ret
.ExchangeText:
	db "とりかえ@"
.StayAsIsText:
	db "このまま@"

PokerMinigame_HudTextbox_DrawCursor:
	ldh a, [hJoypadDown]
	and D_UP | D_DOWN
	ret z

	xor a
	ldh [hJoypadDown], a
	hlcoord 12, 14
	ld [hl], a
	hlcoord 12, 16
	ld [hl], a

	ld a, [wPokerPayout]
	xor 1
	ld [wPokerPayout], a
	ld e, a
	ld d, $00
	ld hl, .PosTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld [hl], '▶'
	ret

.PosTable:
	dw SCREEN_WIDTH * 14 + 12 + wTileMap
	dw SCREEN_WIDTH * 16 + 12 + wTileMap

PokerMinigame_Shuffling:
	ld hl, PokerMinigame_ShufflingTable

	ld a, [wPokerTurnNumber]
	ld c, a
	ld b, $6D
	call .SetSub

	ld a, [wPokerTurnNumber]
	ld c, a
	ld a, 40
	sub c
	ld c, a
	ld b, $6C
.SetSub:
	ld a, c
	and a
	ret z
	dec c

	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, b
	ld [de], a
	jr .SetSub


PokerMinigame_ChangeCursor:
	ld de, $6818
	ld a, SPRITE_ANIM_OBJ_POKER_CURSOR
	call InitSpriteAnimStruct
	ld a, c
	ld [wPokerDoubleUp], a
	ld a, b
	ld [wPokerDoubleUp + 1], a
	ret

PokerMinigame_ChangeCursor_Change:
	ld hl, hJoypadDown
	ld a, [hl]
	and B_BUTTON
	jr nz, .Next
	and a
	ret

.Next:
	ld hl, wPokerSortOrder
	ld a, 5
.Loop:
	bit 7, [hl]
	jr z, .Pass
	ld [hl], 0
.Pass:
	inc hl
	dec a
	jr nz, .Loop
	scf
	ret

PokerMinigame_ChangeCursor_Class:
	ld a, [wPokerDoubleUp]
	ld c, a
	ld a, [wPokerDoubleUp + 1]
	ld b, a
	ld hl, 0
	add hl, bc
	ld [hl], 0
	ret

PokerMinigame_GetMatchText:
	ld hl, PokerMinigame_BlankText
	call PrintText
	ld a, [wPokerAllow]
	ld e, a
	ld d, $00
	ld hl, .Table
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $C3B9
	call PlaceString
	ret

.Table:
	dw PokerMinigame_DudText, PokerMinigame_OnePairText, PokerMinigame_TwoPairText, PokerMinigame_ThreeOfAKindText, PokerMinigame_StraightText, PokerMinigame_FlushText, PokerMinigame_FullHouseText, PokerMinigame_StraightFlushText
	dw PokerMinigame_FourOfAKindText, PokerMinigame_FiveOfAKindText

PokerMinigame_GetPayoutText:
	ld hl, wPokerCurrentBet
	ld a, [hli]
	or [hl]
	ret z

	ld hl, PokerMinigame_PayoutText
	call PrintText
	ret

PokerMinigame_OpenCard:
	call PokerMinigame_SetCardColor
	ld a, [wPokerPreviousCard]
	call PokerMinigame_GetCardPos
	call PokerMinigame_PlaceCards
	ret

PokerMinigame_ReverseCard:
	ld a, [wPokerPosition]
	push af
	xor a
	ld [wPokerPosition], a
	ld a, [wPokerPreviousCard]
	call PokerMinigame_GetCardPos
	call PokerMinigame_PlaceCards
	pop af
	ld [wPokerPosition], a
	ret

PokerMinigame_ReverseAllCards:
	ld a, [wPokerColWork]
	and a
	jr z, .all
	ld a, $01
	ld [wPokerPreviousCard], a
	call PokerMinigame_ReverseCard
	ld a, $03
	ld [wPokerPreviousCard], a
	call PokerMinigame_ReverseCard
	ret

.all:
	xor a
	ld [wPokerPreviousCard], a
.loop:
	ld a, [wPokerPreviousCard]
	cp $05
	ret nc
	call PokerMinigame_ReverseCard
	ld hl, wPokerPreviousCard
	inc [hl]
	jr .loop

PokerMinigame_CursorAction:
	ld hl, hJoypadDown
	ld a, [hl]
	and $01
	jr nz, .change

	call .cursor
	ld hl, $0C
	add hl, bc
	ld a, [hl]
	ld e, a
	ld d, $00
	ld hl, .table
	add hl, de
	ld a, [hli]
	ld hl, 6
	add hl, bc
	ld [hl], a
	ret
.change:
	ld hl, $0C
	add hl, bc
	ld a, [hl]
	ld [wPokerPreviousCard], a

	ld e, a
	ld d, $00
	ld hl, wPokerSortOrder
	add hl, de
	ld a, [hl]
	xor %10000000
	ld [hl], a
	bit 7, [hl]
	jr nz, .reverse
	ld hl, $0C
	add hl, bc
	ld a, [hl]
	ld e, a
	ld d, $00
	ld hl, wPokerSortOrder
	add hl, de
	ld a, [hl]
	ld [wPokerPosition], a
	call PokerMinigame_ReverseCard
	call PokerMinigame_OpenCard
	ret
.reverse:
	call PokerMinigame_ReverseCard
	ret
.cursor:
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ret
.left:
	ld hl, $0C
	add hl, bc
	ld a, [hl]
	and a
	jr z, .leftmax
	dec [hl]
	ret
.leftmax:
	ld [hl], 4
	ret
.right:
	ld hl, $0C
	add hl, bc
	ld a, [hl]
	cp 4
	jr z, .rightmax
	inc [hl]
	ret
.rightmax:
	ld [hl], $00
	ret

.table:
	db $10
	db $28
	db $40
	db $58
	db $70

PokerMinigame_DoubleUpMain:
	ld a, [wPokerColWork]
	and a
	jr nz, .init

	call PokerMinigame_ClearColor
	call PokerMinigame_ClearBoard
	ld c, 10
	call DelayFrames

	call PokerMinigame_GetNextCard
	ld [wPokerColWork], a
.init:
	ld a, $01
	ld [wPokerPreviousCard], a
	ld a, [wPokerColWork]
	ld [wPokerPosition], a
	call PokerMinigame_SetCardNumber
	call PokerMinigame_ReverseCard
	call PokerMinigame_OpenCard

	ld c, $20
	call DelayFrames

	ld a, $03
	ld [wPokerPreviousCard], a
	call PokerMinigame_GetNextCard
	call PokerMinigame_SetCardNumber
	call PokerMinigame_ReverseCard

	ld hl, PokerMinigame_DoubleUpInstructionsText
	call PrintText

	ld hl, PokerMinigame_HighLowWindow
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow

	call PokerMinigame_OpenCard

	ld a, [wPokerColWork]
	dec a
	call PokerMinigame_DataConvert
	and %00001111
	ld e, a

	ld a, [w2DMenuDataEnd]
	cp 1
	jr z, .up
	ld a, [wPokerPosition]
	dec a
	call PokerMinigame_DataConvert
	and %00001111
	cp e
	jr z, .tie
	jr nc, .dud
	jr .double

.up:
	ld a, [wPokerPosition]
	dec a
	call PokerMinigame_DataConvert
	and %00001111
	cp e
	jr z, .tie
	jr c, .dud
	jr .double

.tie:
	ld hl, PokerMinigame_TieText
	call PrintText
	jr .ret

.double:
	ld hl, PokerMinigame_WinDoubleUpText
	call PrintText
	ld hl, wPokerCurrentBet
	ld d, [hl]
	inc hl
	ld e, [hl]
	sla e
	rl d
	call PokerMinigame_CheckCoinCase
	jr nc, .pass
	ld de, 9999
.pass:
	ld [hl], e
	dec hl
	ld [hl], d
	jr .ret

.dud:
	ld hl, PokerMinigame_FailDoubleUpText
	call PrintText
	xor a
	ld hl, wPokerCurrentBet
	ld [hli], a
	ld [hl], a
.ret:
	ld a, [wPokerPosition]
	ld [wPokerColWork], a
	ret

PokerMinigame_SetCardColor:
	ld a, [wPokerPosition]
	dec a
	call PokerMinigame_DataConvert
	and %11110000
	swap a
	ld e, a
	ld d, $00
	ld hl, .ColTable
	add hl, de
	ld a, [hl]
	ld [wPokerWorkEnd + 3], a

	ld a, [wPokerPreviousCard]
	ld e, a
	ld d, $00
	ld hl, .PosTable
	add hl, de
	ld a, [hl]

	ld hl, wPokerWorkEnd + 4
	ld [hli], a
	ld [hl], 5
	inc hl
	add $03
	ld [hli], a
	ld [hl], $0A
	callfar Function9645
	ret

.ColTable:
	db %00001111
	db %00001010
	db %00000000
	db %00000101
	db %00000000

.PosTable:
	db 2, 5, 8, 11, 14

PokerMinigame_ClearColor:
	ld b, SGB_POKER
	call GetSGBLayout
	ret

PokerMinigame_CardData:
	db $05, $60, $11, $20, $11, $30, $11, $40, $11, $50, $11, $60, $12, $20, $12, $30
	db $12, $40, $12, $50, $12, $60, $13, $20, $13, $30, $13, $40, $13, $50, $13, $60
	db $14, $20, $14, $30, $14, $40, $14, $50, $14, $60, $15, $20, $15, $30, $15, $40
	db $15, $50, $15, $60, $16, $20, $16, $30, $16, $40, $16, $50, $16, $60, $17, $20
	db $17, $30, $17, $40, $17, $50, $17, $60, $18, $20, $18, $30, $18, $40, $18, $50
	db $18, $60, $19, $20, $19, $30, $19, $40, $19, $50, $19, $60, $1A, $20, $1A, $30
	db $1A, $40, $1A, $50, $1A, $60

PokerMinigame_InstructionsText:
	text "エーボタン　で　カードを　えらび"
	line "ビーボタン　で　しょうぶ！"
	done

PokerMinigame_NoCoinsText:
	text "コインが"
	line "なくなっちゃった<⋯⋯>"
	done

PokerMinigame_ReplayText:
	text "もう　１かい"
	line "あそびますか？"
	done

PokerMinigame_DoubleUpText:
	text "ダブルアップ　に"
	line "ちょうせん　しますか？"
	done

PokerMinigame_DoubleUpInstructionsText:
	text "みぎ　の　カードは"
	line "ひだり　より　うえ？した？"
	done

PokerMinigame_TieText:
	text "ひきわけー"
	done

PokerMinigame_WinDoubleUpText:
	text "やったー！！"
	done

PokerMinigame_FailDoubleUpText:
	text "ざんねん⋯⋯"
	done

PokerMinigame_AskBetText:
	text "コインを"
	line "なんまい　かけますか？"
	done

PokerMinigame_NotEnoughCoinsText:
	text "コインが　たりません！"
	prompt

PokerMinigame_PayoutText:
	text "やったー！！"
	line "コイン　@"
	deciram wPokerCurrentBet, 2, 4
	text "まい　いただき！"
	done

PokerMinigame_ShuffleCardsText:
	text "カードを　きります"
	done

PokerMinigame_BlankText:
	db "@"

PokerMinigame_DudText:
	db "はずれ@"

PokerMinigame_OnePairText:
	db "１ぺア@"

PokerMinigame_TwoPairText:
	db "２ぺア@"

PokerMinigame_ThreeOfAKindText:
	db "３カード@"

PokerMinigame_StraightText:
	db "ストレート@"

PokerMinigame_FlushText:
	db "フラッシュ@"

PokerMinigame_FullHouseText:
	db "フルハウス@"

PokerMinigame_StraightFlushText:
	db "ストレートフラッシュ@"

PokerMinigame_FourOfAKindText:
	db "４カード@"

PokerMinigame_FiveOfAKindText:
	db "５カード@"

PokerMinigame_HighLowWindow:
	db	%01000000
	db	12, 14, 17, 19
	dw	.text
	db	1
.text:
	db	%10000000
	db	2
	db "うえ@"
	db "した@"

PokerMinigame_BetWindow:
	db	%01000000
	db	10, 13, 17, 19
	dw	.text
	db	1
.text:
	db	%10000000
	db	3
	db	"１０まい@"
	db	"　５まい@"
	db	"　１まい@"

PokerMinigame_ReverseData:
	db $04, $05, $05, $06, $02, $2C, $2D, $03, $0A, $2E, $2F, $0B, $0A, $5C, $5D, $0B
	db $02, $5E, $5F, $03, $07, $08, $08, $09

PokerMinigame_ConvTable:
	db $00, $10, $20, $30, $40, $01, $11, $21, $31, $41, $02, $12, $22, $32, $42, $03
	db $13, $23, $33, $43, $04, $14, $24, $34, $44, $05, $15, $25, $35, $45, $06, $16
	db $26, $36, $46, $07, $17, $27, $37, $47, $08, $18, $28, $38, $48, $09, $19, $29
	db $39, $49, $0A, $1A, $2A, $3A, $4A

PokerMinigame_ShufflingTable:
	db $68, $C3, $54, $C3, $40, $C3, $2C, $C3, $18, $C3, $04, $C3, $F0, $C2, $DC, $C2
	db $C8, $C2, $B4, $C2, $A0, $C2, $A1, $C2, $A2, $C2, $A3, $C2, $A4, $C2, $A5, $C2
	db $A6, $C2, $A7, $C2, $A8, $C2, $A9, $C2, $AA, $C2, $AB, $C2, $AC, $C2, $AD, $C2
	db $AE, $C2, $AF, $C2, $B0, $C2, $B1, $C2, $B2, $C2, $B3, $C2, $C7, $C2, $DB, $C2
	db $EF, $C2, $03, $C3, $17, $C3, $2B, $C3, $3F, $C3, $53, $C3, $67, $C3, $7B, $C3

