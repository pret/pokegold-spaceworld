LCD::
	push af
	ldh a, [hLCDCPointer]
	and a
	jr z, .done
	push hl
	rla
	jr c, .try_hide_sprites
	ldh a, [rLY]
	ld l, a
	ld h, HIGH(wLYOverrides)
	ld h, [hl]
	ldh a, [hLCDCPointer]
	ld l, a
	ld a, h
	ld h, $FF
	ld [hl], a
	pop hl
	pop af
	reti

.try_hide_sprites
	ldh a, [rLY]
	cp 128
	jr nz, .dont_hide
	ld hl, rLCDC
	res B_LCDC_OBJS, [hl]
.dont_hide
	pop hl
	pop af
	reti

	; Seems unused?
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	pop hl
.done
	pop af
	reti

; TODO: can this be done using `sine_table`?
	db 0, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 3, 3, 2, 2, 1, 0, -1, -2, -2, -3, -3, -4, -4, -4, -4, -4, -3, -3, -2, -2, -1

DisableLCD::
	ldh a, [rLCDC]
	bit B_LCDC_ENABLE, a
	ret z
	xor a
	ldh [rIF], a
	ldh a, [rIE]
	ld b, a
	res B_IE_VBLANK, a
	ldh [rIE], a
.wait
	ldh a, [rLY]
	cp LY_VBLANK + 1
	jr nz, .wait
	ldh a, [rLCDC]
	and ~LCDC_ENABLE
	ldh [rLCDC], a
	xor a
	ldh [rIF], a
	ld a, b
	ldh [rIE], a
	ret

EnableLCD::
	ldh a, [rLCDC]
	set B_LCDC_ENABLE, a
	ldh [rLCDC], a
	ret
