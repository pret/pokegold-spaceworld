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
; This code is defined in ROM, but
; copied to and called from HRAM.
LOAD "OAM DMA", HRAM
hOAMDMA::
	ld a, HIGH(wShadowOAM)
	ldh [rDMA], a
	ld a, $28
.wait
	dec a
	jr nz, .wait
	ret
ENDL
.OAMDMAEnd
