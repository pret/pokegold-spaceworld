INCLUDE "constants.asm"

SECTION "home/print_num.asm", ROM0

PrintNumber::
; function to print a number
; de = address of number in little-endian format
; hl = destination address
; b = flags and length
; bit 7: if set, do not print leading zeroes
;        if unset, print leading zeroes
; bit 6: if set, left-align the string (do not pad empty digits with spaces)
;        if unset, right-align the string
; bits 0-5: length of number in bytes
;           01 - 1 byte
;           02 - 2 bytes
;           <> - 3 bytes
; c = number of digits from 2 to 7
;     For 1-digit numbers, add the value to char "0"
;     instead of calling PrintNumber.
; This function works as follow
; There are three temporary registers
; - hPrintNumDividend,
; - hPrintNumDivisor,
; - hPrintNumTemp
; All are three bytes long and organized in big-endian order.
; To produce digits, PrintNumber is going to
; 1. Store Input in hPrintNumDividend
;    1a. Init hPrintNumLeadingDigit to zero (no prior leading digit)
; 2. Repeatedly call .PrintDigit for required digits 7 thru 3:
;    2a. Store divisor in hPrintNumDivisor
;    2b. Divide dividend by divisor to get digit
;    2c. hPrintNumTemp is used, because dividend < divisor might
;        not be immediately visible in byte-wise division
;    2d. Update hPrintNumLeadingDigit in case digit > 0
; 3. Perform the same operations for two digits as byte-wide operations
;    as opposed to three-byte-wide operations
; 4. Check if at least one non-zero digit was printed, else print zero.
; 5. Done.
	push bc
	xor a
	ldh [hPrintNumLeadingDigit], a
	ldh [hPrintNumDividend], a
	ldh [hPrintNumDividend + 1], a
	ld a, b
	and $0f
	cp $01
	jr z, .byte
	cp $02
	jr z, .word
	ld a, [de]
	ldh [hPrintNumDividend], a
	inc de
	ld a, [de]
	ldh [hPrintNumDividend + 1], a
	inc de
	ld a, [de]
	ldh [hPrintNumDividend + 2], a
	jr .start
.word
	ld a, [de]
	ldh [hPrintNumDividend + 1], a
	inc de
	ld a, [de]
	ldh [hPrintNumDividend + 2], a
	jr .start
.byte
	ld a, [de]
	ldh [hPrintNumDividend + 2], a
.start
	push de
	ld d, b
	ld a, c
	ld b, a
	xor a
	ld c, a
	ld a, b
	cp $02
	jr z, .two_digits
	cp $03
	jr z, .three_digits
	cp $04
	jr z, .four_digits
	cp $05
	jr z, .five_digits
	cp $06
	jr z, .six_digits
.seven_digits
	ld a, 1000000 / $10000 % $100
	ldh [hPrintNumDivisor], a
	ld a, 1000000 / $100 % $100
	ldh [hPrintNumDivisor + 1], a
	ld a, 1000000 % $100
	ldh [hPrintNumDivisor + 2], a
	call .PrintDigit
	call .AdvancePointer
.six_digits
	ld a, 100000 / $10000 % $100
	ldh [hPrintNumDivisor], a
	ld a, 100000 / $100 % $100
	ldh [hPrintNumDivisor + 1], a
	ld a, 100000 % $100
	ldh [hPrintNumDivisor + 2], a
	call .PrintDigit
	call .AdvancePointer
.five_digits
	xor a
	ldh [hPrintNumDivisor], a
	ld a, 10000 / $100
	ldh [hPrintNumDivisor + 1], a
	ld a, 10000 % $100
	ldh [hPrintNumDivisor + 2], a
	call .PrintDigit
	call .AdvancePointer
.four_digits
	xor a
	ldh [hPrintNumDivisor], a
	ld a, 1000 / $100
	ldh [hPrintNumDivisor + 1], a
	ld a, 1000 % $100
	ldh [hPrintNumDivisor + 2], a
	call .PrintDigit
	call .AdvancePointer
.three_digits
	xor a
	ldh [hPrintNumDivisor], a
	xor a
	ldh [hPrintNumDivisor + 1], a
	ld a, 100
	ldh [hPrintNumDivisor + 2], a
	call .PrintDigit
	call .AdvancePointer
