INCLUDE "constants.asm"

SECTION "engine/dumps/bank02.asm@_SpawnPlayer", ROMX

_SpawnPlayer::
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
	call CenterObject
	ret

PlayerObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, SPRITEMOVEFN_OBEY_DPAD, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

SpawnFollower::
	call SetFollowerDefaultAttributes
	ld a, [wUsedSprites + 1]
	ld [wMap1ObjectSprite], a
	ld a, FOLLOWER
	call CopyMapObjectToFollowerObjectStruct
	ld b, PLAYER
	ld c, FOLLOWER
	call StartFollow
	ret

SetFollowerDefaultAttributes::
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
	object_event -4, -4, SPRITE_RHYDON, SPRITEMOVEFN_FOLLOW_2, 15, 15, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

DeleteFollower::
	ld a, FOLLOWER
	call DeleteMapObject
	xor a
	ld [wObjectFollow_Follower], a
	ld a, -1
	ld [wObjectFollow_Leader], a
	ret

DebugMapViewer_SetupGold::
	ld a, PLAYER_OBJECT_INDEX
	ld hl, .DebugMapViewer_GoldObjectTemplate
	call CopyPlayerObjectTemplate
	ld a, 1
	call Spawn_ConvertCoords
	ret

.DebugMapViewer_GoldObjectTemplate:
	object_event -4, -4, SPRITE_GOLD, $17, 14, 14, 0, 0, 0, 0, 0, 0, 0, 0
	db $00, $00

_InitializeVisibleSprites::
	ld bc, wMap2Object
	ld a, FOLLOWER + 1
.loop
	ldh [hMapObjectIndex], a
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
	call CopyObjectStruct
	pop bc
	jp c, .ret

.next
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.ret:
	ret

CopyObjectStruct:
	call CheckObjectMask
	and a
	ret nz ; masked

	ld hl, wObjectStructs + OBJECT_LENGTH * 3
	ld a, 3
	ld de, OBJECT_LENGTH
.loop
	ldh [hObjectStructIndex], a
	ld a, [hl]
	and a
	jr z, .done
	add hl, de
	ldh a, [hObjectStructIndex]
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
	bit SCRIPTED_MOVEMENT_STATE_F, a
	ret z

	ld hl, OBJECT_FLAGS2
	add hl, de
	set FROZEN_F, [hl]
	ret

CheckObjectMask:
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld a, [hl]
	ret

MaskObject:
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], -1 ; masked
	ret

UnmaskObject:
	ldh a, [hMapObjectIndex]
	ld e, a
	ld d, 0
	ld hl, wObjectMasks
	add hl, de
	ld [hl], 0 ; unmasked
	ret

CopyMapObjectToObjectStruct::
	ldh a, [hMapObjectIndex]
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld [hl], a

	ldh a, [hObjectStructIndex]
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld [hl], a

	ld hl, OBJECT_STEP_TYPE
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
	ld hl, OBJECT_SPRITE_Y
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
	ld hl, OBJECT_SPRITE_X
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

	ld hl, OBJECT_ACTION
	add hl, de
	ld [hl], 0

	ld hl, OBJECT_DIRECTION
	add hl, de
	ld [hl], 0

	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_SPRITE
	add hl, de
	ld [hl], a

	call GetSpriteVTile
	ld hl, OBJECT_SPRITE_TILE
	add hl, de
	ld [hl], a

	ld hl, MAPOBJECT_RADIUS
	add hl, bc
	ld a, [hl]
	call CopyMapObject_Radius

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
	ld [hl], COLLISION_OBJS | NOCLIP_NOT_SET | COLLISION_TILES
	ldh a, [hObjectStructIndex]
	push hl
	ld hl, wCenteredObject
	cp [hl]
	pop hl
	jr nz, .not_centered
	set CENTERED_OBJECT_F, [hl]

.not_centered
	cp PLAYER_OBJECT_INDEX
	jr z, .wont_delete
	cp FOLLOWER_OBJECT_INDEX
	jr nz, .will_delete

.wont_delete
	set WONT_DELETE_F, [hl]
