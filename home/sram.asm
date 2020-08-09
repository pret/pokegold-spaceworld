INCLUDE "constants.asm"

SECTION "home/sram.asm", ROM0

OpenSRAM:: ; 32a7
	push af
	ld a, 1
	ld [MBC3LatchClock], a
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	pop af
	ld [MBC3SRamBank], a
	ret

CloseSRAM:: ; 32b7
	push af
	ld a, SRAM_DISABLE
	ld [MBC3LatchClock], a
	ld [MBC3SRamEnable], a
	pop af
	ret