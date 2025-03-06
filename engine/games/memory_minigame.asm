INCLUDE "constants.asm"

SECTION "engine/games/memory_minigame.asm", ROMX

; MemoryMinigame.Jumptable indices
	const_def
	const MEMORYGAME_RESTART_GAME
	const MEMORYGAME_RESTART_BOARD
	const MEMORYGAME_INIT_BOARD_AND_CURSOR
	const MEMORYGAME_CHECK_TRIES_REMAINING
	const MEMORYGAME_PICK_CARD_1
	const MEMORYGAME_PICK_CARD_2
	const MEMORYGAME_DELAY_PICK_AGAIN
	const MEMORYGAME_REVEAL_ALL
	const MEMORYGAME_ASK_PLAY_AGAIN
DEF MEMORYGAME_END_LOOP_F EQU 7

DEF MEMORYGAME_STARTING_COINS EQU 256

MemoryMinigame:
; Always start off with 256 coins
	ld hl, wCoins
	ld [hl], HIGH(MEMORYGAME_STARTING_COINS)
	inc hl
	ld [hl], LOW(MEMORYGAME_STARTING_COINS)

	call .LoadGFXAndPals
	call DelayFrame
.loop
	call .JumptableLoop
	jr nc, .loop
	ret

.LoadGFXAndPals:
	call DisableLCD
	ld b, SGB_DIPLOMA
	call GetSGBLayout
	callfar ClearSpriteAnims

	ld hl, MemoryGameGFX
	ld de, vChars2
	ld bc, $70 tiles
	ld a, BANK(MemoryGameGFX)
	call FarCopyData

	ld hl, PointerGFX
	ld de, vSprites
	ld bc, $4 tiles
	ld a, BANK(PointerGFX)
	call FarCopyData

	ld a, SPRITE_ANIM_DICT_ARROW_CURSOR
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], 0

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
	ld a, %11100011
	ldh [rLCDC], a
	ld a, %11100100
	ldh [rBGP], a
	ld a, %11100000
	ldh [rOBP0], a
	ret

.JumptableLoop:
	ld a, [wJumptableIndex]
	bit MEMORYGAME_END_LOOP_F, a
	jr nz, .quit
	call .ExecuteJumptable
	callfar PlaySpriteAnimations
	call DelayFrame
	and a
	ret

.quit
	scf
	ret

.ExecuteJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw .RestartGame
	dw .ResetBoard
	dw .InitBoardTilemapAndCursorObject
	dw .CheckTriesRemaining
	dw .PickCard1
	dw .PickCard2
	dw .DelayPickAgain
	dw .RevealAll
	dw .AskPlayAgain

.RestartGame:
	call MemoryGame_InitStrings
	ld hl, wJumptableIndex
	inc [hl]
	ret

.ResetBoard:
	call Cursor_AnimateCursor
	jr nc, .proceed
	ld hl, wJumptableIndex
	set MEMORYGAME_END_LOOP_F, [hl]
	ret

.proceed
	call MemoryGame_InitBoard
	ld hl, wJumptableIndex
	inc [hl]
	xor a
	ld [wMemoryGameCounter], a
	ld hl, wMemoryGameLastMatches
rept 4
	ld [hli], a
endr
	ld [hl], a
	ld [wMemoryGameNumCardsMatched], a

.InitBoardTilemapAndCursorObject:
	ld hl, wMemoryGameCounter
	ld a, [hl]
	cp 45
	jr nc, .spawn_object
	inc [hl]
	call MemoryGame_Card2Coord
	xor a
	ld [wMemoryGameLastCardPicked], a
	call MemoryGame_PlaceCard
	ret

.spawn_object
	depixel 6, 3, 4, 4
	ld a, SPRITE_ANIM_OBJ_MEMORY_GAME_CURSOR
	call InitSpriteAnimStruct
	ld a, 5
	ld [wMemoryGameNumberTriesRemaining], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.CheckTriesRemaining:
	ld a, [wMemoryGameNumberTriesRemaining]
	hlcoord 17, 0
	add "０"
	ld [hl], a
	ld hl, wMemoryGameNumberTriesRemaining
	ld a, [hl]
	and a
	jr nz, .next_try
	ld a, MEMORYGAME_REVEAL_ALL
	ld [wJumptableIndex], a
	ret

