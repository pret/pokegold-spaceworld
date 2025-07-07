INCLUDE "constants.asm"

SECTION "engine/overworld/map_objects.asm", ROMX

HandleStepTypeAndAction:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .not_zero
	call StepFunction_Reset
.not_zero
	ld e, a
	ld d, 0
	ld hl, HandleObjectAction
	push hl
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit FROZEN_F, [hl]
	jp nz, .Frozen
	ld hl, .StepTypesJumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

; entries correspond to STEP_TYPE_* constants (see constants/map_object_constants.asm)
.StepTypesJumptable:
	dw StepFunction_Reset
	dw StepFunction_FromMovement
	dw StepFunction_NPCWalk
	dw StepFunction_Sleep
	dw StepFunction_Standing
	dw StepFunction_PlayerWalk
	dw StepFunction_ContinueWalk
	dw StepFunction_ObeyDPad
	dw StepFunction_Indexed1
	dw StepFunction_Indexed2
	dw StepFunction_Follow1
	dw StepFunction_0b_0e
	dw StepFunction_0b_0e
	dw StepFunction_0b_0e
	dw StepFunction_0b_0e
	dw StepFunction_NPCJump
	dw StepFunction_PlayerJump
	dw StepFunction_TeleportFrom
	dw StepFunction_TeleportTo
	dw Stub_StepFunction_13

.Frozen:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ret

HandleObjectAction:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OFF_SCREEN_F, [hl]
	jr nz, SetFacingStanding
	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	ld hl, ObjectActionPointers
	jp CallJumptable

ObjectActionPointers:
	dw SetFacingStanding
	dw SetFacingStepAction
	dw SetFacingCurrent
	dw CounterclockwiseSpinAction

SetFacingStanding:
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], STANDING
	ret

SetFacingStepAction:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit SLIDING_F, [hl]
	jr nz, SetFacingCurrent

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit FROZEN_F, [hl]
	jr nz, SetFacingCurrent

	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	inc a
	and %00001111
	ld [hl], a

	rrca
	rrca
	maskbits NUM_DIRECTIONS
	ld d, a

	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	and %00001100
	or d
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

SetFacingCurrent:
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	and %00001100
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

; Here, OBJECT_STEP_FRAME consists of two 2-bit components,
; using only Bits 0-1 and 4-5.
; Bits 0-1 is a timer (4 overworld frames).
; Bits 4-5 determines the facing - the direction is counterclockwise.
CounterclockwiseSpinAction:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld a, [hl]
	and %11110000
	ld e, a

	ld a, [hl]
	inc a
	and %00001111
	ld d, a
	cp 4
	jr c, .ok

	ld d, 0
	ld a, e
	add $10
	and %00110000
	ld e, a

.ok
	ld a, d
	or e
	ld [hl], a

	swap e
	ld d, 0
	ld hl, .facings
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
	ret

.facings:
	db OW_DOWN
	db OW_RIGHT
	db OW_UP
	db OW_LEFT

CopyCoordsTileToLastCoordsTile:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_LAST_TILE
	add hl, bc
	ld [hl], a
	call SetTallGrassFlags
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld a, [hl]
	call ResetObjFlags2_7
	ret

CopyLastCoordsToCoords:
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], a
	ret

UpdateTallGrassFlags:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit OVERHEAD_F, [hl]
	jr z, .ok

	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld a, [hl]
	call SetTallGrassFlags

.ok
	nop
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld a, [hl]
	call ResetObjFlags2_7
	ret c
	ld hl, OBJECT_LAST_TILE
	add hl, bc
	ld a, [hl]
	call ResetObjFlags2_7
	ret

; This entire function was blanked out for the final game. See 'UselessAndA' in pokegold.
ResetObjFlags2_7:
; This comparison is pointless because the instructions below it have been nop'd out.
	and COLLISION_TYPE_MASK
	cp HI_NYBBLE_WARPS
	nop
	nop

	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OBJ_FLAGS2_7_F, [hl]
	and a
	ret

; Unused
SetObjFlags2_7:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OBJ_FLAGS2_7_F, [hl]
	scf
	ret

SetTallGrassFlags:
	call CheckGrassTile
	jr c, .reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OVERHEAD_F, [hl]
	ret

.reset
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ret

CheckGrassTile:
	ld d, a
	and $f0
	cp HI_NYBBLE_TALL_GRASS
	jr z, .grass
	cp HI_NYBBLE_WATER
	jr z, .water
	scf
	ret

.grass
	ld a, d
	and LO_NYBBLE_GRASS
	ret z
	scf
	ret
; For some reason, the above code is duplicated down here.
.water
	ld a, d
	and LO_NYBBLE_GRASS
	ret z
	scf
	ret

EndSpriteMovement:
	xor a
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

InitStep:
	and %00001111
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit FIXED_FACING_F, [hl]
	jr nz, GetNextTile

	ld hl, OBJECT_DIRECTION
	add hl, bc
	add a
	add a
	and %00001100
	ld [hl], a
	; fallthrough

GetNextTile:
	call GetStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld a, d
	call GetStepVectorSign
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	add [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, e
	call GetStepVectorSign
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	add [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld [hl], a
	ld e, a
	push bc
	call GetCoordTileCollision
	pop bc
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld [hl], a
	ret

AddStepVector:
	call GetStepVector
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

; Return (x, y, duration, speed) in (d, e, a, h).
GetStepVector:
	ld hl, OBJECT_WALKING
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, StepVectors
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ret

GetStepVectorSpeed:
	ld hl, OBJECT_WALKING
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, StepVectors + 3 ; speed
	add hl, de
	ld a, [hl]
	ret

StepVectors:
; x,  y, duration, speed
	; slow
	db  0,  1, 16, 1
	db  0, -1, 16, 1
	db -1,  0, 16, 1
	db  1,  0, 16, 1
	; normal
	db  0,  2,  8, 2
	db  0, -2,  8, 2
	db -2,  0,  8, 2
	db  2,  0,  8, 2
	; fast
	db  0,  4,  4, 4
	db  0, -4,  4, 4
	db -4,  0,  4, 4
	db  4,  0,  4, 4
	; even faster!
	db  0,  8,  2, 8
	db  0, -8,  2, 8
	db -8,  0,  2, 8
	db  8,  0,  2, 8

GetStepVectorSign:
	add a
	ret z  ; 0 or 128 (-128)
	ld a, 1
	ret nc ; +1 to +127
	ld a, -1
	ret    ; -127 to -1

UpdatePlayerStep:
	ld hl, OBJECT_WALKING
	add hl, bc
	ld a, [hl]
	maskbits NUM_DIRECTIONS
	ld [wPlayerStepDirection], a
	call GetStepVector
	ld a, d
	ld [wPlayerStepVectorX], a
	ld a, e
	ld [wPlayerStepVectorY], a
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_CONTINUE_F, [hl]
	ret

Unreferenced_GetObjectSpritePos:
	ld a, [wXCoord]
	ld d, a
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	sub d
	and $f
	swap a
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld [hl], a
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	sub e
	and $f
	swap a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld [hl], a
	ret

ClearObjectJumptableIndex:
	ld hl, OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], 0
	ret

Object_IncAnonJumptableIndex:
	ld hl, OBJECT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret

GetObjectJumptableIndex:
	ld hl, OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld a, [hl]
	ret

SetObjectJumptableIndex:
	ld hl, OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

Object_AnonJumptable:
	ld hl, OBJECT_JUMPTABLE_INDEX
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

StepFunction_FromMovement:
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld a, [hl]
	and %00011111
	ld hl, .Pointers
	jp CallJumptable

.Pointers:
	dw MovementFunction_Null
	dw MovementFunction_RandomWalkXY
	dw MovementFunction_RandomSpin
	dw MovementFunction_RandomWalkY
	dw MovementFunction_RandomWalkX
	dw MovementFunction_TurnDown
	dw MovementFunction_TurnUp
	dw MovementFunction_TurnLeft
	dw MovementFunction_TurnRight
	dw NULL
	dw NULL
	dw NULL
	dw NULL
	dw NULL
	dw NULL
	dw NULL
	dw MovementFunction_ObeyDPad
	dw MovementFunction_Indexed1
	dw MovementFunction_Indexed2
	dw MovementFunction_Follow1
	dw MovementFunction_14_17 ; 14
	dw MovementFunction_14_17 ; 15
	dw MovementFunction_14_17 ; 16
	dw MovementFunction_14_17 ; 17
	dw MovementFunction_Follow2
	dw MovementFunction_GetFarMovementData ; 19
	dw Stub_MovementFunction_1a ; 1a

MovementFunction_Null:
	ret

MovementFunction_RandomWalkY:
	call Random
	ldh a, [hRandomAdd]
	and %1
	jp _RandomWalkContinue

MovementFunction_RandomWalkX:
	call Random
	ldh a, [hRandomAdd]
	and %1
	or %10
	jp _RandomWalkContinue

MovementFunction_RandomWalkXY:
	call Random
	ldh a, [hRandomAdd]
	and %11
	jp _RandomWalkContinue

MovementFunction_RandomSpin:
	call Random
	ldh a, [hRandomAdd]
	and %00001100
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	jp RandomSpinContinue

MovementFunction_TurnDown:
	ld a, OW_DOWN
	jr TurnContinue

MovementFunction_TurnUp:
	ld a, OW_UP
	jr TurnContinue

MovementFunction_TurnLeft:
	ld a, OW_LEFT
	jr TurnContinue

MovementFunction_TurnRight:
	ld a, OW_RIGHT
	; fallthrough
TurnContinue:
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	call CopyLastCoordsToCoords
	call EndSpriteMovement
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING
	jp StepFunction_Standing

MovementFunction_ObeyDPad:
StepFunction_ObeyDPad:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_OBEY_DPAD
	jp GetPlayerMovement

MovementFunction_Indexed1:
StepFunction_Indexed1:
	jp GetIndexedMovementIndex1

MovementFunction_Indexed2:
StepFunction_Indexed2:
	jp GetIndexedMovementIndex2

MovementFunction_Follow1:
StepFunction_Follow1:
	jp _GetFollowerNextMovementIndex

MovementFunction_14_17:
StepFunction_0b_0e:
	jp GetMovementObject

MovementFunction_Follow2:
	jp _GetFollowerNextMovementIndex

MovementFunction_GetFarMovementData:
	jp GetFarMovementData

Stub_MovementFunction_1a:
	ret

Stub_StepFunction_13:
	ret

StepFunction_Reset:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTileCollision
	pop bc
	ld hl, OBJECT_TILE_COLLISION
	add hl, bc
	ld [hl], a
	call CopyCoordsTileToLastCoordsTile
	call EndSpriteMovement
	ld a, STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], a
	ret

