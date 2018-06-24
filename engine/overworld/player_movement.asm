INCLUDE "constants.asm"

SECTION "Player Movement", ROMX[$4000], BANK[$3]

OverworldMovementCheck::
	jp _OverworldMovementCheck

UnusedOverworldMovementCheck::
	ld a, $01
	ldh [hEventCollisionException], a
	ld a, [wPlayerDirection]
	and a
	jr z, _SetPlayerIdle ; player movement is disabled
	ldh a, [hJoyState]
	ld d, a
	ld hl, wce63
	bit 1, [hl]
	jr z, .skip_debug_move
	bit B_BUTTON_F, d
	jp nz, CheckMovementDebug
.skip_debug_move
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jp z, OldCheckMovementSkateboard
	cp PLAYER_SURF
	jp z, OldCheckMovementSurf
	jp CheckMovementWalkOrBike
_SetPlayerIdle:
	ld a, $2a
_SetPlayerAnimation:
	ld [wcb77], a
	ld a, [wPlayerLastMapX]
	ld [wPlayerStandingMapX], a
	ld a, [wPlayerLastMapY]
	ld [wPlayerStandingMapY], a
	and a
	ret

CheckMovementWalkOrBike:
	call _CheckMovementWalkOrBike
	jp _SetPlayerAnimation

_CheckMovementWalkOrBike:
	ld a, d
	and (D_DOWN | D_UP | D_LEFT | D_RIGHT)
	jp z, .done
	ld a, d
	bit D_DOWN_F, a
	jp nz, .moveDown
	bit D_UP_F, a
	jp nz, .moveUp
	bit D_LEFT_F, a
	jp nz, .moveLeft
	bit D_RIGHT_F, a
	jr nz, .moveRight
.done:
	ld a, $2a
	ret
.moveRight:
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerStandingMapX], a
	call _CheckPlayerObjectCollision
	jr c, .faceRight
	call IsPlayerCollisionTileSolid
	jr nc, .canMoveRight
	jr .faceRight
.canMoveRight
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, $0f
	ret z
	ld a, $0b
	ret
.faceRight:
	ld a, $03
	ret

.moveLeft:
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerStandingMapX], a
	call _CheckPlayerObjectCollision
	jr c, .faceLeft
	call IsPlayerCollisionTileSolid
	jr nc, .canMoveLeft
	jr .faceLeft
.canMoveLeft
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, $0e
	ret z
	ld a, $0a
	ret
.faceLeft:
	ld a, $02
	ret

.moveDown:
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerStandingMapY], a
	call _CheckPlayerObjectCollision
	jr c, .faceDown
	call IsPlayerCollisionTileSolid
	jr nc, .canMoveDown
	cp OLD_COLLISION_LEDGE
	jr nz, .faceDown
.jumpDown:
	ld a, $18
	ret
.canMoveDown
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, $0c
	ret z
	ld a, $08
	ret
.faceDown:
	ld a, $00
	ret

.moveUp:
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerStandingMapY], a
	call _CheckPlayerObjectCollision
	jr c, .faceUp
	call IsPlayerCollisionTileSolid
	jr nc, .canMoveUp
	jr .faceUp
.canMoveUp
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	ld a, $0d
	ret z
	ld a, $09
	ret
.faceUp:
	ld a, $01
	ret

CheckMovementDebug::
	ld a, d
	call _CheckMovementDebug
	jp _SetPlayerAnimation

_CheckMovementDebug:
	bit D_DOWN_F, a
	jr nz, .moveDown
	bit D_UP_F, a
	jr nz, .moveUp
	bit D_LEFT_F, a
	jr nz, .moveLeft
	bit D_RIGHT_F, a
	jr nz, .moveRight
.idle:
	ld a, $2a
	ret
.moveDown:
	ld a, [wTileDown]
	cp $ff
	ld a, $0c
	ret nz
	ld a, $19
	ret
.moveUp:
	ld a, [wTileUp]
	cp $ff
	ld a, $0d
	ret nz
	ld a, $18
	ret
