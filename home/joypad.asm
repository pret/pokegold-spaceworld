INCLUDE "constants.asm"

SECTION "Joypad functions", ROM0[$07FE]

Joypad:: ; 7fe (0:7fe)
; Read the joypad register and translate it to something more
; workable for use in-game. There are 8 buttons, so we can use
; one byte to contain all player input.

; Updates:

; hJoypadUp: released this frame (delta)
; hJoypadDown: pressed this frame (delta)
; hJoypadState: currently pressed
; hJoypadSum: pressed so far
	ld a, [$d4ab]
	and $d0
	ret nz
	ld a, 1 << 5 ; select direction keys
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	cpl
	and $0f
	swap a
	ld b, a
	ld a, 1 << 4 ; select button keys
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	cpl
	and $0f
	or b
	ld b, a
	ld a, (1 << 5 | 1 << 4) ; port reset
	ldh [rJOYP], a
	ldh a, [hJoypadState]
	ld e, a
	xor b
	ld d, a
	and e
	ldh [hJoypadUp], a
	ld a, d
	and b
	ldh [hJoypadDown], a
	ld c, a
	ldh a, [hJoypadSum]
	or c
	ldh [hJoypadSum], a
	ld a, b
	ldh [hJoypadState], a
	ldh [hJoypadState2], a
	and $0f
	cp $0f
	jp z, Reset
	ret
; 0x84a
