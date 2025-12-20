INCLUDE "constants.asm"


SECTION "home/unknown.asm@Empty function", ROM0

InexplicablyEmptyFunction::
rept 16
	nop
endr
	ret


; TODO:
; 1. Figure out what these are. Might be related to RTC, like ClearRTCStatus and the ilk.
; 2. Give them proper names.
; 3. Move them to their own file(s).

SECTION "home/unknown.asm@Unknown functions", ROM0

; Init the options with values of $00 because EmptyAllSRAMBanks sets them to $FF, and that's no good!
; Final game gets around this by filling the entirety of SRAM banks with $00, which this demo probably should've done.
InitOptions::
	ld a, BANK(sOptions)
	call OpenSRAM
	ld hl, sOptions ; TODO: label this.
	ld bc, 7
	xor a
	call ByteFill
	call CloseSRAM
	ret

LoadSGBBorderOptions::
	ld a, BANK(sOptions)
	call OpenSRAM
	ld a, [sOptions]
	and SGB_BORDER
	ld [wOptions], a
	call CloseSRAM
	ret


SECTION "home/unknown.asm@Unknown_20f8", ROM0

Function20f8::
	call UnfreezeAllObjects
	call UnfreezePlayer
	ret


SECTION "home/unknown.asm@Debug menu sound test call", ROM0

DebugMenuSoundTest::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_DebugMenuSoundTest)
	call Bankswitch
	call _DebugMenuSoundTest

	pop af
	call Bankswitch
	jp DebugMenu
