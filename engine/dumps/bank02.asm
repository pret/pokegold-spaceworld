INCLUDE "constants.asm"

SECTION "engine/dumps/bank02.asm@SpawnPlayer", ROMX

SpawnPlayer:
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
	call Function1908
	ret

PlayerObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, $10, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

Function8031:
	call SpawnFollower
	ld a, [wUsedSprites+1]
	ld [wMap1ObjectSprite], a
	ld a, $01
	call Function1602
	ld b, PLAYER
	ld c, FOLLOWER
	call StartFollow
	ret

SpawnFollower:
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
	object_event -4, -4, SPRITE_RHYDON, $18, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

Function806c:
	ld a, $01
	call Function169f
	xor a
	ld [wObjectFollow_Follower], a
	ld a, $ff
	ld [wObjectFollow_Leader], a
	ret

Function807b:
	ld a, $01
	ld hl, Data8089
	call CopyPlayerObjectTemplate
	ld a, $01
	call Spawn_ConvertCoords
	ret

Data8089:
	object_event -4, -4, SPRITE_GOLD, $17, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

_InitializeVisibleSprites:
	ld bc, wMap2Object
	ld a, 2
.loop
	ldh [hConnectionStripLength], a
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
	call Function80eb
	pop bc
	jp c, .ret

.next
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.ret:
	ret

Function80eb:
	call Function811a
	and a
	ret nz ; masked

	ld hl, wObject1StructEnd
	ld a, $03
	ld de, OBJECT_LENGTH
.loop
	ldh [hConnectedMapWidth], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hConnectedMapWidth]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	scf
	ret ; overflow

.done
	ld d, h
	ld e, l
	call CopyMapObjectToObjectStruct
	ld a, [wVramState]
	bit 7, a
	ret z

	ld hl, OBJECT_FLAGS2
	add hl, de
	set 5, [hl]
	ret

Function811a:
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld a, [hl]
	ret

Function8125:
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld [hl], $ff
	ret

Function8131:
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld [hl], $00
	ret

CopyMapObjectToObjectStruct:
	ldh a, [hMapObjectIndex]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld [hl], a

	ldh a, [hObjectStructIndex]
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_DIRECTION
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
	ld hl, OBJECT_SPRITE_X_OFFSET
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
	ld hl, OBJECT_SPRITE_Y
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

	ld hl, OBJECT_STEP_DURATION
	add hl, de
	ld [hl], 0

	ld hl, OBJECT_WALKING
	add hl, de
	ld [hl], 0

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld [hl], a

	call Function820d
	ld hl, OBJECT_SPRITE_TILE
	add hl, de
	ld [hl], a

	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	call Function81f8

	ld hl, MAPOBJECT_SCRIPT_POINTER + 1
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_21
	add hl, de
	ld [hl], a
	and a
	ret

InitObjectFlags:
	ld hl, OBJECT_FLAGS1
	add hl, de
	ld [hl], $70
	ldh a, [hObjectStructIndex]
	push hl
	ld hl, wCenteredObject
	cp [hl]
	pop hl
	jr nz, .sub_81e0
	set 7, [hl]
.sub_81e0
	cp $01
	jr z, .sub_81e8
	cp $02
	jr nz, .sub_81ea
.sub_81e8
	set 1, [hl]
.sub_81ea
	ld hl, OBJECT_FLAGS2
	add hl, de
	ld [hl], $00
	ldh a, [hObjectStructIndex]
	cp $01
	ret z
	set 4, [hl]
	ret

Function81f8:
	push af
	swap a
	and $0f
	inc a
	ld hl, OBJECT_RADIUS
	add hl, de
	ld [hl], a
	pop af
	and $0f
	inc a
	ld hl, OBJECT_SPRITE_X
	add hl, de
	ld [hl], a
	ret

Function820d:
	push af
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT
	jr nz, .not_player
	pop af
	ld a, $00
	ret
.not_player
	cp $01
	jr nz, .sub_8220
	pop af
	ld a, $0c
	ret
.sub_8220
	pop af
	push hl
	push de
	ld d, a
	ld e, $00
	ld hl, wUsedNPCSprites
.sub_8229
	ld a, [hli]
	cp d
	jr z, .sub_8238
	inc e
	ld a, e
	cp $0a
	jr nz, .sub_8229
	ld a, $00
	scf
	jr .sub_823f
.sub_8238
	ld hl, Data8242
	ld d, $00
	add hl, de
	ld a, [hl]
