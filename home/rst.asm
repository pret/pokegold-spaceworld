; rst vectors

; Reset vector space used for hack interrupt - see hack.asm.

SECTION "home/rst.asm@rst38", ROM0
if DEBUG && def(SILVER)
	rst $38
else
	jp $F080 ; Jumps in the middle of unmapped memory. Probably used to trigger a breakpoint of sorts.
endc
