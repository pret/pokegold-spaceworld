INCLUDE "constants.asm"

SECTION "home/math.asm", ROM0

Multiply::
	push hl
	push bc
	callfar _Multiply
	pop bc
	pop hl
	ret

Divide::
	push hl
	push de
	push bc
	homecall _Divide
	pop bc
	pop de
	pop hl
	ret

SECTION "home/math.asm@SubtractAbsolute", ROM0

SubtractAbsolute:: ; unreferenced
; Return |a - b|, sign in carry.
	sub b
	ret nc
	cpl
	add 1
	scf
	ret
