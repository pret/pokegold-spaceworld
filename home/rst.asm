; rst vectors

SECTION "home/rst.asm@rst00", ROM0
	rst $38

SECTION "home/rst.asm@rst08", ROM0
	rst $38

SECTION "home/rst.asm@rst10", ROM0
	rst $38

SECTION "home/rst.asm@rst18", ROM0
	rst $38

SECTION "home/rst.asm@rst20", ROM0
	rst $38

SECTION "home/rst.asm@rst28", ROM0
	rst $38

SECTION "home/rst.asm@rst30", ROM0
	rst $38
	
; Reset vector space used for hack interrupt - see hack.asm.

SECTION "home/rst.asm@rst38", ROM0
if DEBUG && def(SILVER)
	rst $38
else
	jp $F080 ; Jumps in the middle of unmapped memory. Probably used to trigger a breakpoint of sorts.
endc
