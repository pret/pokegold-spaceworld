include "constants.asm"

SECTION "home/math.asm", ROM0

Multiply::
	push hl
	push bc
	callab _Multiply
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
