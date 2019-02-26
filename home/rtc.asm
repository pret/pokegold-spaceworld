include "constants.asm"

; if DEBUG
SECTION "home/rtc.asm", ROM0
; else
; SECTION "Time Of Day Palettes", ROM0 [$02EF]
; endc

UpdateTimeOfDayPalettes: ; 32b (0:032b)
	ld a, [wVramState]
	bit 0, a
	ret z
TimeOfDayPals::
	callab _TimeOfDayPals ; Func_8c2e3
	ret

UpdateTimePals:: ; 33a
	callab _UpdateTimePals ; Func_8c335
	ret