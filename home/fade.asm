include "constants.asm"

SECTION "home/fade.asm", ROM0

Function0343::
	ld a, [wTimeOfDayPal] ; tells if current map is dark
	ld b, a
	ld hl, FadePal4
	ld a, l
	sub b
	ld l, a
	jr nc, .okay
	dec h
.okay
	ld a, [hli]
	ld [rBGP], a
	ld a, [hli]
	ld [rOBP0], a
	ld a, [hli]
	ld [rOBP1], a
	ret

GBFadeInFromBlack::
	ld hl, FadePal1
	ld b, 4
	jr _GBFadeIncCommon

GBFadeOutToWhite::
	ld hl, FadePal6
	ld b, 3
_GBFadeIncCommon:
; Rotate palettes to the right and fill with loaded colors from the left.
; If we're already at the leftmost color, fill with the leftmost color.
.loop
	ld a, [hli]
	ld [rBGP], a
	ld a, [hli]
	ld [rOBP0], a
	ld a, [hli]
	ld [rOBP1], a
	ld c, 8
	call DelayFrames
	dec b
	jr nz, .loop
	ret

GBFadeOutToBlack::
	ld hl, FadePal5 - 1
	ld b, 4
	jr _GBFadeDecCommon

GBFadeInFromWhite::
	ld hl, FadePal8 - 1
	ld b, 3
_GBFadeDecCommon:
; Rotate palettes to the left and fill with loaded colors from the right.
; If we're already at the rightmost color, fill with the rightmost color.
.loop
	ld a, [hld]
	ld [rOBP1], a
	ld a, [hld]
	ld [rOBP0], a
	ld a, [hld]
	ld [rBGP], a
	ld c, 8
	call DelayFrames
	dec b
	jr nz, .loop
	ret

FadePal1:: db %11111111, %11111111, %11111111
FadePal2:: db %11111110, %11111110, %11111000
FadePal3:: db %11111001, %11100100, %11100100
FadePal4:: db %11100100, %11010000, %11100000
;                rBGP      rOBP0      rOBP1
FadePal5:: db %11100100, %11010000, %11100000
FadePal6:: db %10010000, %10000000, %10010000
FadePal7:: db %01000000, %01000000, %01000000
FadePal8:: db %00000000, %00000000, %00000000
