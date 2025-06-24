INCLUDE "constants.asm"

SECTION "engine/overworld/minor_objects.asm", ROMX

HandleMinorObjects:
	ld bc, wMinorObjects
	ld a, 1
.loop
	ldh [hObjectStructIndex], a
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip
	call .HandleMinorObjectAction

.skip
	ld hl, MINOR_OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_MINOR_OBJECTS + 1
	jr nz, .loop
	ret


.HandleMinorObjectAction:
	ld hl, MINOR_OBJECT_TYPE
	add hl, bc
	ld a, [hl]
	ld hl, .MinorObjects
	call CallJumptable

	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [hl]
	and a
	ret z

	ld hl, MINOR_OBJECT_ANIM
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .MinorObjectAnimations
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MinorObjects:
	dw MinorObject_Null
	dw MinorObject_Shadow
	dw MinorObject_Emote
	dw MinorObject_03
	dw MinorObject_04
	dw MinorObject_BoulderDust

.MinorObjectAnimations:
	dw MinorObjectAnim_Null
	dw MinorObjectAnim_Shadow
	dw MinorObjectAnim_Emote
	dw MinorObjectAnim_03
	dw MinorObjectAnim_BoulderDust

MinorObject_Null:
	ret

MinorObjectAnim_Null:
	ret

DelMinorObject:
	push bc
	ld h, b
	ld l, c
	ld bc, MINOR_OBJECT_LENGTH
	xor a
	call ByteFill
	pop bc
	ret

MinorObject_IncAnonJumptableIndex:
	ld hl, MINOR_OBJECT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

Unreferenced_CallMinorObject_AnonJumptable:
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, MINOR_OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

MinorObject_AnonJumptable:
	ld hl, MINOR_OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	add a
	ld l, a
	ld h, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

MinorObject_GetParentObjectStruct:
	push bc
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [hl]
	dec a
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ret

; Unused, purpose unknown.
; VAR2 => TIMER, VAR3 => X_OFFSET
MinorObject_03:
MinorObject_04:
	ld de, .anon_dw
	jp MinorObject_AnonJumptable

.anon_dw:
	dw .zero
	dw .one

.zero:
	call MinorObject_IncAnonJumptableIndex
	ld hl, MINOR_OBJECT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld [hl], a
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, MINOR_OBJECT_VAR3
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	ld [hl], a

.one:
	jp MinorObject_FollowParentObject

MinorObject_Shadow:
	ld de, .anon_dw
	jp MinorObject_AnonJumptable

.anon_dw:
	dw .zero
	dw .one

.zero:
	call MinorObject_IncAnonJumptableIndex
; Redundant; the player's step duration is already stored to MINOR_OBJECT_VAR2 in SpawnShadow.
	call MinorObject_GetParentObjectStruct
	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld a, [hl]
	add a
	dec a
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld [hl], a
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	ld [hl], 8

.one:
	jp MinorObject_FollowParentObject

; VAR2 => X_OFFSET, VAR3 => Y_OFFSET
MinorObject_BoulderDust:
	ld de, .anon_dw
	jp MinorObject_AnonJumptable

.anon_dw:
	dw .zero
	dw .one

.zero:
	call MinorObject_GetParentObjectStruct
	ld hl, MINOR_OBJECT_ANIM_TIMER
	add hl, de
	ld a, [hl]
	add 1
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld [hl], a
	ld hl, MINOR_OBJECT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, MINOR_OBJECT_VAR3
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, MINOR_OBJECT_VAR1
	add hl, bc
	ldh a, [rOBP1]
	ld [hl], a
	ldh [rOBP1], a

.one:
	jp MinorObject_FollowParentObject

MinorObject_FollowParentObject:
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld a, [hl]
	and a
	jr z, .no_timer
	dec [hl]
	jp z, DelMinorObject
.no_timer
	call MinorObject_GetParentObjectStruct
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld a, [hl]
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	add [hl]
	ld hl, MINOR_OBJECT_X_POS
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld a, [hl]
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	add [hl]
	ld hl, MINOR_OBJECT_Y_POS
	add hl, bc
	ld [hl], a
	ret

; Unused.
MinorObject_Emote:
	ld hl, .anon_dw
	jp MinorObject_AnonJumptable

.anon_dw:
	dw .zero
	dw .one

.zero:
	call MinorObject_IncAnonJumptableIndex
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld [hl], 49
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	ld [hl], 0
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	ld [hl], -16

.one:
	jp MinorObject_FollowParentObject

MinorObjectAnim_Shadow:
	ld hl, MINOR_OBJECT_FRAME
	add hl, bc
	ld [hl], MINOR_OBJECT_SPRITE_SHADOW
	ret

; Unused.
MinorObjectAnim_Emote:
	ld hl, MINOR_OBJECT_TIMER
	add hl, bc
	ld a, [hl]
	cp 48
	ld a, MINOR_OBJECT_SPRITE_EMOTE
	jr c, .visible
	ld a, MINOR_OBJECT_SPRITE_NULL
.visible
	ld hl, MINOR_OBJECT_FRAME
	add hl, bc
	ld [hl], a
	ret

; Unused, purpose unknown.
; VAR1 => FRAME
MinorObjectAnim_03:
	ld hl, MINOR_OBJECT_ANIM_TIMER
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp 5
	jr c, .dont_flip_bit

	xor a
	ld [hl], a
	ld hl, MINOR_OBJECT_08
	add hl, bc
	ld a, [hl]
	xor 1
	ld [hl], a
.dont_flip_bit
	ld hl, MINOR_OBJECT_08
	add hl, bc
	ld a, 0
	bit 0, [hl]
	jr z, .set_frame_null

	ld hl, MINOR_OBJECT_VAR1
	add hl, bc
	ld a, [hl]
.set_frame_null
	ld hl, MINOR_OBJECT_FRAME
	add hl, bc
	ld [hl], a
	ret

MinorObjectAnim_BoulderDust:
	ld hl, MINOR_OBJECT_ANIM_TIMER
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp 3
	ld a, MINOR_OBJECT_SPRITE_BOULDER_DUST_1
	jr nz, .dont_flip
	xor a
	ld [hl], a
	ld a, MINOR_OBJECT_SPRITE_BOULDER_DUST_2
.dont_flip
	ld hl, MINOR_OBJECT_FRAME
	add hl, bc
	ld [hl], a
	ret

INCLUDE "data/sprites/minor_object_sprites.inc"
