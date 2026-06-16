INCLUDE "constants.asm"

SECTION "engine/menu/set_time.asm", ROMX

SetTime:
	ld hl, wStartHour
	ldh a, [hRTCHours]
	ld [hli], a
	ldh a, [hRTCMinutes]
	ld [hl], a
	ld hl, AdjustTimeText
	call PrintText
	ret

AdjustTimeText:
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
	bit A_BUTTON_F, a
	jp nz, .set_time
	bit D_UP_F, a
	jr nz, .inc_hour
	bit D_DOWN_F, a
	jr nz, .dec_hour
	bit D_RIGHT_F, a
	jr nz, .inc_minute
	bit D_LEFT_F, a
	jr nz, .dec_minute
	jr .loop
.inc_hour
	ld a, [wStartHour]
	cp 23
	jr z, .show_text
	inc a
	ld [wStartHour], a
	jr .show_text
.dec_hour
	ld a, [wStartHour]
	and a
	jr z, .show_text
	dec a
	ld [wStartHour], a
	jr .show_text
.inc_minute
	ld a, [wStartMinute]
	cp 59
	jr z, .show_text
	inc a
	ld [wStartMinute], a
	jr .show_text
.dec_minute
	ld a, [wStartMinute]
	and a
	jr z, .show_text
	dec a
	ld [wStartMinute], a
.show_text
	ld hl, AdjustTimeText ; meant AdjustTimeEndText?
	call PrintText
	jp .loop
.set_time
	call Function04ac
	call Function0502
	jp TextAsmEnd

AdjustTimeEndText:
	deciram wStartHour, 1, 2
	text "　じ"
	line "@"
	deciram wStartMinute, 1, 2
	text "　ふん？"
	done
