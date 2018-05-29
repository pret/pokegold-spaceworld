SECTION "OAM DMA", ROMX[$4153],BANK[1]

WriteOAMDMACodeToHRAM:: ; 4153
    ld c, LOW(hOAMDMA)
    ld b, .OAMDMAEnd - .OAMDMA
    ld hl, .OAMDMA
.loop
    ld a, [hli]
    ld [$ff00+c], a
    inc c
    dec b
    jr nz, .loop
    ret

.OAMDMA ; 4161
    ld a, HIGH(wVirtualOAM)
    ldh [rDMA], a
    ld a, $28
.wait
    dec a
    jr nz, .wait
    ret
.OAMDMAEnd ; 416b
