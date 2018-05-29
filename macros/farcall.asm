
farcall: MACRO ; bank, address
	ld a, BANK(\1)
	ld hl, \1
	call FarCall_hl
ENDM

callfar: MACRO ; address, bank
	ld hl, \1
	ld a, BANK(\1)
	call FarCall_hl
ENDM

homecall: MACRO
	ld a, [hROMBank]
	push af
	ld a, BANK(\1)
	call Bankswitch
	call \1
	pop af
	call Bankswitch
ENDM
