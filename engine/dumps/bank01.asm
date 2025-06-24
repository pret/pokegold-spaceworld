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


Function6445:
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, wStringBuffer1
	ld de, wcd11
	ld bc, $0006
	call CopyBytes
.sub_645d
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, $04
.sub_646d
	ld a, [hl]
	and a
	jr z, .sub_648d
	inc hl
	dec b
	jr nz, .sub_646d
	push de
	call ForgetMove
	pop de
	jp c, .sub_64d6
	push hl
	push de
	ld [wce37], a
	call Unreferenced_GetMoveName
	ld hl, Text664b
	call PrintText
	pop de
	pop hl
.sub_648d
	ld a, [wce32]
	ld [hl], a
	ld bc, $0015
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
	jp z, .sub_64eb
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jp nz, .sub_64eb
	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, $0004
	call CopyBytes
	ld bc, $0011
	add hl, bc
	ld de, wBattleMonPP
	ld bc, $0004
	call CopyBytes
	jp .sub_64eb
.sub_64d6
	ld hl, Text65b9
	call PrintText
	call YesNoBox
	jp c, .sub_645d
	ld hl, Text65d7
	call PrintText
	ld b, $00
	ret
.sub_64eb
	ld hl, Text658c
	call PrintText
	ld b, $01
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
.sub_650f
	push hl
	ld hl, MoveAskForgetText
	call PrintText
	coord hl, 10, 8
	ld b, $08
	ld c, $08
	call DrawTextBox
	coord hl, 12, 10
	ld a, SCREEN_WIDTH*2
	ld [wListMovesLineSpacing], a
	predef ListMoves
	ld a, $0a
	ld [w2DMenuCursorInitY], a
	ld a, $0b
	ld [w2DMenuCursorInitX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, $01
	ld [w2DMenuNumCols], a
	ld [w2DMenuDataEnd], a
	ld [wMenuCursorX], a
	ld a, $03
	ld [wMenuJoypadFilter], a
	ld a, $20
	ld [w2DMenuFlags], a
	xor a
	ld [w2DMenuFlags+1], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	call Get2DMenuJoypad
	push af
	call ReloadTilesFromBuffer
	pop af
	pop hl
	bit 1, a
	jr nz, .sub_658a
	push hl
	ld a, [w2DMenuDataEnd]
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsHMMove
	pop bc
	pop de
	ld a, d
	jr c, .sub_6581
	pop hl
	add hl, bc
	and a
	ret
.sub_6581
	ld hl, Text6691
	call PrintText
	pop hl
	jr .sub_650f
.sub_658a
	scf
	ret

Text658c:
	text_from_ram wcd11
	text "は　あたらしく"
	line ""
	text_end

Text6599:
	text_from_ram wStringBuffer2
	text "を　おぼえた！"
	text_end

Text65a5:
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end

MoveAskForgetText:
	text "どの　わざを"
	next "わすれさせたい？"
	done

Text65b9:
	text "それでは<⋯⋯>　"
	text_end

Text65c1:
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえるのを　あきらめますか？"
	done

Text65d7:
	text_from_ram wcd11
	text "は　"
	text_end

Text65de:
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえずに　おわった！"
	prompt

AskForgetMoveText:
	text_from_ram wcd11
	text "は　あたらしく"
	line ""
	text_end
	text_from_ram wStringBuffer2
	text "を　おぼえたい<⋯⋯>！"
	para "しかし　"
	text_end
	text_from_ram wcd11
	text "は　わざを　４つ"
	line "おぼえるので　せいいっぱいだ！"
	para ""
	text_end
	text_from_ram wStringBuffer2
	text "の　かわりに"
	line "ほかの　わざを　わすれさせますか？"
	done

Text664b:
	text "１　２の　<⋯⋯>"
	text_end

Text6653:
	text_exit
	start_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, Text6661
	ret

Text6661:
	text "　ポカン！"
	text_end

Text6668:
	text_exit
	text ""
	para ""
	text_end

Text666c:
	text_from_ram wcd11
	text "は　"
	text_end

Text6673:
	text_from_ram wStringBuffer1
	text "の"
	line "つかいかたを　きれいに　わすれた！"
	para "そして<⋯⋯>！"
	prompt

Text6691:
	text "それは　たいせつなわざです"
	line "わすれさせることは　できません！"
	prompt

Function66b1:
	ld hl, wcd74
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurItem]
	cp $c4
	jr nc, .sub_66d2
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	inc hl
	ld a, [hld]
	ldh [hSpriteOffset], a
	ld a, [hld]
	ldh [hConnectedMapWidth], a
	ld a, [hl]
	ldh [hConnectionStripLength], a
	jr .sub_66d5
