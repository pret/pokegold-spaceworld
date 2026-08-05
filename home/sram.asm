OpenSRAM::
	push af
	ld a, 1
	ld [rRTCLATCH], a
	ld a, RAMG_SRAM_ENABLE
	ld [rRAMG], a
	pop af
	ld [rRAMB], a
	ret

CloseSRAM::
	push af
	ld a, RAMG_SRAM_DISABLE
	ld [rRTCLATCH], a
	ld [rRAMG], a
	pop af
	ret
