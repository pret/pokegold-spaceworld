INCLUDE "constants.asm"

SECTION "home/tilemap.asm", ROM0

Function360b::
	call ClearSprites
	ld hl, wVramState
	set 0, [hl]
	call Function3657
	call LoadFontExtra
	call GetMemSGBLayout
	jr WaitBGMap

ClearBGPalettes::
	call ClearPalettes
WaitBGMap::
; Tell VBlank to update BG Map
	ld a, $1
	ldh [hBGMapMode], a
; Wait for it to do its magic
	ld c, 3
	call DelayFrames
	ret

SetPalettes::
	ld a, %11100100
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a
	ret

ClearPalettes::
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ret

GetMemSGBLayout::
	ld b, SGB_RAM
GetSGBLayout::
	ld a, [wSGB]
	and a
	ret z
	predef_jump LoadSGBLayout

SetHPPal::
	ld a, e
	cp 27 ; 56.25%
	ld d, $0
	jr nc, .done
	cp 10 ; 20.83%
	inc d
	jr nc, .done
	inc d
.done:
	ld [hl], d
	ret

Function3657::
	call DisableLCD
	callfar Function140d9
	call LoadFont
	call UpdateSprites
	call EnableLCD
	ret
