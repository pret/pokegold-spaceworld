BattleCommand_LockOn:
	ld hl, wEnemySubStatus5
	ldh a, [hBattleTurn]
	and a
	jr z, .got_substatus
	ld hl, wPlayerSubStatus5

.got_substatus
	ld a, [wAttackMissed]
	and a
	jr nz, .fail

	call CheckSubstituteOpp
	jp nz, .fail

	set SUBSTATUS_LOCK_ON, [hl]
	call LoadMoveAnim
	ld hl, TookAimText
	jp PrintText

.fail
	call BattleCommand_MoveDelay
	jp PrintDidntAffectText

TookAimText:
	text "<TARGET>を"
	line "ロックオンした！"
	prompt
