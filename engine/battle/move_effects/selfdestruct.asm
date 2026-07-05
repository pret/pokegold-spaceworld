BattleCommand_Selfdestruct:
; Reuses Mega Punch's hit animation
	ld a, MOVE_MEGA_PUNCH
	ld [wNumHits], a
	ld c, 3
	call DelayFrames

	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld hl, wBattleMonStatus
	ld de, wPlayerSubStatus4
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wEnemyMonStatus
	ld de, wEnemySubStatus4

.ok
; BUG: hl is increased one too many times, causing only the lower byte of the user's current HP to be zeroed out,
; and incorrectly zeroing the high byte of the user's max HP.
	xor a
	ld [hli], a
	ld [hli], a ; Without this line, the bug wouldn't happen. This byte isn't even used in normal gameplay (wPartyMon#Unused)
	inc hl
	ld [hli], a
	ld [hl], a
	ld a, [de]
	res SUBSTATUS_LEECH_SEED, a
	ld [de], a
; Final game additionally removes Destiny Bond here
	ret
