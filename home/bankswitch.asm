INCLUDE "constants.asm"

SECTION "home/bankswitch.asm", ROM0

; Moved to a rst vector in final US releases (not sure about JP).
; All rst vectors are unused at this point in development.
Bankswitch::
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret
