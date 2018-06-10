include "constants.asm"

if DEBUG
SECTION "Unknown 3025", ROM0 [$3025]
else
SECTION "Unknown 3025", ROM0 [$2fe9]
endc

Function3025::
	ld hl, .Text
	call Function3111
	ret

.Text: ; 00:302c
	text "ゲームフりーク！"
	done

Function3036:: ; 3036
	ld hl, .Text
	ret

.Text: ; 00:303a
	db "@"

Function303b::
	ld a, [wcdb0]
	bit 0, a
	jr z, asm_3062
	call Function3055
	ret z
	ld hl, hUnknownFFF3
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .Return
	push de
	jp hl

.Return: ; 00:3051
	call Function307a
	ret

Function3055:: ; 00:3055
	ldh a, [hFFEA]
	ld b, a
.asm_3058: ; 00:3058
	ld a, [hli]
	cp $ff
	ret z
	cp b
	jp z, Function3240
	jr .asm_3058

asm_3062: ; 00:3062
	ld a, [wcdb0]
	bit 1, a
	ret z
	ld h, d
	ld l, e
	ldh a, [hFFEE]
	dec a
	ld d, $0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, Function307a
	push de
	jp hl

Function307a:: ; 00:307a
	ld hl, wcdb0
	res 0, [hl]
	res 1, [hl]
	call Function3240
	ret

Function3085:: ; 00:3085
	push hl
	push de
	push bc
	ld de, $99
	ld a, [wcdb0]
	bit 0, a
	jr z, .asm_3097
	ld de, hFFEA
	jr .asm_309e

.asm_3097: ; 00:3097
	bit 1, a
	jr z, .asm_309e
	ld de, hFFEE
.asm_309e: ; 00:309e
	hlcoord 4, 12
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	ld de, wMapScriptNumber
	hlcoord 1, 12
	lb bc, PRINTNUM_LEADINGZEROS | 1, 2
	call PrintNumber
	pop bc
	pop de
	pop hl
	ret

Function30b7::
	ldh a, [hJoyState]
	bit A_BUTTON_F, a
	jp z, Function323e
	call Function3103
	jp nc, Function30e8
	ld d, $0
	ld e, a
	ld a, [wce63]
	bit 1, a
	call nz, Function3085
	ld hl, wd668
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	add hl, de
	ld de, hUnknownFFF3
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wcdb0
	set 0, [hl]
	call Function3240
	ret

Function30e8:: ; 00:30e8
	call Function2f1d
	jp nc, Function323e
	ld a, e
	ldh [hFFEB], a
	ld a, d
	ldh [hFFEC], a
	ld a, b
	ldh [hFFED], a
	ld a, [hl]
	ldh [hFFEE], a
	ld hl, wcdb0
	set 1, [hl]
	call Function3240
	ret

Function3103:: ; 00:3103
	callba Function776e
	ret nc
	call Function319b
	scf
	ret

