include "constants.asm"

SECTION "Battle Home", ROM0 [$3C43]

GetPlayerPartyMonAttribute:: ; 3c43
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, $0
	add hl, bc
	ld bc, $30
	ld a, [wCurPartyMon]
	call AddNTimes
	pop bc
	ret

Function3c56:: ; 3c56
	jpba Functione77f

Function3c5e:: ; 3c5e
	push hl
	push de
	push bc
	callab Functiond3ad
	pop bc
	pop de
	pop hl
	ret

GetBattleAnimPointer:: ; 3c6d
	ld a, $32
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a
	ld a, $33
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ret

GetBattleAnimByte:: ; 3c84
	push hl
	push de
	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, $32
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ld a, [de]
	ld [wBattleAnimByte], a
	inc de
	ld a, $33
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ld [hl], d
	dec hl
	ld [hl], e
	pop de
	pop hl
	ld a, [wBattleAnimByte]
	ret
