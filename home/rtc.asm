INCLUDE "constants.asm"

SECTION "home/rtc.asm", ROM0

UpdateTimeOfDayPalettes:
	ld a, [wVramState]
	bit 0, a
	ret z
	; fallthrough

TimeOfDayPals::
	callab _TimeOfDayPals
	ret

UpdateTimePals::
	callab _UpdateTimePals
	ret