.moveLeft:
	ld a, [wTileLeft]
	cp $ff
	ld a, $0e
	ret nz
	ld a, $1b
	ret
.moveRight:
	ld a, [wTileRight]
	cp $ff
	ld a, $0f
	ret nz
	ld a, $1a
	ret

OldCheckMovementSkateboard::
	call _OldCheckMovementSkateboard
	jp _SetPlayerAnimation

_OldCheckMovementSkateboard:
	ld a, [wSkatingDirection]
	cp $ff
	jp z, .skateStand
	push de
	ld e, a
	ld d, $00
	ld hl, .skateMovementTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop de
	jp hl
.skateMovementTable:
	dw .skateDown
	dw .skateUp
	dw .skateLeft
	dw .skateRight

.skateStand:
	ld a, d
	and (D_DOWN | D_UP | D_LEFT | D_RIGHT)
	jp z, .done
	bit D_DOWN_F, d
	jp nz, .skateDown
	bit D_UP_F, d
	jp nz, .skateUp
	bit D_LEFT_F, d
	jp nz, .skateLeft
	bit D_RIGHT_F, d
	jp nz, .skateRight
.done:
	ld a, $ff
	ld [wSkatingDirection], a
	ld a, $2a
	ret

.skateDown:
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerStandingMapY], a
	ld a, $00
	ld [wSkatingDirection], a
	call _CheckPlayerObjectCollision
	jr c, .skateDownCollision
	call IsPlayerCollisionTileSolid
	jr nc, .canSkateDown
	cp OLD_COLLISION_LEDGE
	jr z, .skateJumpDown
	cp (OLD_COLLISION_ROCK | COLLISION_FLAG)
	jr nz, .skateDownCollision
.skateJumpDown:
	ld a, $1c
	ret
.canSkateDown:
	call OldIsTileCollisionGrass
	jr z, .skateDownSlowly
	ld a, $0c
	ret
.skateDownSlowly:
	ld a, $08
	ret
.skateDownCollision:
	ld a, $ff
	ld [wSkatingDirection], a
	ld a, $00
	ret

.skateUp:
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerStandingMapY], a
	ld a, $01
	ld [wSkatingDirection], a
	call _CheckPlayerObjectCollision
	jr c, .skateUpCollision
	call IsPlayerCollisionTileSolid
	jr nc, .canSkateUp
	cp $59
	jr nz, .skateUpCollision
.skateJumpUp:
	ld a, $1d
	ret
.canSkateUp:
	call OldIsTileCollisionGrass
	jr z, .skateUpSlowly
	ld a, $0d
	ret
.skateUpSlowly:
	ld a, $09
	ret
.skateUpCollision:
	ld a, $ff
	ld [wSkatingDirection], a
	ld a, $01
	ret

.skateLeft:
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerStandingMapX], a
	ld a, $02
	ld [wSkatingDirection], a
	call _CheckPlayerObjectCollision
	jr c, .skateLeftCollision
	call IsPlayerCollisionTileSolid
	jr nc, .canSkateLeft
	cp $59
	jr nz, .skateLeftCollision
.skateJumpLeft:
	ld a, $1e
	ret
.canSkateLeft:
	call OldIsTileCollisionGrass
	jr z, .skateLeftSlowly
	ld a, $0e
	ret
.skateLeftSlowly:
	ld a, $0a
	ret
.skateLeftCollision:
	ld a, $ff
	ld [wSkatingDirection], a
	ld a, $02
	ret

.skateRight:
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerStandingMapX], a
	ld a, $03
	ld [wSkatingDirection], a
	call _CheckPlayerObjectCollision
	jr c, .skateRightCollision
	call IsPlayerCollisionTileSolid
	jr nc, .canSkateRight
	cp $59
	jr nz, .skateRightCollision
.skateJumpRight:
	ld a, $1f
	ret
.canSkateRight:
	call OldIsTileCollisionGrass
	jr z, .skateRightSlowly
	ld a, $0f
	ret
.skateRightSlowly:
	ld a, $0b
	ret
.skateRightCollision:
	ld a, $ff
	ld [wSkatingDirection], a
	ld a, $03
	ret

OldIsTileCollisionGrass::
; Check whether collision ID in a is
; grass
; Result:
; nz - not grass
;  z - grass
	cp $82
	ret z
	cp $83
	ret z
	cp $8a
	ret z
	cp $8b
	ret

OldCheckMovementSurf::
	call _OldCheckMovementSurf
	jp _SetPlayerAnimation

_OldCheckMovementSurf:
	ld a, d
	and (D_DOWN | D_UP | D_LEFT | D_RIGHT)
	bit D_DOWN_F, a
	jp nz, .trySurfDown
	bit D_UP_F, a
	jp nz, .trySurfUp
	bit D_LEFT_F, a
	jp nz, .trySurfLeft
	bit D_RIGHT_F, a
	jr nz, .trySurfRight
.idle:
	ld a, $2a
	ret

.trySurfDown:
	ld a, [wPlayerLastMapY]
	inc a
	ld [wPlayerStandingMapY], a
	call _CheckPlayerObjectCollision
	jr c, .faceDown
	call IsPlayerCollisionTileSolid
	jr nc, .surfDownLand ; FIXME: This assumes cut-trees are solid, which they aren't.
	                     ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .faceDown
.surfDown:
	ld a, $08
	ret
.faceDown:
	ld a, $00
	ret
.surfDownLand:
	call SetPlayerStateWalk
	ld a, $04
	ret

.trySurfUp:
	ld a, [wPlayerLastMapY]
	dec a
	ld [wPlayerStandingMapY], a
	call _CheckPlayerObjectCollision
	jr c, .faceUp
	call IsPlayerCollisionTileSolid
	jr nc, .surfUpLand ; FIXME: This assumes cut-trees are solid, which they aren't.
	                   ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .faceUp
.surfUp:
	ld a, $09
	ret
.faceUp:
	ld a, $01
	ret
.surfUpLand:
	call SetPlayerStateWalk
	ld a, $05
	ret

.trySurfLeft:
	ld a, [wPlayerLastMapX]
	dec a
	ld [wPlayerStandingMapX], a
	call _CheckPlayerObjectCollision
	jr c, .faceLeft
	call IsPlayerCollisionTileSolid
	jr nc, .surfLeftLand ; FIXME: This assumes cut-trees are solid, which they aren't.
	                     ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .faceLeft
.surfLeft:
	ld a, $0a
	ret
.faceLeft:
	ld a, $02
	ret
.surfLeftLand
	call SetPlayerStateWalk
	ld a, $06
	ret

.trySurfRight
	ld a, [wPlayerLastMapX]
	inc a
	ld [wPlayerStandingMapX], a
	call _CheckPlayerObjectCollision
	jr c, .faceRight
	call IsPlayerCollisionTileSolid
	jr nc, .surfRightLand ; FIXME: This assumes cut-trees are solid, which they aren't.
	                      ;        You can walk into them from water because of this.
	call OldIsTileCollisionWater
	jr c, .faceRight
.surfRight:
	ld a, $0b
	ret
.faceRight:
	ld a, $03
	ret
.surfRightLand
	call SetPlayerStateWalk
	ld a, $07
	ret

OldIsTileCollisionWater:: ; c2ee (3:42ee)
; Check if collision ID in a is water
; Input:
; a - collision ID
; Result:
;  c - water
; nc - not water
	and COLLISION_TYPE_MASK
	cp OLD_COLLISION_TYPE_WATER
	ret z
	cp OLD_COLLISION_TYPE_WATER2
	ret z
	scf
	ret

SetPlayerStateWalk::
	push bc
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	call RedrawPlayerSprite
	pop bc
	ret

IsPlayerCollisionTileSolid::
; Return whether the collision under player's feet
; is solid/sometimes solid or non-solid.
; Clobbers: a
; Results:
;  a - collision ID under player's feet
; nc - non-solid
;  c - solid/sometimes solid
	push de
	ld bc, wPlayerStruct
	ld hl, $775a
	ld a, $01
	call FarCall_hl
	ld a, e
	pop de
	ret

