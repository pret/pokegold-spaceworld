INCLUDE "constants.asm"

SECTION "home/toolgear.asm", ROM0

; local charmap, global charmap won't apply
; see https://github.com/rednex/rgbds/issues/265#issuecomment-395229694
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

EnableToolgear:: ; 00:2018
	ld hl, wd153
	res 0, [hl]
	ld hl, wToolgearFlags
	set 0, [hl]
	ret

DisableToolgear:: ; 00:2023
	ld hl, wToolgearFlags
	res 0, [hl]
	xor a
	ldh [hLCDCPointer], a
	ret

InitToolgearBuffer:: ; 00:202c
	xor a
	ldh [hBGMapMode], a
	ld hl, wToolgearFlags
	bit 0, [hl]
	jr z, .hide_window

	res 7, [hl]
	call LoadToolgearGraphics

	bgcoord hl, 0, 0, wToolgearBuffer
	ld a, "─"
	ld bc, SCREEN_WIDTH
	call ByteFill

	bgcoord hl, 0, 1, wToolgearBuffer
	ld a, "　"
	ld bc, SCREEN_WIDTH
	call ByteFill

	call UpdateToolgear

	ld hl, vBGMap1
	ld bc, $0004 ; 4 tiles = 2 rows
	bgcoord de, 0, 0, wToolgearBuffer
	call Get2bpp

	ld a, $80
	ldh [hLCDCPointer], a
	ld a, $80
	ldh [rWY], a
	ldh [hWY], a
	ret

.hide_window: ; 00:206b
	xor a
	ldh [hLCDCPointer], a
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	ret

UpdateToolgear:: ; 2075
; Prepares a buffer for the clock display, which in the Debug ROM is displayed on the bottom of the screen.
; This function is called every frame, and loads special tiles into the $66-$7a space.
	bgcoord hl, 0, 1, wToolgearBuffer
	ld bc, SCREEN_WIDTH
	ld a, "　"
	call ByteFill

if DEBUG
	ld hl, wd153
	bit 0, [hl]
	jr z, .debug_show_time
	ld hl, wXCoord
	bgcoord de, 4, 1, wToolgearBuffer
	ld c, $01
	call .printHex
	ld hl, wYCoord
	bgcoord de, 8, 1, wToolgearBuffer
	ld c, $01
	call .printHex
	ret
.debug_show_time:
endc

	ld hl, hRTCHours
	bgcoord de, 0, 1, wToolgearBuffer
	call .printDec
	ld hl, hRTCMinutes
	bgcoord de, 3, 1, wToolgearBuffer
	call .printDec
	ldh a, [hRTCDays]
	and 7
	add "日" ; Sunday
	ldbgcoord_a 6, 1, wToolgearBuffer
	ld a, "⚡" ; power
	ldbgcoord_a 9, 1, wToolgearBuffer
	inc a ; mobile
	ldbgcoord_a 11, 1, wToolgearBuffer
	ldh a, [hRTCSeconds]
	and 1
	ret z
	ld a, $70 ; :
	ldbgcoord_a 2, 1, wToolgearBuffer
	ret

.printHex:: ; 20cd
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

.printDec:: ; 20dc
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

.printDigit:: ; 20f1
; .printDigit
; print a hexadecimal digit for value in a to de
	and $0f
	add "０"
	ld [de], a
	inc de
	ret