.will_delete
	ld hl, OBJECT_FLAGS2
	add hl, de
	ld [hl], 0
	ldh a, [hObjectStructIndex]
	cp PLAYER_OBJECT_INDEX
	ret z
	set COLLISION_TILES_F, [hl]
	ret

CopyMapObject_Radius:
	push af
	swap a
	and $f
	inc a
	ld hl, OBJECT_RADIUS_X
	add hl, de
	ld [hl], a
	pop af
	and $f
	inc a
	ld hl, OBJECT_RADIUS_Y
	add hl, de
	ld [hl], a
	ret

GetSpriteVTile:
	push af
	ldh a, [hMapObjectIndex]
	cp PLAYER_OBJECT
	jr nz, .not_player
	pop af
	ld a, $0 ; offset of player tiles
	ret
.not_player
	cp FOLLOWER
	jr nz, .not_follower
	pop af
	ld a, $c ; offset of follower's tiles
	ret

.not_follower
	pop af
	push hl
	push de
	ld d, a
	ld e, 0
	ld hl, wUsedSprites + 2
.loop
	ld a, [hli]
	cp d
	jr z, .found

	inc e
	ld a, e
	cp SPRITE_GFX_LIST_CAPACITY - 2
	jr nz, .loop
	ld a, 0
	scf
	jr .done

.found
	ld hl, .VTileOffsets
	ld d, $00
	add hl, de
	ld a, [hl]
.done
	pop de
	pop hl
	ret

.VTileOffsets:
	db $18, $24, $30, $3c, $48, $54, $60, $6c, $78, $7c

CheckObjectEnteringVisibleRange:
	nop
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	jp CallJumptable

.dw:
	dw CheckVisibleRange_Down
	dw CheckVisibleRange_Up
	dw CheckVisibleRange_Left
	dw CheckVisibleRange_Right

Function8261:
	ret

Unreferenced_CheckObjectEnteringVisibleRange_Alternate:
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	ld hl, .dw
	jp CallJumptable

.dw:
	dw CheckVisibleRange_DownAlt
	dw CheckVisibleRange_UpAlt
	dw CheckVisibleRange_LeftAlt
	dw CheckVisibleRange_RightAlt

CheckVisibleRange_UpAlt:
	ld a, [wYCoord]
	sub 2
	jr CheckVisibleRange_Vertical

CheckVisibleRange_DownAlt:
	ld a, [wYCoord]
	add 10
	jr CheckVisibleRange_Vertical

CheckVisibleRange_LeftAlt:
	ld a, [wXCoord]
	sub 2
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_RightAlt:
	ld a, [wXCoord]
	add 11
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_Up:
	ld a, [wYCoord]
	sub 1
	jr CheckVisibleRange_Vertical

CheckVisibleRange_Down:
	ld a, [wYCoord]
	add 9
CheckVisibleRange_Vertical:
	ld d, a
	ld a, [wXCoord]
	ld e, a
	ld bc, wMap2Object
	ld a, 2
.loop_v
	ldh [hMapObjectIndex], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_v

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, d
	cp [hl]
	jr nz, .next_v

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_v

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, [hl]
	add 1
	sub e
	jr c, .next_v

	cp MAPOBJECT_SCREEN_WIDTH
	jr nc, .next_v

	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de
.next_v
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_v
	ret

CheckVisibleRange_Left:
	ld a, [wXCoord]
	sub 1
	jr CheckVisibleRange_Horizontal

CheckVisibleRange_Right:
	ld a, [wXCoord]
	add 10
CheckVisibleRange_Horizontal:
	ld e, a
	ld a, [wYCoord]
	ld d, a
	ld bc, wMap2Object
	ld a, 2
.loop_h
	ldh [hConnectionStripLength], a
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next_h

	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld a, e
	cp [hl]
	jr nz, .next_h

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .next_h

	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	add $01
	sub d
	jr c, .next_h

	cp MAPOBJECT_SCREEN_HEIGHT
	jr nc, .next_h

	push de
	push bc
	call CopyObjectStruct
	pop bc
	pop de
.next_h
	ld hl, MAPOBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECTS
	jr nz, .loop_h
	ret

