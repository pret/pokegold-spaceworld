INCLUDE "constants.asm"

SECTION "home/misc_3c43.asm", ROM0

GetPartyParamLocation::
; Get the location of parameter a from wCurPartyMon in hl
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	pop bc
	ret

UseItem::
	farjp _UseItem

CheckTossableItem::
	push hl
	push de
	push bc
	callfar _CheckTossableItem
	pop bc
	pop de
	pop hl
	ret

GetBattleAnimPointer::
	ld a, BANK(BattleAnimationsBankRef)
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

	ld a, BANK(BattleAnimationsBankRef)
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

InitSpriteAnimStruct::
	ld [wSpriteAnimAddrBackup], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call Bankswitch
	ld a, [wSpriteAnimAddrBackup]
	call _InitSpriteAnimStruct
	pop af
	call Bankswitch
	ret

EmptyFunction3cbe::
	ret
