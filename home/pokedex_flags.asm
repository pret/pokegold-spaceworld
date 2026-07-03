INCLUDE "constants.asm"

SECTION "home/pokedex_flags.asm", ROM0

WaitPressedAny::
; Waits for one of the buttons in d to be pressed.
; If bc is negative, waits forever.
; Otherwise, times out after bc frames then returns z.

; Reset hJoypadSum to clear button history
	xor a
	ldh [hJoypadSum], a
.loop:
; Wait for joypad polling.
	call DelayFrame

; If any of the buttons in d were pressed, return nz.
	ldh a, [hJoypadSum]
	and a
	jr z, .not_pressed
	and d
	ret nz
.not_pressed:

; If bc < 0, don't check timeout.
	bit 7, b
	jr nz, .loop

; Count down to timeout.
	dec bc
	ld a, b
	or c
	jr nz, .loop

; Return z, signifying that the request timed out.
	ret

CountSetBits::
; Count the number of bits set in b bytes at hl.
; Return to a, c, and wNumSetBits.
	ld c, $0
.byte_loop
	ld a, [hli]
	ld e, a
	ld d, $8
.bit_loop
	srl e
	ld a, $0
	adc c
	ld c, a
	dec d
	jr nz, .bit_loop
	dec b
	jr nz, .byte_loop
	ld a, c
	ld [wNumSetBits], a
	ret
