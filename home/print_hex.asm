INCLUDE "constants.asm"

SECTION "home/print_hex.asm", ROM0

PrintHexBytes: ; 3597 (0:3597)
; Print c hex bytes located at de to hl
.loop
	push bc
	call PrintHexByte
	pop bc
	dec c
	jr nz, .loop
	ret

PrintHexByte:: ; 35a0 (0:35a0)
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

GetHexDigit: ; 35b2 (0:35b2)
; Get a hex digit tile number
; in a.
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