.sub_66d2
	call .sub_66d9
.sub_66d5
	ld de, hConnectionStripLength
	ret
.sub_66d9
	ld a, [wCurItem]
	sub $c9
	ret c
	ld d, a
	ld hl, Table66fa
	srl a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	srl d
	jr nc, .sub_66f0
	swap a
.sub_66f0
	and $f0
	ldh [hConnectedMapWidth], a
	xor a
	ldh [hConnectionStripLength], a
	ldh [hSpriteOffset], a
	ret

Table66fa:
	db $32, $21, $34, $24
	db $34, $21, $45, $55
	db $32, $32, $55, $52
	db $54, $52, $41, $21
	db $12, $42, $25, $24
	db $22, $52, $24, $34
	db $42

Function6713:
	push hl
	call LoadStandardMenuHeader
	ld a, [wBattleMode]
	dec a
	coord hl, 1, 0
	ld b, $04
	ld c, $0a
	call z, ClearBox
	ld a, [wCurPartySpecies]
	ld [wce37], a
	call GetPokemonName
	ld a, [wDebugFlags]
	bit 1, a
	pop hl
	push hl
	ld hl, Text6788
	call PrintText
	call YesNoBox
	pop hl
	jr c, .sub_6779
	push hl
	ld e, l
	ld d, h
	ld a, BANK(NamingScreen)
	ld b, $00
	ld hl, NamingScreen
	call FarCall_hl
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld a, [wBattleMode]
	and a
	jr nz, .sub_676b
	call LoadFontExtra
	call Function3657
	jr .sub_6773
.sub_676b
	callfar _LoadHPBar
.sub_6773
	pop hl
	ld a, [hl]
	cp $50
	jr nz, .sub_6784
.sub_6779
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_6784
	call CloseWindow
	ret

Text6788:
	text_from_ram wStringBuffer1
	text "に"
	line "ニックネームを　つけますか？"
	done

Function679d:
	ld de, wFieldMoveScriptID
	push de
	ld hl, NamingScreen
	ld b, $00
	ld a, BANK(NamingScreen)
	call FarCall_hl
	call ClearBGPalettes
	call Function360b
	call UpdateTimePals
	pop de
	ld a, [de]
	cp $50
	jr z, .sub_67d3
	ld hl, wPartyMonNicknames
	ld bc, $0006
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wFieldMoveScriptID
	ld bc, $0006
	call CopyBytes
	and a
	ret
.sub_67d3
	scf
	ret

CorrectNickErrors:
	push bc
	push de
	ld b, $06
.sub_67d9
	ld a, [de]
	cp $50
	jr z, .sub_6802
	ld hl, Table6805
	dec hl
.sub_67e2
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .sub_67f5
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .sub_67e2
	cp [hl]
	jr nc, .sub_67e2
	ld a, $e6
	ld [de], a
	jr .sub_67e2
.sub_67f5
	inc de
	dec b
	jr nz, .sub_67d9
	pop de
	push de
	ld a, $e6
	ld [de], a
	inc de
	ld a, $50
	ld [de], a
.sub_6802
	pop de
	pop bc
	ret

Table6805::
	db $00, $05, $14, $19, $1d
	db $26, $35, $3a, $49, $7f
	db $ff

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

SECTION "engine/dumps/bank01.asm@SettingsScreen", ROMX

SettingsScreen:
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

Function78ed:
	call Function7a93

