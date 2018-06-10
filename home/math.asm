include "constants.asm"

if DEBUG
SECTION "Math utility functions", ROM0 [$3380]
else
SECTION "Math utility functions", ROM0 [$3344]
endc

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
