INCLUDE "constants.asm"

SECTION "engine/dumps/bank02.asm@Function8000", ROMX

Function8000:
	ld a, $00
	ld hl, Data8022
	call Function1656
	call Function1668
	ld a, $01
	ldh [hConnectedMapWidth], a
	ld de, wPlayerSprite
	ld a, $00
	ldh [hConnectionStripLength], a
	ld bc, wMapObjects
	call Function813d
	ld a, $00
	call Function1908
	ret

Data8022:
	db $01, $00, $00, $10, $ee, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

Function8031:
	call Function8047
	ld a, [wUsedSprites+1]
	ld [wMap1ObjectSprite], a
	ld a, $01
	call Function1602
	ld b, $00
	ld c, $01
	call StartFollow
	ret

Function8047:
	ld a, $01
	ld hl, Data805d
	call Function1656
	ld a, [wPlayerNextMapX]
	ld [wMap1ObjectXCoord], a
	ld a, [wPlayerNextMapY]
	dec a
	ld [wMap1ObjectYCoord], a
	ret

Data805d:
	db $4d, $00, $00, $18, $ff, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

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
	call Function1656
	ld a, $01
	call Function1668
	ret

Data8089:
	db $01, $00, $00, $17, $ee, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

_InitializeVisibleSprites:
	ld bc, wMap2Object
	ld a, $02
.sub_809d
	ldh [hConnectionStripLength], a
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_80dc
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .sub_80dc
	ld a, [wXCoord]
	ld d, a
	ld a, [wYCoord]
	ld e, a
	ld hl, $0003
	add hl, bc
	ld a, [hl]
	add $01
	sub d
	jr c, .sub_80dc
	cp $0c
	jr nc, .sub_80dc
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_80dc
	cp $0b
	jr nc, .sub_80dc
	push bc
	call Function80eb
	pop bc
	jp c, Function80ea
.sub_80dc
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $10
	jr nz, .sub_809d
	ret

Function80ea:
	ret

Function80eb:
	call Function811a
	and a
	ret nz
	ld hl, wObject1StructEnd
	ld a, $03
	ld de, $0028
.sub_80f8
	ldh [hConnectedMapWidth], a
	ld a, [hl]
	and a
	jr z, .sub_8108
	add hl, de
	ldh a, [hConnectedMapWidth]
	inc a
	cp $0a
	jr nz, .sub_80f8
	scf
	ret
.sub_8108
	ld d, h
	ld e, l
	call Function813d
	ld a, [wVramState]
	bit 7, a
	ret z
	ld hl, $0005
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

Function813d:
	ldh a, [hConnectionStripLength]
	ld hl, $0001
	add hl, de
	ld [hl], a
	ldh a, [hConnectedMapWidth]
	ld hl, $0000
	add hl, bc
	ld [hl], a
	ld hl, $0008
	add hl, de
	ld [hl], $00
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	ld hl, $0015
	add hl, de
	ld [hl], a
	ld hl, $0011
	add hl, de
	ld [hl], a
	ld hl, wYCoord
	sub [hl]
	and $0f
	swap a
	ld hl, $0019
	add hl, de
	ld [hl], a
	ld hl, $0003
	add hl, bc
	ld a, [hl]
	ld hl, $0014
	add hl, de
	ld [hl], a
	ld hl, $0010
	add hl, de
	ld [hl], a
	ld hl, wXCoord
	sub [hl]
	and $0f
	swap a
	ld hl, $0018
	add hl, de
	ld [hl], a
	ld hl, $0004
	add hl, bc
	ld a, [hl]
	ld hl, $0003
	add hl, de
	ld [hl], a
	call Function81ce
	ld hl, $000d
	add hl, de
	ld [hl], $ff
	ld hl, $000a
	add hl, de
	ld [hl], $00
	ld hl, $0007
	add hl, de
	ld [hl], $00
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	ld hl, $0000
	add hl, de
	ld [hl], a
	call Function820d
	ld hl, $0002
	add hl, de
	ld [hl], a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	call Function81f8
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	ld hl, $0021
	add hl, de
	ld [hl], a
	and a
	ret

Function81ce:
	ld hl, $0004
	add hl, de
	ld [hl], $70
	ldh a, [hConnectedMapWidth]
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
	ld hl, $0005
	add hl, de
	ld [hl], $00
	ldh a, [hConnectedMapWidth]
	cp $01
	ret z
	set 4, [hl]
	ret

Function81f8:
	push af
	swap a
	and $0f
	inc a
	ld hl, $0016
	add hl, de
	ld [hl], a
	pop af
	and $0f
	inc a
	ld hl, $0017
	add hl, de
	ld [hl], a
	ret

Function820d:
	push af
	ldh a, [hConnectionStripLength]
	cp $00
	jr nz, .sub_8218
	pop af
	ld a, $00
	ret
.sub_8218
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
	ld de, Table83fb
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	push de
	ret

Table83fb:
	dw Function8432
	dw Function844a
	dw Function8459
	dw Function8433
	dw Function8438
	dw Function843d
	dw Function8468
	dw Function8477
	dw Function8485
	dw Function848b
	dw Function8494
	dw Function849b
	dw Function84a9
	dw Function84af
	dw Function84b8

Function8419:
	ld a, c
	ld [wVBCopyFarSrcBank], a
	ld a, l
	ld [wVBCopyFarSrc], a
	ld a, h
	ld [wVBCopyFarSrc+1], a

Function8425:
	ld a, e
	ld [wVBCopyFarDst], a
	ld a, d
	ld [wVBCopyFarDst+1], a

Function842d:
	ld a, b
	ld [wVBCopyFarSize], a
	ret

Function8432:
	ret

Function8433:
	ld hl, ShockEmoteGFX
	jr Function8440

Function8438:
	ld hl, QuestionEmoteGFX
	jr Function8440

Function843d:
	ld hl, HappyEmoteGFX

Function8440:
	ld de, vChars1 + $780
	ld b, $04
	ld c, BANK(HappyEmoteGFX)
	jp Function8419

Function844a:
	ld [hl], $00
	ld hl, JumpShadowGFX
	ld de, vChars1 + $7c0
	ld b, $01
	ld c, BANK(JumpShadowGFX)
	jp Function8419

Function8459:
	ld [hl], $00
	ld hl, UnknownBouncingOrbGFX
	ld de, vChars1 + $7c0
	ld b, $04
	ld c, BANK(UnknownBouncingOrbGFX)
	jp Function8419

Function8468:
	ld [hl], $00
	ld hl, UnknownBallGFX
	ld de, vChars1 + $7c0
	ld b, $01
	ld c, BANK(UnknownBallGFX)
	jp Function8419

Function8477:
	inc [hl]
	ld hl, GrampsSpriteGFX
	ld de, vChars0
	ld b, $06
	ld c, BANK(GrampsSpriteGFX)
	jp Function8419

Function8485:
	inc [hl]
	ld b, $06
	jp Function842d

Function848b:
	inc [hl]
	ld de, vChars1
	ld b, $06
	jp Function8425

Function8494:
	ld [hl], $00
	ld b, $06
	jp Function842d

Function849b:
	inc [hl]
	ld hl, ClefairySpriteGFX
	ld de, vChars0
	ld b, $06
	ld c, BANK(ClefairySpriteGFX)
	jp Function8419

Function84a9:
	inc [hl]
	ld b, $06
	jp Function842d

Function84af:
	inc [hl]
	ld de, vChars1
	ld b, $06
	jp Function8425

Function84b8:
	ld [hl], $00
	ld b, $06
	jp Function842d

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
	ld hl, wVirtualOAM
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

SECTION "engine/dumps/bank02.asm@SetTitleBGDecorationBorder", ROMX

SetTitleBGDecorationBorder:
	ld de, TitleBGDecorationBorder
	ld hl, vChars2 + $500
	lb bc, BANK(TitleBGDecorationBorder), $09
	call Request2bpp
	coord hl, 0, 8
	ld b, $50
	call Function91ef
	coord hl, 0, 16
	ld b, $54
	call Function91ef
	ret

Function91ef:
	xor a
	ld c, $14
.sub_91f2
	and $03
	or b
	ld [hli], a
	inc a
	dec c
	jr nz, .sub_91f2
	ret

