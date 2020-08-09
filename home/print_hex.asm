INCLUDE "constants.asm"

SECTION "home/print_hex.asm", ROM0

PrintHexBytes:
; Print c hex bytes located at de to hl
.loop
	push bc
	call PrintHexByte
	pop bc
	dec c
	jr nz, .loop
	ret

PrintHexByte::
; Print one hex byte located at de to hl
	ld a, [de]
	swap a
	and $0f
	call GetHexDigit
	ld [hli], a
	ld a, [de]
	and $0f
	call GetHexDigit
	ld [hli], a
	inc de
	ret

GetHexDigit:
; Get a hex digit tile number in a
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
