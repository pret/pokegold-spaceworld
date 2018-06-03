INCLUDE "constants.asm"

if DEBUG
SECTION "Bankswitch", ROM0[$32C2]
else
SECTION "Bankswitch", ROM0[$3286]
endc

; Moved to a rst vector in final US releases (not sure about JP)
; All rst vectors are unused at this point in development
Bankswitch:: ; 32c2
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret
