INCLUDE "constants.asm"

SECTION "engine/overworld/healing_machine.asm", ROMX

AnimateHealingMachine::
	ld a, [wPartyCount]
	and a
	ret z
	call GroupHealingMachineSprites
	ld de, PokeCenterFlashingMonitorAndHealBall
	ld hl, vChars0 tile $7c
	lb bc, BANK(PokeCenterFlashingMonitorAndHealBall), 2
	call Request2bpp
	ld d, 2
	call LoadHealingMachineSprites
	ldh a, [rOBP1]
	push af
	ld a, $e0
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
	ld d, 0
	call LoadHealingMachineSprites
	pop af
	ldh [rOBP1], a
	call UngroupHealingMachineSprites
	call UpdateSprites
	ret
	
PokeCenterFlashingMonitorAndHealBall:
	INCBIN "gfx/overworld/heal_machine.2bpp"

PokeCenterOAMData:
	; heal machine monitor
	dbsprite  4,  4,  2,  0, $7c, OBP_NUM
	dbsprite  4,  4,  6,  0, $7c, OBP_NUM
	; poke balls 1-6
	dbsprite  4,  4,  0,  6, $7d, OBP_NUM
	dbsprite  5,  4,  0,  6, $7d, OBP_NUM | X_FLIP
	dbsprite  4,  5,  0,  3, $7d, OBP_NUM
	dbsprite  5,  5,  0,  3, $7d, OBP_NUM | X_FLIP
	dbsprite  4,  6,  0,  0, $7d, OBP_NUM
	dbsprite  5,  6,  0,  0, $7d, OBP_NUM | X_FLIP

LoadHealingMachineSprites:
	ld a, 2
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
	nop
	sub a, h
	add hl, de

UngroupHealingMachineSprites:
	ld hl, .ungroup
	call HealingMachineLoop
	ld a, 0
	call ObjectUseOBP0
	ret

.ungroup:
	nop
	sbc a
	add hl, de
