INCLUDE "constants.asm"

SECTION "engine/menu/set_time.asm", ROMX

SetTime:
	ld hl, wStartHour
	ldh a, [hRTCHours]
	ld [hli], a
	ldh a, [hRTCMinutes]
	ld [hl], a
	ld hl, Textdbaf4
	call PrintText
	ret

Textdbaf4:
	deciram wStartHour, 1, 2
	text "　じ"
	line "@"
	deciram wStartMinute, 1, 2
	text "　ふん？@"
	start_asm
.loop
	call ClearJoypad
	call GetJoypad
	ldh a, [hJoyState]
	and a
	jr z, .loop
	bit 0, a
	jp nz, .sub_dbb63
	bit 6, a
	jr nz, .sub_dbb2a
	bit 7, a
	jr nz, .sub_dbb37
	bit 4, a
	jr nz, .sub_dbb43
	bit 5, a
	jr nz, .sub_dbb50
	jr .loop
.sub_dbb2a
	ld a, [wStartHour]
	cp $17
	jr z, .sub_dbb5a
	inc a
	ld [wStartHour], a
	jr .sub_dbb5a
.sub_dbb37
	ld a, [wStartHour]
	and a
	jr z, .sub_dbb5a
	dec a
	ld [wStartHour], a
	jr .sub_dbb5a
.sub_dbb43
	ld a, [wStartMinute]
	cp $3b
	jr z, .sub_dbb5a
	inc a
	ld [wStartMinute], a
	jr .sub_dbb5a
.sub_dbb50
	ld a, [wStartMinute]
	and a
	jr z, .sub_dbb5a
	dec a
	ld [wStartMinute], a
.sub_dbb5a
	ld hl, Textdbaf4 ; meant Textdbb6c?
	call PrintText
	jp .loop
.sub_dbb63
	call Function04ac
	call Function0502
	jp TextAsmEnd

Textdbb6c:
	deciram wStartHour, 1, 2
	text "　じ"
	line "@"
	deciram wStartMinute, 1, 2
	text "　ふん？"
	done