Unreferenced_RandomWalkContinue_Duplicate:
	call InitStep
	call CanObjectMoveInDirection
	jr c, RandomWalk_NewDuration
	call UpdateTallGrassFlags
	ldh a, [hMapObjectIndex]
	ld d, a
	ld a, [wCenteredObject]
	cp d
	jr z, RandomWalk_Centered
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	jp StepFunction_NPCWalk

_RandomWalkContinue:
	call InitStep
	call CanObjectMoveInDirection
	jr c, RandomWalk_NewDuration
	call UpdateTallGrassFlags
	ldh a, [hConnectionStripLength]
	ld d, a
	ld a, [wCenteredObject]
	cp d
	jr z, RandomWalk_Centered
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_CONTINUE_WALK
	jp StepFunction_ContinueWalk

RandomWalk_Centered:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_PLAYER_WALK
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	jp StepFunction_PlayerWalk

RandomWalk_NewDuration:
	call EndSpriteMovement
	call CopyLastCoordsToCoords

RandomSpinContinue:
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	call Random
	ldh a, [hRandomAdd]
	and $7f
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	jp StepFunction_Sleep

; Unreferenced.
; Runs back and forth every four tiles. If it hits a wall, or NPC, it will continue to try to move in that direction.
; Due to an oversight, OBJECT_MOVEMENT_INDEX is not reset upon loading a room, causing the exact range of the running to be effectively random.
MovementFunction_RunBackAndForth:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld a, [hl]
	and %111
	cp 4
	ld a, STEP_WALK << 2 | RIGHT
	jr nc, .right
	ld a, STEP_WALK << 2 | LEFT
.right
	call InitStep
	call CanObjectMoveInDirection
	jr c, .cant_move
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	inc [hl]
	jp StepFunction_NPCWalk
	
.cant_move
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	call CopyLastCoordsToCoords
	ret

; Unreferenced.
; Makes the NPC turn to face the player in the direction that the player is closer to.
; In situations where Horiz. distance = Vert. distance, vertical directions take priority.
FacePlayerObject:
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, d
	sub [hl]
	ld d, a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	jr z, .lined_up_vertical
	ld a, d
	and a
	jr z, .lined_up_horizontal
	push de
	ld a, d
	call .FlipNegativeToPositive
	ld d, a
	ld a, e
	call .FlipNegativeToPositive
	ld e, a
	cp d
	pop de
	jr nc, .closer_horizontal
.lined_up_vertical
.closer_vertical
	ld a, OW_LEFT
	bit 7, d
	jr nz, .done
	ld a, OW_RIGHT
	jr .done

.lined_up_horizontal
.closer_horizontal
	ld a, OW_UP
	bit 7, e
	jr nz, .done
	ld a, OW_DOWN
.done
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a
	ret

.FlipNegativeToPositive:
	bit 7, a
	ret z
	dec a
	cpl
	ret

Stubbed_UpdateYOffset:
; dummied out
	ret
	ld hl, OBJECT_1E
	add hl, bc
	inc [hl]
	ld a, [hl]
	srl a
	srl a
	and %00000111
	ld l, a
	ld h, 0
	ld de, .y_offsets
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ret

.y_offsets:
	db 0, -1, -2, -3, -4, -3, -2, -1

UpdateJumpPosition:
	call GetStepVectorSpeed
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	ld d, 0
	ld hl, .y_offsets
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT_INDEX
	ret nz
	ldh a, [hJoypadState]
	and D_PAD
	ret z

	ld d, OW_DOWN
	bit D_DOWN_F, a
	jr nz, .got_direction

	ld d, OW_UP
	bit D_UP_F, a
	jr nz, .got_direction

	ld d, OW_LEFT
	bit D_LEFT_F, a
	jr nz, .got_direction

	; D_RIGHT_F
	ld d, OW_RIGHT
.got_direction
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], d
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ret

.y_offsets:
	db  -4,  -5,  -6,  -7
	db  -8,  -9, -10, -11
	db -11, -11, -12, -12
	db -12, -12, -12, -12
	db -11, -11, -10, -10
	db  -9,  -9,  -8,  -8
	db  -6,  -5,  -4,  -2
	db  -1,   0,   0,   0

Movement_teleport_from:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TELEPORT_FROM
	call ClearObjectJumptableIndex

StepFunction_TeleportFrom:
	ld de, .anon_dw
	jp Object_AnonJumptable

.anon_dw:
	dw .InitSpin
	dw .DoSpin
	dw .InitSpinRise
	dw .DoSpinRise

.InitSpin:
	ld hl, OBJECT_1E
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Object_IncAnonJumptableIndex
.DoSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Object_IncAnonJumptableIndex
	ret

.InitSpinRise:
	ld hl, OBJECT_1E
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], 16
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Object_IncAnonJumptableIndex
.DoSpinRise:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	call ClearObjectJumptableIndex
	ret

