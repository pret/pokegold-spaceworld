INCLUDE "constants.asm"

SECTION "home/map_objects.asm", ROM0

Function15b5::
	callab SpawnPlayer
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

Function15d1::
	ldh [hMapObjectIndex], a
	call GetMapObject
	call Function40eb
	ret

Function15da::
	ldh [hMapObjectIndex], a
	callab Function8131
	ldh a, [hMapObjectIndex]
	call GetMapObject
	call Function40eb
	ret

Function15ed::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld a, $0
	ldh [hObjectStructIndex], a
	ld de, wObjectStructs
	callab CopyMapObjectToObjectStruct
	ret

Function1602::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld a, FOLLOWER_STRUCT
	ldh [hObjectStructIndex], a
	ld de, wObject1Struct
	callab CopyMapObjectToObjectStruct
	ret

Function1617::
	ldh [hMapObjectIndex], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp $ff
	ret z
	ld [hl], $ff
	push af
	ld d, a
	ld a, [wObjectFollow_Leader]
	cp d
	jr nz, .asm_1633
	ld a, $ff
	ld [wObjectFollow_Leader], a
.asm_1633:
	ld a, [wObjectFollow_Follower]
	cp d
	jr nz, .asm_163e
	ld a, $0
	ld [wObjectFollow_Follower], a
.asm_163e:
	pop af
	call GetObjectStruct
	ld bc, OBJECT_LENGTH
	xor a
	call ByteFill
	ret

Function164a::
	call Function1617
	callab Function8125
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
	add $4
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld [hl], a
	ld a, [wYCoord]
	add $4
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld [hl], a
	ret

Function1680::
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

Function169f::
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	push af
	ld [hl], $ff
	inc hl
	ld bc, MAPOBJECT_LENGTH - 1
	xor a
	call ByteFill
	pop af
	cp $ff
	ret z
	cp $a
	ret nc
	ld b, a
	ld a, [wObjectFollow_Leader]
	cp b
	jr nz, .asm_16c5
	ld a, $ff
	ld [wObjectFollow_Leader], a
.asm_16c5:
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
	ld hl, $3
	add hl, bc
	ld [hl], $19
	ld hl, $8
	add hl, bc
	ld [hl], $0
	ld hl, wVramState
	set 7, [hl]
	and a
	ret

Function16fb::
	ld [wMovementObject], a
	ldh a, [hROMBank]
	ld [wMovementDataBank], a
	ld a, l
	ld [wMovementDataAddr], a
	ld a, h
	ld [wMovementDataAddr + 1], a
	ld a, [wMovementObject]
	call CheckObjectVisibility
	jr c, .asm_171f
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], $19
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], $0
.asm_171f:
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

PushToCmdQueue::
	push de
	call GetCmdQueueEmptySlot
	pop de
	ret c
	ld b, h
	ld c, l
	ld a, [de]
	inc de
	ld hl, $1
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, $2
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, $3
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, $d
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, $e
	add hl, bc
	ld [hl], a
	ld a, [de]
	inc de
	ld hl, $f
	add hl, bc
	ld [hl], a
	ldh a, [hMapObjectIndex]
	inc a
	ld hl, $0
	add hl, bc
	ld [hl], a
	push bc
	dec a
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld hl, $18
	add hl, de
	ld a, [hl]
	ld hl, $4
	add hl, bc
	ld [hl], a
	ld hl, $19
	add hl, de
	ld a, [hl]
	ld hl, $5
	add hl, bc
	ld [hl], a
	ret

GetCmdQueueEmptySlot::
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld a, 1
.asm_1796:
	ldh [hObjectStructIndex], a
	ld a, [hl]
	and a
	jr z, .asm_17a6
	add hl, de
	ldh a, [hObjectStructIndex]
	inc a
	cp 4 + 1
	jr nz, .asm_1796
	scf
	ret

.asm_17a6:
	xor a
	ret

UpdateSprites::
	ld a, [wVramState]
	bit 0, a
	ret z
	callab Function5007
	callab _UpdateSprites
	ret

