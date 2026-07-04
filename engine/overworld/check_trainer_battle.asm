SECTION "engine/overworld/check_trainer_battle.asm", ROMX

_CheckTrainerBattle:
	xor a
	ld bc, NUM_OBJECTS * 2
	ld hl, wCurrMapInlineTrainers
	call ByteFill
	ld de, wMap2Object
	ld a, 2 ; next the player
.loop
	push af
	push de

; Is a trainer
	ld hl, MAPOBJECT_TYPE
	add hl, de
	ld a, [hl]
	cp 0 ; 1 or greater == not a trainer
	jr nz, .next

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next
	call .check_inline_trainer

.next
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.check_inline_trainer
	jp CheckInlineTrainer
