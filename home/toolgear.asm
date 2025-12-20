INCLUDE "constants.asm"

SECTION "home/toolgear.asm", ROM0

; local charmap, global charmap won't apply
; see https://github.com/gbdev/rgbds/issues/265#issuecomment-395229694
newcharmap local
	charmap "０", $66
	charmap "１", $67
	charmap "２", $68
	charmap "３", $69
	charmap "４", $6a
	charmap "５", $6b
	charmap "６", $6c
	charmap "７", $6d
	charmap "８", $6e
	charmap "９", $6f
	; if debug coords shown
	charmap "Ａ", $70
	charmap "Ｂ", $71
	charmap "Ｃ", $72
	charmap "Ｄ", $73
	charmap "Ｅ", $74
	charmap "Ｆ", $75
	; small kana aren't actively loaded

	; if clock shown
	charmap "：", $70
	charmap "日", $71
	charmap "月", $72
	charmap "火", $73
	charmap "水", $74
	charmap "木", $75
	charmap "金", $76
	charmap "土", $77
	charmap "⚡", $78 ; power
	charmap "☎", $79 ; mobile

	; active frame
	charmap "┌", $79 ; only if debug coords shown
	charmap "─", $7a
	charmap "┐", $7b
	charmap "│", $7c
	charmap "└", $7d
	charmap "┘", $7e
	charmap "　", $7f

EnableToolgear::
	ld hl, wd153
	res TOOLGEAR_COORDS_F, [hl]
	ld hl, wToolgearFlags
	set TOOLGEAR_COORDS_F, [hl]
	ret

DisableToolgear::
	ld hl, wToolgearFlags
	res SHOW_TOOLGEAR_F, [hl]
	xor a
	ldh [hLCDCPointer], a
	ret

InitToolgearBuffer::
	xor a
	ldh [hBGMapMode], a
	ld hl, wToolgearFlags
	bit SHOW_TOOLGEAR_F, [hl]
	jr z, .hide_window

	res HIDE_TOOLGEAR_F, [hl]
	call LoadToolgearGraphics

	bgcoord hl, 0, 0, wToolgearBuffer
	ld a, '─'
	ld bc, SCREEN_WIDTH
	call ByteFill

	bgcoord hl, 0, 1, wToolgearBuffer
	ld a, '　'
	ld bc, SCREEN_WIDTH
	call ByteFill

	call UpdateToolgear

	ld hl, vBGMap1
	ld bc, $4 ; 4 tiles = 2 rows
	bgcoord de, 0, 0, wToolgearBuffer
	call Get2bpp

	ld a, $80
	ldh [hLCDCPointer], a
	ld a, $80
	ldh [rWY], a
	ldh [hWY], a
	ret

.hide_window
	xor a
	ldh [hLCDCPointer], a
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	ret

UpdateToolgear::
; Prepares a buffer for the clock display, which in the Debug ROM is displayed on the bottom of the screen.
; This function is called every frame, and loads special tiles into the $66-$7a space.
	bgcoord hl, 0, 1, wToolgearBuffer
	ld bc, SCREEN_WIDTH
	ld a, '　'
	call ByteFill

	ld hl, wd153
	bit TOOLGEAR_COORDS_F, [hl]
	jr z, .debug_show_time

	ld hl, wXCoord
	bgcoord de, 4, 1, wToolgearBuffer
	ld c, 1
	call .printHex
	ld hl, wYCoord
	bgcoord de, 8, 1, wToolgearBuffer
	ld c, 1
	call .printHex
	ret

.debug_show_time
	ld hl, hRTCHours
	bgcoord de, 0, 1, wToolgearBuffer
	call .printDec
	ld hl, hRTCMinutes
	bgcoord de, 3, 1, wToolgearBuffer
	call .printDec
	ldh a, [hRTCDays]
	and 7
	add '日' ; Sunday
	ldbgcoord_a 6, 1, wToolgearBuffer
	ld a, '⚡' ; power
	ldbgcoord_a 9, 1, wToolgearBuffer
	inc a ; mobile
	ldbgcoord_a 11, 1, wToolgearBuffer
	ldh a, [hRTCSeconds]
	and 1
	ret z

	ld a, '：'
	ldbgcoord_a 2, 1, wToolgearBuffer
	ret

.printHex::
; .printHex
; print c hexadecimal digits from hl to de
; clobbers: a, b
	ld a, [hli]
	ld b, a
	swap a
	call .printDigit
	ld a, b
	call .printDigit
	dec c
	jr nz, .printHex
	ret

.printDec::
; .printDec
; print c decimal digits from hl to de
; clobbers: a, b
	ld a, [hli]
	ld b, 0
.mod10:
	inc b
	sub 10
	jr nc, .mod10
	dec b
	add 10
	push af
	ld a, b
	call .printDigit
	pop af
	call .printDigit
	ret

.printDigit::
; .printDigit
; print a hexadecimal digit for value in a to de
	and $f
	add '０'
	ld [de], a
	inc de
	ret
