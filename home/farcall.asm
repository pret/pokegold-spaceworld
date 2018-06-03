INCLUDE "constants.asm"

if DEBUG
SECTION "Farcall", ROM0[$2FA8]
else
SECTION "FarCall", ROM0[$2F6C]
endc

FarCall_hl:: ; 2fa8
	push af
	ld a, b
	ld [wFarCallBCBuffer], a
	ld a, c
	ld [wFarCallBCBuffer + 1], a
	pop af
	ld b, a
	ldh a, [hROMBank]
	push af
	ld a, b
	call Bankswitch
	ld bc, .return
	push bc
	push hl
	ld a, [wFarCallBCBuffer]
	ld b, a
	ld a, [wFarCallBCBuffer + 1]
	ld c, a
	ret

.return
	ld a, b
	ld [wFarCallBCBuffer], a
	ld a, c
	ld [wFarCallBCBuffer + 1], a
	pop bc
	ld a, b
	call Bankswitch
	ld a, [wFarCallBCBuffer]
	ld b, a
	ld a, [wFarCallBCBuffer + 1]
	ld c, a
	ret
