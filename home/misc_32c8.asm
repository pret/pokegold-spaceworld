include "constants.asm"

; if DEBUG
SECTION "home/misc_32c8.asm@Unknown 32c8", ROM0
; else
; SECTION "Unknown 32c8", ROM0[$328c]
; endc

Function32c8::
	predef GetItemAmount
	ld a, b
	and a
	ret

Function32d0::
	ld hl, .Data
	ret

.Data: ; 00:32d4
	db "@"

SubtractSigned::
	sub b
	ret nc
	cpl
	add $1
	scf
	ret

; if DEBUG
SECTION "home/misc_32c8.asm@Unknown 3686", ROM0
; else
; SECTION "Unknown 3686", ROM0[$364a]
; endc

GiveMonToPlayer:: ; 3686
; Give to the player Pokemon of species b at level c.
	ld a, b
	ld [wMonDexIndex], a
	ld a, c
	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a
	jpba Function1130a

WaitPressedAny:: ; 369a
; Waits for one of the buttons in d to be pressed.
; If bc is negative, waits forever.
; Otherwise, times out after bc frames then returns z.

; Reset hJoypadSum to clear button history
	xor a
	ldh [hJoypadSum], a
.loop: ; 00:369d
; Wait for joypad polling.
	call DelayFrame

; If any of the buttons in d were pressed, return nz.
	ldh a, [hJoypadSum]
	and a
	jr z, .not_pressed
	and d
	ret nz
.not_pressed: ; 00:36a7

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

CountSetBits:: ; 36b1
; Count the number of bits set in b bytes at hl.
; Return to a, c, and wCountSetBitsResult.
	ld c, $0
.asm_36b3: ; 00:36b3
	ld a, [hli]
	ld e, a
	ld d, $8
.asm_36b7: ; 00:36b7
	srl e
	ld a, $0
	adc c
	ld c, a
	dec d
	jr nz, .asm_36b7
	dec b
	jr nz, .asm_36b3
	ld a, c
	ld [wCountSetBitsResult], a
	ret