_CheckPlayerObjectCollision::
; Check whether player object currentl
; collides with any other object.
; Result:
; nc - no collision
;  c - collision
	push de
	ld hl, $7894
	ld a, $01
	call FarCall_hl
	pop de
	ret nc
	jp _CheckCompanionObjectCollision

_CheckCompanionObjectCollision::
; Marks the object struct pointed to by hl
; as having collided with player object.
; If object struct (as identified by hEventID)
; is companion, cancel collision on 5th frames.
; Result:
; nc - no collision
;  c - collision
	ld hl, (wPlayerFlags + 1) - wPlayerStruct
	add hl, bc
	set 1, [hl] ; mark object as having collided with player
	ldh a, [hEventID]
	cp $02
	jr z, .isCompanion
	xor a
	ld [wCompanionCollisionFrameCounter], a
	scf
	ret
.isCompanion
	ld a, [wCompanionCollisionFrameCounter]
	inc a
	cp $05
	ld [wCompanionCollisionFrameCounter], a
	jr z, .cancelCollision
	scf
	ret
.cancelCollision
	xor a
	ld [wCompanionCollisionFrameCounter], a
	ret

_OverworldMovementCheck::
	ld a, $01
	ldh [hEventCollisionException], a
	ld a, [wPlayerDirection]
	and a
	jp z, _SetPlayerIdle
	ldh a, [hJoyState]
	ld d, a
	ld hl, wce63
	bit 1, [hl]
	jr z, .skip_debug_move
	bit B_BUTTON_F, d
	jp nz, CheckMovementDebug
.skip_debug_move
	call .checkMovementRelease
	jp _SetPlayerAnimation

.checkMovementRelease:
	ld a, [wPlayerState]
	cp PLAYER_SKATE
	jp z, OldCheckMovementSkateboard ; FIXME: OldCheckMovementSkateboard already calls _SetPlayerAnimation
	                                 ;        The skateboard doesn't work, because it uses the current
	                                 ;        coordinate as player animation.
	cp PLAYER_SURF
	jp z, CheckMovementSurf
	jp CheckMovementWalk

CheckMovementWalk::
	ld a, [wPlayerStandingTile]
	swap a
	and LOW((COLLISION_TYPE_MASK >> 4) | (COLLISION_TYPE_MASK << 4))
	ld hl, .walkingCollisionTable
	jp CallJumptable

.walkingCollisionTable:
	dw CheckMovementWalkRegular ; regular
	dw CheckMovementWalkSolid   ; trees, grass, etc.
	dw CheckMovementWalkSolid   ; water
	dw CheckMovementWalkSolid   ; water current
	dw CheckMovementWalkLand    ; slowdown and fixed movement
	dw CheckMovementWalkLand2   ; fixed movement
	dw CheckMovementWalkRegular ; ???
	dw CheckMovementWalkWarp    ; warps
	dw CheckMovementWalkMisc    ; ???
	dw CheckMovementWalkSpecial ; counters, signposts, book cases
	dw CheckMovementWalkJump    ; jumps
	dw CheckMovementWalkRegular ; unused -- movement prohibit not yet implemented
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused
	dw CheckMovementWalkRegular ; unused

_MovementDone:
	ld a, $2a
	ret

CheckMovementWalkSolid::
	jp CheckMovementWalkRegular

CheckMovementWalkLand::
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	jr nz, .slowdown
	call CheckMovementWalkRegular
	call .slowMovementDown
	ret
.slowdown
	ld b, $08
	cp (COLLISION_LAND_S & COLLISION_SUBTYPE_MASK)
	jr z, .slowdownDone
	ld b, $09
	cp (COLLISION_LAND_N & COLLISION_SUBTYPE_MASK)
	jr z, .slowdownDone
	ld b, $0a
	cp (COLLISION_LAND_W & COLLISION_SUBTYPE_MASK)
	jr z, .slowdownDone
	ld b, $0b
	cp (COLLISION_LAND_E & COLLISION_SUBTYPE_MASK)
	jr z, .slowdownDone
	; fall-through --> map other codes to COLLISION_LAND_E
