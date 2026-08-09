; Init the options with values of $00 because EmptyAllSRAMBanks sets them to $FF, and that's no good!
; Final game gets around this by filling the entirety of SRAM banks with $00, which this demo probably should've done.
InitOptions::
	ld a, BANK(sOptions)
	call OpenSRAM
	ld hl, sOptions
	ld bc, wDebugFlags4 - wOptions ; BUG: This only clears 7 bytes instead of the needed 8.
	xor a                          ; wDebugFlags4 isn't cleared as a result.
	call ByteFill
	call CloseSRAM
	ret

LoadSGBBorderOptions::
	ld a, BANK(sOptions)
	call OpenSRAM
	ld a, [sOptions]
	and SGB_BORDER
	ld [wOptions], a
	call CloseSRAM
	ret
