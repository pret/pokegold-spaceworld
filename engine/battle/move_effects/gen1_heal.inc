Unreferenced_Gen1HealEffect:
	call GetOpponentItem
	ldh a, [hBattleTurn]
	and a
	ld de, wBattleMonHP
	ld hl, wBattleMonMaxHP
	ld a, [wPlayerMoveStruct]
	jr z, .healEffect
	ld de, wEnemyMonHP
	ld hl, wEnemyMonMaxHP
	ld a, [wEnemyMoveStruct]

.healEffect:
	ld b, a
	ld a, [de]
	cp [hl]
; BUG: The previous comparison is ignored.
; This made healing moves in Gen 1 fail when user's HP is 255/511 points lower than max HP.
	inc de
	inc hl
	ld a, [de]
	sbc [hl]
	jp z, .failed
	ld a, b
	cp MOVE_REST
	jr nz, .healHP
	push hl
	push de
	push af
	call BattleCommand_MoveDelay
	ld hl, wBattleMonStatus
	ldh a, [hBattleTurn]
	and a
	jr z, .restEffect
	ld hl, wEnemyMonStatus

.restEffect:
	ld a, [hl]
	and a
	ld [hl], 2
	ld hl, Unused_WentToSleepText
	jr z, .printRestText
	ld hl, Unused_RestedText

.printRestText:
	call PrintText
	pop af
	pop de
	pop hl

.healHP:
	ld a, [hld]
	ld [wHPBarMaxHP], a
	ld c, a
	ld a, [hl]
	ld [wHPBarMaxHP + 1], a
	ld b, a
	jr z, .gotHPAmountToHeal
; Recover and Softboiled only heal for half the mon's max HP
	srl b
	rr c

.gotHPAmountToHeal:
	ld a, [de]
	ld [wHPBarOldHP], a
	add c
	ld [de], a
	ld [wHPBarNewHP], a
	dec de
	ld a, [de]
	ld [wHPBarOldHP + 1], a
	adc b
	ld [de], a
	ld [wHPBarNewHP + 1], a
	inc hl
	inc de
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .playAnim
; copy max HP to current HP if an overflow occurred
	ld a, [hli]
	ld [de], a
	ld [wHPBarNewHP + 1], a
	inc de
	ld a, [hl]
	ld [de], a
	ld [wHPBarNewHP], a

.playAnim:
	call LoadMoveAnim
	ldh a, [hBattleTurn]
	and a
	hlcoord 10, 9
	ld a, 1
	jr z, .updateHPBar
	hlcoord 2, 2
	xor a

.updateHPBar:
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ld hl, UpdateBattleHuds
	call CallFromBank0F
	ld hl, Unused_RegainedHealthText
	jp PrintText

.failed:
	call BattleCommand_MoveDelay
	jp PrintButItFailed

Unused_WentToSleepText:
	text "<USER>は"
	line "ねむりはじめた！"
	done

Unused_RestedText:
	text "<USER>は　けんこうになって"
	line "ねむりはじめた！"
	done

Unused_RegainedHealthText:
	text "<USER>は　たいりょくを"
	line "かいふくした！"
	prompt
