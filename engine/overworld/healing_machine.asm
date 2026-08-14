AnimateHealingMachine::
	ld a, [wPartyCount]
	and a
	ret z
	call GroupHealingMachineSprites
	ld de, PokeCenterFlashingMonitorAndHealBall
	ld hl, vChars0 tile $7c
	lb bc, BANK(PokeCenterFlashingMonitorAndHealBall), 2
	call Request2bpp
	ld d, LEFT ; make the nurse turn to face the machine
	call SetPokecenterNurseFacing
	ldh a, [rOBP1]
	push af
	ld a, %11100000
	ldh [rOBP1], a
	ld hl, wShadowOAMSprite32
	ld de, PokeCenterOAMData
	call CopyHealingMachineOAM
	call CopyHealingMachineOAM ; duplicate, removed code?
	ld a, [wPartyCount]
	ld b, a
.partyLoop
	call CopyHealingMachineOAM
	ld c, 30
	call DelayFrames
	dec b
	jr nz, .partyLoop
	ld d, $28
	call FlashSprite8Times
	ld c, 32
	call DelayFrames
	ld d, DOWN ; make the nurse turn to face the player
	call SetPokecenterNurseFacing
	pop af
	ldh [rOBP1], a
	call UngroupHealingMachineSprites
	call UpdateSprites
	ret

PokeCenterFlashingMonitorAndHealBall:
	INCBIN "gfx/overworld/heal_machine.2bpp"

PokeCenterOAMData:
	; heal machine monitor
	dbsprite  4,  4,  2,  0, $7c, OAM_PAL1
	dbsprite  4,  4,  6,  0, $7c, OAM_PAL1
	; poke balls 1-6
	dbsprite  4,  4,  0,  6, $7d, OAM_PAL1
	dbsprite  5,  4,  0,  6, $7d, OAM_PAL1 | OAM_XFLIP
	dbsprite  4,  5,  0,  3, $7d, OAM_PAL1
	dbsprite  5,  5,  0,  3, $7d, OAM_PAL1 | OAM_XFLIP
	dbsprite  4,  6,  0,  0, $7d, OAM_PAL1
	dbsprite  5,  6,  0,  0, $7d, OAM_PAL1 | OAM_XFLIP

SetPokecenterNurseFacing:
	ld a, SILENT_HILL_POKECENTER_NURSE
	call SetObjectFacing
	call UpdateSprites
	ret
FlashSprite8Times:
	ld b, 8
.loop
	ldh a, [rOBP1]
	xor d
	ldh [rOBP1], a
	ld c, 10
	call DelayFrames
	dec b
	jr nz, .loop
	ret

CopyHealingMachineOAM:
; copy one OAM entry and advance the pointers
REPT 4
	ld a, [de]
	inc de
	ld [hli], a
ENDR
	ret

GroupHealingMachineSprites::
    ld hl, .group
	call HealingMachineLoop
	ret

.group:
	dba ObjectUseOBP0

UngroupHealingMachineSprites:
	ld hl, .ungroup
	call HealingMachineLoop
	ld a, 0
	call ObjectUseOBP0
	ret

.ungroup:
	dba ObjectUseOBP1
