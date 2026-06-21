DEF MAX_ROLLOUT_COUNT EQU 5

BattleCommand_Rollout:
	ld hl, wPlayerSubStatus1
	ld de, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemySubStatus1
	ld de, wEnemyRolloutCount

.ok
	bit SUBSTATUS_ROLLOUT, [hl]
	jr z, .reset

	ld b, doturn_command
	jp SkipToBattleCommand

.reset:
	xor a
	ld [de], a
	ret

BattleCommand_RolloutPower:
	ld hl, wPlayerRolloutCount
	ld de, wPlayerSubStatus1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyRolloutCount
	ld de, wEnemySubStatus1

.ok
	ld a, [wAttackMissed]
	and a
	jr z, .hit

	ld a, [de]
	res SUBSTATUS_ROLLOUT, a
	ld [de], a
	ret

.hit
	inc [hl]
	ld a, [hl]
	ld b, a
	cp MAX_ROLLOUT_COUNT
	jr nz, .not_done_with_rollout

	ld a, [de]
	res SUBSTATUS_ROLLOUT, a
	ld [de], a
	jr .done_with_substatus_flag

.not_done_with_rollout
	ld a, [de]
	set SUBSTATUS_ROLLOUT, a
	ld [de], a

.done_with_substatus_flag
.loop
	dec b
	jr z, .done_damage

	ld hl, wCurDamage + 1
	sla [hl]
	dec hl
	rl [hl]
	jr nc, .loop

	ld a, $ff
	ld [hli], a
	ld [hl], a

.done_damage
	ret
