INCLUDE "constants.asm"

SECTION "Bankswitch", ROM0[$32C2]

; Moved to a rst vector in final US releases (not sure about JP)
; All rst vectors are unused at this point in development
Bankswitch:: ; 32c2
    ldh [hROMBank], a
    ld [MBC3RomBank], a
    ret
