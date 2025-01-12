
MACRO farcall ; bank, address
	ld a, BANK(\1)
	ld hl, \1
	call FarCall_hl
ENDM

MACRO callfar ; address, bank
	ld hl, \1
	ld a, BANK(\1)
	call FarCall_hl
ENDM

MACRO homecall
	ldh a, [hROMBank]
	push af
	ld a, BANK(\1)
	call Bankswitch
	call \1
	pop af
	call Bankswitch
ENDM

MACRO farjp
	ld a, BANK(\1)
	ld hl, \1
	jp FarCall_hl
ENDM

MACRO jpfar
	ld hl, \1
	ld a, BANK(\1)
	jp FarCall_hl
ENDM
