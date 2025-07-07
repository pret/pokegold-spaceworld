INCLUDE "constants.asm"

SECTION "home/rtc.asm", ROM0

UpdateTimeOfDayPalettes:
	ld a, [wStateFlags]
	bit SPRITE_UPDATES_DISABLED_F, a
	ret z
	; fallthrough

TimeOfDayPals::
	callfar _TimeOfDayPals
	ret

UpdateTimePals::
	callfar _UpdateTimePals
	ret