.next_try
	dec [hl]
	xor a
	ld [wMemoryGameCardChoice], a
	ld hl, wJumptableIndex
	inc [hl]

.PickCard1:
	ld a, [wMemoryGameCardChoice]
	and a
	ret z
	dec a
	ld e, a
	ld d, 0
	ld hl, wMemoryGameCards
	add hl, de
	ld a, [hl]
	cp -1
	ret z
	ld [wMemoryGameLastCardPicked], a
	ld [wMemoryGameCard1], a
	ld a, e
	ld [wMemoryGameCard1Location], a
	call MemoryGame_Card2Coord
	call MemoryGame_PlaceCard
	xor a
	ld [wMemoryGameCardChoice], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.PickCard2:
	ld a, [wMemoryGameCardChoice]
	and a
	ret z
	dec a
	ld hl, wMemoryGameCard1Location
	cp [hl]
	ret z
	ld e, a
	ld d, 0
	ld hl, wMemoryGameCards
	add hl, de
	ld a, [hl]
	cp -1
	ret z
	ld [wMemoryGameLastCardPicked], a
	ld [wMemoryGameCard2], a
	ld a, e
	ld [wMemoryGameCard2Location], a
	call MemoryGame_Card2Coord
	call MemoryGame_PlaceCard
	ld a, 64
	ld [wMemoryGameCounter], a
	ld hl, wJumptableIndex
	inc [hl]

.DelayPickAgain:
	ld hl, wMemoryGameCounter
	ld a, [hl]
	and a
	jr z, .PickAgain
	dec [hl]
	ret

.PickAgain:
	call MemoryGame_CheckMatch
	ld a, MEMORYGAME_CHECK_TRIES_REMAINING
	ld [wJumptableIndex], a
	ret

.RevealAll:
	ldh a, [hJoypadDown]
	and A_BUTTON
	ret z
	xor a
	ld [wMemoryGameCounter], a

.RevelationLoop:
	ld hl, wMemoryGameCounter
	ld a, [hl]
	cp 45
	jr nc, .finish_round
	inc [hl]
	push af
	call MemoryGame_Card2Coord
	pop af
	push hl
	ld e, a
	ld d, 0
	ld hl, wMemoryGameCards
	add hl, de
	ld a, [hl]
	pop hl
	cp -1
	jr z, .RevelationLoop
	ld [wMemoryGameLastCardPicked], a
	call MemoryGame_PlaceCard
	jr .RevelationLoop

.finish_round
	call TextboxWaitPressAorB_BlinkCursor
	ld hl, wJumptableIndex
	inc [hl]

.AskPlayAgain:
	call Cursor_InterpretJoypad
	jr nc, .restart
	ld hl, wJumptableIndex
	set MEMORYGAME_END_LOOP_F, [hl]
	ret

.restart
	xor a
	ld [wJumptableIndex], a
	ret

MemoryGame_CheckMatch:
	ld hl, wMemoryGameCard1
	ld a, [hli]
	cp [hl]
	jr nz, .no_match

	ld a, [wMemoryGameCard1Location]
	call MemoryGame_Card2Coord
	call MemoryGame_DeleteCard

	ld a, [wMemoryGameCard2Location]
	call MemoryGame_Card2Coord
	call MemoryGame_DeleteCard

	ld a, [wMemoryGameCard1Location]
	ld e, a
	ld d, 0
	ld hl, wMemoryGameCards
	add hl, de
	ld [hl], -1

	ld a, [wMemoryGameCard2Location]
	ld e, a
	ld d, 0
	ld hl, wMemoryGameCards
	add hl, de
	ld [hl], -1

	ld hl, wMemoryGameLastMatches
.find_empty_slot
	ld a, [hli]
	and a
	jr nz, .find_empty_slot
	dec hl
	ld a, [wMemoryGameCard1]
	ld [hl], a
	ld [wMemoryGameLastCardPicked], a
	ld hl, wMemoryGameNumCardsMatched
	ld e, [hl]
	inc [hl]
	inc [hl]
	ld d, 0
	hlcoord 5, 0
	add hl, de
	call MemoryGame_PlaceCard
	ld hl, .VictoryText
	call PrintText
	ret

