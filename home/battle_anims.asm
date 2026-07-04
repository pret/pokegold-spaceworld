GetBattleAnimPointer::
	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ret

GetBattleAnimByte::
	push hl
	push de

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld a, [de]
	ld [wBattleAnimByte], a
	inc de

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld [hl], d
	dec hl
	ld [hl], e

	pop de
	pop hl

	ld a, [wBattleAnimByte]
	ret