Function78f0:
	call Function7a41
	ld [hl], $ed
	call Function7a55
	call WaitBGMap
.sub_78fb
	call DelayFrame
	call GetJoypadDebounced
	ldh a, [hJoySum]
	ld b, a
	and a
	jr z, .sub_78fb
	ld a, b
	and $0a
	jr nz, .sub_7924
	ld a, b
	and $04
	jr nz, .sub_7939
	ld a, b
	and $01
	jr z, Function7977
	ld a, [wc409]
	cp $10
	jr nz, Function78f0
	ld a, [wTileMapBackup]
	cp $07
	jr z, .sub_7956
.sub_7924
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
.sub_7939
	ld hl, wce5f
	ld a, [hl]
	xor $08
	ld [hl], a
	callfar UpdateSGBBorder
	call LoadFont
	call LoadFontExtra
	ld c, $70
	call DelayFrames
	jp Function78ed
.sub_7956
	ld a, [wActiveFrame]
	inc a
	and $07
	ld [wActiveFrame], a
	coord hl, 17, 16
	add $f7
	ld [hl], a
	call LoadFontExtra
	jr Function78f0

Function796a:
	push af
	call Function7a41
	ld [hl], $7f
	pop af
	ld [wTileMapBackup], a
	jp Function78f0

Function7977:
	ld a, [wc409]
	bit 7, b
	jr nz, .sub_799e
	bit 6, b
	jr nz, .sub_79c1
	cp $07
	jp z, .sub_7a10
	cp $0b
	jp z, .sub_7a1b
	cp $0d
	jp z, .sub_7a26
	cp $10
	jp z, .sub_7a31
	bit 5, b
	jp nz, .sub_79f6
	jp .sub_7a01
.sub_799e
	cp $10
	ld b, $f3
	ld hl, wc40a
	jr z, .sub_79e2
	cp $03
	ld b, $04
	inc hl
	jr z, .sub_79e2
	cp $07
	ld b, $04
	inc hl
	jr z, .sub_79e2
	cp $0b
	ld b, $02
	inc hl
	jr z, .sub_79e2
	ld b, $03
	inc hl
	jr .sub_79e2
.sub_79c1
	cp $07
	ld b, $fc
	ld hl, wc40a
	jr z, .sub_79e2
	cp $0b
	ld b, $fc
	inc hl
	jr z, .sub_79e2
	cp $0d
	ld b, $fe
	inc hl
	jr z, .sub_79e2
	cp $10
	ld b, $fd
	inc hl
	jr z, .sub_79e2
	ld b, $0d
	inc hl
.sub_79e2
	add b
	push af
	ld a, [hl]
	push af
	call Function7a41
	ld [hl], $ec
	pop af
	ld [wTileMapBackup], a
	pop af
	ld [wc409], a
	jp Function78f0
.sub_79f6
	ld a, [wc40a]
	cp $01
	jr z, .sub_7a0a
	sub $07
	jr .sub_7a0a
.sub_7a01
	ld a, [wc40a]
	cp $0f
	jr z, .sub_7a0a
	add $07
.sub_7a0a
	ld [wc40a], a
	jp Function796a
.sub_7a10
	ld a, [wWhichPicTest]
	xor $0b
	ld [wWhichPicTest], a
	jp Function796a
.sub_7a1b
	ld a, [wc40c]
	xor $0b
	ld [wc40c], a
	jp Function796a
.sub_7a26
	ld a, [wc40d]
	xor $0b
	ld [wc40d], a
	jp Function796a
.sub_7a31
	call Function7a41
	ld [hl], $ec
	ld a, [wTileMapBackup]
	xor $06
	ld [wTileMapBackup], a
	jp Function78f0

Function7a41:
	ld a, [wc409]
	ld hl, wTileMap
	ld bc, $0014
	call AddNTimes
	ld a, [wTileMapBackup]
	ld b, $00
	ld c, a
	add hl, bc
	ret

Function7a55:
	ld hl, Table7c22
	ld a, [wc40a]
	ld c, a