; Determines path of object 'b' to map coordinates 'de' at speed 'c'.
; Makes the object invisible for the duration of the path.
ComputeObjectPathToCoords_Invisible::
	ld a, c
	push af
	call InitMovementBuffer
	ld a, movement_hide_object
	call AppendToMovementBuffer

	ld a, b
	call GetMapObject
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, bc
	ld a, [hl]
	cp -1
	jr z, .not_loaded

	call GetObjectStruct
	ld hl, OBJECT_MAP_Y
	add hl, bc
	ld a, [hl]
	ld hl, OBJECT_MAP_X
	add hl, bc
	ld b, [hl]
	ld c, a
	jr .done

.not_loaded
	ld hl, MAPOBJECT_Y_COORD
	add hl, bc
	ld a, [hl]
	ld hl, MAPOBJECT_X_COORD
	add hl, bc
	ld b, [hl]
	ld c, a
.done
	pop af
	call ComputePathToWalkToDestination
	ld a, movement_show_object
	call AppendToMovementBuffer
	ld a, movement_step_end
	call AppendToMovementBuffer
	xor a
	ret

; Determines path of object 'b' to map coordinates 'de' at speed 'c'.
Unreferenced_ComputeObjectPathToCoords::
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
	call ComputePathToWalkToDestination
	ld a, movement_step_end
	call AppendToMovementBuffer
	ret

Function83a2:
	push de
	call InitMovementBuffer
	pop de
	call Function83b0
	ld a, movement_step_end
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
	call ComputePathToWalkToDestination
	ret

_LoadMinorObjectGFX::
	ld hl, wQueuedMinorObjectGFX
	push hl
	ld a, [hl]
	ld l, a
	ld h, 0
	ld de, .MinorObjectGFX
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	push de
	ret

.MinorObjectGFX:
	dw .LoadNull
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

.LoadNull:
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
	ld de, vChars1 tile $78
	ld b, (HappyEmoteGFX.end - HappyEmoteGFX) / LEN_2BPP_TILE
	ld c, BANK(EmoteGFX)
	jp .FarCopy

.LoadJumpShadow:
	ld [hl], $00
	ld hl, JumpShadowGFX
	ld de, vChars1 tile $7c
	ld b, (JumpShadowGFX.end - JumpShadowGFX) / LEN_2BPP_TILE
	ld c, BANK(JumpShadowGFX)
	jp .FarCopy

.LoadUnknownBouncingOrb:
	ld [hl], $00
	ld hl, UnknownBouncingOrbGFX
	ld de, vChars1 tile $7c
	ld b, (UnknownBouncingOrbGFX.end - UnknownBouncingOrbGFX) / LEN_2BPP_TILE
	ld c, BANK(UnknownBouncingOrbGFX)
	jp .FarCopy

.LoadBoulderDust:
	ld [hl], $00
	ld hl, BoulderDustGFX
	ld de, vChars1 tile $7c
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

; a = d * sin(e * pi/32)
_Sine::
	ld a, e
	calc_sine_wave

Function86a0:
	call InitTownMap
	ld hl, ClearSpriteAnims
	ld a, BANK(ClearSpriteAnims)
	call FarCall_hl
	call PlaceGoldInMap
	call WaitBGMap
	call SetPalettes
.sub_86b4
	call DelayFrame
	call GetJoypadDebounced
	ld hl, PlaySpriteAnimations
	ld a, BANK(PlaySpriteAnimations)
	call FarCall_hl
	ld hl, hJoyDown
	ld a, [hl]
	and $03
	jr z, .sub_86b4
	ret

FlyMap:
	ld hl, hInMenu
	ld a, [hl]
	push af
	ld [hl], $01
	call InitTownMap
	ld hl, ClearSpriteAnims
	ld a, BANK(ClearSpriteAnims)
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

	callfar PlaySpriteAnimations

	ld hl, hJoyDown
	ld a, [hl]
	and $02
	jr nz, .sub_873e
	ld a, [hl]
	and $01
	jr nz, .sub_8743
	call Function8747

	callfar GetFlyPointMapLocation

	ld d, $00
	ld hl, LandmarkPositions
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
	ldh [hInMenu], a
	ret

