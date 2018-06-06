include "constants.asm"

if DEBUG
SECTION "Unknown 32c8", ROM0[$32c8]
else
SECTION "Unknown 32c8", ROM0[$328c]
endc

Function32c8::
	predef Functionce10
	ld a, b
	and a
	ret

Function32d0::
	ld hl, .Data
	ret

.Data: ; 00:32d4
	db "@"

SubtractSigned::
	sub b
	ret nc
	cpl
	add $1
	scf
	ret