SECTION "engine/dumps/bank02.asm@Function928b", ROMX

LoadSGBLayout:
	ld a, b
	cp $ff
	jr nz, .not_ram
	ld a, [wccd0]
.not_ram
	cp $fc
	jp z, SGB_ApplyPartyMenuHPPals
	ld l, a
	ld h, 0
	add hl, hl
	ld de, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, _LoadSGBLayout_ReturnFromJumpTable
	push de
	jp hl

.Jumptable:
	dw SGB_BattleGrayscale
	dw SGB_BattleColors
	dw SGB_TownMap
	dw SGB_StatsScreenHPPals
	dw SGB_Pokedex
	dw SGB_SlotMachine
	dw SGB_TitleScreen
	dw SGB_GSIntro
	dw SGB_Diploma
	dw SGB_MapPals
	dw SGB_PartyMenu
	dw SGB_Evolution
	dw SGB_GFIntro
	dw SGB_TrainerCard
	dw SGB0e
	dw SGB_PikachuMinigame
	dw SGB_PokedexSelection
	dw SGB_Poker
	dw SGB12
	dw SGB_TrainerGear
	dw SGB_TrainerGearMap
	dw SGB_TrainerGearRadio

SGB_BattleGrayscale:
	ld hl, PalPacket_BattleGrayscale
	ld de, BlkPacket_Battle
	ret

SGB_BattleColors:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes

	ld a, [wca3f]
	ld hl, wca02
	call Function9567
	jr c, .sub_92f7

	ld e, $00
	call Function9599
.sub_92f7
	ld b, a
	ld a, [wca44]
	ld hl, wcdd7
	call Function9567
	jr c, .sub_9308
	ld e, $01
	call Function9599
.sub_9308
	ld c, a
	ld hl, wcce2
	ld a, [wccd1]
	add $23
	ld [hli], a
	inc hl
	ld a, [wccd2]
	add $23
	ld [hli], a
	inc hl
	ld a, b
	ld [hli], a
	inc hl
	ld a, c
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_Battle
	ld a, $01
	ld [wccd0], a
	ret

SGB0e:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, wcce2
	ld [hl], $10
	inc hl
	inc hl
	ld a, [wccd1]
	add $23
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_98bc
	ret

SGB_TownMap:
	ld hl, Data99fc
	ld de, BlkPacket_986c
	ret

SGB_StatsScreenHPPals:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wMonDexIndex]
	call Function956d
	call Function957e
	push af
	ld hl, wcce2
	ld a, [wccd9]
	add $23
	ld [hli], a
	inc hl
	pop af
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_StatsScreen
	ret

SGB_PartyMenu:
	ld hl, PalPacket_PartyMenu
	ld de, wcce2
	ret

SGB_Pokedex:
	ld hl, PalPacket_Pokedex
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, [wMonDexIndex]
	call Function956d
	ld hl, wcce4
	ld [hl], a
	ld hl, wcce1
	ld de, BlkPacket_Pokedex
	ret

SGB_PokedexSelection:
	ld hl, PalPacket_99bc
	ld de, BlkPacket_986c
	ret

SGB_SlotMachine:
	ld hl, PalPacket_SlotMachine
	ld de, BlkPacket_SlotMachine
	ret

SGB_TitleScreen:
	ld hl, PalPacket_TitleScreen
	ld de, BlkPacket_TitleScreen
	ret

SGB_Diploma:
	ld hl, PalPacket_9a3c
	ld de, BlkPacket_986c
	ret

SGB_GSIntro:
	ld b, 0
	ld hl, .BlkPacketTable
rept 4
	add hl, bc
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.BlkPacketTable:
	dw BlkPacket_986c, PalPacket_GSIntroShellderLapras
	dw BlkPacket_GSIntroJigglypuffPikachu, PalPacket_GSIntroJigglypuffPikachu
	dw BlkPacket_986c, PalPacket_GSIntroStartersTransition

SGB_GFIntro:
	ld hl, PalPacket_GFIntro
	ld de, BlkPacket_986c
	ld a, $08
	ld [wccd0], a
	ret

SGB_PikachuMinigame:
	ld hl, PalPacket_PikachuMinigame
	ld de, BlkPacket_986c
	ret

