BattleCommand_Present:
	ld a, [wAttackMissed]
	and a
	ret nz

	push bc
	call BattleRandom
	ld b, a
	ld hl, PresentPower
	ld c, 0

.next
	ld a, [hli]
	cp -1
	jr z, .heal_effect

	cp b
	jr nc, .got_power

	inc c
	inc hl
	jr .next

.got_power
	xor a
	ld [wBattleAnimParam], a
	call LoadMoveAnim
	ld d, [hl]
	pop bc
	ret

.heal_effect
	pop bc
	ld a, 1
	ld [wBattleAnimParam], a
	call LoadMoveAnim

	ldh a, [hBattleTurn]
	push af
	xor 1
	ldh [hBattleTurn], a
	callfar GetQuarterMaxHP
	pop af
	ldh [hBattleTurn], a

	callfar RestoreHP
	jp EndMoveEffect

INCLUDE "data/moves/present_power.inc"