.sub_7a5c
	ld a, [hli]
	cp c
	jr z, .sub_7a63
	inc hl
	jr .sub_7a5c
.sub_7a63
	ld a, [hl]
	ld d, a
	ld a, [wWhichPicTest]
	dec a
	jr z, .sub_7a6f
	set 7, d
	jr .sub_7a71
.sub_7a6f
	res 7, d
.sub_7a71
	ld a, [wc40c]
	dec a
	jr z, .sub_7a7b
	set 6, d
	jr .sub_7a7d
.sub_7a7b
	res 6, d
.sub_7a7d
	ld a, [wc40d]
	dec a
	jr z, .sub_7a87
	set 5, d
	jr .sub_7a89
.sub_7a87
	res 5, d
.sub_7a89
	ld a, [wce5f]
	and $08
	or d
	ld [wce5f], a
	ret

Function7a93:
	call ClearBGPalettes
	call DisableLCD
	xor a
	ldh [hBGMapMode], a
	call .sub_7b26
	xor a
	ld hl, wc40a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ld [wTextBoxFlags], a
	ld hl, Table7c23
	ld a, [wce5f]
	ld c, a
	and $07
	push bc
	ld de, $0002
	call FindItemInTable
	pop bc
	dec hl
	ld a, [hl]
	ld [wc40a], a
	coord hl, 0, 3
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7ad0
	ld a, $0a
.sub_7ad0
	ld [wWhichPicTest], a
	coord hl, 0, 7
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7ae1
	ld a, $0a
.sub_7ae1
	ld [wc40c], a
	coord hl, 0, 11
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7af2
	ld a, $0a
.sub_7af2
	ld [wc40d], a
	coord hl, 0, 13
	call .sub_7b1f
	ld a, $01
	ld [wc40e], a
	coord hl, 1, 16
	ld [hl], $ec
	coord hl, 7, 16
	ld [hl], $ec
	ld a, [wc40a]
	ld [wTileMapBackup], a
	ld a, $03
	ld [wc409], a
	call EnableLCD
	call WaitBGMap
	call SetPalettes
	ret
.sub_7b1f
	ld e, a
	ld d, $00
	add hl, de
	ld [hl], $ec
	ret
.sub_7b26
	ld de, vChars1 + $0700
	ld hl, TrainerCardGFX
	ld bc, $0010
	ld a, BANK(TrainerCardGFX)
	call FarCopyData
	ld hl, wTileMap
	ld bc, $0168
	ld a, $f0
	call ByteFill
	coord hl, 1, 1
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 5
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 9
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 13
	lb bc, 1, 18
	call ClearBox
	coord hl, 1, 1
	ld de, Text7bad
	call PlaceString
	coord hl, 1, 5
	ld de, Text7bc9
	call PlaceString
	coord hl, 1, 9
	ld de, Text7be8
	call PlaceString
	coord hl, 1, 13
	ld de, Text7c03
	call PlaceString
	coord hl, 1, 16
	ld de, Text7c12
	call PlaceString
	coord hl, 6, 15
	ld b, $01
	ld c, $0b
	call DrawTextBox
	coord hl, 7, 16
	ld de, Text7c17
	call PlaceString
	ld a, [wActiveFrame]
	coord hl, 17, 16
	add $f7
	ld [hl], a
	ret

Text7bad:
	db "はなしの　はやさ"
	next "　はやい　　　　ふつう　　　　おそい"
	text_end

Text7bc9:
	db "せんとう　アニメーション"
	next "　じっくり　みる　　とばして　みる"
	text_end

Text7be8:
	db "しあいの　ルール"
	next "　いれかえタイプ　　かちぬきタイプ"
	text_end

Text7c03:
	db "　モノラル　　　　　ステレオ"
	text_end

Text7c12:
	db "　おわり"
	text_end

Text7c17:
	db "　わく　を　かえる　"
	text_end

Table7c22:
	db $0F

Table7c23:
	db $05, $08, $03
	db $01, $01, $08
	db $FF

Unknown7c2a:
rept 491
	db $39, $00
endr