SGB_Poker:
	ld hl, BlkPacket_986c
	ld de, wc51a
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, PalPacket_Poker
	ld de, BlkPacket_986c
	ret

SGB_MapPals:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wcce2
	ld [hld], a
	ld de, BlkPacket_986c
	ld a, $09
	ld [wccd0], a
	ret

SGB_Evolution:
	push bc
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	pop bc
	ld a, c
	and a
	ld a, $0e
	jr nz, .sub_9437
	ld a, [wccd1]
	call Function956d
	call Function957e
.sub_9437
	ld [wcce2], a
	ld hl, wcce1
	ld de, BlkPacket_986c
	ret

SGB_TrainerCard:
	ld hl, PalPacket_9a3c
	ld de, BlkPacket_986c
	ret

SGB12:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld hl, BlkPacket_986c
	ld de, wccf1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	call GetMapPalsIndex
	ld hl, wcce2
	ld [hl], a
	ld a, [wMonDexIndex]
	call Function956d
	ld hl, wcce4
	ld [hl], a
	ld hl, wccf4
	ld a, $05
	ld [hli], a
	ld a, [wMenuBorderLeftCoord]
	ld [hli], a
	ld a, [wMenuBorderTopCoord]
	ld [hli], a
	ld a, [wMenuBorderRightCoord]
	ld [hli], a
	ld a, [wMenuBorderBottomCoord]
	ld [hl], a
	ld hl, wcce1
	ld de, wccf1
	ret

SGB_TrainerGear:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $30
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearMap:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $26
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

SGB_TrainerGearRadio:
	ld hl, PalPacket_995c
	ld de, wcce1
	ld bc, PALPACKET_LENGTH
	call CopyBytes
	ld a, $16
	ld [wcce2], a
	ld a, $39
	ld [wcce4], a
	ld hl, wcce1
	ld de, BlkPacket_TrainerGear
	ret

GetMapPalsIndex:
	ld a, [wMapPermissions]
	cp ROUTE
	jr z, .is_route
	cp CAVE
	jr z, .is_cave
	cp GATE
	jr z, .is_gate
	cp ENVIRONMENT_5
	jr z, .env5
	cp INDOOR
	jr z, .indoors
	call Function9527
	jr c, .sub_9524
	call Function9543
	ret

.indoors
	call Function9536
	jr c, .sub_9524
	call Function9543
	ret

.is_route
	call Function9527
	jr c, .sub_9524
	ld a, $00
	ret

.is_cave
	call Function9527
	jr c, .sub_9524
	ld a, $0c
	ret

.is_gate
	ld a, $03
	ret

.env5
	ld a, $04
	ret

.sub_9524
	ld a, $0d
	ret

Function9527:
	ld a, [wTimeOfDay]
	and $03
	jr z, .sub_9534
	cp $03
	jr z, .sub_9534
	scf
	ret
.sub_9534
	and a
	ret

Function9536:
	ld a, [wTimeOfDay]
	and $03
	cp $02
	jr nz, .sub_9541
	scf
	ret
.sub_9541
	and a
	ret

Function9543:
	ld a, [wMapGroup]
	ld e, a
	ld d, $00
	ld hl, Data954f
	add hl, de
	ld a, [hl]
	ret

Data954f:
	db $01, $07, $0c, $03, $08, $06, $0b, $04
	db $05, $0a, $02, $03, $02, $02, $09, $01

_LoadSGBLayout_ReturnFromJumpTable:
	push de
	call PushSGBPals
	pop hl
	jp PushSGBPals

Function9567:
	bit 3, a
	ld a, $18
	ret nz
	ld a, [hl]

Function956d:
	and a
	jr z, .sub_957a
	ld e, a
	ld d, $00
	ld hl, PokemonPalettes
	add hl, de
	ld a, [hl]
	and a
	ret
.sub_957a
	ld a, $0f
	scf
	ret

Function957e:
	push bc
	push af
	ld hl, wPartyMon1DVs
	ld a, [wWhichPokemon]
	ld bc, $0030
	call AddNTimes
	call Function95b0
	ld b, $00
	jr nc, .sub_9595
	ld b, $0a
