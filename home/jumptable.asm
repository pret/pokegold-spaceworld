INCLUDE "constants.asm"

SECTION "home/jumptable.asm", ROM0

CallJumptable::
; CallJumptable
; Call function whose pointer is
; at index a in 2-byte pointer table
; pointed to by hl.
; Clobbers: a, hl
;
; This became rst $28 in final GSC.
	push de
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	pop de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; Call the function pointed to by the 3-byte pointer at hl.
; Clobbers: a, hl.
CallPointerAt::
	ldh a, [hROMBank]
	push af
	ld a, [hli]
	call Bankswitch

	ld a, [hli]
	ld h, [hl]
	ld l, a

	call ._hl_
	
	pop hl
	ld a, h
	call Bankswitch
	ret

._hl_:
	jp hl
