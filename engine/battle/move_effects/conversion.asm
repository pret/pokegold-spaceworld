; Works as in Gen 1: copies the opponent's types to the user.
BattleCommand_Conversion:
	ld hl, wEnemyMonType
	ld de, wBattleMonType
	ldh a, [hBattleTurn]
	and a
	jr z, .got_mon_types
	push hl
	ld h, d
	ld l, e
	pop de

.got_mon_types:
	call CheckHiddenOpponent
	jr nz, .fail
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	call LoadMoveAnim
	ld hl, .TransformedTypeText
	jp PrintText

.TransformedTypeText
	text "<TARGET>の　タイプを"
	line "じぶんに　はりつけた！"
	prompt

.fail
	jp PrintButItFailed
