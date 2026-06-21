BattleCommand_FrustrationPower:
	push bc
	ld hl, wBattleMonHappiness
	ldh a, [hBattleTurn]
	and a
	jr z, .got_happiness
	ld hl, wEnemyMonHappiness

.got_happiness:
; If happiness is higher than 70, cap power at 30 minimum.
	ld a, [hl]
	cp 70
	ld d, 30
	jr nc, .happiness_higher_than_70

; 100 - Happiness = Move's power
	ld b, a
	ld a, 100
	sub b
	ld d, a

.happiness_higher_than_70:
	pop bc
	ret
