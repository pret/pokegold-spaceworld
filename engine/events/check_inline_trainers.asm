; Unreferenced version of CheckInlineTrainers

Unreferenced_CheckInlineTrainers:
	ld a, [wDebugFlags]
	set UNK_DEBUG_FLAG_6_F, a ; Should probably be "bit UNK_DEBUG_FLAG_6_F, a"?
	ret nz
	xor a
	ldh [hSeenTrainerDistance], a
	ldh [hSeenTrainerDirection], a
	ld a, FOLLOWER + 1
	ldh [hSeenTrainerObject], a
	ld hl, wCurrMapInlineTrainers + (2 * FOLLOWER_OBJECT_INDEX) ; Skip wReservedObjectStruct and the player's struct
	ld de, 2 ; Length of wCurrMapInlineTrainers entries
	ld b, NUM_OBJECTS - FOLLOWER_OBJECT_INDEX
.loop
	ld a, [hl]
	and a
	jr nz, .found
	add hl, de
	ldh a, [hSeenTrainerObject]
	inc a
	ldh [hSeenTrainerObject], a
	dec b
	jr nz, .loop
	ret

.found
	ldh [hSeenTrainerDistance], a
	inc hl
	ld a, [hl]
	ldh [hSeenTrainerDirection], a
	ld hl, wDebugFlags
	set UNK_DEBUG_FLAG_6_F, [hl]
	ret

Unreferenced_TestTrainerWalkToPlayer:
	ld hl, wJoypadFlags
	set 6, [hl]
	ldh a, [hSeenTrainerObject]
	call FreezeAllOtherObjects
	ldh a, [hSeenTrainerObject]
	ld hl, .MovementData
	ldh a, [hSeenTrainerDistance]
	dec a
	ld e, a
	ld d, 0
	add hl, de
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

.MovementData:
	big_step LEFT
	big_step LEFT
	big_step LEFT
	step_end
