INCLUDE "constants.asm"

SECTION "home/lcd.asm", ROM0

LCD::
	push af
	ldh a, [hLCDCPointer]
	and a
	jr z, .done
	push hl
	rla
	jr c, .try_hide_sprites
	ld a, [rLY]
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
	ld a, [rLY]
	cp $80
	jr nz, .dont_hide
	ld hl, rLCDC
	res 1, [hl]
.dont_hide
	pop hl
	pop af
	reti

	; Seems unused?
	ldh a, [hSCX]
	ld [rSCX], a
	ldh a, [hSCY]
	ld [rSCY], a
	pop hl
.done
	pop af
	reti

; TODO: can this be done using `sine_table`?
	db 0, 1, 2, 2, 3, 3, 4, 4, 4, 4, 4, 3, 3, 2, 2, 1, 0, -1, -2, -2, -3, -3, -4, -4, -4, -4, -4, -3, -3, -2, -2, -1

DisableLCD::
	ld a, [rLCDC]
	bit 7, a
	ret z
	xor a
	ld [rIF], a
	ld a, [rIE]
	ld b, a
	res 0, a
	ld [rIE], a
.wait
	ld a, [rLY]
	cp LY_VBLANK + 1
	jr nz, .wait
	ld a, [rLCDC]
	and $7f ; Shut LCD down
	ld [rLCDC], a
	xor a
	ld [rIF], a
	ld a, b
	ld [rIE], a
	ret

EnableLCD::
	ld a, [rLCDC]
	set 7, a
	ld [rLCDC], a
	ret
