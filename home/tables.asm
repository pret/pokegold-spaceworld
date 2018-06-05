INCLUDE "constants.asm"
	
SECTION "FindItemInTable", ROM0[$35F8]

; find value a from table hl with row length de
; returns carry and row index b if successful

FindItemInTable: ; 00:35F8
	ld b, 0
	ld c, a
	
.nextItem
	ld a, [hl]
	cp $FF
	jr z, .fail
	cp c
	jr z, .success
	inc b
	add hl, de
	jr .nextItem
	
.fail
	and a
	ret
	
.success
	scf
	ret