INCLUDE "constants.asm"
	
SECTION "FindItemInTable", ROM0[$35F8]

; find value a from table hl with row length de
; returns carry and row index b if successful
FindItemInTable: ; 00:35F8
	ld b, 0
	ld c, a
	
.loop
	ld a, [hl]
	cp -1
	jr z, .fail
	cp c
	jr z, .success
	inc b
	add hl, de
	jr .loop
	
.fail
	and a
	ret
	
.success
	scf
	ret