.no_match
	xor a
	ld [wMemoryGameLastCardPicked], a

	ld a, [wMemoryGameCard1Location]
	call MemoryGame_Card2Coord
	call MemoryGame_PlaceCard

	ld a, [wMemoryGameCard2Location]
	call MemoryGame_Card2Coord
	call MemoryGame_PlaceCard

	ld hl, .DarnText
	call PrintText
	ret

.VictoryText:
	start_asm
	push bc
	hlcoord 2, 13
	call MemoryGame_PlaceCard
	ld hl, .YeahText
	pop bc
	inc bc
	inc bc
	inc bc
	ret

.YeahText:
	text "　いただき！"
	done

.DarnText:
	text "ざんねん⋯⋯"
	done

MemoryGame_InitBoard:
	ld hl, wMemoryGameCards
	ld bc, wMemoryGameCardsEnd - wMemoryGameCards
	xor a
	call ByteFill
	call MemoryGame_GetDistributionOfTiles

	ld c, 2
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 8
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 4
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 7
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 3
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 6
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 1
	ld b, [hl]
	call MemoryGame_SampleTilePlacement

	ld c, 5
	ld hl, wMemoryGameCards
	ld b, wMemoryGameCardsEnd - wMemoryGameCards
.loop
	ld a, [hl]
	and a
	jr nz, .no_load
	ld [hl], c
.no_load
	inc hl
	dec b
	jr nz, .loop
	ret


MemoryGame_SampleTilePlacement:
	push hl
	ld de, wMemoryGameCards
.loop
	call Random
	and %00111111
	cp 45
	jr nc, .loop
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hl]
	and a
	jr nz, .loop
	ld [hl], c
	dec b
	jr nz, .loop
	pop hl
	inc hl
	ret

MemoryGame_GetDistributionOfTiles:
	ld a, [wMenuCursorY]
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ld de, .distributions
	add hl, de
	ret

.distributions
	db $02, $03, $06, $06, $06, $08, $08, $06
	db $02, $02, $04, $06, $06, $08, $08, $09
	db $02, $02, $02, $04, $07, $08, $08, $0c

MemoryGame_PlaceCard:
	ld a, [wMemoryGameLastCardPicked]
	sla a
	sla a
	add 4
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	ld [hl], a
	ld c, 3
	call DelayFrames
	ret

MemoryGame_DeleteCard:
	ld a, 1
	ld [hli], a
	ld [hld], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ld [hl], a
	ld c, 3
	call DelayFrames
	ret

MemoryGame_InitStrings:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, 1
	call ByteFill
	hlcoord 0, 0
	ld de, .str1
	call PlaceString
	hlcoord 15, 0
	ld de, .str2
	call PlaceString
	ld hl, .dummy_text
	call PrintText
	ret

.dummy_text
	db "@"
.str1
	db "とったもの@"
.str2
	db "あと　かい@"

MemoryGame_Card2Coord:
	ld d, 0
.find_row
	sub 9
	jr c, .found_row
	inc d
	jr .find_row

.found_row
	add 9
	ld e, a
	hlcoord 1, 2
	ld bc, 2 * SCREEN_WIDTH
.loop2
	ld a, d
	and a
	jr z, .done
	add hl, bc
	dec d
	jr .loop2

.done
	sla e
	add hl, de
	ret

; Called from sprite animation routine?
MemoryGame_AnimateCursor:
	ld a, [wJumptableIndex]
	cp MEMORYGAME_REVEAL_ALL
	jr nc, .quit
	call GetJoypadDebounced
	ld hl, hJoypadDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .pressed_a
	ld a, [hl]
	and D_LEFT
	jr nz, .pressed_left
	ld a, [hl]
	and D_RIGHT
	jr nz, .pressed_right
	ld a, [hl]
	and D_UP
	jr nz, .pressed_up
	ld a, [hl]
	and D_DOWN
	jr nz, .pressed_down
	ret

.quit
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], 0
	ret

.pressed_a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc a
	ld [wMemoryGameCardChoice], a
	ret

.pressed_left
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	and a
	ret z
	sub 1 tiles
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	dec [hl]
	ret

.pressed_right
	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cp (9 - 1) tiles
	ret z
	add 1 tiles
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ret

.pressed_up
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	ret z
	sub 1 tiles
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub 9
	ld [hl], a
	ret

.pressed_down
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp (5 - 1) tiles
	ret z
	add a, $10
	ld [hl], a
	ld hl, SPRITEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add a, 9
	ld [hl], a
	ret

