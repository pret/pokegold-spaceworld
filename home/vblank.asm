INCLUDE "constants.asm"

SECTION "VBlank handler", ROM0[$150]

VBlank:: ; 0150
    push af
    push bc
    push de
    push hl
    ldh a, [hVBlank]
    and 3
    ld e, a
    ld d, 0
    ld hl, .blanks
    add hl, de
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, .return
    push de
    jp hl
.return
    pop hl
    pop de
    pop bc
    pop af
    reti

.blanks
	dw VBlank0
	dw VBlank1
	dw VBlank2
	dw VBlank3

VBlank0:: ; 175 (0:175)
; rng
; scx, scy, wy, wx
; bg map
; row/column redraw
; copy 2bpp
; copy 1bpp
; animate tileset
; copy far 2bpp
; enable oam sprites
; oam
; joypad
; sound / serial / lcd_stat
	ldh a, [hVBlankCounter]
	inc a
	ldh [hVBlankCounter], a
	bit 0, a
	jr nz, .even_frame
	ldh a, [hRTCRandom]
	ld b, a
	ldh a, [rLY]
	adc b
.even_frame
	; advance random variables
	ld b, a
	ldh a, [hRandomAdd]
	adc b
	ldh [hRandomAdd], a
	ld b, a
	ldh a, [hRandomSub]
	sbc b
	ldh [hRandomSub], a
	ldh a, [hRTCSeconds]
	ldh [hRTCRandom], a
	ldh a, [hROMBank]
	ld [wVBlankSavedROMBank], a
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ld a, [wDisableVBlankWYUpdate]
	and a
	jr nz, .ok
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a
.ok
	call AutoBgMapTransfer
	call RedrawRowOrColumn
	call VBlankCopy
	call VBlankCopyDouble
	call AnimateTileset
	call VBlankCopyFar
	call EnableSprites
	call hOAMDMA
	xor a
	ld [wVBlankOccurred], a
	ld a, [wVBlankCounter]
	and a
	jr z, .skipDec
	dec a
	ld [wVBlankCounter], a
.skipDec
	call Joypad
	xor a
	ldh [rIF], a
	ld a, (1 << SERIAL | 1 << LCD_STAT)
	ldh [rIE], a
	ld a, (1 << LCD_STAT)
	ldh [rIF], a
	ei
	call UpdateSound
	ld a, [wVBlankSavedROMBank]
	call Bankswitch
	di
	xor a
	ldh [rIF], a
	ld a, (1 << JOYPAD | 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK)
	ldh [rIE], a
	ret

VBlank1:: ; 1f6 (0:1f6)
; Simple VBlank
; 
; scx, scy
; dmg pals
; bg map
; copy 2bpp
; oam
; sound / lcd_stat
; no counters!
	ldh a, [hROMBank]
	ld [wVBlankSavedROMBank], a
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ld a, [wBGP]
	ldh [rBGP], a
	ld a, [wOBP0]
	ldh [rOBP0], a
	ld a, [wOBP1]
	ldh [rOBP1], a
	call AutoBgMapTransfer
	call VBlankCopy
	ld a, [wDisableVBlankOAMUpdate]
	and a
	jr nz, .skip_oam
	call hOAMDMA
.skip_oam
	xor a
	ld [wVBlankOccurred], a
	xor a
	ldh [rIF], a
	ld a, (1 << LCD_STAT)
	ldh [rIE], a
	ldh [rIF], a
	ei
	call UpdateSound
	ld a, [wVBlankSavedROMBank]
	call Bankswitch
	di
	xor a
	ldh [rIF], a
	ld a, (1 << JOYPAD | 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK)
	ldh [rIE], a
	ret

VBlank2:: ; 241 (0:241)
; rng
; scx, scy, wy, wx
; joypad
; bg map
; row/column redraw
; copy 2bpp
; copy 1bpp
; copy far 2bpp
; oam
; sound
	ldh a, [hVBlankCounter]
	inc a
	ldh [hVBlankCounter], a
	bit 0, a
	jr nz, .even_frame
	ldh a, [rLY]
.even_frame
	; advance random variables
	ld b, a
	ldh a, [hRandomAdd]
	adc b
	ldh [hRandomAdd], a
	ld b, a
	ldh a, [hRandomSub]
	sbc b
	ldh [hRandomSub], a
	call Joypad
	ldh a, [hROMBank]
	ld [wVBlankSavedROMBank], a
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ld a, [wDisableVBlankWYUpdate]
	and a
	jr nz, .ok
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a
.ok
	call AutoBgMapTransfer
	call RedrawRowOrColumn
	call VBlankCopy
	call VBlankCopyDouble
	call VBlankCopyFar
	call hOAMDMA
	xor a
	ld [wVBlankOccurred], a
	ld a, [wVBlankCounter]
	and a
	jr z, .skipDec
	dec a
	ld [wVBlankCounter], a
.skipDec
	call UpdateSound
	ld a, [wVBlankSavedROMBank]
	call Bankswitch
	ret

VBlank3:: ; 2a0 (0:2a0)
; rng
; joypad
; scx, scy, wy, wx
; bg map
; row/column redraw
; copy 2bpp
; copy 1bpp
; animate tileset
; copy far 2bpp
; enable oam sprites
; oam
; sound / lcd_stat
	ldh a, [hVBlankCounter]
	inc a
	ldh [hVBlankCounter], a
	bit 0, a
	jr nz, .even_frame
	ldh a, [rLY]
.even_frame
	ld b, a
	ldh a, [hRandomAdd]
	adc b
	ldh [hRandomAdd], a
	ld b, a
	ldh a, [hRandomSub]
	sbc b
	ldh [hRandomSub], a
	call Joypad
	ldh a, [hROMBank]
	ld [wVBlankSavedROMBank], a
	ldh a, [hSCX]
	ldh [rSCX], a
	ldh a, [hSCY]
	ldh [rSCY], a
	ld a, [wDisableVBlankWYUpdate]
	and a
	jr nz, .ok
	ldh a, [hWY]
	ldh [rWY], a
	ldh a, [hWX]
	ldh [rWX], a
.ok
	call AutoBgMapTransfer
	call RedrawRowOrColumn
	call VBlankCopy
	call VBlankCopyDouble
	call AnimateTileset
	call VBlankCopyFar
	call EnableSprites
	call hOAMDMA
	xor a
	ld [wVBlankOccurred], a
	ld a, [wVBlankCounter]
	and a
	jr z, .skipDec
	dec a
	ld [wVBlankCounter], a
.skipDec
	xor a
	ldh [rIF], a
	ld a, (1 << LCD_STAT)
	ldh [rIE], a
	ldh [rIF], a
	ei
	call UpdateSound
	ld a, [wVBlankSavedROMBank]
	call Bankswitch
	di
	xor a
	ldh [rIF], a
	ld a, (1 << JOYPAD | 1 << SERIAL | 1 << TIMER | 1 << LCD_STAT | 1 << VBLANK)
	ldh [rIE], a
	ret
; 0x317