.slowdownDone
	ld a, b
	ret
.slowMovementDown:
	ld b, $04
	cp $08
	jr z, .slowMovementDownDone
	ld b, $05
	cp $09
	jr z, .slowMovementDownDone
	ld b, $06
	cp $0a
	jr z, .slowMovementDownDone
	ld b, $07
	cp $0b
	jr z, .slowMovementDownDone
	ret
.slowMovementDownDone
	ld a, b
	ret

CheckMovementWalkLand2::
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	ld b, $08
	cp (COLLISION_LAND2_S & COLLISION_SUBTYPE_MASK)
	jr z, .done
	ld b, $09
	cp (COLLISION_LAND2_N & COLLISION_SUBTYPE_MASK)
	jr z, .done
	ld b, $0a
	cp (COLLISION_LAND2_W & COLLISION_SUBTYPE_MASK)
	jr z, .done
	ld b, $0b
	cp (COLLISION_LAND2_E & COLLISION_SUBTYPE_MASK)
	jr z, .done
	; fall-through --> map other codes to COLLISION_LAND2_E
.done
	ld a, b
	ret

UnusedCheckMovementWalk60::
	jp CheckMovementWalkRegular

CheckMovementWalkWarp::
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	jr z, .exitWarpDpadDirection
	cp $01
	jr z, .exitWarpDownNoBoundsCheck
	ld a, [wPlayerStandingTile]
	cp $7a
	jr z, .exitWarpDownNoBoundsCheck
	jp CheckMovementWalkRegular
.exitWarpDownNoBoundsCheck
	ld a, $08
	ret
.exitWarpDpadDirection
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jr nz, .exitWarpDown
	bit D_UP_F, a
	jr nz, .exitWarpUp
	bit D_LEFT_F, a
	jr nz, .exitWarpLeft
	bit D_RIGHT_F, a
	jr nz, .exitWarpRight
	jp _MovementDone
.exitWarpDown
	ld a, [wTileDown]
	cp $ff
	jp nz, CheckMovementWalkRegular
	call z, _ReportMovementOutOfBounds
.faceDown:
	ld a, $00
	ret
.exitWarpUp
	ld a, [wTileUp]
	cp $ff
	jp nz, CheckMovementWalkRegular
	call z, _ReportMovementOutOfBounds
.faceUp:
	ld a, $01
	ret
.exitWarpLeft
	ld a, [wTileLeft]
	cp $ff
	jp nz, CheckMovementWalkRegular
	call z, _ReportMovementOutOfBounds
.faceLeft:
	ld a, $02
	ret
.exitWarpRight
	ld a, [wTileRight]
	cp $ff
	jp nz, CheckMovementWalkRegular
	call z, _ReportMovementOutOfBounds
.faceRight:
	ld a, $03
	ret

_ReportMovementOutOfBounds::
	ret

CheckMovementWalkMisc::
	jp CheckMovementWalkRegular

CheckMovementWalkSpecial::
	jp CheckMovementWalkRegular

CheckMovementWalkRegular::
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jp nz, TryWalkDown
	bit D_UP_F, a
	jp nz, TryWalkUp
	bit D_LEFT_F, a
	jp nz, TryWalkLeft
	bit D_RIGHT_F, a
	jp nz, TryWalkRight
	jp _MovementDone

CheckMovementWalkJump:
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jr nz, .checkJumpDown
	bit D_UP_F, a
	jr nz, .checkJumpUp
	bit D_LEFT_F, a
	jr nz, .checkJumpLeft
	bit D_RIGHT_F, a
	jr nz, .checkJumpRight
	jp _MovementDone
.checkJumpDown:
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_S & COLLISION_SUBTYPE_MASK)
	jr z, .jumpDown
	cp (COLLISION_JUMP_SE & COLLISION_SUBTYPE_MASK)
	jr z, .jumpDown
	cp (COLLISION_JUMP_SW & COLLISION_SUBTYPE_MASK)
	jr z, .jumpDown
	jp TryWalkDown
