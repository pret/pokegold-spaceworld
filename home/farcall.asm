INCLUDE "constants.asm"

SECTION "home/farcall.asm", ROM0

FarCall_hl::
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

.return:
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
