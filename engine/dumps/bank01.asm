INCLUDE "constants.asm"

SECTION "engine/dumps/bank01.asm@SetDemoEventFlags", ROMX

SetDemoEventFlags:
	ld hl, wd41a
	set 5, [hl]
	ld hl, wd41a
	set 7, [hl] ; talked to blue
	ld hl, wd41a
	set 0, [hl] ; read email
	ld hl, wd41a
	set 3, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41e
	set 5, [hl]
	ld hl, wd41b
	set 1, [hl] ; followed oak to back room
	ld hl, wd41c
	set 4, [hl] ; received pokedexes
	ld hl, wd41d
	set 2, [hl] ; beat rival in lab
	ld hl, wd41b
	set 2, [hl] ; chose a starter
	ld a, %1
	ld [wd29a], a
	ld a, %1
	ld [wd29b], a
	ld a, %110
	ld [wd29c], a
	ld a, %10010
	ld [wd29d], a
	ld a, %110
	ld [wd29e], a
	ld a, %10
	ld [wd2a0], a
	ret

SECTION "engine/dumps/bank01.asm@HandleStepTypeAndAction", ROMX

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
	ld hl, wVramState
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
	ld hl, wVramState
	res SCRIPTED_MOVEMENT_STATE_F, [hl]
	ret

Movement_step_stop:
	ld hl, OBJECT_ACTION
	add hl, bc
	ld [hl], OBJECT_ACTION_STAND

	ld hl, OBJECT_STEP_TYPE
	add hl, bc
	ld [hl], STEP_TYPE_STANDING

	ld hl, wVramState
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
	ld a, [wVramState]
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

SECTION "engine/dumps/bank01.asm@ReanchorBGMap_NoOAMUpdate", ROMX

ReanchorBGMap_NoOAMUpdate:
	xor a
	ldh [hLCDCPointer], a
	ld hl, wToolgearFlags
	set 7, [hl] ; hide toolgear
	res 2, [hl] ; transfer toolgear to window
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	xor a
	ldh [hBGMapMode], a
	xor a
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress+1], a
	call LoadMapPart
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	call .Transfer
	xor a ; LOW(vBGMap0)
	ld [wBGMapAnchor], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress+1], a
	ld [wBGMapAnchor+1], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	call WaitBGMap
	ret

.Transfer
	ld a, $60 ; blank tile?
	ld hl, wTileMapBackup
	ld bc, (SCREEN_WIDTH * 6) + 8
	call ByteFill
	ld hl, vBGMap0
	ld c, 8
.loop
	push bc
	push hl
	ld de, wTileMapBackup
	lb bc, BANK(wTileMapBackup), 8
	call Request2bpp
	pop hl
	ld bc, BG_MAP_WIDTH * 4
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

LoadFonts_NoOAMUpdate:
	call UpdateSprites
	call LoadFont
	call LoadFontExtra
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ret


LearnMove:
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NUM_MOVES
; Get the first empty move slot.  This routine also serves to
; determine whether the Pokemon learning the moves already has
; all four slots occupied, in which case one would need to be
; deleted.
.next
	ld a, [hl]
	and a
	jr z, .learn
	inc hl
	dec b
	jr nz, .next
; If we're here, we enter the routine for forgetting a move
; to make room for the new move we're trying to learn.
	push de
	call ForgetMove
	pop de
	jp c, .cancel
	push hl
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	ld hl, Text_1_2_and_Poof
	call PrintText
	pop de
	pop hl
.learn
	ld a, [wPutativeTMHMMove]
	ld [hl], a
	ld bc, MON_PP - MON_MOVES
	add hl, bc

	push hl
	push de
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop hl

	ld [hl], a

	ld a, [wBattleMode]
	and a
	jp z, .learned

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jp nz, .learned

	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, NUM_MOVES
	call CopyBytes
	ld bc, wPartyMon1PP - (wPartyMon1Moves + NUM_MOVES)
	add hl, bc
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
	jp .learned

.cancel
	ld hl, StopLearningMoveText
	call PrintText
	call YesNoBox
	jp c, .loop
	ld hl, DidNotLearnMoveText
	call PrintText
	ld b, 0
	ret
.learned
	ld hl, LearnedMoveText
	call PrintText
	ld b, 1
	ret

ForgetMove::
	push hl
	ld hl, AskForgetMoveText
	call PrintText
	call YesNoBox
	pop hl
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	pop hl
.loop
	push hl
	ld hl, MoveAskForgetText
	call PrintText
	hlcoord 10, 8
	ld b, NUM_MOVES * 2
	ld c, MOVE_NAME_LENGTH + 3
	call DrawTextBox
	hlcoord 12, 10
	ld a, SCREEN_WIDTH * 2
	ld [wListMovesLineSpacing], a
	predef ListMoves
	; w2DMenuData
	ld a, $a
	ld [w2DMenuCursorInitY], a
	ld a, $b
	ld [w2DMenuCursorInitX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld [w2DMenuDataEnd], a
	ld [wMenuCursorX], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, $20 ; enable sprite animations
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	call Get2DMenuJoypad
	push af
	call ReloadTilesFromBuffer
	pop af
	pop hl
	bit B_BUTTON_F, a
	jr nz, .cancel
	push hl
	ld a, [w2DMenuDataEnd]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsHMMove
	pop bc
	pop de
	ld a, d
	jr c, .hmmove
	pop hl
	add hl, bc
	and a
	ret

.hmmove
	ld hl, MoveCantForgetHMText
	call PrintText
	pop hl
	jr .loop
.cancel
	scf
	ret

LearnedMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　あたらしく"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえた！@"
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end

MoveAskForgetText:
	text "どの　わざを"
	next "わすれさせたい？"
	done

StopLearningMoveText:
	text "それでは<⋯⋯>　@"
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえるのを　あきらめますか？"
	done

DidNotLearnMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえずに　おわった！"
	prompt

AskForgetMoveText:
	text_from_ram wMonOrItemNameBuffer
	text "は　あたらしく"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえたい<⋯⋯>！"
	para "しかし　@"
	text_from_ram wMonOrItemNameBuffer
	text "は　わざを　４つ"
	line "おぼえるので　せいいっぱいだ！"
	para "@"
	text_from_ram wStringBuffer2
	text "の　かわりに"
	line "ほかの　わざを　わすれさせますか？"
	done

Text_1_2_and_Poof:
	text "１　２の　<⋯⋯>@"
	text_exit
	start_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, MoveForgotText
	ret

MoveForgotText:
	text "　ポカン！@"
	text_exit
	text ""
	para "@"
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer1
	text "の"
	line "つかいかたを　きれいに　わすれた！"
	para "そして<⋯⋯>！"
	prompt

MoveCantForgetHMText:
	text "それは　たいせつなわざです"
	line "わすれさせることは　できません！"
	prompt

; This function is wildly out of date. It assumes wItemAttributesPointer uses either an early layout,
; or an updated version of Generation I's ItemPrices. The final game stores prices with the rest of
; the ItemAttributes anyway, so this function is pointless now.
; Stores item's price as BCD at hItemPrice (3 bytes).
; Input: [wCurItem] = item id.
GetItemPrice_Old::
	ld hl, wItemAttributesPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurItem]
	cp ITEM_HM01_RED
	jr nc, .get_tm_price

	dec a
	ld c, a
	ld b, 0
rept 4 ; Appears to be an earlier length for ItemAttributes?
	add hl, bc
endr
	inc hl
	ld a, [hld]
	ldh [hItemPrice + 2], a
	ld a, [hld]
	ldh [hItemPrice + 1], a
	ld a, [hl]
	ldh [hItemPrice], a
	jr .done

.get_tm_price
	call GetMachinePrice_Old
.done
	ld de, hItemPrice
	ret

GetMachinePrice_Old:
	ld a, [wCurItem]
	sub ITEM_TM01_RED
	ret c ; HMs are priceless
	ld d, a
	ld hl, TechnicalMachinePrices_Old
	srl a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	srl d
	jr nc, .odd_numbered_machine
	swap a
.odd_numbered_machine
	and $f0
	ldh [hItemPrice + 1], a
	xor a
	ldh [hItemPrice], a
	ldh [hItemPrice + 2], a
	ret

; In thousands (nybbles).
TechnicalMachinePrices_Old:
	nybble_array
	nybble 3 ; TM01
	nybble 2 ; TM02
	nybble 2 ; TM03
	nybble 1 ; TM04
	nybble 3 ; TM05
	nybble 4 ; TM06
	nybble 2 ; TM07
	nybble 4 ; TM08
	nybble 3 ; TM09
	nybble 4 ; TM10
	nybble 2 ; TM11
	nybble 1 ; TM12
	nybble 4 ; TM13
	nybble 5 ; TM14
	nybble 5 ; TM15
	nybble 5 ; TM16
	nybble 3 ; TM17
	nybble 2 ; TM18
	nybble 3 ; TM19
	nybble 2 ; TM20
	nybble 5 ; TM21
	nybble 5 ; TM22
	nybble 5 ; TM23
	nybble 2 ; TM24
	nybble 5 ; TM25
	nybble 4 ; TM26
	nybble 5 ; TM27
	nybble 2 ; TM28
	nybble 4 ; TM29
	nybble 1 ; TM30
	nybble 2 ; TM31
	nybble 1 ; TM32
	nybble 1 ; TM33
	nybble 2 ; TM34
	nybble 4 ; TM35
	nybble 2 ; TM36
	nybble 2 ; TM37
	nybble 5 ; TM38
	nybble 2 ; TM39
	nybble 4 ; TM40
	nybble 2 ; TM41
	nybble 2 ; TM42
	nybble 5 ; TM43
	nybble 2 ; TM44
	nybble 2 ; TM45
	nybble 4 ; TM46
	nybble 3 ; TM47
	nybble 4 ; TM48
	nybble 4 ; TM49
	nybble 2 ; TM50
	end_nybble_array NUM_TMS

; Unused. Also leftover from Generation I.
AskName_Old:
	push hl
	call LoadStandardMenuHeader
	ld a, [wBattleMode]
	dec a
	hlcoord 1, 0
	ld b, 4
	ld c, 10
	call z, ClearBox

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
; Test for being in debug field mode that doesn't go anywhere... maybe the name screen was skipped in debug mode?
	ld a, [wDebugFlags]
	bit 1, a
	pop hl
	push hl
	ld hl, AskGiveNickname_Old
	call PrintText
	call YesNoBox
	pop hl
	jr c, .declined_nickname

	push hl
	ld e, l
	ld d, h
	ld a, BANK(NamingScreen)
	ld b, NAME_MON
	ld hl, NamingScreen
	call FarCall_hl
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld a, [wBattleMode]
	and a
	jr nz, .in_battle
	call LoadFontExtra
	call ReloadSpritesAndFont
	jr .done

.in_battle
	callfar _LoadHPBar
.done
	pop hl
	ld a, [hl]
	cp "@"
	jr nz, .not_terminated ; shouldn't this be the other way around? 'jr z' instead of 'jr nz'?
.declined_nickname
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.not_terminated
	call CloseWindow
	ret

AskGiveNickname_Old:
	text_from_ram wStringBuffer1
	text "に"
	line "ニックネームを　つけますか？"
	done

Unreferenced_DisplayNameRaterScreen:
	ld de, wUnknownNameBuffer
	push de
	ld hl, NamingScreen
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	call FarCall_hl
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	call UpdateTimePals
	pop de
	ld a, [de]
	cp "@"
	jr z, .empty_name
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wUnknownNameBuffer
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	and a
	ret

.empty_name
	scf
	ret

; Replace invalid name characters with question marks, or replaces entire name with "？" if no terminator is found.
; These characters include control characters, kana with diacritics they shouldn't have, and English letter tiles.
CorrectNickErrors:
	push bc
	push de
	ld b, MON_NAME_LENGTH
.checkchar
	ld a, [de]
	cp "@"
	jr z, .end
	ld hl, InvalidNicknameChars
	dec hl
.loop
	inc hl
	ld a, [hl]
	cp -1
	jr z, .done
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .loop
	cp [hl]
	jr nc, .loop
	ld a, "？"
	ld [de], a
	jr .loop

.done
	inc de
	dec b
	jr nz, .checkchar
	pop de
	push de
	ld a, "？"
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
.end
	pop de
	pop bc
	ret