.jumpDown:
	ld a, $18
	ret
.checkJumpUp:
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_N & COLLISION_SUBTYPE_MASK)
	jr z, .jumpUp
	cp (COLLISION_JUMP_NE & COLLISION_SUBTYPE_MASK)
	jr z, .jumpUp
	cp (COLLISION_JUMP_NW & COLLISION_SUBTYPE_MASK)
	jr z, .jumpUp
	jp TryWalkUp
.jumpUp:
	ld a, $19
	ret
.checkJumpLeft:
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_W & COLLISION_SUBTYPE_MASK)
	jr z, .jumpLeft
	cp (COLLISION_JUMP_SW & COLLISION_SUBTYPE_MASK)
	jr z, .jumpLeft
	cp (COLLISION_JUMP_NW & COLLISION_SUBTYPE_MASK)
	jr z, .jumpLeft
	jp TryWalkLeft
.jumpLeft:
	ld a, $1a
	ret
.checkJumpRight
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_JUMP_E & COLLISION_SUBTYPE_MASK)
	jr z, .jumpRight
	cp (COLLISION_JUMP_SE & COLLISION_SUBTYPE_MASK)
	jr z, .jumpRight
	cp (COLLISION_JUMP_NE & COLLISION_SUBTYPE_MASK)
	jr z, .jumpRight
	jp TryWalkRight
.jumpRight
	ld a, $1b
	ret

TryWalkDown::
	ld d, 0
	ld e, 1
	call _CheckObjectCollision
	jr c, .faceDown
	ld a, [wTileDown]
	call CheckCollisionSolid
	jr c, .faceDown
.moveDown:
	ld a, $08
	ret
.faceDown:
	ld a, $00
	ret

TryWalkUp::
	ld d, 0
	ld e, -1
	call _CheckObjectCollision
	jr c, .faceUp
	ld a, [wTileUp]
	call CheckCollisionSolid
	jr c, .faceUp
.moveUp:
	ld a, $09
	ret
.faceUp:
	ld a, $01
	ret

TryWalkLeft::
	ld d, -1
	ld e, 0
	call _CheckObjectCollision
	jr c, .faceLeft
	ld a, [wTileLeft]
	call CheckCollisionSolid
	jr c, .faceLeft
.moveLeft:
	ld a, $0a
	ret
.faceLeft:
	ld a, $02
	ret

TryWalkRight::
	ld d, 1
	ld e, 0
	call _CheckObjectCollision
	jr c, .faceRight
	ld a, [wTileRight]
	call CheckCollisionSolid
	jr c, .faceRight
.moveRight:
	ld a, $0b
	ret
.faceRight:
	ld a, $03
	ret

CheckMovementSurf::
	ld a, [wPlayerStandingTile]
	swap a
	and  LOW((COLLISION_TYPE_MASK >> 4) | (COLLISION_TYPE_MASK << 4))
	ld hl, .surfCollisionTable
	jp CallJumptable

.surfCollisionTable
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfWater
	dw CheckMovementSurfWater2
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular
	dw CheckMovementSurfRegular

CheckMovementSurfRegular::
	ldh a, [hJoyState]
	bit D_DOWN_F, a
	jp nz, TrySurfDown
	bit D_UP_F, a
	jp nz, TrySurfUp
	bit D_LEFT_F, a
	jp nz, TrySurfLeft
	bit D_RIGHT_F, a
	jp nz, TrySurfRight
	jp _MovementDone

CheckMovementSurfWater::
	ld a, [wPlayerStandingTile]
	and COLLISION_SUBTYPE_MASK
	cp (COLLISION_WATERFALL & COLLISION_SUBTYPE_MASK)
	jr nz, CheckMovementSurfRegular
.waterfall:
	ld a, $0c
	ret

