; rst vectors

SECTION "rst00", ROM0
	rst $38

SECTION "rst08", ROM0
	rst $38

SECTION "rst10", ROM0
	rst $38

SECTION "rst18", ROM0
	rst $38

SECTION "rst20", ROM0
	rst $38

SECTION "rst28", ROM0
	rst $38

SECTION "rst30", ROM0
	rst $38

SECTION "rst38", ROM0
if DEF(_SILVER) && DEF(_DEBUG)
	rst $38
else
	; Jumps in the middle of unmapped echo RAM.
	; Probably used to trigger a breakpoint.
	jp $F080
endc