InvalidNicknameChars:
	db "<NULL>",   "オ゛" + 1
	db "<PLAY_G>", "ノ゛" + 1
	db "<NI>",     "<NO>" + 1
	db "<ROUTE>",  "<GREEN>" + 1
	db "<MOM>",    "┘" + 1
	db -1

SECTION "engine/dumps/bank01.asm@CanObjectMoveInDirection", ROMX

CanObjectMoveInDirection:
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit COLLISION_TILES_F, [hl]
	jr z, .noclip_tiles
	push hl
	call _IsObjectCollisionTileSolid
	pop hl
	ret c

.noclip_tiles
	bit COLLISION_OBJS_F, [hl]
	jr z, .noclip_objs
	push hl
	push bc
	call WillObjectBumpIntoSomeoneElse
	pop bc
	pop hl
	ret c

.noclip_objs
	bit NOCLIP_NOT_SET_F, [hl]
	jr z, .move_anywhere
	push hl
	call HasObjectReachedMovementLimit
	pop hl
	ret c
	push hl
	call IsObjectMovingOffEdgeOfScreen
	pop hl
	ret c
.move_anywhere
	and a
	ret

SECTION "engine/dumps/bank01.asm@CheckFacingObject", ROMX

CheckFacingObject:
	call GetFacingTileCoord
	cp COLLISION_COUNTER
	jr z, .counter
	cp COLLISION_COUNTER_98
	jr nz, .not_counter
.counter
	ld a, [wPlayerMapX]
	sub d
	cpl
	inc a
	add d
	ld d, a
	ld a, [wPlayerMapY]
	sub e
	cpl
	inc a
	add e
	ld e, a
.not_counter
	ld bc, wPlayerSprite
	ld a, PLAYER_OBJECT_INDEX
	ldh [hMapObjectIndex], a
	call _CheckObjectCollision
	ret nc
	ld hl, OBJECT_WALKING
	add hl, bc
	ld a, [hl]
	cp STANDING
	jr z, .standing
	xor a
	ret
.standing
	scf
	ret

WillObjectBumpIntoSomeoneElse:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	jr _CheckObjectCollision

IsObjectFacingSomeoneElse:
	ldh a, [hMapObjectIndex]
	call GetObjectStruct
	call .GetFacingCoords
	call _CheckObjectCollision
	ret
.GetFacingCoords
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld a, [hl]
	and %00001100
	and a
	jr z, .down
	
	cp OW_UP
	jr z, .up
	cp OW_LEFT
	jr z, .left
	; OW_RIGHT
	inc d
	ret
.down
	inc e
	ret
.up
	dec e
	ret
.left
	dec d
	ret

SECTION "engine/dumps/bank01.asm@HasObjectReachedMovementLimit", ROMX

HasObjectReachedMovementLimit:
	ld hl, OBJECT_RADIUS_X
	add hl, bc
	ld a, [hl]
	and a
	jr z, .check_y
	ld e, a
	ld d, a
	ld hl, OBJECT_INIT_X
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .yes
	cp e
	jr z, .yes
.check_y
	ld hl, OBJECT_RADIUS_Y
	add hl, bc
	ld a, [hl]
	and a
	jr z, .nope
	ld e, a
	ld d, a
	ld hl, OBJECT_INIT_Y
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .yes
	cp e
	jr z, .yes
.nope
	and a
	ret

.yes
	scf
	ret

IsObjectMovingOffEdgeOfScreen:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [wXCoord]
	cp [hl]
	jr z, .check_y
	jr nc, .yes
	add (SCREEN_WIDTH / 2) - 1
	cp [hl]
	jr c, .yes
.check_y
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [wYCoord]
	cp [hl]
	jr z, .nope
	jr nc, .yes
	add (SCREEN_HEIGHT / 2) - 1
	cp [hl]
	jr c, .yes
.nope
	and a
	ret

.yes
	scf
	ret

SECTION "engine/dumps/bank01.asm@OptionsMenu", ROMX

DEF OPT_TEXT_SPEED_ROW EQU 3
DEF OPT_BATTLE_ANIM_ROW EQU 7
DEF OPT_BATTLE_STYLE_ROW EQU 11
DEF OPT_SOUND_ROW EQU 13
DEF OPT_BOTTOM_ROW EQU 16

