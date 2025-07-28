INCLUDE "constants.asm"

SECTION "engine/pokemon/learn.asm", ROMX

LearnMove::
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
; Get the first empty move slot.  This routine also serves to
; determine whether the Pokemon learning the moves already has
; all four slots occupied, in which case one would need to be
; deleted.
.next
	ld a, [hl]
	and a
	jr z, .learn
	inc hl
	dec b
	jr nz, .next
; If we're here, we enter the routine for forgetting a move
; to make room for the new move we're trying to learn.
	push de
	call ForgetMove
	pop de
	jp c, .cancel
	push hl
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ld hl, Text_1_2_and_Poof
	call PrintText
	pop de
	pop hl
.learn
	ld a, [wPutativeTMHMMove]
	ld [hl], a
	ld bc, MON_PP - MON_MOVES
	add hl, bc

	push hl
	push de
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop hl

	ld [hl], a

	ld a, [wBattleMode]
	and a
	jp z, .learned

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jp nz, .learned

	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES)
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	jp .learned

.cancel
	ld hl, StopLearningMoveText
	call PrintText
	call YesNoBox
	jp c, .loop
	ld hl, DidNotLearnMoveText
	call PrintText
	ld b, 0
	ret
.learned
	ld hl, LearnedMoveText
	call PrintText
	ld b, 1
	ret

ForgetMove::
	push hl
	ld hl, AskForgetMoveText
	call PrintText
	call YesNoBox
	pop hl
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	pop hl
.loop
	push hl
	ld hl, MoveAskForgetText
	call PrintText
	hlcoord 10, 8
	ld b, NUM_MOVES * 2
	ld c, MOVE_NAME_LENGTH
	call DrawTextBox
	hlcoord 12, 10
	ld a, SCREEN_WIDTH * 2
	ld [wListMovesLineSpacing], a
	predef ListMoves
	; w2DMenuData
	ld a, 10
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld [w2DMenuDataEnd], a
	ld [wMenuCursorX], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, $20 ; enable sprite animations
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	call StaticMenuJoypad
	push af
	call ReloadTilesFromBuffer
	pop af
	pop hl
	bit B_BUTTON_F, a
	jr nz, .cancel
	push hl
	ld a, [w2DMenuDataEnd]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsHMMove
	pop bc
	pop de
	ld a, d
	jr c, .hmmove
	pop hl
	add hl, bc
	and a
	ret

.hmmove
	ld hl, MoveCantForgetHMText
	call PrintText
	pop hl
	jr .loop
.cancel
	scf
	ret

LearnedMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　あたらしく"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえた！@"
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end

MoveAskForgetText:
	text "どの　わざを"
	next "わすれさせたい？"
	done

StopLearningMoveText:
	text "それでは<⋯⋯>　@"
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえるのを　あきらめますか？"
	done

DidNotLearnMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえずに　おわった！"
	prompt

AskForgetMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　あたらしく"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえたい<⋯⋯>！"
	para "しかし　@"
	text_from_ram wMonOrItemNameBuffer
	text "は　わざを　４つ"
	line "おぼえるので　せいいっぱいだ！"
	para "@"
	text_from_ram wStringBuffer2
	text "の　かわりに"
	line "ほかの　わざを　わすれさせますか？"
	done

Text_1_2_and_Poof:
	text "１　２の　<⋯⋯>@"
	text_exit
	start_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, MoveForgotText
	ret

MoveForgotText:
	text "　ポカン！@"
	text_exit
	text ""
	para "@"
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer1
	text "の"
	line "つかいかたを　きれいに　わすれた！"
	para "そして<⋯⋯>！"
	prompt

MoveCantForgetHMText:
	text "それは　たいせつなわざです"
	line "わすれさせることは　できません！"
	prompt