Movement_teleport_to:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_TELEPORT_TO
	call ClearObjectJumptableIndex

StepFunction_TeleportTo:
	ld de, .anon_dw
	jp Object_AnonJumptable

.anon_dw:
	dw .InitWait
	dw .DoWait
	dw .InitDescent
	dw .DoDescent
	dw .InitFinalSpin
	dw .DoFinalSpin
	dw .FinishStep

.InitWait:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_00
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Object_IncAnonJumptableIndex
	ret

.DoWait:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Object_IncAnonJumptableIndex
.InitDescent:
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_1E
	add hl, bc
	ld [hl], 4
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Object_IncAnonJumptableIndex
	ret

.DoDescent:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Sine
	ld a, h
	sub $60
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Object_IncAnonJumptableIndex
.InitFinalSpin:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], 16
	call Object_IncAnonJumptableIndex
	ret

.DoFinalSpin:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_SPIN
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
.FinishStep:
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_STEP_FRAME
	add hl, bc
	ld [hl], 0
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	ld [hl], 0
	call ClearObjectJumptableIndex
	ret

Unreferenced_Function4b22:
	call ClearObjectJumptableIndex
	; fallthrough
Stub_Function4b25:
	ret

SpawnShadow:
	ld a, MINOR_OBJECT_GFX_SHADOW
	ld [wQueuedMinorObjectGFX], a
	push bc
	ld de, .ShadowObject
	call SpawnMinorObject
	ld d, b
	ld e, c
	pop bc
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld a, [hl]
	add a
	dec a
	ld hl, MINOR_OBJECT_VAR2
	add hl, de
	ld [hl], a
	ret

.ShadowObject:
	db MINOR_OBJECT_TYPE_SHADOW, MINOR_OBJECT_ANIM_SHADOW, $fc, 2, 0, 8

; Unreferenced in this build
SpawnStrengthBoulderDust:
	ld e, a
	add a
	add e
	ld e, a
	ld d, 0
	ld hl, .BoulderDustObject
	add hl, de
	ld d, h
	ld e, l
	push bc
	call SpawnMinorObject
	pop bc
	ld a, MINOR_OBJECT_GFX_BOULDER_DUST
	ld [wQueuedMinorObjectGFX], a
	ret

.BoulderDustObject:
	db MINOR_OBJECT_TYPE_BOULDER_DUST, MINOR_OBJECT_ANIM_BOULDER_DUST, $fc, 2, 2, 8

StepFunction_Sleep:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_Standing:
	call Stubbed_UpdateYOffset
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

StepFunction_NPCWalk:
	call Stubbed_UpdateYOffset
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyCoordsTileToLastCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

StepFunction_ContinueWalk:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	call AddStepVector
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyCoordsTileToLastCoordsTile
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ret

StepFunction_PlayerWalk:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STEP
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call CopyCoordsTileToLastCoordsTile
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

GetPlayerMovement:
	ld a, [wPlayerMovement]
	jp DoMovementFunction

GetMovementObject:
	ld a, [wMovementObject]
	jp DoMovementFunction

GetIndexedMovementIndex1:
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wMovementObject
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	jp DoMovementFunction

GetIndexedMovementIndex2:
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wIndexedMovement2Pointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	jp DoMovementFunction

GetFarMovementData:
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wMovementDataAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [wMovementDataBank]
	call GetFarByte
	jp DoMovementFunction

DoMovementFunction:
	push af
	call ApplyMovementToFollower
	pop af
	ld l, a
	ld h, 0
	add hl, hl
	ld de, MovementPointers
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

MovementPointers:
	dw Movement_turn_head_down ; 0
	dw Movement_turn_head_up ; 1
	dw Movement_turn_head_left ; 2
	dw Movement_turn_head_right ; 3
	dw Movement_slow_step_down ; 4
	dw Movement_slow_step_up ; 5
	dw Movement_slow_step_left ; 6
	dw Movement_slow_step_right ; 7
	dw Movement_step_down ; 8
	dw Movement_step_up ; 9
	dw Movement_step_left ; a
	dw Movement_step_right ; b
	dw Movement_fast_step_down ; c
	dw Movement_fast_step_up ; d
	dw Movement_fast_step_left ; e
	dw Movement_fast_step_right ; f
	dw Movement_fastest_step_down ; 10
	dw Movement_fastest_step_up ; 11
	dw Movement_fastest_step_left ; 12
	dw Movement_fastest_step_right ; 13
	dw Movement_slow_jump_step_down ; 14
	dw Movement_slow_jump_step_up ; 15
	dw Movement_slow_jump_step_left ; 16
	dw Movement_slow_jump_step_right ; 17
	dw Movement_jump_step_down ; 18
	dw Movement_jump_step_up ; 19
	dw Movement_jump_step_left ; 1a
	dw Movement_jump_step_right ; 1b
	dw Movement_fast_jump_step_down ; 1c
	dw Movement_fast_jump_step_up ; 1d
	dw Movement_fast_jump_step_left ; 1e
	dw Movement_fast_jump_step_right ; 1f
	dw Movement_fastest_jump_step_down ; 20
	dw Movement_fastest_jump_step_up ; 21
	dw Movement_fastest_jump_step_left ; 22
	dw Movement_fastest_jump_step_right ; 23
	dw Movement_remove_sliding ; 24
	dw Movement_set_sliding ; 25
	dw Movement_remove_fixed_facing ; 26
	dw Movement_fix_facing ; 27
	dw Movement_show_object ; 28
	dw Movement_hide_object ; 29
	dw Movement_step_sleep_1 ; 2a
	dw Movement_step_sleep_2 ; 2b
	dw Movement_step_sleep_3 ; 2c
	dw Movement_step_sleep_4 ; 2d
	dw Movement_step_sleep_5 ; 2e
	dw Movement_step_sleep_6 ; 2f
	dw Movement_step_sleep_7 ; 30
	dw Movement_step_sleep_8 ; 31
	dw Movement_step_end ; 32
	dw Movement_remove_object ; 33
	dw Movement_step_loop ; 34
	dw Movement_step_stop ; 35
	dw Movement_teleport_from ; 36
	dw Movement_teleport_to ; 37