OptionsMenu::
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
.ReinitDisplay:
	call DisplayOptionsMenu
.Loop:
	call GetOptionsMenuCursorPos
	ld [hl], "▶"
	call SetOptionsFromCursorPositions
	call WaitBGMap
.wait_joy_loop
	call DelayFrame
	call GetJoypadDebounced
	ldh a, [hJoySum]
	ld b, a
	and a
	jr z, .wait_joy_loop
	ld a, b
	and START | B_BUTTON
	jr nz, .ExitOptions
	ld a, b
	and SELECT
	jr nz, .SwitchSGBBorder
	ld a, b
	and A_BUTTON
	jr z, .CheckDPad

	ld a, [wOptionsMenuCursorY]
	cp OPT_BOTTOM_ROW
	jr nz, .Loop

	ld a, [wOptionsMenuCursorX]
	cp 7
	jr z, .SwitchActiveFrame
.ExitOptions:
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	pop af
	ld [wVramState], a
	ld hl, wd4a9
	bit 0, [hl]
	jp z, TitleSequenceStart
	ret

.SwitchSGBBorder:
	ld hl, wOptions
	ld a, [hl]
	xor (1 << SGB_BORDER)
	ld [hl], a
	callfar UpdateSGBBorder
	call LoadFont
	call LoadFontExtra
	ld c, 112
	call DelayFrames
	jp .ReinitDisplay

.SwitchActiveFrame
	ld a, [wActiveFrame]
	inc a
	and 7
	ld [wActiveFrame], a
	hlcoord 17, 16
	add "１"
	ld [hl], a
	call LoadFontExtra
	jr .Loop

.ClearOldMenuCursor:
	push af
	call GetOptionsMenuCursorPos
	ld [hl], "　"
	pop af
	ld [wOptionsMenuCursorX], a
	jp .Loop

.CheckDPad:
	ld a, [wOptionsMenuCursorY]
	bit D_DOWN_F, b
	jr nz, .down_pressed
	bit D_UP_F, b
	jr nz, .up_pressed

	cp OPT_BATTLE_ANIM_ROW
	jp z, .Cursor_BattleAnimation
	cp OPT_BATTLE_STYLE_ROW
	jp z, .Cursor_BattleStyle
	cp OPT_SOUND_ROW
	jp z, .Cursor_Audio
	cp OPT_BOTTOM_ROW
	jp z, .Cursor_BottomRow

.Cursor_TextSpeed:
	bit D_LEFT_F, b
	jp nz, .text_speed_left
	jp .text_speed_right

.down_pressed
	cp OPT_BOTTOM_ROW
	ld b, OPT_TEXT_SPEED_ROW - OPT_BOTTOM_ROW
	ld hl, wOptionsTextSpeedCursorX
	jr z, .update_cursor

	cp OPT_TEXT_SPEED_ROW
	ld b, OPT_BATTLE_ANIM_ROW - OPT_TEXT_SPEED_ROW
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_ANIM_ROW
	ld b, OPT_BATTLE_STYLE_ROW - OPT_BATTLE_ANIM_ROW
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_STYLE_ROW
	ld b, OPT_SOUND_ROW - OPT_BATTLE_STYLE_ROW
	inc hl ; wOptionsAudioSettingsCursorX
	jr z, .update_cursor

	ld b, OPT_BOTTOM_ROW - OPT_SOUND_ROW
	inc hl ; wOptionsBottomRowCursorX
	jr .update_cursor

.up_pressed
	cp OPT_BATTLE_ANIM_ROW
	ld b, OPT_TEXT_SPEED_ROW - OPT_BATTLE_ANIM_ROW
	ld hl, wOptionsTextSpeedCursorX
	jr z, .update_cursor

	cp OPT_BATTLE_STYLE_ROW
	ld b, OPT_BATTLE_ANIM_ROW - OPT_BATTLE_STYLE_ROW
	inc hl ; wOptionsBattleAnimCursorX
	jr z, .update_cursor

	cp OPT_SOUND_ROW
	ld b, OPT_BATTLE_STYLE_ROW - OPT_SOUND_ROW
	inc hl ; wOptionsBattleStyleCursorX
	jr z, .update_cursor

	cp OPT_BOTTOM_ROW
	ld b, OPT_SOUND_ROW - OPT_BOTTOM_ROW
	inc hl ; wOptionsAudioSettingsCursorX
	jr z, .update_cursor

	ld b, OPT_BOTTOM_ROW - OPT_TEXT_SPEED_ROW
	inc hl ; wOptionsBottomRowCursorX