.two_digits
	ld c, $00
	ldh a, [hPrintNumDividend + 2]
.mod_10
	cp $0a
	jr c, .modded_10
	sub $0a
	inc c
	jr .mod_10
.modded_10
	ld b, a
	ldh a, [hPrintNumLeadingDigit]
	or c
	ldh [hPrintNumLeadingDigit], a
	jr nz, .LeadingNonZero
	call .PrintLeadingZero
	jr .PrintLeastSignificantDigit
.LeadingNonZero
	ld a, "０"
	add c
	ld [hl], a
.PrintLeastSignificantDigit
	call .AdvancePointer
	ld a, "０"
	add b
	ld [hli], a
	pop de
	pop bc
	ret

.PrintDigit:
	ld c, $00
.loop
	ldh a, [hPrintNumDivisor]
	ld b, a
	ldh a, [hPrintNumDividend]
	ldh [hPrintNumTemp], a         ; store high byte in case dividend < divisor
	cp b                           ; in subsequent bytes
	jr c, .DividendLessThanDivisor ; dividend < divisor --> the digit is zero
	sub b
	ldh [hPrintNumDividend], a
	ldh a, [hPrintNumDivisor + 1]
	ld b, a
	ldh a, [hPrintNumDividend + 1]
	ldh [hPrintNumTemp + 1], a     ; store mid byte in case dividend < divisor
	cp b                           ; in subsequent byte
	jr nc, .SubtractMidNoBorrow
	ldh a, [hPrintNumDividend]                ; try to borrow from upper byte
	or $00
	jr z, .DividendLessThanDivisorRestoreHigh ; can't borrow, because dividend < divisor
	dec a
	ldh [hPrintNumDividend], a
	ldh a, [hPrintNumDividend + 1]
.SubtractMidNoBorrow
	sub b
	ldh [hPrintNumDividend + 1], a
	ldh a, [hPrintNumDivisor + 2]
	ld b, a
	ldh a, [hPrintNumDividend + 2]
	ldh [hPrintNumTemp + 2], a    ; store low byte in case dividend < divisor, which
	cp b                          ; goes unused, because the algorithm doesn't
	jr nc, .SubtractLoNoBorrow    ; clobber hPrintNumDividend + 2 in that case
	ldh a, [hPrintNumDividend + 1]
	and a
	jr nz, .SubtractLoBorrow
	ldh a, [hPrintNumDividend]    ; if mid byte == zero, we need to borrow from high
	and a
	jr z, .DividendLessThanDivisorRestoreMid
.SubtractLoBorrowFromHigh
	dec a
	ldh [hPrintNumDividend], a
	xor a
.SubtractLoBorrow
	dec a
	ldh [hPrintNumDividend + 1], a
	ldh a, [hPrintNumDividend + 2]
.SubtractLoNoBorrow
	sub b
	ldh [hPrintNumDividend + 2], a
	inc c
	jr .loop
.DividendLessThanDivisorRestoreMid
	ldh a, [hPrintNumTemp + 1]
	ldh [hPrintNumDividend + 1], a
.DividendLessThanDivisorRestoreHigh
	ldh a, [hPrintNumTemp]
	ldh [hPrintNumDividend], a
.DividendLessThanDivisor
	ldh a, [hPrintNumLeadingDigit]
	or c
	jr z, .PrintLeadingZero
	ld a, "０"
	add c
	ld [hl], a
	ldh [hPrintNumLeadingDigit], a
	ret
.PrintLeadingZero:
; prints a leading zero unless they are turned off in the flags
	bit 7, d
	ret z
	ld [hl], "０"
	ret

.AdvancePointer:
; increments the pointer unless leading zeroes are not being printed,
; the number is left-aligned, and no nonzero digits have been printed yet
	bit 7, d      ; print leading zeroes?
	jr nz, .inc
	bit 6, d      ; left alignment or right alignment?
	jr z, .inc
	ldh a, [hPrintNumLeadingDigit]
	and a
	ret z         ; don't advance if leading digit is zero
.inc
	inc hl
	ret
