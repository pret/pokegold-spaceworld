LatchClock:
	ld a, 0
	ld [rRTCLATCH], a
	ld a, 1
	ld [rRTCLATCH], a
	ret

UpdateTime::
	ldh a, [hRTCStatusFlags]
	bit 0, a
	ret nz

; enable clock r/w
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a

; clock data is 'backwards' in hram
	call LatchClock
	ld a, RAMB_RTC_S
	ld [rRAMB], a
	ld a, [rRTCREG]
	and $7f
	ldh [hRTCSeconds], a

	ld a, RAMB_RTC_M
	ld [rRAMB], a
	ld a, [rRTCREG]
	and $7f
	ldh [hRTCMinutes], a

	ld a, RAMB_RTC_H
	ld [rRAMB], a
	ld a, [rRTCREG]
	and $1f
	ldh [hRTCHours], a
	call CloseSRAM

	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jr z, .get_time_of_day

	ld a, [wTimeOfDayDebugFlags]
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

SetClock::
; set clock data from hram

	ld hl, hRTCStatusFlags
	set 0, [hl]
	call StopRTC
; enable clock r/w
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
; set clock data
; stored 'backwards' in hram
	call LatchClock

; seconds
	ld a, RAMB_RTC_S
	ld [rRAMB], a
	ld a, 0
	ld [rRTCREG], a

; minutes
	ld a, RAMB_RTC_M
	ld [rRAMB], a
	ld a, [wStartMinute]
	ld [rRTCREG], a

; hours
	ld a, RAMB_RTC_H
	ld [rRAMB], a
	ld a, [wStartHour]
	ld [rRTCREG], a

; days
	ld a, [wStartDay]
	ldh [hRTCDays], a

; cleanup
	call CloseSRAM
	ld hl, hRTCStatusFlags
	res 0, [hl]
	ret

StopRTC:: ; unreferenced
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	call LatchClock
	ld a, RAMB_RTC_DH
	ld [rRAMB], a
	ld a, [rRTCREG]
	set B_RAMB_RTC_DH_HALT, a
	ld [rRTCREG], a
	call CloseSRAM
	ret

StartRTC::
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	call LatchClock
	ld a, RAMB_RTC_DH
	ld [rRAMB], a
	ld a, [rRTCREG]
	res B_RAMB_RTC_DH_HALT, a
	ld [rRTCREG], a
	call CloseSRAM
	ret