Movement_step_loop:
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld [hl], 0
	jp StepFunction_FromMovement

Movement_step_end:
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .get_map_object
	ld a, SPRITEMOVEFN_TURN_DOWN
	jr .ok

.get_map_object
	push bc
	call GetMapObject
	ld hl, MAPOBJECT_MOVEMENT
	add hl, bc
	ld a, [hl]
	pop bc
.ok
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	ld hl, OBJECT_MOVEMENT_INDEX
	add hl, bc
	ld [hl], 0
	ld hl, wStateFlags
	res SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret

Movement_remove_object:
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	pop af
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], -1
	pop bc
	ld hl, wObjectFollow_Leader
	ldh a, [hMapObjectIndex]
	cp [hl]
	jr nz, .not_leading
	ld [hl], -1
.not_leading
	ld hl, wStateFlags
	res SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret

Movement_step_stop:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING

	ld hl, wStateFlags
	res SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret

Movement_step_sleep_1:
	ld a, 1
	jr Movement_step_sleep_common

Movement_step_sleep_2:
	ld a, 2
	jr Movement_step_sleep_common

Movement_step_sleep_3:
	ld a, 3
	jr Movement_step_sleep_common

Movement_step_sleep_4:
	ld a, 4
	jr Movement_step_sleep_common

Movement_step_sleep_5:
	ld a, 5
	jr Movement_step_sleep_common

Movement_step_sleep_6:
	ld a, 6
	jr Movement_step_sleep_common

Movement_step_sleep_7:
	ld a, 7
	jr Movement_step_sleep_common

Movement_step_sleep_8:
	ld a, 8

Movement_step_sleep_common:
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_SLEEP
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	jp StepFunction_Sleep

Movement_remove_sliding:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res SLIDING_F, [hl]
	jp StepFunction_FromMovement

Movement_set_sliding:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set SLIDING_F, [hl]
	jp StepFunction_FromMovement

Movement_remove_fixed_facing:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res FIXED_FACING_F, [hl]
	jp StepFunction_FromMovement

Movement_fix_facing:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set FIXED_FACING_F, [hl]
	jp StepFunction_FromMovement

; LIKELY A BUG: Should be resetting/setting bits in OBJECT_FLAGS1, not OBJECT_FLAGS2.
Movement_show_object:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res INVISIBLE_F, [hl]
	jp StepFunction_FromMovement

Movement_hide_object:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set INVISIBLE_F, [hl]
	jp StepFunction_FromMovement

Movement_turn_head_down:
	ld a, OW_DOWN
	jr TurnHead

Movement_turn_head_up:
	ld a, OW_UP
	jr TurnHead

Movement_turn_head_left:
	ld a, OW_LEFT
	jr TurnHead

Movement_turn_head_right:
	ld a, OW_RIGHT
	jr TurnHead

TurnHead:
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], STANDING
	ret

Movement_slow_step_down:
	ld a, STEP_SLOW << 2 | DOWN
	jp NormalStep

Movement_slow_step_up:
	ld a, STEP_SLOW << 2 | UP
	jp NormalStep

Movement_slow_step_left:
	ld a, STEP_SLOW << 2 | LEFT
	jp NormalStep

Movement_slow_step_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jp NormalStep

Movement_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jp NormalStep

Movement_step_up:
	ld a, STEP_WALK << 2 | UP
	jp NormalStep

Movement_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jp NormalStep

Movement_step_right:
	ld a, STEP_WALK << 2 | RIGHT
	jp NormalStep

Movement_fast_step_down:
	ld a, STEP_BIKE << 2 | DOWN
	jp NormalStep

Movement_fast_step_up:
	ld a, STEP_BIKE << 2 | UP
	jp NormalStep

Movement_fast_step_left:
	ld a, STEP_BIKE << 2 | LEFT
	jp NormalStep

Movement_fast_step_right:
	ld a, STEP_BIKE << 2 | RIGHT
	jp NormalStep

Movement_fastest_step_down:
	ld a, STEP_FASTEST << 2 | DOWN
	jp NormalStep

Movement_fastest_step_up:
	ld a, STEP_FASTEST << 2 | UP
	jp NormalStep

Movement_fastest_step_left:
	ld a, STEP_FASTEST << 2 | LEFT
	jp NormalStep

Movement_fastest_step_right:
	ld a, STEP_FASTEST << 2 | RIGHT
	jp NormalStep

