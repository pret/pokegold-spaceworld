INCLUDE "constants.asm"

SECTION "engine/overworld/object_collision.asm@GetSpritesNextTile", ROMX

; Get the tile that the sprite will walk onto next
GetSpritesNextTile:
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTile
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



SECTION "engine/overworld/object_collision.asm@_CheckObjectCollision", ROMX

; returns the carry flag if a sprite is at coords d, e
; will not collide with sprite index stored in hEventCollisionException
_CheckObjectCollision:
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
	jr nz, .check_last_position
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	cp e
	jr nz, .check_last_position
	ldh a, [hEventCollisionException]
	ld l, a
	ldh a, [hObjectStructIndex]
	cp l
	jr nz, .collision
.check_last_position
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
	jr nz, .collision
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

.collision
	scf
	ret

SECTION "engine/overworld/object_collision.asm@_CheckPlayerObjectCollision", ROMX

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
