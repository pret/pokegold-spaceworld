include "constants.asm"

; if DEBUG
SECTION "home/tilemap.asm", ROM0
; else
; SECTION "Tilemap Functions", ROM0 [$35CF]
; endc

Function360b::
	call ClearSprites
	ld hl, wVramState
	set 0, [hl]
	call Function3657
	call LoadFontExtra
	call GetMemSGBLayout
	jr WaitBGMap

ClearBGPalettes:: ; 361e
	call ClearPalettes
WaitBGMap:: ; 00:3621
; Tell VBlank to update BG Map
	ld a, $1
	ldh [hBGMapMode], a
; Wait for it to do its magic
	ld c, 3
	call DelayFrames
	ret

SetPalettes:: ; 00:362b
	ld a, %11100100
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a
	ret

ClearPalettes:: ; 00:3634
	xor a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ret

GetMemSGBLayout:: ; 00:363c
	ld b, SGB_RAM
GetSGBLayout:: ; 00:363e
	ld a, [wSGB]
	and a
	ret z
	predef_jump Function928b

SetHPPal:: ; 00:3648
	ld a, e
	cp 27 ; 56.25%
	ld d, $0
	jr nc, .done
	cp 10 ; 20.83%
	inc d
	jr nc, .done
	inc d
.done: ; 00:3655
	ld [hl], d
	ret

Function3657:: ; 00:3657
	call DisableLCD
	callab Function140d9
	call LoadFont
	call UpdateSprites
	call EnableLCD
	ret