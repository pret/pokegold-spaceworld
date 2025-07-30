INCLUDE "constants.asm"

SECTION "engine/overworld/player_object.asm", ROMX

_SpawnPlayer::
	ld a, PLAYER
	ld hl, PlayerObjectTemplate
	call CopyPlayerObjectTemplate
	call Spawn_ConvertCoords
	ld a, PLAYER_STRUCT
	ldh [hObjectStructIndex], a
	ld de, wPlayerStruct
	ld a, PLAYER_OBJECT
	ldh [hMapObjectIndex], a
	ld bc, wMapObjects
	call CopyMapObjectToObjectStruct
	ld a, PLAYER_OBJECT
	call CenterObject
	ret

PlayerObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, SPRITEMOVEFN_OBEY_DPAD, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

SpawnFollower::
	call SetFollowerDefaultAttributes
	ld a, [wUsedSprites + 1]
	ld [wMap1ObjectSprite], a
	ld a, FOLLOWER
	call CopyMapObjectToFollowerObjectStruct
	ld b, PLAYER
	ld c, FOLLOWER
	call StartFollow
	ret

SetFollowerDefaultAttributes::
	ld a, FOLLOWER
	ld hl, FollowerObjectTemplate
	call CopyPlayerObjectTemplate
	ld a, [wPlayerMapX]
	ld [wMap1ObjectXCoord], a
	ld a, [wPlayerMapY]
	dec a
	ld [wMap1ObjectYCoord], a
	ret

FollowerObjectTemplate:
	object_event -4, -4, SPRITE_RHYDON, SPRITEMOVEFN_FOLLOW_2, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

DeleteFollower::
	ld a, FOLLOWER
	call DeleteMapObject
	xor a
	ld [wObjectFollow_Follower], a
	ld a, -1
	ld [wObjectFollow_Leader], a
	ret

DebugMapViewer_SetupCursor::
	ld a, MAP_VIEWER_CURSOR ; Temporarily overwrites the follower's map object
	ld hl, .CursorObjectTemplate
	call CopyPlayerObjectTemplate
	ld a, MAP_VIEWER_CURSOR
	call Spawn_ConvertCoords
	ret

.CursorObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, $17, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

_InitializeVisibleSprites::
	ld bc, wMap2Object
	ld a, 2
.loop
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next

	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub d
	jr c, .next

	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next

	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next

	push bc
	call CopyObjectStruct
	pop bc
	jp c, .ret

.next
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.ret:
	ret

CopyObjectStruct::
	call CheckObjectMask
	and a
	ret nz ; masked

	ld hl, wObjectStructs + OBJECT_LENGTH * 3
	ld a, 3
	ld de, OBJECT_LENGTH
.loop
	ldh [hObjectStructIndex], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	scf
	ret ; overflow

.done
	ld d, h
	ld e, l
	call CopyMapObjectToObjectStruct
	ld a, [wStateFlags]
	bit SCRIPTED_MOVEMENT_STATE_F, a
	ret z

	ld hl, OBJECT_FLAGS2
	add hl, de
	set FROZEN_F, [hl]
	ret

CheckObjectMask::
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld a, [hl]
	ret

MaskObject::
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], -1 ; masked
	ret

UnmaskObject::
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], 0 ; unmasked
	ret

