INCLUDE "constants.asm"

SECTION "home/time.asm", ROM0

LatchClock:
	ld a, 0
	ld [MBC3LatchClock], a
	ld a, 1
	ld [MBC3LatchClock], a
	ret

UpdateTime::
	ldh a, [hRTCStatusFlags]
	bit 0, a
	ret nz

; enable clock r/w
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a

; clock data is 'backwards' in hram
	call LatchClock
	ld a, RTC_S
	ld [MBC3SRamBank], a
	ld a, [MBC3RTC]
	and $7f
	ldh [hRTCSeconds], a

	ld a, RTC_M
	ld [MBC3SRamBank], a
	ld a, [MBC3RTC]
	and $7f
	ldh [hRTCMinutes], a

	ld a, RTC_H
	ld [MBC3SRamBank], a
	ld a, [MBC3RTC]
	and $1f
	ldh [hRTCHours], a
	call CloseSRAM

	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jr z, .get_time_of_day

	ld a, [wd153]
	bit OVERWORLD_MINUTE_TIME_F, a
	jr nz, .get_time_with_seconds

.get_time_of_day
	ldh a, [hRTCHours]
	ld b, a
	ld hl, .TimesOfDay
.loop1
	ld a, [hli]
	cp b
	jr nc, .got_time
	inc hl
	jr .loop1

.got_time
	ld a, [hl]
	ld [wTimeOfDay], a
	ret

.get_time_with_seconds
	ldh a, [hRTCSeconds]
	ld b, a
	ld hl, .TimesOfDay_Debug
.loop2
	ld a, [hli]
	cp b
	jr nc, .got_time_2
	inc hl
	jr .loop2

.got_time_2
	ld a, [hl]
	ld [wTimeOfDay], a
	ret

.TimesOfDay:
	db MORN_HOUR, NITE_F
	db DAY_HOUR, MORN_F
	db NITE_HOUR, DAY_F
	db MAX_HOUR, NITE_F

.TimesOfDay_Debug:
	db 30, DAY_F
	db 35, NITE_F
	db 50, DARKNESS_F
	db 59, MORN_F

Function04ac::
	ld hl, hRTCStatusFlags
	set 0, [hl]
	call Function04ea
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	call LatchClock

	ld a, RTC_S
	ld [MBC3SRamBank], a
	ld a, 0
	ld [MBC3RTC], a

	ld a, RTC_M
	ld [MBC3SRamBank], a
	ld a, [wStartMinute]
	ld [MBC3RTC], a

	ld a, RTC_H
	ld [MBC3SRamBank], a
	ld a, [wStartHour]
	ld [MBC3RTC], a

	ld a, [wStartDay]
	ldh [hRTCDays], a

	call CloseSRAM
	ld hl, hRTCStatusFlags
	res 0, [hl]
	ret

Function04ea::
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	call LatchClock
	ld a, RTC_DH
	ld [MBC3SRamBank], a
	ld a, [MBC3RTC]
	set 6, a
	ld [MBC3RTC], a
	call CloseSRAM
	ret

Function0502::
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	call LatchClock
	ld a, RTC_DH
	ld [MBC3SRamBank], a
	ld a, [MBC3RTC]
	res 6, a
	ld [MBC3RTC], a
	call CloseSRAM
	ret