.sub_9595
	pop af
	add b
	pop bc
	ret

Function9599:
	push bc
	push af
	ld a, e
	and a
	ld a, [wcae1]
	jr z, .sub_95a4
	srl a
.sub_95a4
	srl a
	ld b, $00
	jr nc, .sub_95ac
	ld b, $0a
.sub_95ac
	pop af
	add b
	pop bc
	ret

Function95b0:
	ld a, [hl]
	cp $a0
	jr c, .sub_95ca
	ld a, [hli]
	and $0f
	cp $0a
	jr c, .sub_95ca
	ld a, [hl]
	cp $a0
	jr c, .sub_95ca
	ld a, [hl]
	and $0f
	cp $0a
	jr c, .sub_95ca
	scf
	ret
.sub_95ca
	and a
	ret

Function95cc:
	ld hl, wcddf
	ldh a, [hBattleTurn]
	and a
	jr nz, .sub_95d7
	ld hl, wca08
.sub_95d7
	call Function95b0
	ld hl, wcae1
	jr nc, .sub_95ec
	ldh a, [hBattleTurn]
	and a
	jr nz, .sub_95e8
	set 0, [hl]
	jr .sub_95f7
.sub_95e8
	set 1, [hl]
	jr .sub_95f7
.sub_95ec
	ldh a, [hBattleTurn]
	and a
	jr nz, .sub_95f5
	res 0, [hl]
	jr .sub_95f7
.sub_95f5
	res 1, [hl]
.sub_95f7
	ret

Function95f8:
	ld hl, BlkPacket_98fc
	ld de, wcce2
	ld bc, $0030
	jp CopyBytes

SGB_ApplyPartyMenuHPPals:
	ld hl, wccd3
	ld a, [wcce1]
	ld e, a
	ld d, $00
	add hl, de
	ld e, l
	ld d, h
	ld a, [de]
	and a
	ld e, $05
	jr z, .sub_961d
	dec a
	ld e, $0a
	jr z, .sub_961d
	ld e, $0f
.sub_961d
	push de
	ld hl, wcceb
	ld bc, $0006
	ld a, [wcce1]
	call AddNTimes
	pop de
	ld [hl], e
	ret

LoadMagikarpPalettes_Intro:
	ld hl, PalPacket_MagikarpIntro
	jp PushSGBPals

LoadForestPalettes2_Intro:
	ld hl, BlkPacket_986c
	jp PushSGBPals

LoadVenusaurPalettes_Intro:
	ld hl, PalPacket_VenusaurIntro
	jp PushSGBPals

LoadCharizardPalettes_Intro:
	ld hl, PalPacket_99bc
	jp PushSGBPals

Function9645:
	ld hl, wc51a
	jp PushSGBPals

PushSGBPals:
	ld a, [wJoypadFlags]
	push af
	set 7, a
	ld [wJoypadFlags], a
	call _PushSGBPals
	pop af
	ld [wJoypadFlags], a
	ret

_PushSGBPals:
	ld a, [hl]
	and $7
	ret z
	ld b, a
.loop
	push bc
	xor a
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	ld b, $10
.loop2
	ld e, $08
	ld a, [hli]
	ld d, a
.loop3
	bit 0, d
	ld a, $10
	jr nz, .ok
	ld a, $20
.ok
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	rr d
	dec e
	jr nz, .loop3
	dec b
	jr nz, .loop2
	ld a, $20
	ldh [rJOYP], a
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	pop bc
	dec b
	jr nz, .loop
	ret

CheckSGB:
	ld a, [wJoypadFlags]
	push af
	set 7, a
	ld [wJoypadFlags], a

	xor a
	ldh [rJOYP], a
	ld [wSGB], a
	call PushSGBBorderPalsAndWait
	jr nc, .skip
	ld a, 1
	ld [wSGB], a
	call _InitSGBBorderPals
	call PushSGBBorder
	call SGBBorder_PushBGPals
	call SGB_ClearVRAM
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
.skip
	pop af
	ld [wJoypadFlags], a
	ret

_InitSGBBorderPals:
	ld hl, .PacketPointerTable
	ld c, 9

.loop
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call _PushSGBPals
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