.sub_823f
	pop de
	pop hl
	ret

Data8242:
	db $18, $24, $30, $3c, $48, $54, $60, $6c
	db $78, $7c

Function824c:
	nop
	ld a, [wPlayerStepDirection]
	cp $ff
	ret z
	ld hl, Table8259
	jp CallJumptable

Table8259:
	dw Function8299
	dw Function8292
	dw Function82e6
	dw Function82ed

Function8261:
	ret

Function8262:
	ld a, [wPlayerStepDirection]
	cp $ff
	ret z
	ld hl, Table826e
	jp CallJumptable

Table826e:
	dw Function827d
	dw Function8276
	dw Function8284
	dw Function828b

Function8276:
	ld a, [wYCoord]
	sub $02
	jr Function829e

Function827d:
	ld a, [wYCoord]
	add $0a
	jr Function829e

Function8284:
	ld a, [wXCoord]
	sub $02
	jr Function82f2

Function828b:
	ld a, [wXCoord]
	add $0b
	jr Function82f2

Function8292:
	ld a, [wYCoord]
	sub $01
	jr Function829e

Function8299:
	ld a, [wYCoord]
	add $09

Function829e:
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld bc, wMap2Object
	ld a, $02
.sub_82a8
	ldh [hConnectionStripLength], a
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_82d8
	ld hl, $0002
	add hl, bc
	ld a, d
	cp [hl]
	jr nz, .sub_82d8
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .sub_82d8
	ld hl, $0003
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_82d8
	cp $0c
	jr nc, .sub_82d8
	push de
	push bc
	call Function80eb
	pop bc
	pop de
.sub_82d8
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $10
	jr nz, .sub_82a8
	ret

Function82e6:
	ld a, [wXCoord]
	sub $01
	jr Function82f2

Function82ed:
	ld a, [wXCoord]
	add $0a

Function82f2:
	ld e, a
	ld a, [wYCoord]
	ld d, a
	ld bc, wMap2Object
	ld a, $02
.sub_82fc
	ldh [hConnectionStripLength], a
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_832c
	ld hl, $0003
	add hl, bc
	ld a, e
	cp [hl]
	jr nz, .sub_832c
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .sub_832c
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	add $01
	sub d
	jr c, .sub_832c
	cp $0b
	jr nc, .sub_832c
	push de
	push bc
	call Function80eb
	pop bc
	pop de
.sub_832c
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $10
	jr nz, .sub_82fc
	ret

Function833a:
	ld a, c
	push af
	call InitMovementBuffer
	ld a, $29
	call AppendToMovementBuffer
	ld a, b
	call GetMapObject
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .sub_8361
	call GetObjectStruct
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	ld hl, $0010
	add hl, bc
	ld b, [hl]
	ld c, a
	jr .sub_836c
.sub_8361
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	ld hl, $0003
	add hl, bc
	ld b, [hl]
	ld c, a
.sub_836c
	pop af
	call ComputePathToWalkToPlayer
	ld a, $28
	call AppendToMovementBuffer
	ld a, $32
	call AppendToMovementBuffer
	xor a
	ret

Function837c:
	call InitMovementBuffer
	push bc
	ld a, b
	call GetMapObject
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	ld hl, $0011
	add hl, bc
	ld c, [hl]
	ld b, a
	pop hl
	ld a, l
	call ComputePathToWalkToPlayer
	ld a, $32
	call AppendToMovementBuffer
	ret

Function83a2:
	push de
	call InitMovementBuffer
	pop de
	call Function83b0
	ld a, $32
	call AppendToMovementBuffer
	ret

Function83b0:
	push de
	push bc
	ld a, c
	call GetMapObject
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ld a, b
	call GetMapObject
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	call GetObjectStruct
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	ld hl, $0011
	add hl, bc
	ld c, [hl]
	ld b, a
	ld hl, $0010
	add hl, de
	ld a, [hl]
	ld hl, $0011
	add hl, de
	ld e, [hl]
	ld d, a
	pop af
	call ComputePathToWalkToPlayer
	ret

Function83e8:
	ld hl, wcb70
	push hl
	ld a, [hl]
	ld l, a
	ld h, $00
	ld de, .Table83fb
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	push de
	ret

