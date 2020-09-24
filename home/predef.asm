INCLUDE "constants.asm"

SECTION "home/predef.asm", ROM0

Predef::
	ld [wPredefID], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(GetPredefPointer)
	call Bankswitch
	call GetPredefPointer
	call Bankswitch
	ld hl, .return
	push hl
	push de
	jr .get_regs

.return
	ld a, h
	ld [wPredefHL], a
	ld a, l
	ld [wPredefHL + 1], a
	pop hl
	ld a, h
	call Bankswitch
	ld a, [wPredefHL]
	ld h, a
	ld a, [wPredefHL + 1]
	ld l, a
	ret

.get_regs
	ld a, [wPredefHL]
	ld h, a
	ld a, [wPredefHL + 1]
	ld l, a
	ld a, [wPredefDE]
	ld d, a
	ld a, [wPredefDE + 1]
	ld e, a
	ld a, [wPredefBC]
	ld b, a
	ld a, [wPredefBC + 1]
	ld c, a
	ret