.PacketPointerTable:
	dw MaskEnFreezePacket
	dw DataSndPacket1
	dw DataSndPacket2
	dw DataSndPacket3
	dw DataSndPacket4
	dw DataSndPacket5
	dw DataSndPacket6
	dw DataSndPacket7
	dw DataSndPacket8

UpdateSGBBorder:
	ld a, [wSGB]
	ret z
	di
	xor a
	ldh [rJOYP], a
	ld hl, MaskEnFreezePacket
	call _PushSGBPals
	call PushSGBBorder
	ld hl, MaskEnCancelPacket
	call _PushSGBPals
	ei
	ret

PushSGBBorder:
	call .LoadSGBBorderPointers
	push de
	call SGBBorder_YetMorePalPushing
	pop hl
	call SGBBorder_MorePalPushing
	ret

.LoadSGBBorderPointers:
	ld a, [wce5f]
	bit 3, a
	jr nz, .spaceworld_border

; load alternate border
	ld hl, UnusedSGBBorderGFX
	ld de, UnusedSGBBorderTilemap
	ret

.spaceworld_border
	ld hl, SGBBorderGFX
	ld de, SGBBorderTilemap
	ret

SGB_ClearVRAM:
	ld hl, vChars0
	ld bc, $2000
	xor a
	call ByteFill
	ret

PushSGBBorderPalsAndWait:
	ld hl, MltReq2Packet
	call _PushSGBPals
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	ld a, $20
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $10
	ldh [rJOYP], a
rept 6
	ldh a, [rJOYP]
endr
	call SGBDelayCycles
	call SGBDelayCycles
	ld a, $30
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	call SGBDelayCycles
	call SGBDelayCycles
	ldh a, [rJOYP]
	and $3
	cp $3
	jr nz, .carry
	call .FinalPush
	and a
	ret

.carry
	call .FinalPush
	scf
	ret

.FinalPush:
	ld hl, MltReq1Packet
	call _PushSGBPals
	jp SGBDelayCycles

SGBBorder_PushBGPals:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld hl, SuperPalettes
	ld de, vChars1
	ld bc, $1000
	call CopyData
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, PalTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_MorePalPushing:
	call DisableLCD
	ld a, %11100100
	ldh [rBGP], a
	ld de, vChars1
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld b, SCREEN_HEIGHT
.loop
	push bc
	ld bc, 6 * 2
	call CopyData
	ld bc, SCREEN_WIDTH * 2
	call ClearBytes
	ld bc, 6 * 2
	call CopyData
	pop bc
	dec b
	jr nz, .loop
	ld bc, (6 + SCREEN_WIDTH + 6) * 5 * 2
	call CopyData
	ld bc, $100
	call ClearBytes
	ld bc, $80
	call CopyData
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, PctTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

SGBBorder_YetMorePalPushing:
	call DisableLCD
	ld a, $e4
	ldh [rBGP], a
	ld de, vChars1
	ld b, $80
.loop
	push bc
	ld bc, $10
	call CopyData
	ld bc, $10
	call ClearBytes
	pop bc
	dec b
	jr nz, .loop
	call DrawDefaultTiles
	ld a, $e3
	ldh [rLCDC], a
	ld hl, ChrTrnPacket
	call _PushSGBPals
	xor a
	ldh [rBGP], a
	ret

CopyData:
	ld a, [hli]
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, CopyData
	ret

ClearBytes:
	xor a
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, ClearBytes
	ret

DrawDefaultTiles:
	hlbgcoord 0, 0
	ld de, BG_MAP_WIDTH - SCREEN_WIDTH
	ld a, $80
	ld c, 12 + 1
.line
	ld b, SCREEN_WIDTH
.tile
	ld [hli], a
	inc a
	dec b
	jr nz, .tile
	add hl, de
	dec c
	jr nz, .line
	ret

SGBDelayCycles:
	ld de, 7000
.wait
	nop
	nop
	nop
	dec de
	ld a, d
	or e
	jr nz, .wait
	ret

INCLUDE "data/sgb/blk_packets.inc"
INCLUDE "data/sgb/pal_packets.inc"
INCLUDE "data/sgb/ctrl_packets.inc"