.update_cursor
	add b
	push af
	ld a, [hl]
	push af
	call GetOptionsMenuCursorPos
	ld [hl], "▷"
	pop af
	ld [wOptionsMenuCursorX], a
	pop af
	ld [wOptionsMenuCursorY], a
	jp .Loop

.text_speed_left
	ld a, [wOptionsTextSpeedCursorX]
	cp 1
	jr z, .update_text_speed
	sub 7
	jr .update_text_speed

.text_speed_right
	ld a, [wOptionsTextSpeedCursorX]
	cp 15
	jr z, .update_text_speed
	add 7
.update_text_speed
	ld [wOptionsTextSpeedCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BattleAnimation:
	ld a, [wOptionsBattleAnimCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsBattleAnimCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BattleStyle:
	ld a, [wOptionsBattleStyleCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsBattleStyleCursorX], a
	jp .ClearOldMenuCursor
	
.Cursor_Audio:
	ld a, [wOptionsAudioSettingsCursorX]
	xor %1011 ; 1 <-> 10
	ld [wOptionsAudioSettingsCursorX], a
	jp .ClearOldMenuCursor

.Cursor_BottomRow:
	call GetOptionsMenuCursorPos
	ld [hl], "▷"
	ld a, [wOptionsMenuCursorX]
	xor %110 ; 1 <-> 7
	ld [wOptionsMenuCursorX], a
	jp .Loop

GetOptionsMenuCursorPos:
	ld a, [wOptionsMenuCursorY]
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ld a, [wOptionsMenuCursorX]
	ld b, 0
	ld c, a
	add hl, bc
	ret

SetOptionsFromCursorPositions:
	ld hl, TextSpeedOptionData
	ld a, [wOptionsTextSpeedCursorX]
	ld c, a
.loop
	ld a, [hli]
	cp c
	jr z, .found
	inc hl
	jr .loop

.found
	ld a, [hl]
	ld d, a
	ld a, [wOptionsBattleAnimCursorX]
	dec a
	jr z, .battle_anim_off
	set BATTLE_SCENE_F, d
	jr .battle_anim_on

.battle_anim_off
	res BATTLE_SCENE_F, d
.battle_anim_on
	ld a, [wOptionsBattleStyleCursorX]
	dec a
	jr z, .battle_shift_off
	set BATTLE_SHIFT_F, d
	jr .battle_shift_on

.battle_shift_off
	res BATTLE_SHIFT_F, d
.battle_shift_on
	ld a, [wOptionsAudioSettingsCursorX]
	dec a
	jr z, .mono
	set STEREO_F, d
	jr .stereo

.mono
	res STEREO_F, d
.stereo
	ld a, [wOptions]
	and 1 << SGB_BORDER
	or d
	ld [wOptions], a
	ret

DisplayOptionsMenu:
	call ClearBGPalettes
	call DisableLCD
	xor a
	ldh [hBGMapMode], a
	call .LoadGFX_DrawDisplay
	xor a
	ld hl, wOptionsTextSpeedCursorX
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	assert FAST_TEXT_DELAY_F == 0
	inc a ; 1 << FAST_TEXT_DELAY_F
	ld [wTextBoxFlags], a
	ld hl, TextSpeedOptionData + 1
	ld a, [wOptions]
	ld c, a
	and TEXT_DELAY_MASK
	push bc
	ld de, 2
	call FindItemInTable
	pop bc
	dec hl
	ld a, [hl]
	ld [wOptionsTextSpeedCursorX], a ;
	hlcoord 0, OPT_TEXT_SPEED_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; On
	jr nc, .battle_anim
	ld a, 10 ; Off
.battle_anim
	ld [wOptionsBattleAnimCursorX], a
	hlcoord 0, OPT_BATTLE_ANIM_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; Shift
	jr nc, .battle_style
	ld a, 10 ; Set
.battle_style
	ld [wOptionsBattleStyleCursorX], a
	hlcoord 0, OPT_BATTLE_STYLE_ROW
	call .PlaceUnfilledRightArrow
	sla c
	ld a, 1 ; Mono
	jr nc, .mono_stereo
	ld a, 10 ; Stereo
.mono_stereo
	ld [wOptionsAudioSettingsCursorX], a
	hlcoord 0, OPT_SOUND_ROW
	call .PlaceUnfilledRightArrow
	ld a, 1
	ld [wOptionsBottomRowCursorX], a
; Cursor in front of "Cancel"
	hlcoord 1, OPT_BOTTOM_ROW
	ld [hl], "▷"
; Cursor in front of frame options
	hlcoord 7, OPT_BOTTOM_ROW
	ld [hl], "▷"
	ld a, [wOptionsTextSpeedCursorX]
	ld [wOptionsMenuCursorX], a
	ld a, 3
	ld [wOptionsMenuCursorY], a
	call EnableLCD
	call WaitBGMap
	call SetPalettes
	ret

.PlaceUnfilledRightArrow
	ld e, a
	ld d, 0
	add hl, de
	ld [hl], "▷"
	ret

.LoadGFX_DrawDisplay
	ld de, vChars1 tile $70
	ld hl, TrainerCardGFX
	ld bc, 1 tiles
	ld a, BANK(TrainerCardGFX)
	call FarCopyData
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $f0 ; checkered square tile
	call ByteFill
; Text Speed
	hlcoord 1, OPT_TEXT_SPEED_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Battle Scene
	hlcoord 1, OPT_BATTLE_ANIM_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Battle Style
	hlcoord 1, OPT_BATTLE_STYLE_ROW - 2
	lb bc, 3, 18
	call ClearBox
; Sound
	hlcoord 1, OPT_SOUND_ROW
	lb bc, 1, 18
	call ClearBox

	hlcoord 1, OPT_TEXT_SPEED_ROW - 2
	ld de, .OptionsText_TextSpeed
	call PlaceString

	hlcoord 1, OPT_BATTLE_ANIM_ROW - 2
	ld de, .OptionsText_BattleScene
	call PlaceString

	hlcoord 1, OPT_BATTLE_STYLE_ROW - 2
	ld de, .OptionsText_BattleStyle
	call PlaceString

	hlcoord 1, OPT_SOUND_ROW
	ld de, .OptionsText_Sound
	call PlaceString

	hlcoord 1, OPT_BOTTOM_ROW
	ld de, .OptionsText_Cancel
	call PlaceString
; Draw the text box for the frame options
	hlcoord 6, OPT_BOTTOM_ROW - 1
	ld b, 1
	ld c, 11
	call DrawTextBox

	hlcoord 7, OPT_BOTTOM_ROW
	ld de, .OptionsText_FrameType
	call PlaceString
; Place # of active frame
	ld a, [wActiveFrame]
	hlcoord 17, 16
	add "１"
	ld [hl], a
	ret

.OptionsText_TextSpeed:
	db "はなしの　はやさ"
	next "　はやい　　　　ふつう　　　　おそい"
	text_end

.OptionsText_BattleScene:
	db "せんとう　アニメーション"
	next "　じっくり　みる　　とばして　みる"
	text_end

.OptionsText_BattleStyle:
	db "しあいの　ルール"
	next "　いれかえタイプ　　かちぬきタイプ"
	text_end

.OptionsText_Sound:
	db "　モノラル　　　　　ステレオ"
	text_end

.OptionsText_Cancel:
	db "　おわり"
	text_end

.OptionsText_FrameType:
	db "　わく　を　かえる　"
	text_end

; Table that indicates how the 3 text speed options affect frame delays.
; Format:
; 00: X coordinate of menu cursor.
; 01: delay after printing a letter (in frames).
TextSpeedOptionData:
	db 15, TEXT_DELAY_SLOW
	db  8, TEXT_DELAY_MED
	db  1, TEXT_DELAY_FAST
	db  8, -1

Unknown7c2a:
rept 491
	db $39, $00
endr
