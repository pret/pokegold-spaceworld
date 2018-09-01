INCLUDE "constants.asm"

SECTION "Patch text bank", ROMX[$4000], BANK[$29]

; The actual text data goes in CSVs in hack/text.
; At build time, this file is concatenated with the code files built from the CSVs. 
; If more banks are needed, this approach should be switched out - likely for
; including bank numbers in the compiled text .asms, or putting the text .asms
; in a linkerscript or similar.

