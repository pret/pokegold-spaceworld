
callba: MACRO ; bank, address
	ld a, BANK(\1)
	ld hl, \1
	call FarCall_hl
ENDM

callab: MACRO ; address, bank
	ld hl, \1
	ld a, BANK(\1)
	call FarCall_hl
ENDM

homecall: MACRO
	ldh a, [hROMBank]
	push af
	ld a, BANK(\1)
	call Bankswitch
	call \1
	pop af
	call Bankswitch
ENDM

jpba: MACRO
	ld a, BANK(\1)
	ld hl, \1
	jp FarCall_hl
ENDM

jpab: MACRO
	ld hl, \1
	ld a, BANK(\1)
	jp FarCall_hl
ENDM
