INCLUDE "constants.asm"

SECTION "Misc Utility Functions", ROM0[$3429]

AddNTimes:: ; 3429 (0:3429)
	and a
	ret z
.asm_342b
	add hl, bc
	dec a
	jr nz, .asm_342b
	ret
; 0x3430