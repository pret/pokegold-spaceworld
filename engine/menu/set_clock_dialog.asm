INCLUDE "constants.asm"

SECTION "engine/menu/set_clock_dialog.asm", ROMX

DEF UP_ARROW      EQU $f0
DEF DOWN_ARROW    EQU $ee

SetClockDialog:
	call SetClockDialog_Init

.loop
	call SetClockDialog_Run
	jr nc, .loop

	ld hl, SetClockDialog_ConfirmTimeDate
	call PrintText

	hlcoord 3, 13
	call SetClockDialog_PrintDayOfWeek
	ld de, wHourBuffer

	hlcoord 8, 14
	call SetClockDialog_PrintNumber
	ld de, wMinuteBuffer

	hlcoord 12, 14
	call SetClockDialog_PrintNumber

	call YesNoBox
	jr c, SetClockDialog
	call LoadFont
	ret

SetClockDialog_Init:
	xor a
	ld [wJumptableIndex], a
	ld hl, wc408
	ld bc, 50
	call ByteFill

; load days of week
	ld de, HUD_GFX
	ld hl, vChars2 tile $40
	lb bc, BANK(HUD_GFX), $20
	call Request1bpp

	ld de, UpArrowGFX
	ld hl, vFont tile $70
	lb bc, BANK(UpArrowGFX), 1
	call Request1bpp
	ret

UpArrowGFX:
INCBIN "gfx/font/up_arrow.1bpp"

SetClockDialog_Run:
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done

	call SetClockDialog_RunFunction
	call SetClockDialog_PrintUpDownArrows
	call DelayFrame
	and a
	ret

.done
	scf
	ret

SetClockDialog_PrintUpDownArrows:
	ld hl, wClockDialogArrowBlinkCounter
	ld a, [hl]
	inc [hl]
	and 8
	jr nz, .clear_arrows

; Print up arrow
	hlcoord 18, 14
	ld [hl], UP_ARROW

; Print down arrow
	hlcoord 18, 16
	ld [hl], DOWN_ARROW
	ret

.clear_arrows
	ld a, '　'
	hlcoord 18, 14
	ld [hl], a
	hlcoord 18, 16
	ld [hl], a
	ret

SetClockDialog_RunFunction:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw SetClockDialog_AskDay
	dw SetClockDialog_ChooseDayOfWeek
	dw SetClockDialog_AskHour
	dw SetClockDialog_ChooseHour
	dw SetClockDialog_AskMinutes
	dw SetClockDialog_ChooseMinutes

SetClockDialog_AskDay:
	ld hl, SetClockDialog_WhatDayIsIt
	call PrintText
	hlcoord 10, 16
	ld de, .DayString
	call PlaceString

	ld hl, wJumptableIndex
	inc [hl]
	ret

.DayString:
	db "ようび@"

SetClockDialog_ChooseDayOfWeek:
	hlcoord 9, 15
	call SetClockDialog_PrintDayOfWeek
	call GetJoypadDebounced
	ld hl, hJoySum
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed
	ld a, [hl]
	and D_UP
	jr nz, .up_pressed
	ld a, [hl]
	and D_DOWN
	jr nz, .down_pressed
	ret

.up_pressed
	ld hl, wDayOfWeekBuffer
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 7

.decrease
	dec a
	ld [hl],  a
	ret

.down_pressed
	ld hl, wDayOfWeekBuffer
	ld a, [hl]
	cp 6
	jr c, .increase
	ld a, $ff

.increase
	inc a
	ld [hl], a
	ret

.a_pressed
	ld a, [wDayOfWeekBuffer]
	ld [wStartDay], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

SetClockDialog_AskHour:
	ld hl, SetClockDialog_HowManyHours
	call PrintText

	hlcoord 10, 16
	ld de, .HoursString
	call PlaceString
	ld hl, wJumptableIndex
	inc [hl]
	ret

.HoursString:
	db "じ@"

SetClockDialog_ChooseHour:
	ld de, wHourBuffer
	hlcoord 8, 16
	call SetClockDialog_PrintNumber
	call GetJoypadDebounced
	ld hl, hJoySum
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed
	ld a, [hl]
	and D_UP
	jr nz, .up_pressed
	ld a, [hl]
	and D_DOWN
	jr nz, .down_pressed
	ret

.up_pressed
	ld hl, wHourBuffer
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 24

.decrease
	dec a
	ld [hl], a
	ret

.down_pressed
	ld hl, wHourBuffer
	ld a, [hl]
	cp 23
	jr c, .increase
	ld a, $ff

.increase
	inc a
	ld [hl], a
	ret

.a_pressed
	ld a, [wHourBuffer]
	ld [wStartHour], a
	ld hl, wJumptableIndex
	inc [hl]
	ret

.b_pressed
	ld hl, wJumptableIndex
	ld [hl], 0
	ret

SetClockDialog_AskMinutes:
	ld hl, SetClockDialog_HowManyMinutes
	call PrintText
	hlcoord 10, 16
	ld de, .MinutesString
	call PlaceString
	ld hl, wJumptableIndex
	inc [hl]
	ret

.MinutesString:
	db "ふん@"

SetClockDialog_ChooseMinutes:
	ld de, wMinuteBuffer
	hlcoord 8, 16
	call SetClockDialog_PrintNumber
	call GetJoypadDebounced
	ld hl, hJoySum
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed
	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed
	ld a, [hl]
	and D_UP
	jr nz, .up_pressed
	ld a, [hl]
	and D_DOWN
	jr nz, .down_pressed
	ret

.up_pressed
	ld hl, wMinuteBuffer
	ld a, [hl]
	and a
	jr nz, .decrease
	ld a, 60

.decrease
	dec a
	ld [hl], a
	ret

.down_pressed
	ld hl, wMinuteBuffer
	ld a, [hl]
	cp 59
	jr c, .increase
	ld a, $ff

.increase
	inc a
	ld [hl], a
	ret

.a_pressed
	ld a, [wMinuteBuffer]
	ld [wStartMinute], a
	ld hl, wJumptableIndex

; Display confirmation dialog
	set 7, [hl]
	ret

.b_pressed
	ld hl, wJumptableIndex
	ld [hl], 2
	ret

SetClockDialog_PrintDayOfWeek:
; Print top half
	ld a, [wDayOfWeekBuffer]
	sla a
	add $40
	ld [hl], a
	inc a

; Move down one row and print the bottom half
	ld de, SCREEN_WIDTH
	add hl, de
	ld [hl], a
	ret

SetClockDialog_PrintNumber:
	push hl
	ld a, $7f
	ld [hli], a
	ld [hl], a
	pop hl
	lb bc, 1, 2
	call PrintNumber
	ret

SetClockDialog_WhatDayIsIt:
	text "きょうは　なんようび　だったかの？"
	done

SetClockDialog_HowManyHours:
	text "いまは　なんじ　じゃ？"
	done

SetClockDialog_HowManyMinutes:
	deciram wStartHour, 1, 2
	text "じ　なんふん　かな？"
	done

SetClockDialog_ConfirmTimeDate:
	text "　　　ようび　　　じ　　　ふん"
	line "ほんとうに　あっているかの？"
	done
