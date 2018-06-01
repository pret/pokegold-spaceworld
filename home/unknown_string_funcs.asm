INCLUDE "constants.asm"

SECTION "Func_0x3259", ROM0[$3259]

; Called during start of new game
; A far call for 03:4AA1
Func_0x3259:: ; 3259
	push bc
	ld a,[$FF98]
	push af
	ld a,3
	call Bankswitch
	push hl
	push de
	call $4AA1
	pop de
	pop hl
	pop bc
	ld a,b
	call Bankswitch
	pop bc
	ret

SECTION "Func_0x366C", ROM0[$366C]

Func_0x366C:: ; 366c
	ld a,b
	ld [wce37],a
	ld [wcd76],a
	ld a,c
	ld [wcd7d],a
	ld hl,wd19e
	call Func_0x3259
	ret nc
	call Func_0x376F
	call CopyStringToBuffer
	scf
	ret
	
SECTION "Func_0x376F", ROM0[$376F]

Func_0x376F:: ; 376F
	push hl
	push bc
	ld a,[wce37]
	cp $C4
	jr nc,.skip
	ld [wcb5b],a
	ld a,4
	ld [wNameCategory],a
	call GetName
	jr .next
.skip
	call Func_0x378E
.next
	ld de,wcd26
	pop bc
	pop hl
	ret
	
SECTION "Func_0x378E", ROM0[$378E]

Func_0x378E::
	push hl
	push de
	push bc
	ld a,[wce37]
	push af
	cp $C9
	jr nc,.skip
	add a,5
	ld [wce37],a
	ld hl,HM_String
	ld bc,$0006
	jr .next
.skip
	ld hl,TM_String
	ld bc,$0005
.next
	ld de,wcd26
	call CopyBytes
	ld a,[wce37]
	sub a,$C8
	ld b,$F6
.loop
	sub a,$0A
	jr c,.exit
	inc b
	jr .loop
.exit
	add a,$0A
	push af
	ld a,b
	ld [de],a
	inc de
	pop af
	ld b,$F6
	add b
	ld [de],a
	inc de
	ld a,$50
	ld [de],a
	pop af
	ld [wce37],a
	pop bc
	pop de
	pop hl
	ret
	
TM_String:
	db "わざマシン@"
	
HM_String:
	db "ひでんマシン@"