Movement_slow_jump_step_down:
	ld a, STEP_SLOW << 2 | DOWN
	jp JumpStep

Movement_slow_jump_step_up:
	ld a, STEP_SLOW << 2 | UP
	jp JumpStep

Movement_slow_jump_step_left:
	ld a, STEP_SLOW << 2 | LEFT
	jp JumpStep

Movement_slow_jump_step_right:
	ld a, STEP_SLOW << 2 | RIGHT
	jp JumpStep

Movement_jump_step_down:
	ld a, STEP_WALK << 2 | DOWN
	jp JumpStep

Movement_jump_step_up:
	ld a, STEP_WALK << 2 | UP
	jp JumpStep

Movement_jump_step_left:
	ld a, STEP_WALK << 2 | LEFT
	jp JumpStep

Movement_jump_step_right:
	ld a, STEP_WALK << 2 | RIGHT
	jp JumpStep

Movement_fast_jump_step_down:
	ld a, STEP_BIKE << 2 | DOWN
	jp JumpStep

Movement_fast_jump_step_up:
	ld a, STEP_BIKE << 2 | UP
	jp JumpStep

Movement_fast_jump_step_left:
	ld a, STEP_BIKE << 2 | LEFT
	jp JumpStep

Movement_fast_jump_step_right:
	ld a, STEP_BIKE << 2 | RIGHT
	jp JumpStep

Movement_fastest_jump_step_down:
	ld a, STEP_FASTEST << 2 | DOWN
	jp JumpStep

Movement_fastest_jump_step_up:
	ld a, STEP_FASTEST << 2 | UP
	jp JumpStep

Movement_fastest_jump_step_left:
	ld a, STEP_FASTEST << 2 | LEFT
	jp JumpStep

Movement_fastest_jump_step_right:
	ld a, STEP_FASTEST << 2 | RIGHT
	jp JumpStep

NormalStep:
	call InitStep
	call UpdateTallGrassFlags
	ld a, [wCenteredObject]
	ld d, a
	ldh a, [hMapObjectIndex]
	cp d
	jr z, .player

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_WALK
	jp StepFunction_NPCWalk

.player
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_PLAYER_WALK
	jp StepFunction_PlayerWalk

JumpStep:
	call InitStep
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], 0

	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]

	call ClearObjectJumptableIndex 
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	call SpawnShadow

	ld a, [wCenteredObject]
	ld d, a
	ldh a, [hMapObjectIndex]
	cp d
	jr z, .player

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_JUMP
	jp StepFunction_NPCJump

.player
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_PLAYER_JUMP
	jp StepFunction_PlayerJump

Unferenced_NPCJumpInit:
	call InitStep
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_NPC_JUMP
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ld hl, OBJECT_JUMP_HEIGHT
	add hl, bc
	ld [hl], 0
	call ClearObjectJumptableIndex
	; fallthrough
StepFunction_NPCJump:
	ld de, .anon_dw
	jp Object_AnonJumptable

.anon_dw
	dw .Jump
	dw .Land

.Jump:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call Object_IncAnonJumptableIndex
	call CopyCoordsTileToLastCoordsTile
	call GetNextTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ret

.Land:
	call AddStepVector
	call UpdateJumpPosition
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	call CopyCoordsTileToLastCoordsTile
	call ClearObjectJumptableIndex
	ret

StepFunction_PlayerJump:
	ld de, .anon_dw
	jp Object_AnonJumptable

.anon_dw
	dw .StepJump
	dw .InitLand
	dw .StepLand

.StepJump
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	call CopyCoordsTileToLastCoordsTile
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OVERHEAD_F, [hl]
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	set PLAYERSTEP_MIDAIR_F, [hl]
	call Object_IncAnonJumptableIndex
	ret

.InitLand
	call GetNextTile
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_START_F, [hl]
	call Object_IncAnonJumptableIndex

.StepLand
	call UpdateJumpPosition
	call UpdatePlayerStep
	ld hl, OBJECT_STEP_DURATION
	add hl, bc
	dec [hl]
	ret nz
	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_FROM_MOVEMENT
	call CopyCoordsTileToLastCoordsTile
	ld hl, wPlayerStepFlags
	set PLAYERSTEP_STOP_F, [hl]
	call ClearObjectJumptableIndex

; Redundant?
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT_INDEX
	jp z, .player
	ret

.player
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	rra
	rra
	maskbits NUM_DIRECTIONS
	ld d, a
	ld hl, OBJECT_WALKING
	add hl, bc
	ld a, [hl]
	maskbits NUM_DIRECTIONS
	cp d
	ret z
	jp Stub_Function4b25

ApplyMovementToFollower:
	ld e, a
	ld a, [wObjectFollow_Follower]
	and a
	ret z
	cp -1
	ret z
	ld a, [wObjectFollow_Leader]
	ld d, a
	ldh a, [hConnectionStripLength]
	cp d
	ret nz
	ld a, e
	cp movement_step_sleep
	ret z