CheckMovementSurfWater2::
	ld a, [wPlayerStandingTile]
	and COLLISION_WATER_SUBTYPE_MASK
	ld d, $0b
	jr z, .done ; COLLISION_WATER2_E
	ld d, $0a
	cp (COLLISION_WATER2_W & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .done
	ld d, $09
	cp (COLLISION_WATER2_N & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .done
	ld d, $08
	cp (COLLISION_WATER2_S & COLLISION_WATER_SUBTYPE_MASK)
	jr z, .done
	; fall-through --> no aliasing due to mask
.done
	ld a, d
	ret

TrySurfDown:
	ld d, 0
	ld e, 1
	call _CheckObjectCollision
	jr c, .faceDown
	ld a, [wTileDown]
	call CheckCollisionSometimesSolid
	jr c, .faceDown ; FIXME: This assumes cut-trees are solid, which they aren't.
	                ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, $08
	ret
.faceDown:
	ld a, $00
	ret

TrySurfUp:
	ld d, 0
	ld e, -1
	call _CheckObjectCollision
	jr c, .faceUp
	ld a, [wTileUp]
	call CheckCollisionSometimesSolid
	jr c, .faceUp ; FIXME: This assumes cut-trees are solid, which they aren't.
	              ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, $09
	ret
.faceUp:
	ld a, $01
	ret

TrySurfLeft:
	ld d, -1
	ld e, 0
	call _CheckObjectCollision
	jr c, .faceLeft
	ld a, [wTileLeft]
	call CheckCollisionSometimesSolid
	jr c, .faceLeft ; FIXME: This assumes cut-trees are solid, which they aren't.
	                ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, $0a
	ret
.faceLeft:
	ld a, $02
	ret

TrySurfRight:
	ld d, 1
	ld e, 0
	call _CheckObjectCollision
	jr c, .faceRight
	ld a, [wTileRight]
	call CheckCollisionSometimesSolid
	jr c, .faceRight ; FIXME: This assumes cut-trees are solid, which they aren't.
	                 ;        You can walk into them from water because of this.
	call nz, SurfDismount
	ld a, $0b
	ret
.faceRight:
	ld a, $03
	ret
SurfDismount:
	jp SetPlayerStateWalk

_CheckObjectCollision::
; Check if coordinates relative
; to player collide with another object
; Clobbers:
; a, hl
; Input:
; de - Relative coords x, y
; Output:
; nc - no collision
;  c - collision
; hEventID - Event ID of colliding event
	ld a, $01
	ldh [hEventCollisionException], a
	ld a, [wPlayerStandingMapX]
	add d
	ld d, a
	ld a, [wPlayerStandingMapY]
	add e
	ld e, a
	ld hl, $77dd
	ld a, $01
	call FarCall_hl
	ret nc
	jp _CheckCompanionObjectCollision

CheckCollisionSolid::
; Checks whether collision ID in a
; is solid or not.
; Clobbers:
; hl
; Input:
;  a - collision ID
; Result:
;  a - collision type
;  c - solid
; nc - not solid
	call GetCollisionType
	and a
	ret z
	scf
	ret

GetCollisionType::
; Get collision type for collision ID in a
; Clobbers: hl
; Input:
;  a - collision ID
; Result:
;  a - collision type
;      00 - not solid
;      01 - sometimes solid (cut tree, water etc.)
;      0F - always solid
	push de
	ld hl, .collisionTypeTable
	ld e, a
	ld d, $00
	add hl, de
	ld a, [hl]
	pop de
	ret

.collisionTypeTable:
INCBIN "data/collision/collision_type_table.bin"

_UnusedReturnFalse::
	xor a
	ret

_UnusedReturnTrue::
	xor a
	scf
	ret

CheckCollisionSometimesSolid::
; Checks whether collision ID in a
; is sometimes, always or never solid.
; Clobbers:
; hl
; Input:
;  a - collision ID
; Result:
;  c - always solid
; nc - sometimes not solid, check a
;  a - result
;      00 - sometimes solid
;      01 - never solid
	call GetCollisionType
	cp $01
	jr z, .sometimesSolid
	and a
	jr z, .solid
	jr .alwaysSolid
.sometimesSolid:
	xor a
	ret
.solid:
	ld a, $01
	and a
	ret
.alwaysSolid:
	scf
	ret
