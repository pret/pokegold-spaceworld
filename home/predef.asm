INCLUDE "constants.asm"

if DEBUG
SECTION "Predef", ROM0[$2FDE]
else
SECTION "Predef", ROM0[$2FA2]
endc

Predef:: ; 2fde
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
	ld a, h ; Could have used `pop af` instead
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
