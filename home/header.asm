SECTION "Entry point", ROM0
	nop
	jp Init


SECTION "Global check value", ROM0
; The ROMs have incorrect global checksums, so set them here.
; RGBFIX only calculates checksums for the "correctheader" ROMs.
if DEF(_GOLD)
	if DEF(_DEBUG)
		dw $C621
	else
		dw $497E
	endc
endc
if DEF(_SILVER)
	if DEF(_DEBUG)
		dw $2FC9
	else
		dw $7AB1
	endc
endc
