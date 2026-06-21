INCLUDE "constants.asm"

SECTION "engine/battle/read_trainer_attributes.asm", ROMX

GetOTName::
	ld hl, wOTPlayerName
	ld a, [wLinkMode]
	and a
	jr nz, .ok

	ld hl, wRivalName
	ld a, [wTrainerClass]
	cp TRAINER_RIVAL
	jr z, .ok

	ld hl, wPlayerName
	cp TRAINER_PROTAGONIST
	jr z, .ok

	ld [wCurSpecies], a
	ld a, TRAINER_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld hl, wStringBuffer1

.ok
	ld de, wOTClassName
	ld bc, TRAINER_CLASS_NAME_LENGTH
	jp CopyBytes

GetTrainerAttributes::
	call GetOTName
	ld a, [wTrainerClass]
	dec a
	ld hl, TrainerClassAttributes + TRNATTR_SPRITEPOINTER1
	ld bc, NUM_TRAINER_ATTRIBUTES
	call AddNTimes
	ld de, wEnemyTrainerGraphicsPointer
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	ld [wEnemyTrainerBaseReward], a
	ret

; Forces the opponent to use the protagonist front sprite.
Unreferenced_GetLinkBattlePic:
	ld hl, wEnemyTrainerGraphicsPointer
	ld de, ProtagonistPic
	ld [hl], e
	inc hl
	ld [hl], d
	ret

INCLUDE "data/trainers/attributes.inc"
INCLUDE "data/trainers/class_names.inc"
