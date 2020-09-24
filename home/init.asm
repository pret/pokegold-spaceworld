INCLUDE "constants.asm"


SECTION "NULL", ROM0
NULL::


SECTION "home/init.asm@Entry point", ROM0
	nop
	jp Init


SECTION "home/init.asm@Global check value", ROM0
; The ROM has an incorrect global check, so set it here.
; It is not corrected by RGBFIX.
	dw $C621


SECTION "home/init.asm@Init", ROM0

Reset:
	call DisableAudio
	call ClearPalettes
	ei

	ld hl, wJoypadFlags
	set 7, [hl]

	ld c, 32
	call DelayFrames

	jr Init ; pointless

Init:
	di
	xor a
	ld [rIF], a
	ld [rIE], a
	ld [rSCX], a
	ld [rSCY], a
	ld [rSB], a
	ld [rSC], a
	ld [rWX], a
	ld [rWY], a
	ld [rBGP], a
	ld [rOBP0], a
	ld [rOBP1], a
	ld [rTMA], a
	ld [rTAC], a
	ld [wTitleSequenceOpeningType], a ; Useless, since WRAM gets cleared right after
	ld a, 1 << rTAC_ON | rTAC_4096_HZ
	ld [rTAC], a
	ld a, 1 << rLCDC_ENABLE
	ld [rLCDC], a
	call DisableLCD

	ld sp, wStackBottom
	call ClearVRAM

	ld hl, WRAM0_Begin
	ld bc, WRAM1_End - WRAM0_Begin
.clear_loop
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop

	ld hl, HRAM_Begin
	ld bc, HRAM_End - HRAM_Begin
	call ByteFill
	call ClearSprites

	ld a, BANK(WriteOAMDMACodeToHRAM)
	call Bankswitch
	call WriteOAMDMACodeToHRAM

	xor a
	ldh [hMapAnims], a
	ldh [hSCX], a
	ldh [hSCY], a
	ldh [rJOYP], a
	ld a, 1 << rSTAT_HBLANK
	ld [rSTAT], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ld [rWY], a
	ld a, 7
	ldh [hWX], a
	ld [rWX], a

	ld a, $ff
	ldh [hLinkPlayerNumber], a
	ld h, HIGH($9800)
	call BlankBGMap
	ld h, HIGH($9C00)
	call BlankBGMap
	ld a, LCDC_DEFAULT
	ld [rLCDC], a

	call DisableAudio
	call _2007
	predef CheckSGB
	ld a, $1F
	ld [rIE], a
	ld a, HIGH($9C00)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a

	call DisableLCD
	call ClearVRAM
	ld a, LCDC_DEFAULT
	ld [rLCDC], a
	ei

	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	ld a, RTC_DH
	ld [MBC3SRamBank], a
	xor a
	ld [SRAM_Begin], a
	ld a, 0 ; Useless
	ld [MBC3LatchClock], a
	ld [MBC3SRamEnable], a
	jp GameInit

ClearVRAM:
	ld hl, VRAM_Begin
	ld bc, VRAM_End - VRAM_Begin
	xor a
	call ByteFill
	ret

BlankBGMap:
	ld a, "　"
	jr _FillBGMap

FillBGMap:
	ld a, l
_FillBGMap:
	ld de, BG_MAP_WIDTH * BG_MAP_HEIGHT
	ld l, e
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	dec d
	jr nz, .loop
	ret
