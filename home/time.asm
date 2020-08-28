include "constants.asm"

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
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
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
	jr z, .asm_0478
	ld a, [wd153]
	bit 7, a
	jr nz, .asm_048a
.asm_0478
	ldh a, [hRTCHours]
	ld b, a
	ld hl, .Data_049c
.asm_047e
	ld a, [hli]
	cp b
	jr nc, .asm_0485
	inc hl
	jr .asm_047e

.asm_0485
	ld a, [hl]
	ld [wTimeOfDay], a
	ret

.asm_048a
	ldh a, [hRTCSeconds]
	ld b, a
	ld hl, .Data_04a4
.asm_0490
	ld a, [hli]
	cp b
	jr nc, .asm_0497
	inc hl
	jr .asm_0490

.asm_0497
	ld a, [hl]
	ld [wTimeOfDay], a
	ret

.Data_049c:
	db $06, $01
	db $09, $03
	db $0f, $00
	db $18, $01

.Data_04a4:
	db $1e, $00
	db $23, $01
	db $32, $02
	db $3b, $03

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
