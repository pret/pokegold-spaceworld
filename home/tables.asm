INCLUDE "constants.asm"
	
SECTION "FindItemInTable", ROM0[$35F8]

; Inputs:
; hl = start of table to check
; de = row size
; a = item to search for
; Outputs:
; carry = item found
; b = row index of item
FindItemInTable: ; 00:35F8
	ld b, 0
	ld c, a
	
.nextItem
	ld a, [hl] ; load the next item
	cp $FF ; is the list finished?
	jr z, .fail ; if so, then fail
	cp c ; does this item match?
	jr z, .success ; if so, then set the carry flag
	inc b ; increase the row index count
	add hl, de ; move the next row
	jr .nextItem ; check the next item
	
.fail
	and a ; unset the carry flag to indicate failure
	ret
	
.success
	scf ; set the carry flag to indicate success
	ret