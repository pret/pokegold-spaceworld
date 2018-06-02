INCLUDE "constants.asm"

SECTION "Print Hexadecimal functions", ROM0[$3597]

PrintHexBytes: ; 3597 (0:3597)
.loop
	push bc
	call PrintHexByte
	pop bc
	dec c
	jr nz, .loop
	ret

PrintHexByte:: ; 35a0 (0:35a0)
	ld a, [de]
	swap a
	and $0f
	call PrintHexDigit
	ld [hli], a
	ld a, [de]
	and $0f
	call PrintHexDigit
	ld [hli], a
	inc de
	ret

PrintHexDigit: ; 35b2 (0:35b2)
	ld bc, .hexDigitTable
	add c
	ld c, a
	ld a, $00
	adc b
	ld b, a
	ld a, [bc]
	ret

.hexDigitTable:
	db "０１２３４５６７８９ＡＢＣＤＥＦ"