; This whole block could've been:
;	cp movement_turn_head + NUM_DIRECTIONS
;	ret nc
	cp movement_turn_head | DOWN
	ret z
	cp movement_turn_head | UP
	ret z
	cp movement_turn_head | LEFT
	ret z
	cp movement_turn_head | RIGHT
	ret z

	cp movement_step_end
	ret z
	cp movement_step_stop
	ret z
	push af
	ld hl, wFollowerMovementQueueLength
	inc [hl]
	ld e, [hl]
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	pop af
	ld [hl], a
	ret

_GetFollowerNextMovementIndex:
	call GetFollowerNextMovementIndex
	ld hl, MovementPointers
	jp CallJumptable

GetFollowerNextMovementIndex:
	ld hl, wFollowerMovementQueueLength
	ld a, [hl]
	and a
	jr z, .done
	cp -1
	jr z, .done
	ld e, a
	dec [hl]
	ld d, 0
	ld hl, wFollowMovementQueue
	add hl, de
	inc e
	ld a, -1
.loop
	ld d, [hl]
	ld [hld], a
	ld a, d
	dec e
	jr nz, .loop
	ret
.done
	call .CancelFollowIfLeaderMissing
	ret c
	ld a, movement_step_sleep
	ret

.CancelFollowIfLeaderMissing:
	ld a, [wObjectFollow_Leader]
	cp -1
	jr z, .nope
	push bc
	call GetObjectStruct
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	pop bc
	and a
	jr z, .nope
	and a
	ret
.nope
	xor a
	ld [wObjectFollow_Follower], a
	ld a, movement_step_end
	scf
	ret

UpdateAllObjectsFrozen:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done

	ld hl, OBJECT_ACTION
	add hl, bc
	ld a, [hl]
	and a
	ld a, STANDING
	jr z, .next

	push bc
	call .CheckObjectCoveredByTextbox
	pop bc
	ld a, STANDING
	jr c, .next

	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	maskbits NUM_DIRECTIONS, 2
.next
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], a
.done
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

.CheckObjectCoveredByTextbox:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld a, [wXCoord]
	cp d
	jr z, .on_screen_x
	jr nc, .nope
	add $09
	cp d
	jr c, .nope
.on_screen_x
	ld a, [wYCoord]
	cp e
	jr z, .on_screen_y
	jr nc, .nope
	add $08
	cp e
	jr c, .nope
.on_screen_y
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	and %00000111
	ld d, $02
	jr z, .moving_x
	ld d, $03
.moving_x
	ld a, d
	ldh [hCurSpriteHorizTilesOccupied], a
	ld a, [hl]
	srl a
	srl a
	srl a
	ldh [hCurSpriteXCoord], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	and %00000111
	ld e, $02
	jr z, .moving_y
	ld e, $03
.moving_y
	ld a, [hl]
	srl a
	srl a
	srl a
	ldh [hCurSpriteYCoord], a
	ldh a, [hCurSpriteXCoord]
	ld c, a
	ldh a, [hCurSpriteYCoord]
	ld b, a
	call Coord2Tile
	ld bc, OBJECT_INIT_X
.next_row
	push hl
	ldh a, [hCurSpriteHorizTilesOccupied]
	ld d, a
.next_tile
	ld a, [hli]
	cp FIRST_REGULAR_TEXT_CHAR
	jr nc, .covered
	dec d
	jr nz, .next_tile
	pop hl
	add hl, bc
	dec e
	jr nz, .next_row
	and a
	ret

.covered
	pop hl
	jr .nope

.nope
	scf
	ret

HandleNPCStep:
	call ResetStepVector
	call DoStepsForAllObjects
	call HandleMinorObjects
	ret

ResetStepVector:
	xor a
	ld [wPlayerStepVectorX], a
	ld [wPlayerStepVectorY], a
	ld [wPlayerStepFlags], a
	ld a, STANDING
	ld [wPlayerStepDirection], a
	ret

DoStepsForAllObjects:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	call .CheckIfOffScreen
	jr c, .next
	call HandleStepTypeAndAction

.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

.CheckIfOffScreen:
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res OFF_SCREEN_F, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .is_offscreen
	cp (SCREEN_WIDTH / 2) + 2
	jr nc, .is_offscreen
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .is_offscreen
	cp (SCREEN_HEIGHT / 2) + 2
	jr nc, .is_offscreen
	jr .not_offscreen

.is_offscreen
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OFF_SCREEN_F, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .init_pos_offscreen
	cp (SCREEN_WIDTH / 2) + 2
	jr nc, .init_pos_offscreen
	ld a, [wYCoord]
	ld e, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .init_pos_offscreen
	cp (SCREEN_HEIGHT / 2) + 2
	jr nc, .init_pos_offscreen
.not_offscreen
	and a
	ret

.init_pos_offscreen
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT_INDEX
	jr z, .dont_delete
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit WONT_DELETE_F, [hl]
	jr nz, .dont_delete
	call .DeleteMapObject
	scf
	ret
.dont_delete
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set OFF_SCREEN_F, [hl]
	and a
	ret

.DeleteMapObject:
	push bc
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	pop af
	cp -1
	jr z, .ok
	ld hl, wMapObjects
	ld bc, NUM_OBJECTS
	call AddNTimes
	ld bc, OBJECT_SPRITE
	add hl, bc
	ld [hl], -1
.ok
	pop bc
	ret

