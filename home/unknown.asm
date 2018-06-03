INCLUDE "constants.asm"

if DEBUG
SECTION "Empty function", ROM0[$2F97]
else
SECTION "Empty function", ROM0[$2F5B]
endc

InexplicablyEmptyFunction:: ; 2f97
rept 16
	nop
endr
	ret


; TODO:
; 1. Figure out what these are. Might be related to RTC, like ClearRTCStatus and the ilk.
; 2. Give them proper names.
; 3. Move them to their own file(s).

SECTION "Unknown functions", ROM0[$1FF4]

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

SECTION "Unknown functions 2", ROM0[$2075]

_2075:: ; 2075
; Prepares a buffer for the clock display, which in the Debug ROM is displayed on the bottom of the screen.
; This function is called every frame, and loads special tiles into the $66-$7a space.
    ld hl, wcbd2
    ld bc, $14
    ld a, "　"
    call ByteFill

if DEBUG
    ld hl, $d153
    bit 0, [hl]
    jr z, ._209e
    ld hl, $d65b
    ld de, wcbd2 + 4
    ld c, $01
    call _20CD
    ld hl, $d65a
    ld de, wcbd2 + 8
    ld c, $01
    call _20CD
    ret
._209e:
endc

    ld hl, hRTCHours
    ld de, wcbd2
    call _20DC
    ld hl, hRTCMinutes
    ld de, wcbd2 + 3
    call _20DC
    ldh a, [hRTCDays]
    and 7
    add $71 ; Sunday
    ld [wcbd2 + 6], a
    ld a, $78 ; power
    ld [wcbd2 + 9], a
    inc a ; mobile
    ld [wcbd2 + 11], a
    ldh a, [hRTCSeconds]
    and 1
    ret z
    ld a, $70 ; :
    ld [wcbd2 + 2], a
    ret

_20CD:: ; 20cd
; PrintAsHex
    ld a, [hli]
    ld b, a
    swap a
    call _20F1
    ld a, b
    call _20F1
    dec c
    jr nz, _20CD
    ret

_20DC:: ; 20dc
; PrintAsDec
    ld a, [hli]
    ld b, 0
._20df:
    inc b
    sub 10
    jr nc, ._20df
    dec b
    add 10
    push af
    ld a, b
    call _20F1
    pop af
    call _20F1
    ret

_20F1:: ; 20f1
    and %1111
    add $66 ; digit 0
    ld [de], a
    inc de
    ret
