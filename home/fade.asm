include "constants.asm"

if DEBUG
SECTION "DMG Palette Fade Effect", ROM0 [$0343]
else
SECTION "DMG Palette Fade Effect", ROM0 [$0307]
endc

Function0343:: ; 0343
	ld a, [wTimeOfDayPal]
	ld b, a
	ld hl, IncGradGBPalTable_11 ; $39f
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

RotateFourPalettesRight::
	ld hl, IncGradGBPalTable_08 ; $396
	ld b, $4
	jr RotatePalettesRight

RotateThreePalettesRight::
	ld hl, IncGradGBPalTable_13 ; $3a5
	ld b, $3
RotatePalettesRight:: ; 0366
; Rotate palettes to the right and fill with loaded colors from the left
; If we're already at the leftmost color, fill with the leftmost color
.loop
	ld a, [hli]
	ld [rBGP], a
	ld a, [hli]
	ld [rOBP0], a
	ld a, [hli]
	ld [rOBP1], a
	ld c, $8
	call DelayFrames
	dec b
	jr nz, .loop
	ret

RotateFourPalettesLeft::
	ld hl, IncGradGBPalTable_12 - 1 ; $3a1
	ld b, $4
	jr RotatePalettesLeft

RotateThreePalettesLeft::
	ld hl, IncGradGBPalTable_15 - 1 ; $3aa
	ld b, $3
RotatePalettesLeft:: ; 0384
; Rotate palettes to the left and fill with loaded colors from the right
; If we're already at the rightmost color, fill with the rightmost color
.loop
	ld a, [hld]
	ld [rOBP1], a
	ld a, [hld]
	ld [rOBP0], a
	ld a, [hld]
	ld [rBGP], a
	ld c, $8
	call DelayFrames
	dec b
	jr nz, .loop
	ret

; IncGradGBPalTable_00:: db %11111111, %11111111, %11111111
; IncGradGBPalTable_01:: db %11111110, %11111110, %11111110
; IncGradGBPalTable_02:: db %11111001, %11111001, %11111001
; IncGradGBPalTable_03:: db %11100100, %11100100, %11100100

; IncGradGBPalTable_04:: db %11100100, %11100100, %11100100
; IncGradGBPalTable_05:: db %10010000, %10010000, %10010000
; IncGradGBPalTable_06:: db %01000000, %01000000, %01000000

; IncGradGBPalTable_07:: db %00000000, %00000000, %00000000
;                           bgp       obp1       obp2
IncGradGBPalTable_08:: db %11111111, %11111111, %11111111
IncGradGBPalTable_09:: db %11111110, %11111110, %11111000
IncGradGBPalTable_10:: db %11111001, %11100100, %11100100
IncGradGBPalTable_11:: db %11100100, %11010000, %11100000

IncGradGBPalTable_12:: db %11100100, %11010000, %11100000
IncGradGBPalTable_13:: db %10010000, %10000000, %10010000
IncGradGBPalTable_14:: db %01000000, %01000000, %01000000

IncGradGBPalTable_15:: db %00000000, %00000000, %00000000