.Table83fb:
	dw .LoadDone
	dw .LoadJumpShadow
	dw .LoadUnknownBouncingOrb
	dw .LoadShockEmote
	dw .LoadQuestionEmote
	dw .LoadHappyEmote
	dw .LoadBoulderDust
	dw .LoadGrampsSpriteStandPt0
	dw .LoadGrampsSpriteStandPt1
	dw .LoadGrampsSpriteWalkPt0
	dw .LoadGrampsSpriteWalkPt1
	dw .LoadClefairySpriteStandPt0
	dw .LoadClefairySpriteStandPt1
	dw .LoadClefairySpriteWalkPt0
	dw .LoadClefairySpriteWalkPt1

.FarCopy:
	ld a, c
	ld [wVBCopyFarSrcBank], a
	ld a, l
	ld [wVBCopyFarSrc], a
	ld a, h
	ld [wVBCopyFarSrc+1], a
.ContinueFarCopyNewDst:
	ld a, e
	ld [wVBCopyFarDst], a
	ld a, d
	ld [wVBCopyFarDst+1], a
.ContinueFarCopy:
	ld a, b
	ld [wVBCopyFarSize], a
	ret

.LoadDone:
	ret

.LoadShockEmote:
	ld hl, ShockEmoteGFX
	jr .load_emote
.LoadQuestionEmote:
	ld hl, QuestionEmoteGFX
	jr .load_emote
.LoadHappyEmote:
	ld hl, HappyEmoteGFX
.load_emote:
	ld de, vChars1 + $780
	ld b, (HappyEmoteGFX.end - HappyEmoteGFX) / LEN_2BPP_TILE
	ld c, BANK(EmoteGFX)
	jp .FarCopy

.LoadJumpShadow:
	ld [hl], $00
	ld hl, JumpShadowGFX
	ld de, vChars1 + $7c0
	ld b, (JumpShadowGFX.end - JumpShadowGFX) / LEN_2BPP_TILE
	ld c, BANK(JumpShadowGFX)
	jp .FarCopy

.LoadUnknownBouncingOrb:
	ld [hl], $00
	ld hl, UnknownBouncingOrbGFX
	ld de, vChars1 + $7c0
	ld b, (UnknownBouncingOrbGFX.end - UnknownBouncingOrbGFX) / LEN_2BPP_TILE
	ld c, BANK(UnknownBouncingOrbGFX)
	jp .FarCopy

.LoadBoulderDust:
	ld [hl], $00
	ld hl, BoulderDustGFX
	ld de, vChars1 + $7c0
	ld b, (BoulderDustGFX.end - BoulderDustGFX) / LEN_2BPP_TILE
	ld c, BANK(BoulderDustGFX)
	jp .FarCopy

.LoadGrampsSpriteStandPt0:
	inc [hl]
	ld hl, GrampsSpriteGFX
	ld de, vChars0
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	ld c, BANK(GrampsSpriteGFX)
	jp .FarCopy

.LoadGrampsSpriteStandPt1:
	inc [hl]
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadGrampsSpriteWalkPt0:
	inc [hl]
	ld de, vChars1
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopyNewDst

