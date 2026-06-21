BattleCommand_StoreEnergy:
	ld bc, wPlayerSubStatus3
	ld de, wPlayerMoveStruct
	ld hl, wPlayerDamageTaken + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_battle_vars
	ld bc, wEnemySubStatus3
	ld de, wEnemyMoveStruct
	ld hl, wEnemyDamageTaken + 1

.got_battle_vars
	ld a, [bc]
	bit SUBSTATUS_BIDE, a
	ret z

	push hl
	ld hl, wCurDamage
	ld a, [hli]
	ld b, a
	ld c, [hl]
; Add wCurDamage to w[user]DamageTaken
	pop hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld hl, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .check_still_storing_energy
	ld hl, wEnemyRolloutCount

.check_still_storing_energy
	dec [hl]
	jr nz, .still_storing

	ld hl, wPlayerSubStatus3
	res SUBSTATUS_BIDE, [hl]
	ld hl, UnleashedEnergyText
	call PrintText

; BUG: The move struct power and damage taken variables are hardcoded to the player's values.
; No handling exists for the enemy whatsoever, so Bide will silently fail when unleashed by them.

; The move structs are loaded at the beginning of the function, but not used. This is where they would've fit.
	ld a, 1
	ld [wPlayerMoveStructPower], a
	ld hl, wPlayerDamageTaken + 1
	ld a, [hld]
	add a
	ld b, a
	ld [wCurDamage + 1], a
	ld a, [hl]
	rl a
	ld [wCurDamage], a
	or b
	jr nz, .built_up_something
	ld a, 1
	ld [wAttackMissed], a

.built_up_something
	xor a
	ld [hli], a
	ld [hl], a
	ld a, MOVE_BIDE
	ld [wPlayerMoveStruct], a
	ld b, unleashenergy_command
	jp SkipToBattleCommand

.still_storing:
	ld hl, StoringEnergyText
	call PrintText
	jp EndMoveEffect

BattleCommand_UnleashEnergy:
	ld hl, wPlayerSubStatus3
	ld de, wPlayerDamageTaken
	ld bc, wPlayerRolloutCount
	ldh a, [hBattleTurn]
	and a
	jr z, .got_damage
	ld hl, wEnemySubStatus3
	ld de, wEnemyDamageTaken
	ld bc, wEnemyRolloutCount

.got_damage
	set SUBSTATUS_BIDE, [hl]
	xor a
	ld [de], a
	inc de
	ld [de], a
	ld [wPlayerMoveStructEffect], a
	ld [wEnemyMoveStructEffect], a
	call BattleRandom
	and 1
	inc a
	inc a
	ld [bc], a
	ld a, 1
	ld [wBattleAnimParam], a
	call PlayDamageAnim
	jp EndMoveEffect
