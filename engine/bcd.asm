INCLUDE "constants.asm"
	
SECTION "engine/bcd.asm", ROMX

AddBCD: ; 03:4de3
	and a
	ld b, c
.add
	ld a, [de]
	adc [hl]
	daa
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .add
	jr nc, .done
	
	ld a, $99
	inc de
	
.fill
	ld [de], a
	inc de
	dec b
	jr nz, .fill

.done
	ret


SubBCD: ; 03:4df9
	and a
	ld b, c
.sub
	ld a, [de]
	sbc [hl]
	daa
	ld [de], a
	dec de
	dec hl
	dec c
	jr nz, .sub
	jr nc, .done
	ld a, 0
	inc de
	
.fill
	ld [de], a
	inc de
	dec b
	jr nz, .fill
	scf
.done
	ret