include "constants.asm"

SECTION "Map Object Related Functions", ROM0 [$15b5]

Function15b5:: ; 15b5
	callab Function8000
	ret

GetMapObject:: ; 00:15be
	ld hl, wMapObjects
	ld bc, MAP_OBJECT_LENGTH
	call AddNTimes
	ld b, h
	ld c, l
	ret

GetMapObjectAttrPtr:: ; 15ca
	call GetMapObject
	ld d, $0
	add hl, de
	ret

Function15d1:: ; 15d1
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	call Function40eb
	ret

Function15da::
	ldh [hMapObjectIndexBuffer], a
	callab Function8131
	ldh a, [hMapObjectIndexBuffer]
	call GetMapObject
	call Function40eb
	ret

Function15ed::
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	ld a, $0
	ldh [hObjectStructIndexBuffer], a
	ld de, wObjectStructs
	callab Function813d
	ret

Function1602::
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	ld a, $2
	ldh [hObjectStructIndexBuffer], a
	ld de, wObject1Struct
	callab Function813d
	ret

Function1617:: ; 00:1617
	ldh [hMapObjectIndexBuffer], a
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
.asm_1633: ; 00:1633
	ld a, [wObjectFollow_Follower]
	cp d
	jr nz, .asm_163e
	ld a, $0
	ld [wObjectFollow_Follower], a
.asm_163e: ; 00:163e
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

Function1656::
	push hl
	call GetMapObject
	ld d, b
	ld e, c
	ld a, $ff
	ld [de], a
	inc de
	pop hl
	ld bc, MAP_OBJECT_TEMPLATE_LENGTH
	call CopyBytes
	ret

Function1668::
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
	ld hl, OBJECT_NEXT_MAP_X
	add hl, bc
	ld d, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, bc
	ld e, [hl]
	ldh a, [hMapObjectIndexBuffer]
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
	ld bc, MAP_OBJECT_LENGTH - 1
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
.asm_16c5: ; 00:16c5
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
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], $19
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], $0
.asm_171f: ; 00:171f
	ret

CheckObjectVisibility:: ; 00:1720
	ldh [hMapObjectIndexBuffer], a
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .asm_1735
	ldh [hObjectStructIndexBuffer], a
	call GetObjectStruct
	and a
	ret

.asm_1735: ; 00:1735
	scf
	ret

PushToCmdQueue:: ; 1737
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
	ldh a, [hMapObjectIndexBuffer]
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

GetCmdQueueEmptySlot:: ; 00:178e
	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld a, 1
.asm_1796: ; 00:1796
	ldh [hObjectStructIndexBuffer], a
	ld a, [hl]
	and a
	jr z, .asm_17a6
	add hl, de
	ldh a, [hObjectStructIndexBuffer]
	inc a
	cp 4 + 1
	jr nz, .asm_1796
	scf
	ret

.asm_17a6: ; 00:17a6
	xor a
	ret

UpdateSprites:: ; 00:17a8
	ld a, [wVramState]
	bit 0, a
	ret z
	callab Function5007
	callab Function5190
	ret

GetObjectStruct:: ; 00:17bf
	ld bc, $28
	ld hl, wObjectStructs
	call AddNTimes
	ld b, h
	ld c, l
	ret

Function17cb::
	add $10
	ld e, a
	ldh a, [hROMBank]
	push af
	ld a, BANK(Function862e)
	call Bankswitch
	call Function862e
	pop af
	call Bankswitch
	ret

Function17de::
	push hl
	push bc
	ld c, a
	ld b, $ff
	ld hl, .Data
.asm_17e6: ; 00:17e6
	ld a, [hli]
	cp b
	jr z, .asm_17ee
	cp c
	jr nz, .asm_17e6
	scf
.asm_17ee: ; 00:17ee
	pop bc
	pop hl
	ret

.Data: ; 00:17f1
	db $51, $55, $56, $57, $58, $5a, $5b, $ff

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

Function1828:: ; 00:1828
	ld bc, wObjectStructs
	xor a
.asm_182c: ; 00:182c
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_183b
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	set 5, [hl]
.asm_183b: ; 00:183b
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
.asm_184d: ; 00:184d
	push af
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_185c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	res 5, [hl]
.asm_185c: ; 00:185c
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
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	res 5, [hl]
	ret

Function187f::
	xor a
.asm_1880: ; 00:1880
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

._hl_: ; 00:189f
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
	ld hl, OBJECT_FLAGS
	add hl, bc
	set 3, [hl]
	set 2, [hl]
	set 1, [hl]
	ld hl, OBJECT_FLAGS + 1
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

Function18e5:: ; 00:18e5
	ld hl, OBJECT_DIRECTION_WALKING
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
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], a
	ld hl, OBJECT_FACING
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
	ld hl, OBJECT_FLAGS
	add hl, bc
	set 7, [hl]
	ldh a, [hObjectStructIndexBuffer]
	ld [wCenteredObject], a
	ret

Function191d:: ; 00:191d
	ld a, [wCenteredObject]
	cp $ff
	ret z
	call GetObjectStruct
	ld hl, OBJECT_FLAGS
	add hl, bc
	res 7, [hl]
	ld a, $ff
	ld [wCenteredObject], a
	ret

; 1932

StartFollow::
	push bc
	ld a, b
	call SetLeaderIfVisible
	pop bc
	ld a, c
	call SetFollowerIfVisible
	callab QueueFollowerFirstStep
	ret

SetLeaderIfVisible:: ; 00:1945
	call CheckObjectVisibility
	ret c
	ldh a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Leader], a
	ret

ResetLeader::
	xor a
	ld [wObjectFollow_Leader], a
	ret

SetFollowerIfVisible:: ; 00:1954
	push af
	call ResetFollower
	pop af
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_MOVEMENTTYPE
	add hl, bc
	ld [hl], $18
	ld hl, OBJECT_FACING
	add hl, bc
	ld [hl], $0
	ldh a, [hObjectStructIndexBuffer]
	ld [wObjectFollow_Follower], a
	ret

ResetFollower:: ; 00:196f
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
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	res 0, [hl]
	ret

Function1989::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	set 0, [hl]
	ret

Function1994::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	res 4, [hl]
	ret

Function199f::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	set 4, [hl]
	ret

Function19aa::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	set 7, [hl]
	ret

Function19b5::
	call CheckObjectVisibility
	ret c
	ld hl, OBJECT_FLAGS + 1
	add hl, bc
	res 7, [hl]
	ret

SetObjectFacing::
	push de
	call CheckObjectVisibility
	pop de
	ret c
	ld a, d
	add a
	add a
	and $c
	ld hl, OBJECT_DIRECTION_WALKING
	add hl, bc
	ld [hl], a
	ret