InitSprites::
	ld a, [wStateFlags]
	bit SPRITE_UPDATES_DISABLED_F, a
	ret z
	xor a
	ldh [hUsedSpriteIndex], a
	call InitObjectSprites
	call InitMinorObjectSprites
	call MoveUnusedObjectSpritesOffscreen
	ret

InitObjectSprites:
	xor a
	ld bc, wObjectStructs
.loop
	push af
	push bc
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jp z, .skip

	ld hl, OBJECT_FLAGS2
	add hl, bc
	bit LOW_PRIORITY_F, [hl]
	jp nz, .skip

	xor a
	bit OBJ_FLAGS2_7_F, [hl]
	jr z, .not_priority
	add PRIORITY
.not_priority
	bit USE_OBP1_F, [hl]
	jr z, .not_obp_num
	add OBP_NUM
.not_obp_num
	ld d, a
	xor a
	bit OVERHEAD_F, [hl]
	jr z, .not_overhead
	or PRIORITY
.not_overhead
	ldh [hCurSpriteOAMFlags], a
	ld hl, OBJECT_SPRITE_TILE
	add hl, bc
	ld a, [hl]
	ldh [hCurSpriteTile], a
	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_X_OFFSET
	add hl, bc
	add [hl]
	add 8
	ldh [hCurSpriteXPixel], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE_Y_OFFSET
	add hl, bc
	add [hl]
	add 16
	ldh [hCurSpriteYPixel], a
	ld hl, OBJECT_FACING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jp z, .skip

	ld l, a
	ld h, 0
	add hl, hl
	ld bc, Facings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hUsedSpriteIndex]
	ld c, a
	ld b, HIGH(wShadowOAM)
.addsprite
	ldh a, [hCurSpriteYPixel]
	add [hl]
	inc hl
	ld [bc], a
	inc c

	ldh a, [hCurSpriteXPixel]
	add [hl]
	inc hl
	ld [bc], a
	inc c

	ldh a, [hCurSpriteTile]
	add [hl]
	inc hl
	ld [bc], a
	inc c

	ld a, [hl]
	bit RELATIVE_ATTRIBUTES_F, a
	jr z, .nope
	ldh a, [hCurSpriteOAMFlags]
	or [hl]
.nope
	inc hl
	or d
	ld [bc], a
	inc c
	bit FACING_DONE_F, a
	jr z, .addsprite
	ld a, c
	ldh [hUsedSpriteIndex], a
.skip
	pop bc
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECT_STRUCTS
	jp nz, .loop
	ret

MoveUnusedObjectSpritesOffscreen:
	ld b, LOW(wShadowOAMEnd)
	ldh a, [hUsedSpriteIndex]
	cp b
	ret nc
	ld l, a
	ld h, HIGH(wShadowOAM)
	ld de, SPRITEOAMSTRUCT_LENGTH
	ld a, b
	ld c, 160
.loop
	ld [hl], c
	add hl, de
	cp l
	jr nz, .loop
	ret

InitMinorObjectSprites:
	ld bc, wMinorObjects
	ld a, NUM_MINOR_OBJECTS
.loop
	push af
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld hl, MINOR_OBJECT_X_POS
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_X_OFFSET
	add hl, bc
	add [hl]
	add 8
	ldh [hCurSpriteXPixel], a
	ld hl, MINOR_OBJECT_Y_POS
	add hl, bc
	ld a, [hl]
	ld hl, MINOR_OBJECT_Y_OFFSET
	add hl, bc
	add [hl]
	add 16
	ldh [hCurSpriteYPixel], a
	ld hl, MINOR_OBJECT_SPRITE_TILE
	add hl, bc
	ld a, [hl]
	ldh [hCurSpriteTile], a
	ld hl, MINOR_OBJECT_FRAME
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld e, a
	ld d, 0
	ld hl, MinorObjectSpriteTiles
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hUsedSpriteIndex]
	ld d, a
	ld a, [hl]
	and a
	jr z, .next

	add a
	add a
	add d
	cp LOW(wShadowOAMEnd)
	jr nc, .done
	ldh a, [hUsedSpriteIndex]
	ld e, a
	ld d, HIGH(wShadowOAM)
	ld a, [hli]
.addsprite
	ldh [hUsedSpriteTile], a
	ldh a, [hCurSpriteYPixel]
	add [hl]
	ld [de], a
	inc hl
	inc de

	ldh a, [hCurSpriteXPixel]
	add [hl]
	ld [de], a
	inc hl
	inc de

	ldh a, [hCurSpriteTile]
	add [hl]
	ld [de], a
	inc hl
	inc de

	ld a, [hli]
	ld [de], a
	inc de

	ldh a, [hUsedSpriteTile]
	dec a
	jr nz, .addsprite
	ld a, e
	ldh [hUsedSpriteIndex], a
.next
	ld hl, MINOR_OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .loop
	ret
.done
	pop af
	ret

PrintSaveScreenNumbers:
	call MenuBoxCoord2Tile
	push hl
	ld de, (SCREEN_WIDTH * 4) + 10
	add hl, de
	call PrintNumBadges
	pop hl
	push hl
	ld de, (SCREEN_WIDTH * 6) + 9
	add hl, de
	call PrintNumOwnedMons
	pop hl
	ld de, (SCREEN_WIDTH * 8) + 8
	add hl, de
	call PrintPlayTime
	ret
