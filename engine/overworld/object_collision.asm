INCLUDE "constants.asm"

SECTION "engine/overworld/object_collision.asm", ROMX

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

; Get the tile that the sprite will walk onto next
GetSpritesNextTile:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTileCollision
	pop bc
	ret

; Sets carry flag if the object (bc) next tile is a collision
_IsObjectCollisionTileSolid:
	call GetSpritesNextTile
	ld e, a
	ld d, 0
	ld hl, CollisionTypeTable
	add hl, de
	ld a, BANK(CollisionTypeTable)
	call GetFarByte
	and ALWAYS_SOLID ; also covers SOMETIMES_SOLID
	ret z
	scf
	ret

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
	call IsNPCAtCoord
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
	jr IsNPCAtCoord

IsObjectFacingSomeoneElse:
	ldh a, [hMapObjectIndex]
	call GetObjectStruct
	call .GetFacingCoords
	call IsNPCAtCoord
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

; returns the carry flag if a sprite is at coords d, e
; will not collide with sprite index stored in hEventCollisionException
IsNPCAtCoord:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hObjectStructIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next

	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .check_current_coords
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .check_current_coords

	ldh a, [hEventCollisionException]
	ld l, a
	ldh a, [hObjectStructIndex]
	cp l
	jr nz, .yes

.check_current_coords
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .next
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .next
	ldh a, [hEventCollisionException]
	ld l, a
	ldh a, [hObjectStructIndex]
	cp l
	jr nz, .yes

.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	and a
	ret

.yes
	scf
	ret

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

; Sets the carry flag if the player will collide with another sprite's current or next position
_CheckPlayerObjectCollision:
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	ld bc, wObjectStructs
	xor a

.loop
	ldh [hObjectStructIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .check_last_position
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .check_last_position

; skip the player sprite
	ldh a, [hObjectStructIndex]
	cp PLAYER_OBJECT_INDEX
	jr z, .next
	jr .collision

.check_last_position
	ld hl, OBJECT_LAST_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .next
	ld hl, OBJECT_LAST_MAP_X
	add hl, bc
	ld a, [hl]
	cp d
	jr nz, .next
	jr .collision

.next
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hObjectStructIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	xor a
	ret

.collision
	scf
	ret
