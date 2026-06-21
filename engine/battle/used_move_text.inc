BattleCommand_UsedMoveText:
	ld hl, UsedMoveText
	jp PrintText

UsedMoveText:
	text "<USER>@"
	start_asm
	ldh a, [hBattleTurn]
	and a
	ld a, [wPlayerMoveStruct]
	ld hl, wLastPlayerCounterMove
	jr z, .playerTurn
	ld a, [wEnemyMoveStruct]
	ld hl, wLastEnemyCounterMove

.playerTurn:
	ld [hl], a
	ld [wMoveGrammar], a
	call GetMoveGrammar
	ld a, [wAlreadyDisobeyed]
	and a
	ld hl, UsedMove2Text
	ret nz
	ld a, [wMoveGrammar]
	cp 3
	ld hl, UsedMove2Text
	ret c
	ld hl, UsedMove1Text
	ret

UsedMove1Text:
	text "の　@"
	start_asm
	jr UsedMoveText_CheckObedience

UsedMove2Text:
	text "は　@"
	start_asm
UsedMoveText_CheckObedience:
; check obedience
	ld a, [wAlreadyDisobeyed]
	and a
	jr z, .GetMoveNameText
; print " instead,"
	ld hl, .UsedInsteadText
	ret

.UsedInsteadText:
	text "めいれいをむしして@"
	start_asm
.GetMoveNameText:
	ld hl, MoveNameText
	ret

MoveNameText:
	text_start
	line "@"
	text_from_ram wStringBuffer2
	start_asm
; get start address
	ld hl, .endusemovetexts

; get move id
	ld a, [wNumSetBits]

; 2-byte pointer
	add a

; seek
	push bc
	ld b, 0
	ld c, a
	add hl, bc
	pop bc

; get pointer to usedmovetext ender
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.endusemovetexts
; entries correspond to MoveGrammar sets
	dw EndUsedMove1Text
	dw EndUsedMove2Text
	dw EndUsedMove3Text
	dw EndUsedMove4Text
	dw EndUsedMove5Text

EndUsedMove1Text:
	text "を　つかった！"
	done

EndUsedMove2Text:
	text "を　した！"
	done

EndUsedMove3Text:
	text "した！"
	done

EndUsedMove4Text:
	text "　こうげき！"
	done

EndUsedMove5Text:
	text "！"
	done

GetMoveGrammar:
; store move grammar type in wMoveGrammar

	push bc
; wMoveGrammar contains move id
	ld a, [wMoveGrammar]
	ld c, a ; move id
	ld b, 0 ; grammar index

; read grammer table
	ld hl, MoveGrammar

.loop
	ld a, [hli]
; end of table?
	cp -1
	jr z, .end
; match?
	cp c
	jr z, .end
; advance grammar type at 0
	and a
	jr nz, .loop
; next grammar type
	inc b
	jr .loop

.end:
; wMoveGrammar now contains move grammar
	ld a, b
	ld [wMoveGrammar], a

; we're done
	pop bc
	ret

	INCLUDE "data/moves/grammar.inc"