GetObjectStruct::
; Puts the start of the a'th object struct into bc
	ld bc, OBJECT_LENGTH
	ld hl, wObjectStructs
	call AddNTimes
	ld b, h
	ld c, l
	ret

Function17cb::
	add $10

Function17cd::
	ld e, a
	ldh a, [hROMBank]
	push af
	ld a, BANK(Function862e)
	call Bankswitch
	call Function862e
	pop af
	call Bankswitch
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

Function17f9::
	call GetMapObject
	ld hl, $0
	add hl, bc
	ld a, [hl]
	cp $ff
	ret z
	call GetObjectStruct
	push bc
	call Function1828
	pop bc
	ld hl, $5
	add hl, bc
	res 5, [hl]
	ret

Function1813::
	call GetMapObject
	ld hl, $0
	add hl, bc
	ld a, [hl]
	cp $ff
	ret z
	call GetObjectStruct
	ld hl, $5
	add hl, bc
	set 5, [hl]
	ret

Function1828::
	ld bc, wObjectStructs
	xor a
.asm_182c:
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_183b
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 5, [hl]
.asm_183b:
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp 10
	jr nz, .asm_182c
	ret

Function1848::
	push bc
	ld bc, wObjectStructs
	xor a
.asm_184d:
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_185c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
.asm_185c:
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp 10
	jr nz, .asm_184d
	pop bc
	ret

Function186a::
	call GetMapObject
	ld hl, $0
	add hl, bc
	ld a, [hl]
	cp $ff
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 5, [hl]
	ret

Function187f::
	xor a
.asm_1880:
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
	jr nz, .asm_1880
	ret

._hl_:
	jp hl

Function18a0::
	ld a, [wcb70]
	and a
	ret z
	ldh a, [hROMBank]
	push af
	ld a, BANK(Function83e8)
	call Bankswitch
	call Function83e8
	pop af
	call Bankswitch
	ret

Function18b4::
	ld bc, wPlayerStruct
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set 3, [hl]
	set 2, [hl]
	set 1, [hl]
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 5, [hl]
	call Function18e5
	ret

Function18cc::
	ld hl, wPlayerFlags
	res 3, [hl]
	res 2, [hl]
	res 1, [hl]
	ld hl, wPlayerFlags + 1
	res 5, [hl]
	ld hl, wPlayerMovementType
	ld [hl], $10
	ld hl, wPlayerDirection
	ld [hl], $0
	ret

Function18e5::
	ld hl, OBJECT_WALKING
	add hl, bc
	ld a, [hl]
	srl a
	srl a
	and $3
	ld e, a
	ld d, $0
	ld hl, .Data
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_MOVEMENT_TYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], $0
	ret

.Data:
	db $05, $06, $07, $08

Function1908::
	call CheckObjectVisibility
	ret c
	push bc
	call Function191d
	pop bc
	ld hl, OBJECT_FLAGS1
	add hl, bc
	set 7, [hl]
	ldh a, [hObjectStructIndex]
	ld [wCenteredObject], a
	ret

Function191d::
	ld a, [wCenteredObject]
	cp $ff
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS1
	add hl, bc
	res 7, [hl]
	ld a, $ff
	ld [wCenteredObject], a
	ret

StartFollow::
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ld a, c
	call SetFollowerIfVisible
	callab QueueFollowerFirstStep
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
	ld [hl], $18
	ld hl, OBJECT_DIRECTION
	add hl, bc
	ld [hl], $0
	ldh a, [hObjectStructIndex]
	ld [wObjectFollow_Follower], a
	ret

ResetFollower::
	ld a, [wObjectFollow_Follower]
	and a
	ret z
	cp $ff
	ret z
	call GetObjectStruct
	call Function18e5
	ret

Function197e::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 0, [hl]
	ret

Function1989::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 0, [hl]
	ret

Function1994::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 4, [hl]
	ret

Function199f::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 4, [hl]
	ret

Function19aa::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	set 7, [hl]
	ret

Function19b5::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS2
	add hl, bc
	res 7, [hl]
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
	and $c
	ld hl, OBJECT_WALKING
	add hl, bc
	ld [hl], a
	ret