.LoadGrampsSpriteWalkPt1:
	ld [hl], $00
	ld b, (GrampsSpriteGFX.end - GrampsSpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadClefairySpriteStandPt0:
	inc [hl]
	ld hl, ClefairySpriteGFX
	ld de, vChars0
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	ld c, BANK(ClefairySpriteGFX)
	jp .FarCopy

.LoadClefairySpriteStandPt1:
	inc [hl]
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

.LoadClefairySpriteWalkPt0:
	inc [hl]
	ld de, vChars1
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopyNewDst

.LoadClefairySpriteWalkPt1:
	ld [hl], $00
	ld b, (ClefairySpriteGFX.end - ClefairySpriteGFX) / LEN_2BPP_TILE / 4
	jp .ContinueFarCopy

SECTION "engine/dumps/bank02.asm@QueueFollowerFirstStep", ROMX

QueueFollowerFirstStep:
	call Function85f2
	jr c, .sub_85ec
	ld [wFollowMovementQueue], a
	xor a
	ld [wFollowerMovementQueueLength], a
	ret
.sub_85ec
	ld a, $ff
	ld [wFollowerMovementQueueLength], a
	ret

Function85f2:
	ld a, [wObjectFollow_Leader]
	call GetObjectStruct
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	ld a, [wObjectFollow_Follower]
	call GetObjectStruct
	ld hl, $0010
	add hl, bc
	ld a, d
	cp [hl]
	jr z, .sub_861a
	jr c, .sub_8616
	and a
	ld a, $0b
	ret
.sub_8616
	and a
	ld a, $0a
	ret
.sub_861a
	ld hl, $0011
	add hl, bc
	ld a, e
	cp [hl]
	jr z, .sub_862c
	jr c, .sub_8628
	and a
	ld a, $08
	ret
.sub_8628
	and a
	ld a, $09
	ret
.sub_862c
	scf
	ret

Function862e:
	ld a, e
	and $3f
	cp $20
	jr nc, .sub_863a
	call Function8644
	ld a, h
	ret
.sub_863a
	and $1f
	call Function8644
	ld a, h
	xor $ff
	inc a
	ret

Function8644:
	ld e, a
	ld a, d
	ld d, $00
	ld hl, Data8660
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $0000
.sub_8653
	srl a
	jr nc, .sub_8658
	add hl, de
.sub_8658
	sla e
	rl d
	and a
	jr nz, .sub_8653
	ret

Data8660:
	dw $00
	dw $19
	dw $32
	dw $4a
	dw $62
	dw $79
	dw $8e
	dw $a2
	dw $b5
	dw $c6
	dw $d5
	dw $e2
	dw $ed
	dw $f5
	dw $fb
	dw $ff
	dw $100
	dw $ff
	dw $fb
	dw $f5
	dw $ed
	dw $e2
	dw $d5
	dw $c6
	dw $b5
	dw $a2
	dw $8e
	dw $79
	dw $62
	dw $4a
	dw $32
	dw $19

Function86a0:
	call Function881e
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call PlaceGoldInMap
	call WaitBGMap
	call SetPalettes
.sub_86b4
	call DelayFrame
	call GetJoypadDebounced
	ld hl, EffectObjectJumpNoDelay
	ld a, BANK(EffectObjectJumpNoDelay)
	call FarCall_hl
	ld hl, hJoyDown
	ld a, [hl]
	and $03
	jr z, .sub_86b4
	ret

FlyMap:
	ld hl, hJoyDebounceSrc
	ld a, [hl]
	push af
	ld [hl], $01
	call Function881e
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call PlaceGoldInMap
	call Function88b3
	ld hl, wcb60
	ld [hl], c
	inc hl
	ld [hl], b
	coord hl, 1, 15
	ld de, Text8776
	call PlaceString
	call WaitBGMap
	call SetPalettes
	xor a
	ld [wFlyDestination], a
.sub_86fc
	call DelayFrame
	call GetJoypadDebounced
	ld hl, EffectObjectJumpNoDelay
	ld a, BANK(EffectObjectJumpNoDelay)
	call FarCall_hl
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	jr nz, .sub_873e
	ld a, [hl]
	and $01
	jr nz, .sub_8743
	call Function8747
	ld hl, Functionc77d
	ld a, BANK(Functionc77d)
	call FarCall_hl
	ld d, $00
	ld hl, Data8a53
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, wcb60
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, $0004
	add hl, bc
	ld [hl], e
	ld hl, $0005
	add hl, bc
	ld [hl], d
	jr .sub_86fc
.sub_873e
	ld a, $ff
	ld [wFlyDestination], a
.sub_8743
	pop af
	ldh [hJoyDebounceSrc], a
	ret

Function8747:
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, Data8a17
	add hl, de
	ld de, hJoySum
	ld a, [de]
	and $40
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and $80
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and $20
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and $10
	jr nz, .sub_876e
	ret
.sub_876e
	ld a, [hl]
	cp $ff
	ret z
	ld [wFlyDestination], a
	ret

Text8776:
	db "とびさき　を　えらんでください@"

Function8786:
	ld a, [wFlyDestination]
	push af
	xor a
	ld [wFlyDestination], a
	call Function881e
	ld de, PokedexNestIconGFX
	ld hl, vChars0 + $7f0
	lb bc, BANK(PokedexNestIconGFX), $01
	call Request1bpp
	call GetPokemonName
	coord hl, 4, 15
	call PlaceString
	coord hl, 9, 15
	ld de, Text87e4
	call PlaceString
	call WaitBGMap
	call SetPalettes
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, $0168
	xor a
	call ByteFill
	ld hl, Function3e9dc
	ld a, BANK(Function3e9dc)
	call FarCall_hl
.sub_87ca
	call Function87ea
	call GetJoypadDebounced
	ldh a, [hJoyDown]
	and $03
	jr nz, .sub_87df
	ld hl, wFlyDestination
	inc [hl]
	call DelayFrame
	jr .sub_87ca
.sub_87df
	pop af
	ld [wFlyDestination], a
	ret

Text87e4:
	db "の　すみか@"

Function87ea:
	ld a, [wFlyDestination]
	and $10
	jr z, .sub_881a
	ld de, wTileMap
	ld hl, wShadowOAM
.sub_87f7
	ld a, [de]
	and a
	ret z
	push de
	push hl
	ld e, a
	ld d, $00
	ld hl, Data8a53
	add hl, de
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	inc de
	sub $04
	ld [hli], a
	ld a, [de]
	inc de
	sub $04
	ld [hli], a
	ld a, $7f
	ld [hli], a
	xor a
	ld [hli], a
	pop de
	inc de
	jr .sub_87f7
.sub_881a
	call ClearSprites
	ret

Function881e:
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call DisableLCD
	ld hl, TownMapGFX
	ld de, vTilesetEnd
	ld bc, TownMapGFX.End - TownMapGFX
	ld a, BANK(TownMapGFX)
	call FarCopyData
	ld hl, wTileMap
	call DecompTownMapTilemap
	coord hl, 0, 13
	ld b, $03
	ld c, $12
	call DrawTextBox
	ld a, $03
	call UpdateSoundNTimes
	call EnableLCD
	ld b, $02
	call GetSGBLayout
	ret

DecompTownMapTilemap:
	ld de, TownMapTilemap
.sub_8859
	ld a, [de]
	and a
	ret z
	ld b, a
	inc de
	ld a, [de]
	ld c, a
	ld a, b
	add $60
.sub_8863
	ld [hli], a
	dec c
	jr nz, .sub_8863
	inc de
	jr .sub_8859

PlaceGoldInMap:
	ld de, GoldSpriteGFX
	ld hl, vChars0
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp
	ld de, GoldSpriteGFX + $c0
	ld hl, vChars0 + $40
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_41
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $00
	push bc
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	call GetWorldMapLocation
	ld e, a
	ld d, $00
	ld hl, Data8a53
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop bc
	ld hl, $0004
	add hl, bc
	ld [hl], e
	ld hl, $0005
	add hl, bc
	ld [hl], d
	ret

Function88b3:
	ld de, PidgeySpriteGFX
	ld hl, vChars0 + $80
	lb bc, BANK(PidgeySpriteGFX), $04
	call Request2bpp
	ld de, PidgeySpriteGFX + $c0
	ld hl, vChars0 + $c0
	lb bc, BANK(PidgeySpriteGFX), $04
	call Request2bpp
	depixel 0, 0
	ld a, SPRITE_ANIM_INDEX_41
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $08
	ret

TownMapTilemap:
INCBIN "gfx/trainer_gear/town_map.tilemap.rle"

SECTION "engine/dumps/bank02.asm@Data8a17", ROMX

Data8a17:
	db $0b
	db $ff

	db $01, $0a, $03, $00, $02, $00, $05, $01, $03, $01, $04, $02, $0d, $02
	db $0d, $03, $0d, $05, $04, $02, $04, $06, $07
	db $ff

	db $05, $08
	db $ff

	db $06
	db $ff

	db $ff

	db $0e, $09, $06, $0e, $08, $0a, $0a
	db $08, $09, $00, $00, $09, $0c, $00
	db $ff

	db $ff

	db $ff

	db $0b
	db $ff

	db $ff

	db $04, $03
	db $ff

	db $04
	db $ff

	db $08, $08
	db $ff

Data8a53:
	db $00, $00, $1c, $9c, $28, $9c, $34, $9c
	db $40, $9c, $4c, $9c, $5c, $9c, $6c, $94
	db $6c, $84, $6c, $78, $6c, $6c, $64, $6c
	db $5c, $6c, $6c, $64, $6c, $5c, $5c, $5c
	db $5c, $50, $5c, $44, $50, $44, $44, $44
	db $44, $5c, $44, $6c, $4c, $74, $4c, $7c
	db $40, $7c, $34, $7c, $4c, $84, $3c, $8c
	db $34, $94, $5c, $80, $54, $68, $3c, $38
	db $3c, $2c, $34, $2c, $2c, $20, $34, $14
	db $3c, $14, $3c, $20, $48, $14, $54, $1c
	db $54, $2c, $54, $38, $3c, $44, $48, $2c

