INCLUDE "constants.asm"

SECTION "home/map_objects.asm", ROM0

SpawnPlayer::
	callfar _SpawnPlayer
	ret

GetMapObject::
	ld hl, wMapObjects
	ld bc, MAPOBJECT_LENGTH
	call AddNTimes
	ld b, h
	ld c, l
	ret

GetMapObjectAttrPtr::
	call GetMapObject
	ld d, $0
	add hl, de
	ret

Unreferenced_Function15d1::
	ldh [hMapObjectIndex], a
	call GetMapObject
	call OpenDebugMenu
	ret

Unreferenced_Function15da::
	ldh [hMapObjectIndex], a
	callfar UnmaskObject
	ldh a, [hMapObjectIndex]
	call GetMapObject
	call OpenDebugMenu
	ret

CopyMapObjectToReservedObjectStruct::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld a, UNKNOWN_STRUCT
	ldh [hObjectStructIndex], a
	ld de, wReservedObjectStruct
	callfar CopyMapObjectToObjectStruct
	ret

CopyMapObjectToFollowerObjectStruct::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld a, FOLLOWER_STRUCT
	ldh [hObjectStructIndex], a
	ld de, wObject1Struct
	callfar CopyMapObjectToObjectStruct
	ret

ApplyDeletionToMapObject::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	ld [hl], -1
	push af
	ld d, a
	ld a, [wObjectFollow_Leader]
	cp d
	jr nz, .not_leader
	ld a, -1
	ld [wObjectFollow_Leader], a
.not_leader
	ld a, [wObjectFollow_Follower]
	cp d
	jr nz, .not_follower
	ld a, 0
	ld [wObjectFollow_Follower], a
.not_follower
	pop af
	call GetObjectStruct
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	ret

DeleteObjectStruct::
	call ApplyDeletionToMapObject
	callfar MaskObject
	ret

CopyPlayerObjectTemplate::
	push hl
	call GetMapObject
	ld d, b
	ld e, c
	ld a, -1
	ld [de], a
	inc de
	pop hl
	ld bc, MAP_OBJECT_TEMPLATE_LENGTH
	call CopyBytes
	ret

Spawn_ConvertCoords::
	call GetMapObject
	ld a, [wXCoord]
	add 4
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], a
	ld a, [wYCoord]
	add 4
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], a
	ret

; Unreferenced
RelocateMapObjectToStruct::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	ldh a, [hMapObjectIndex]
	call GetMapObject
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], d
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], e
	and a
	ret

DeleteMapObject::
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	push af
	ld [hl], -1
	inc hl
	ld bc, MAPOBJECT_LENGTH - 1
	xor a
	call ByteFill
	pop af
	cp -1
	ret z
	cp NUM_OBJECT_STRUCTS
	ret nc
	ld b, a
	ld a, [wObjectFollow_Leader]
	cp b
	jr nz, .not_leader
	ld a, -1
	ld [wObjectFollow_Leader], a
.not_leader:
	ld a, b
	call GetObjectStruct
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	ret

LoadMovementDataPointer::
	ld [wMovementObject], a
	ldh a, [hROMBank]
	ld [wMovementDataBank], a
	ld a, l
	ld [wMovementDataAddr], a
	ld a, h
	ld [wMovementDataAddr + 1], a
	ld a, [wMovementObject]
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], SPRITEMOVEFN_SCRIPTED
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ld hl, wStateFlags
	set SCRIPTED_MOVEMENT_STATE_F, [hl]
	and a
	ret

LoadMovementDataPointer_KeepStateFlags::
	ld [wMovementObject], a
	ldh a, [hROMBank]
	ld [wMovementDataBank], a
	ld a, l
	ld [wMovementDataAddr], a
	ld a, h
	ld [wMovementDataAddr + 1], a
	ld a, [wMovementObject]
	call CheckObjectVisibility
	jr c, .return ; as opposed to just "ret c"?

	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], SPRITEMOVEFN_SCRIPTED
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET

.return
	ret

CheckObjectVisibility::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .not_visible
	ldh [hObjectStructIndex], a
	call GetObjectStruct
	and a
	ret

.not_visible:
	scf
	ret

; Spawns a minor object attached to the object currently in hMapObjectIndex.
; 'de' is a table containing initialization values in the following order:
; Type, animation, vTiles offset, variables 1-3.
SpawnMinorObject::
	push de
	call GetMinorObjectEmptySlot
	pop de
	ret c
	ld b, h
	ld c, l
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_TYPE
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_ANIM
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_SPRITE_TILE
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_VAR1
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_VAR2
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, MINOR_OBJECT_VAR3
	add hl, bc
	ld [hl], a
	ldh a, [hMapObjectIndex]
	inc a
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld [hl], a
	push bc
	dec a
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld a, [hl]
	ld hl, MINOR_OBJECT_X_POS
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld a, [hl]
	ld hl, MINOR_OBJECT_Y_POS
	add hl, bc
	ld [hl], a
	ret

GetMinorObjectEmptySlot::
	ld hl, wMinorObjects
	ld de, MINOR_OBJECT_LENGTH
	ld a, 1
.loop
	ldh [hObjectStructIndex], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_MINOR_OBJECTS + 1
	jr nz, .loop
	scf
	ret

.done
	xor a
	ret

UpdateSprites::
	ld a, [wStateFlags]
	bit SPRITE_UPDATES_DISABLED_F, a
	ret z
	callfar UpdateAllObjectsFrozen
	callfar InitSprites
	ret

GetObjectStruct::
; Puts the start of the a'th object struct into bc
	ld bc, OBJECT_LENGTH
	ld hl, wObjectStructs
	call AddNTimes
	ld b, h
	ld c, l
	ret

; Unreferenced
Cosine::
; a = d * cos(a * pi/32)
	add %010000 ; cos(x) = sin(x + pi/2)
	; fallthrough
Sine::
	ld e, a
	homecall _Sine
	ret

; sets carry flag if the sprite data includes "in-motion" sprites
IsAnimatedSprite::
	push hl
	push bc
	ld c, a
	ld b, -1
	ld hl, .NonAnimatedSprites
.loop
	ld a, [hli]
	cp b
	jr z, .done
	cp c
	jr nz, .loop
	scf
.done
	pop bc
	pop hl
	ret

.NonAnimatedSprites:
	db SPRITE_SNORLAX
	db SPRITE_POKE_BALL
	db SPRITE_POKEDEX
	db SPRITE_PAPER
	db SPRITE_OLD_LINK_RECEPTIONIST
	db SPRITE_EGG
	db SPRITE_BOULDER
	db -1

FreezeAllOtherObjects::
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	call GetObjectStruct
	push bc
	call FreezeAllObjects
	pop bc
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	ret

; Unreferenced
FreezeObject::
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
	ret

FreezeAllObjects::
	ld bc, wObjectStructs
	xor a
.loop
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

UnfreezeAllObjects::
	push bc
	ld bc, wObjectStructs
	xor a
.loop
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	pop bc
	ret

UnfreezeObject::
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	ret z

	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res FROZEN_F, [hl]
	ret

; Iterates through a dba function table at 'hl' that is 16 entries long. 
Unreferenced_FarCallLoop::
	xor a
.loop
	push af
	push hl
	ld b, a
	ldh a, [hROMBank]
	push af
	ld c, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, c
	call Bankswitch
	ld a, b
	call ._hl_
	pop af
	call Bankswitch
	pop hl
	pop af
	inc a
	cp 16
	jr nz, .loop
	ret

._hl_:
	jp hl

LoadMinorObjectGFX::
	ld a, [wQueuedMinorObjectGFX]
	and a
	ret z
	homecall _LoadMinorObjectGFX
	ret

FreezePlayer::
	ld bc, wPlayerStruct
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set SLIDING_F, [hl]
	set FIXED_FACING_F, [hl]
	set WONT_DELETE_F, [hl]
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set FROZEN_F, [hl]
	call ForceObjectToFaceDirection
	ret

UnfreezePlayer::
	ld hl, wPlayerFlags
	res SLIDING_F, [hl]
	res FIXED_FACING_F, [hl]
	res WONT_DELETE_F, [hl]
	ld hl, wPlayerFlags + 1
	res FROZEN_F, [hl]
	ld hl, wPlayerMovementType
	ld [hl], SPRITEMOVEFN_OBEY_DPAD
	ld hl, wPlayerStepType
	ld [hl], STEP_TYPE_RESET
	ret

; Freezes object at 'bc' by making its movement function force it to keep facing the same direction.
ForceObjectToFaceDirection::
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	srl a
	srl a
	maskbits NUM_DIRECTIONS
	ld e, a
	ld d, 0
	ld hl, .Data
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ret

.Data:
	db SPRITEMOVEFN_TURN_DOWN
	db SPRITEMOVEFN_TURN_UP
	db SPRITEMOVEFN_TURN_LEFT
	db SPRITEMOVEFN_TURN_RIGHT

CenterObject::
	call CheckObjectVisibility
	ret c
	push bc
	call .ClearCenteredObject
	pop bc
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set CENTERED_OBJECT_F, [hl]
	ldh a, [hObjectStructIndex]
	ld [wCenteredObject], a
	ret

.ClearCenteredObject:
	ld a, [wCenteredObject]
	cp -1
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res CENTERED_OBJECT_F, [hl]
	ld a, -1
	ld [wCenteredObject], a
	ret

StartFollow::
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ld a, c
	call SetFollowerIfVisible
	callfar QueueFollowerFirstStep
	ret

SetLeaderIfVisible::
	call CheckObjectVisibility
	ret c
	ldh a, [hObjectStructIndex]
	ld [wObjectFollow_Leader], a
	ret

ResetLeader::
	xor a
	ld [wObjectFollow_Leader], a
	ret

SetFollowerIfVisible::
	push af
	call ResetFollower
	pop af
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], SPRITEMOVEFN_FOLLOW_2
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_RESET
	ldh a, [hObjectStructIndex]
	ld [wObjectFollow_Follower], a
	ret

ResetFollower::
	ld a, [wObjectFollow_Follower]
	and a
	ret z
	cp -1
	ret z
	call GetObjectStruct
	call ForceObjectToFaceDirection
	ret

ResetObjectLowPriority::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res LOW_PRIORITY_F, [hl]
	ret

SetObjectLowPriority::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set LOW_PRIORITY_F, [hl]
	ret

ObjectUseOBP0::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res USE_OBP1_F, [hl]
	ret

ObjectUseOBP1::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set USE_OBP1_F, [hl]
	ret

SetObjFlags2_7_IfVisible::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OBJ_FLAGS2_7_F, [hl]
	ret

ResetObjFlags2_7_IfVisible::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OBJ_FLAGS2_7_F, [hl]
	ret

SetObjectFacing::
	; a is NPC number, d is direction
	push de
	call CheckObjectVisibility
	pop de
	ret c
	ld a, d
	add a
	add a
	and %00001100
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	ret
