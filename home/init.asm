Reset::
	call DisableAudio
	call ClearPalettes
	ei

	ld hl, wJoypadFlags
	set 7, [hl]

	ld c, 32
	call DelayFrames

	jr Init ; pointless

Init::
	di
	xor a
	ldh [rIF], a
	ldh [rIE], a
	ldh [rSCX], a
	ldh [rSCY], a
	ldh [rSB], a
	ldh [rSC], a
	ldh [rWX], a
	ldh [rWY], a
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a
	ldh [rTMA], a
	ldh [rTAC], a
	ld [wTitleSequenceOpeningType], a ; Useless, since WRAM gets cleared right after
	ld a, 1 << B_TAC_START | TAC_4KHZ
	ldh [rTAC], a
	ld a, 1 << B_LCDC_ENABLE
	ldh [rLCDC], a
	call DisableLCD

	ld sp, wStackBottom
	call ClearVRAM

	ld hl, STARTOF(WRAM0)
	ld bc, SIZEOF(WRAM0)
.clear_loop
	ld [hl], 0
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop

	ld hl, STARTOF(HRAM)
	ld bc, SIZEOF(HRAM)
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
	ld a, 1 << B_STAT_MODE_0
	ldh [rSTAT], a
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ldh [rWY], a
	ld a, 7
	ldh [hWX], a
	ldh [rWX], a

	ld a, $ff
	ldh [hSerialConnectionStatus], a
	ld h, HIGH(vBGMap0)
	call BlankBGMap
	ld h, HIGH(vBGMap1)
	call BlankBGMap
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	call DisableAudio
	call LoadSGBBorderOptions
	predef CheckSGB
	ld a, $1F
	ldh [rIE], a
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a

	call DisableLCD
	call ClearVRAM
	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	ei

	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	ld a, RAMB_RTC_DH
	ld [rRAMB], a
	xor a
	ld [rRTCREG], a
	ld a, RTCLATCH_START ; unnecessary
	ld [rRTCLATCH], a
	ld [rRAMG], a
	jp GameInit

ClearVRAM::
	ld hl, STARTOF(VRAM)
	ld bc, SIZEOF(VRAM)
	xor a
	call ByteFill
	ret

BlankBGMap:
	ld a, '　'
	jr _FillBGMap

FillBGMap:
	ld a, l
_FillBGMap:
	ld de, TILEMAP_WIDTH * TILEMAP_HEIGHT
	ld l, e
.loop
	ld [hli], a
	dec e
	jr nz, .loop
	dec d
	jr nz, .loop
	ret
