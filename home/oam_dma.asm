INCLUDE "constants.asm"

SECTION "home/oam_dma.asm", ROMX

WriteOAMDMACodeToHRAM::
	ld c, LOW(hOAMDMA)
	ld b, .OAMDMAEnd - .OAMDMA
	ld hl, .OAMDMA
.loop
	ld a, [hli]
	ldh [c], a
	inc c
	dec b
	jr nz, .loop
	ret

.OAMDMA
	ld a, HIGH(wShadowOAM)
	ldh [rDMA], a
	ld a, $28
.wait
	dec a
	jr nz, .wait
	ret
.OAMDMAEnd