CopyMapObjectToObjectStruct::
	ldh a, [hMapObjectIndex]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld [hl], a

	ldh a, [hObjectStructIndex]
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
	add hl, de
	ld [hl], $00

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_INIT_Y
	add hl, de
	ld [hl], a

	ld hl, OBJECT_MAP_Y
	add hl, de
	ld [hl], a
	ld hl, wYCoord
	sub [hl]
	and $f
	swap a
	ld hl, OBJECT_SPRITE_Y
	add hl, de
	ld [hl], a

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_INIT_X
	add hl, de
	ld [hl], a

	ld hl, OBJECT_MAP_X
	add hl, de
	ld [hl], a
	ld hl, wXCoord
	sub [hl]
	and $f
	swap a
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld [hl], a

	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, de
	ld [hl], a

	call InitObjectFlags

	ld hl, OBJECT_FACING
	add hl, de
	ld [hl], -1

	ld hl, OBJECT_ACTION
	add hl, de
	ld [hl], 0

	ld hl, OBJECT_DIRECTION
	add hl, de
	ld [hl], 0

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld [hl], a

	call GetSpriteVTile
	ld hl, OBJECT_SPRITE_TILE
	add hl, de
	ld [hl], a

	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	call CopyMapObject_Radius

	ld hl, MAPOBJECT_SCRIPT_POINTER + 1
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_21
	add hl, de
	ld [hl], a
	and a
	ret

InitObjectFlags::
	ld hl, OBJECT_FLAGS1
	add hl, de
	ld [hl], COLLISION_OBJS | NOCLIP_NOT_SET | COLLISION_TILES
	ldh a, [hObjectStructIndex]
	push hl
	ld hl, wCenteredObject
	cp [hl]
	pop hl
	jr nz, .not_centered
	set CENTERED_OBJECT_F, [hl]

.not_centered
	cp PLAYER_OBJECT_INDEX
	jr z, .wont_delete
	cp FOLLOWER_OBJECT_INDEX
	jr nz, .will_delete

.wont_delete
	set WONT_DELETE_F, [hl]
.will_delete
	ld hl, OBJECT_FLAGS2
	add hl, de
	ld [hl], 0
	ldh a, [hObjectStructIndex]
	cp PLAYER_OBJECT_INDEX
	ret z
	set COLLISION_TILES_F, [hl]
	ret

CopyMapObject_Radius:
	push af
	swap a
	and $f
	inc a
	ld hl, OBJECT_RADIUS_X
	add hl, de
	ld [hl], a
	pop af
	and $f
	inc a
	ld hl, OBJECT_RADIUS_Y
	add hl, de
	ld [hl], a
	ret

GetSpriteVTile:
	push af
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT
	jr nz, .not_player
	pop af
	ld a, $0 ; offset of player tiles
	ret
.not_player
	cp FOLLOWER
	jr nz, .not_follower
	pop af
	ld a, $c ; offset of follower's tiles
	ret

.not_follower
	pop af
	push hl
	push de
	ld d, a
	ld e, 0
	ld hl, wUsedSprites + 2
.loop
	ld a, [hli]
	cp d
	jr z, .found

	inc e
	ld a, e
	cp SPRITE_GFX_LIST_CAPACITY - 2
	jr nz, .loop
	ld a, 0
	scf
	jr .done

.found
	ld hl, .VTileOffsets
	ld d, $00
	add hl, de
	ld a, [hl]
.done
	pop de
	pop hl
	ret

.VTileOffsets:
	db $18, $24, $30, $3c, $48, $54, $60, $6c, $78, $7c

CheckObjectEnteringVisibleRange::
	nop
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	jp CallJumptable

.dw:
	dw CheckVisibleRange_Down
	dw CheckVisibleRange_Up
	dw CheckVisibleRange_Left
	dw CheckVisibleRange_Right

EmptyFunction8261:
	ret

Unreferenced_CheckObjectEnteringVisibleRange_Alternate::
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	jp CallJumptable

.dw:
	dw CheckVisibleRange_DownAlt
	dw CheckVisibleRange_UpAlt
	dw CheckVisibleRange_LeftAlt
	dw CheckVisibleRange_RightAlt

CheckVisibleRange_UpAlt:
	ld a, [wYCoord]
	sub 2
	jr CheckVisibleRange_Vertical

CheckVisibleRange_DownAlt:
	ld a, [wYCoord]
	add 10
	jr CheckVisibleRange_Vertical

CheckVisibleRange_LeftAlt:
	ld a, [wXCoord]
	sub 2
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_RightAlt:
	ld a, [wXCoord]
	add 11
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_Up::
	ld a, [wYCoord]
	sub 1
	jr CheckVisibleRange_Vertical