; Choose fly destination based on D-Pad input
Function8747:
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, FlyPointPaths
	add hl, de
	ld de, hJoySum
	ld a, [de]
	and D_UP
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and D_DOWN
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and D_LEFT
	jr nz, .sub_876e
	inc hl
	ld a, [de]
	and D_RIGHT
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

Pokedex_GetArea:
	ld a, [wNestIconBlinkCounter]
	push af
	xor a
	ld [wNestIconBlinkCounter], a

	call InitTownMap
	ld de, PokedexNestIconGFX
	ld hl, vChars0 tile $7f
	lb bc, BANK(PokedexNestIconGFX), 1
	call Request1bpp

	call GetPokemonName
	hlcoord 4, 15
	call PlaceString

	hlcoord 9, 15
	ld de, .String_SNest
	call PlaceString

	call WaitBGMap
	call SetPalettes
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	callfar FindNest
.loop
	call .PlaceNest
	call GetJoypadDebounced
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr nz, .done

	ld hl, wNestIconBlinkCounter
	inc [hl]
	call DelayFrame
	jr .loop
.done
	pop af
	ld [wNestIconBlinkCounter], a
	ret

.String_SNest:
	db "の　すみか@"

.PlaceNest:
	ld a, [wNestIconBlinkCounter]
	and $10
	jr z, .done_nest

	ld de, wTileMap
	ld hl, wShadowOAMSprite00
.nestloop
	ld a, [de]
	and a
	ret z
	
	push de
	push hl
	ld e, a
	ld d, $00
	ld hl, LandmarkPositions
	add hl, de
	add hl, de
	ld e, l
	ld d, h

	; load into OAM
	pop hl
; X position
	ld a, [de]
	inc de
	sub 4
	ld [hli], a
; Y position
	ld a, [de]
	inc de
	sub 4
	ld [hli], a
; Nest icon -> Tile ID
	ld a, $7f
	ld [hli], a
; Blank out attributes
	xor a
	ld [hli], a
	
	pop de
	inc de
	jr .nestloop
.done_nest
	call ClearSprites
	ret

InitTownMap:
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
	hlcoord 0, 13
	ld b, 3
	ld c, 18
	call DrawTextBox

	ld a, 3
	call UpdateSoundNTimes
	call EnableLCD
	ld b, SGB_TOWN_MAP
	call GetSGBLayout
	ret

DecompTownMapTilemap:
	ld de, TownMapTilemap
.loop
	ld a, [de]
	and a
	ret z

	ld b, a
	inc de
	ld a, [de]
	ld c, a
	ld a, b
	add $60
.keep_placing_tile
	ld [hli], a
	dec c
	jr nz, .keep_placing_tile
	inc de
	jr .loop

PlaceGoldInMap:
	ld de, GoldSpriteGFX
	ld hl, vChars0
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp

	ld de, GoldSpriteGFX + 12 tiles
	ld hl, vChars0 tile $04
	lb bc, BANK(GoldSpriteGFX), $04
	call Request2bpp

	depixel 0, 0
	ld a, SPRITE_ANIM_OBJ_MAP_CHARACTER_ICON
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_TILE_ID
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
	ld hl, LandmarkPositions
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop bc
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

Function88b3:
	ld de, PidgeySpriteGFX
	ld hl, vChars0 tile $08
	lb bc, BANK(PidgeySpriteGFX), 4
	call Request2bpp
	
	ld de, PidgeySpriteGFX + 12 tiles
	ld hl, vChars0 tile $0c
	lb bc, BANK(PidgeySpriteGFX), 4
	call Request2bpp

	depixel 0, 0
	ld a, SPRITE_ANIM_OBJ_MAP_CHARACTER_ICON
	call InitSpriteAnimStruct

	ld hl, SPRITEANIMSTRUCT_TILE_ID
	add hl, bc
	ld [hl], 8
	ret

TownMapTilemap:
INCBIN "gfx/trainer_gear/town_map.tilemap.rle"
