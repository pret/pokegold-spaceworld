INCLUDE "constants.asm"

SECTION "GetNthString", ROM0[$3732]

GetNthString::
; Return the address of the ath string starting from hl.
	and a
	ret z
	push bc
	ld b, a
	ld c, "@"
.readChar:
	ld a, [hli]
	cp c
	jr nz, .readChar
	dec b
	jr nz, .readChar
	pop bc
	ret
