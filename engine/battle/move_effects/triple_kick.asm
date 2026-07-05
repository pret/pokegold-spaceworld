BattleCommand_TripleKick:
	ld a, [wBattleAnimParam]
	ld b, a
	inc b
	ld a, [wCurDamage + 1]
	ld e, a
	ld a, [wCurDamage]
	ld d, a

.next_kick
	dec b
	ret z
	ld a, [wCurDamage + 1]
	add e
	ld [wCurDamage + 1], a
	ld a, [wCurDamage]
	adc d
	ld [wCurDamage], a

; No overflow.
	jr nc, .next_kick
	ld a, $ff
	ld [wCurDamage], a
	ld [wCurDamage + 1], a
	ret

BattleCommand_KickCounter:
	ld a, [wBattleAnimParam]
	inc a
	ld [wBattleAnimParam], a
	ret
