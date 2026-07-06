; function to print a BCD (Binary-coded decimal) number
; de = address of BCD number
; hl = destination address
; c = flags and length
; bit 7: if set, do not print leading zeroes
;        if unset, print leading zeroes
; bit 6: if set, left-align the string (do not pad empty digits with spaces)
;        if unset, right-align the string
; bits 0-5: length of BCD number in bytes
; Note that bit 7 is modified during execution. The above reflects
; its meaning at the beginning of the functions's execution.
PrintBCDNumber::
	ld b, c                        ; save flags in b
	res PRINTNUM_LEADINGZEROS_F, c
	res PRINTNUM_LEFTALIGN_F, c    ; c now holds the length
.loop
	ld a, [de]
	swap a
	call PrintBCDDigit
	ld a, [de]
	call PrintBCDDigit
	inc de
	dec c
	jr nz, .loop
	bit PRINTNUM_LEADINGZEROS_F, b ; were any non-zero digits printed?
	jr z, .done
.numberEqualsZero                  ; if every digit of the BCD number is zero
	bit PRINTNUM_LEFTALIGN_F, b
	jr nz, .skipRightAlignmentAdjustment
	dec hl                         ; if the string is right-aligned, it needs
.skipRightAlignmentAdjustment      ; to be moved back one space
	ld [hl], '０'
	call PrintLetterDelay
	inc hl
.done
	ret

PrintBCDDigit::
	and $0f
	and a
	jr z, .zeroDigit
	res PRINTNUM_LEADINGZEROS_F, b ; unset PRINTNUM_LEADINGZEROS_F to indicate
.outputDigit                       ; that a nonzero digit has been reached
	add '０'
	ld [hli], a
	jp PrintLetterDelay
.zeroDigit
	bit PRINTNUM_LEADINGZEROS_F, b ; either printing leading zeroes or
	jr z, .outputDigit             ; already reached a nonzero digit?
	bit PRINTNUM_LEFTALIGN_F, b
	ret nz                         ; left-align, don't pad with space
	ld a, '　'
	ld [hli], a
	ret
