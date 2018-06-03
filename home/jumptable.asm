INCLUDE "constants.asm"

SECTION "Jumptable functions", ROM0[$35cd]

CallJumptable:: ; 35cd (0:35cd)
; CallJumptable
; Call function whose pointer is
; at index a in 2-byte pointer table
; pointed to by hl.
; Clobbers: a, hl
;
; This ultimately wound up at rst $28 in
; GSC
	push de
	ld d, $00
	ld e, a
	add hl, de
	add hl, de
	pop de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

CallFar_atHL::
; CallFar_atHL
; Call the function pointed to by
; the 3-byte pointer at hl
; Clobbers: a, hl
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	call Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call .jump
	pop hl
	ld a, h
	call Bankswitch
	ret
.jump: ; 35eb (0:35eb)
	jp hl
