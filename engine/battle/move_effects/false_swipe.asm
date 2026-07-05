BattleCommand_FalseSwipe:
; Makes sure wCurDamage < MonHP
	ld de, wEnemyMonHP + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .got_hp
	ld de, wBattleMonHP + 1

.got_hp
	ld hl, wCurDamage + 1
	ld a, [de]
	dec de
	sub [hl]
	dec hl
	ld a, [de]
	sbc [hl]
	jr z, .hp_under_256
	jr c, .hp_underflow
	jr .done

.hp_under_256
; If HP is a multiple of 256, continue
	inc hl
	inc de
	ld a, [de]
	cp [hl]
	jr nz, .done
	dec hl
	dec de

.hp_underflow
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	dec [hl]
	ld a, [hl]
	inc a
	jr nz, .set_carry_flag
	dec hl
	dec [hl]

.set_carry_flag
	scf
	ret

.done
	and a
	ret
