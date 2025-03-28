INCLUDE "constants.asm"

SECTION "engine/items/tmhm.asm", ROMX

CanLearnTMHMMove:
; Gets the index of TM or HM with move ID wce32,
; then checks the corresponding flag in wCurPartySpecies's learnset.
; Sets register c to 1 if TM/HM is in learnset OR if debug is enabled.
	ld a, [wDebugFlags]
	ld c, 01
	bit 1, a
	ret nz

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wMonHLearnset
	push hl

	ld a, [wce32]
	ld b, a
	ld c, 0
	ld hl, TMHMMoves
.loop
	ld a, [hli]
	cp b
	jr z, .jump
	inc c
	jr .loop

.jump
	pop hl
	ld b, CHECK_FLAG
	push de
	ld d, 0
	predef SmallFarFlagAction
	pop de
	ret

GetTMHMMove:
; converts TM/HM list index to TM/HM move ID
	ld a, [wNamedObjectIndexBuffer]
	dec a
	ld hl, TMHMMoves
	ld b, 0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	ret
