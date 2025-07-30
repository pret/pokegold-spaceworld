INCLUDE "constants.asm"

SECTION "engine/link/time_capsule_2.asm", ROMX

; Takes the DEX_* index stored in wTempSpecies,
; finds its MON_* in the Pokered_MonIndices table,
; and returns its index in wTempSpecies.
ConvertMon_2to1::
	push bc
	push hl
	ld a, [wTempSpecies]
	ld b, a
	ld c, $00
	ld hl, Pokered_MonIndices
.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop
	ld a, c
	ld [wTempSpecies], a
	pop hl
	pop bc
	ret

; Takes the MON_* value stored in wTempSpecies
; and returns the corresponding DEX_* value from Pokered_MonIndices in wTempSpecies.
ConvertMon_1to2::
	push bc
	push hl
	ld a, [wTempSpecies]
	dec a
	ld hl, Pokered_MonIndices
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempSpecies], a
	pop hl
	pop bc
	ret

INCLUDE "data/pokemon/gen1_order.inc"
