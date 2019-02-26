INCLUDE "constants.asm"

; if DEBUG
SECTION "home/unknown.asm@Empty function", ROM0
; else
; SECTION "Empty function", ROM0[$2F5B]
; endc

InexplicablyEmptyFunction:: ; 2f97
rept 16
	nop
endr
	ret


; TODO:
; 1. Figure out what these are. Might be related to RTC, like ClearRTCStatus and the ilk.
; 2. Give them proper names.
; 3. Move them to their own file(s).

SECTION "home/unknown.asm@Unknown functions", ROM0

_1FF4:: ; 1ff4
	ld a, BANK(s0_a600)
	call OpenSRAM
	ld hl, s0_a600 ; TODO: label this.
	ld bc, 7
	xor a
	call ByteFill
	call CloseSRAM
	ret

_2007:: ; 2007
	ld a, BANK(s0_a600)
	call OpenSRAM
	ld a, [s0_a600]
	and 8
	ld [wce5f], a
	call CloseSRAM
	ret

SECTION "home/unknown.asm@Unknown_20f8", ROM0

Function20f8::
	call Function1848
	call Function18cc
	ret

SECTION "home/unknown.asm@Unknown_094c", ROM0

Function094c::
	ldh a, [hROMBank]
	push af
	ld a, BANK(Functionfe255)
	call Bankswitch
	call Functionfe255

	pop af
	call Bankswitch
	jp DebugMenu