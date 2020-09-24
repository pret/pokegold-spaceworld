; Reset vector space used for hack interrupt - see hack.asm.

SECTION "home/rst.asm@rst38", ROM0
	; Jumps in the middle of unmapped echo RAM.
	; Probably used to trigger a breakpoint.
	jp $F080