CheckVisibleRange_Down::
	ld a, [wYCoord]
	add 9
CheckVisibleRange_Vertical::
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld bc, wMap2Object
	ld a, 2
.loop_v
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_v

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, d
	cp [hl]
	jr nz, .next_v

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_v

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next_v

	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next_v

	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de
.next_v
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_v
	ret

CheckVisibleRange_Left::
	ld a, [wXCoord]
	sub 1
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_Right::
	ld a, [wXCoord]
	add 10
CheckVisibleRange_Horizontal::
	ld e, a
	ld a, [wYCoord]
	ld d, a
	ld bc, wMap2Object
	ld a, 2
.loop_h
	ldh [hConnectionStripLength], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_h

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, e
	cp [hl]
	jr nz, .next_h

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_h

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add $01
	sub d
	jr c, .next_h

	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next_h

	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de
.next_h
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_h
	ret

; Determines path of object 'b' to map coordinates 'de' at speed 'c'.
; Makes the object invisible for the duration of the path.
ComputeObjectPathToCoords_Invisible::
	ld a, c
	push af
	call InitMovementBuffer
	ld a, movement_hide_object
	call AppendToMovementBuffer

	ld a, b
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .not_loaded

	call GetObjectStruct
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld b, [hl]
	ld c, a
	jr .done

.not_loaded
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld b, [hl]
	ld c, a
.done
	pop af
	call ComputePathToWalkToDestination
	ld a, movement_show_object
	call AppendToMovementBuffer
	ld a, movement_step_end
	call AppendToMovementBuffer
	xor a
	ret

; Determines path of object 'b' to map coordinates 'de' at speed 'c'.
Unreferenced_ComputeObjectPathToCoords::
	call InitMovementBuffer
	push bc
	ld a, b
	call GetMapObject
	ld hl, MAPOBJECTTEMPLATE_SPRITE
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld c, [hl]
	ld b, a
	pop hl
	ld a, l
	call ComputePathToWalkToDestination
	ld a, movement_step_end
	call AppendToMovementBuffer
	ret

; Creates a path from object 'b' to object 'c' in wMovementBuffer at speed 'd'.
; Unlike the final game's TrainerWalkToPlayer, the final step isn't removed, so they walk on top of the target instead of in front.
ObjectWalkToPlayer::
	push de
	call InitMovementBuffer
	pop de
	call .GetPathToPlayer
	ld a, movement_step_end
	call AppendToMovementBuffer
	ret

.GetPathToPlayer:
	push de
	push bc
	ld a, c
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld a, b
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld c, [hl]
	ld b, a
	ld hl, OBJECT_MAP_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, de
	ld e, [hl]
	ld d, a
	pop af
	call ComputePathToWalkToDestination
	ret

SECTION "engine/overworld/player_object.asm@QueueFollowerFirstStep", ROMX

QueueFollowerFirstStep::
	call .QueueFirstStep
	jr c, .same
	ld [wFollowMovementQueue], a
	xor a
	ld [wFollowerMovementQueueLength], a
	ret

.same
	ld a, -1
	ld [wFollowerMovementQueueLength], a
	ret

.QueueFirstStep:
	ld a, [wObjectFollow_Leader]
	call GetObjectStruct
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld a, [wObjectFollow_Follower]
	call GetObjectStruct
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, d
	cp [hl]
	jr z, .check_y
	jr c, .left
	and a
	ld a, movement_step + RIGHT
	ret

.left
	and a
	ld a, movement_step + LEFT
	ret

.check_y
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, e
	cp [hl]
	jr z, .same_xy
	jr c, .up
	and a
	ld a, movement_step + DOWN
	ret
	
.up
	and a
	ld a, movement_step + UP
	ret

.same_xy
	scf
	ret

; a = d * sin(e * pi/32)
_Sine::
	ld a, e
	calc_sine_wave
