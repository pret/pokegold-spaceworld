include "constants.asm"

SECTION "engine/dumps/bank02.asm@Function8000", ROMX

Function8000: ; 02:4000
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

Data8022: ; 02:4022
	db $01, $00, $00, $10, $ee, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

Function8031: ; 02:4031
	call Function8047
	ld a, [wUsedSprites+1]
	ld [wMap1ObjectSprite], a
	ld a, $01
	call Function1602
	ld b, $00
	ld c, $01
	call StartFollow
	ret

Function8047: ; 02:4047
	ld a, $01
	ld hl, Data805d
	call Function1656
	ld a, [wPlayerNextMapX]
	ld [wMap1ObjectXCoord], a
	ld a, [wPlayerNextMapY]
	dec a
	ld [wMap1ObjectYCoord], a
	ret

Data805d: ; 02:405d
	db $4d, $00, $00, $18, $ff, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

Function806c: ; 02:406c
	ld a, $01
	call Function169f
	xor a
	ld [wObjectFollow_Follower], a
	ld a, $ff
	ld [wObjectFollow_Leader], a
	ret
	
Function807b: ; 02:407b
	ld a, $01
	ld hl, Data8089
	call Function1656
	ld a, $01
	call Function1668
	ret

Data8089: ; 02:4089
	db $01, $00, $00, $17, $ee, $00, $00, $00
	db $00, $00, $00, $00, $00, $00, $00

_InitializeVisibleSprites: ; 02:4098
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

Function80ea: ; 02:40ea
	ret

Function80eb: ; 02:40eb
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
	
Function811a: ; 02:411a
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld a, [hl]
	ret

Function8125: ; 02:4125
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld [hl], $ff
	ret

Function8131: ; 02:4131
	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, $00
	ld hl, wUnknownWordcc9c
	add hl, de
	ld [hl], $00
	ret

Function813d: ; 02:413d
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

Function81ce: ; 02:41ce
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

Function81f8: ; 02:41f8
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
	
Function820d: ; 02:420d
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

Data8242: ; 02:4242
	db $18, $24, $30, $3c, $48, $54, $60, $6c
	db $78, $7c

Function824c: ; 02:424c
	nop
	ld a, [wPlayerStepDirection]
	cp $ff
	ret z
	ld hl, Table8259
	jp CallJumptable
	
Table8259: ; 02:4259
	dw Function8299
	dw Function8292
	dw Function82e6
	dw Function82ed

Function8261: ; 02:4261
	ret

Function8262: ; 02:4262
	ld a, [wPlayerStepDirection]
	cp $ff
	ret z
	ld hl, Table826e
	jp CallJumptable

Table826e: ; 02:426e
	dw Function827d
	dw Function8276
	dw Function8284
	dw Function828b

Function8276: ; 02:4276
	ld a, [wYCoord]
	sub $02
	jr Function829e

Function827d: ; 02:427d
	ld a, [wYCoord]
	add $0a
	jr Function829e

Function8284: ; 02:4284
	ld a, [wXCoord]
	sub $02
	jr Function82f2

Function828b: ; 02:428b
	ld a, [wXCoord]
	add $0b
	jr Function82f2

Function8292: ; 02:4292
	ld a, [wYCoord]
	sub $01
	jr Function829e

Function8299: ; 02:4299
	ld a, [wYCoord]
	add $09
	
Function829e: ; 02:429e
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

Function82e6: ; 02:42e6
	ld a, [wXCoord]
	sub $01
	jr Function82f2

Function82ed: ; 02:42ed
	ld a, [wXCoord]
	add $0a

Function82f2: ; 02:42f2
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

Function833a: ; 02:433a
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

Function837c: ; 02:437c
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

Function83a2: ; 02:43a2
	push de
	call InitMovementBuffer
	pop de
	call Function83b0
	ld a, $32
	call AppendToMovementBuffer
	ret

Function83b0: ; 02:43b0
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

Function83e8: ; 02:43e8
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

Table83fb: ; 02:43fb
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

Function8419: ; 02:4419
	ld a, c
	ld [wVBCopyFarSrcBank], a
	ld a, l
	ld [wVBCopyFarSrc], a
	ld a, h
	ld [wVBCopyFarSrc+1], a

Function8425: ; 02:4425
	ld a, e
	ld [wVBCopyFarDst], a
	ld a, d
	ld [wVBCopyFarDst+1], a
	
Function842d: ; 02:442d
	ld a, b
	ld [wVBCopyFarSize], a
	ret

Function8432: ; 02:4432
	ret

Function8433: ; 02:4433
	ld hl, ShockEmoteGFX
	jr Function8440

Function8438: ; 02:4438
	ld hl, QuestionEmoteGFX
	jr Function8440

Function843d: ; 02:443d
	ld hl, HappyEmoteGFX

Function8440: ; 02:4440
	ld de, $8f80
	ld b, $04
	ld c, BANK(HappyEmoteGFX)
	jp Function8419

Function844a: ; 02:444a
	ld [hl], $00
	ld hl, JumpShadowGFX
	ld de, $8fc0
	ld b, $01
	ld c, BANK(JumpShadowGFX)
	jp Function8419

Function8459: ; 02:4459
	ld [hl], $00
	ld hl, UnknownBouncingOrbGFX
	ld de, $8fc0
	ld b, $04
	ld c, BANK(UnknownBouncingOrbGFX)
	jp Function8419

Function8468: ; 02:4468
	ld [hl], $00
	ld hl, UnknownBallGFX
	ld de, $8fc0
	ld b, $01
	ld c, BANK(UnknownBallGFX)
	jp Function8419

Function8477: ; 02:4477
	inc [hl]
	ld hl, GrampsSpriteGFX
	ld de, vChars0
	ld b, $06
	ld c, BANK(GrampsSpriteGFX)
	jp Function8419

Function8485: ; 02:4485
	inc [hl]
	ld b, $06
	jp Function842d

Function848b: ; 02:448b
	inc [hl]
	ld de, vChars1
	ld b, $06
	jp Function8425

Function8494: ; 02:4494
	ld [hl], $00
	ld b, $06
	jp Function842d

Function849b: ; 02:449b
	inc [hl]
	ld hl, PippiSpriteGFX
	ld de, vChars0
	ld b, $06
	ld c, BANK(PippiSpriteGFX)
	jp Function8419

Function84a9: ; 02:44a9
	inc [hl]
	ld b, $06
	jp Function842d

Function84af: ; 02:44af
	inc [hl]
	ld de, vChars1
	ld b, $06
	jp Function8425

Function84b8: ; 02:44b8
	ld [hl], $00
	ld b, $06
	jp Function842d

SECTION "engine/dumps/bank02.asm@QueueFollowerFirstStep", ROMX
	
QueueFollowerFirstStep: ; 02:45df
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

Function85f2: ; 02:45f2
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

Function862e: ; 02:462e
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

Function8644: ; 02:4644
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

Data8660: ; 02:4660
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

Function86a0: ; 02:46a0
	call Function881e
	ld hl, InitEffectObject
	ld a, BANK(InitEffectObject)
	call FarCall_hl
	call Function886a
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
	
FlyMap: ; 02:46cb
	ld hl, hJoyDebounceSrc
	ld a, [hl]
	push af
	ld [hl], $01
	call Function881e
	ld hl, $4cfd
	ld a, $23
	call FarCall_hl
	call Function886a
	call Function88b3
	ld hl, $cb60
	ld [hl], c
	inc hl
	ld [hl], b
	ld hl, $c3cd
	ld de, Text8776
	call PlaceString
	call WaitBGMap
	call SetPalettes
	xor a
	ld [wFlyDestination], a
.sub_86fc
	call DelayFrame
	call GetJoypadDebounced
	ld hl, $4d13
	ld a, $23
	call FarCall_hl
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	jr nz, .sub_873e
	ld a, [hl]
	and $01
	jr nz, .sub_8743
	call Function8747
	ld hl, $477d
	ld a, $03
	call FarCall_hl
	ld d, $00
	ld hl, $4a53
	add hl, de
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld hl, $cb60
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

Function8747: ; 02:4747
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, $4a17
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
	
Text8776: ; 02:4776
	;db "とびさき　を　えらんでください@"
	db $c4, $3b, $bb, $b7, $7f, $dd, $7f, $b4
	db $d7, $de, $33, $b8, $30, $bb, $b2, $50
	
Function8786: ; 02:4786
	ld a, [wFlyDestination]
	push af
	xor a
	ld [wFlyDestination], a
	call Function881e
	ld de, PokedexNestIconGFX
	ld hl, $87f0
	ld bc, $0201
	call Request1bpp
	call GetPokemonName
	ld hl, $c3d0
	call PlaceString
	ld hl, $c3d5
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
	ld hl, $69dc
	ld a, $0f
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

Text87e4: ; 02:47e4
	;db "の　すみか@"
	db $c9, $7f, $bd, $d0, $b6, $50
	
Function87ea: ; 02:47ea
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
	ld hl, $4a53
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

Function881e: ; 02:481e
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	call DisableLCD
	ld hl, PokedexLocationGFX
	ld de, vTilesetEnd
	ld bc, $0200
	ld a, BANK(PokedexLocationGFX)
	call FarCopyData
	ld hl, wTileMap
	call DecompTownMapTilemap
	ld hl, $c3a4
	ld b, $03
	ld c, $12
	call DrawTextBox
	ld a, $03
	call UpdateSoundNTimes
	call EnableLCD
	ld b, $02
	call GetSGBLayout
	ret

DecompTownMapTilemap: ; 02:4856
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

Function886a: ; 02:486a
	ld de, Function8000
	ld hl, vChars0
	ld bc, $3004
	call Request2bpp
	ld de, $40c0
	ld hl, $8040
	ld bc, $3004
	call Request2bpp
	ld de, $0000
	ld a, $41
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
	ld hl, $4a53
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

Function88b3: ; 02:48b3
	ld de, $5800
	ld hl, $8080
	ld bc, $3104
	call Request2bpp
	ld de, $58c0
	ld hl, $80c0
	ld bc, $3104
	call Request2bpp
	ld de, $0000
	ld a, $41
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $08
	ret
	
TownMapTilemap: ; 02:48da
	db $04, $05
	db $19, $01
	db $1a, $08
	db $1b, $01
	db $04, $02
	db $09, $01
	db $06, $02
	db $04, $05
	db $1c, $01
	db $05, $01
	db $11, $01
	db $12, $01
	db $13, $01
	db $14, $01
	db $15, $01
	db $16, $01
	db $17, $01
	db $1c, $01
	db $04, $02
	db $0a, $01
	db $05, $01
	db $06, $01
	db $04, $05
	db $1d, $01
	db $1a, $08
	db $1e, $01
	db $04, $03
	db $0f, $01
	db $10, $01
	db $04, $01
	db $0d, $01
	db $0e, $02
	db $0d, $01
	db $04, $09
	db $02, $01
	db $04, $02
	db $01, $01
	db $07, $01
	db $08, $01
	db $02, $01
	db $0f, $01
	db $02, $01
	db $04, $01
	db $0f, $01
	db $09, $01
	db $06, $01
	db $08, $01
	db $04, $05
	db $01, $01
	db $05, $01
	db $03, $01
	db $07, $02
	db $05, $01
	db $06, $01
	db $06, $01
	db $05, $01
	db $07, $01
	db $0e, $01
	db $05, $01
	db $07, $03
	db $08, $01
	db $04, $03
	db $02, $01
	db $04, $01
	db $0f, $01
	db $04, $01
	db $0c, $01
	db $06, $01
	db $07, $01
	db $0b, $01
	db $06, $01
	db $07, $01
	db $0b, $01
	db $04, $01
	db $0f, $01
	db $10, $01
	db $06, $01
	db $05, $01
	db $07, $02
	db $0c, $01
	db $07, $02
	db $03, $01
	db $0f, $01
	db $09, $01
	db $07, $01
	db $06, $01
	db $07, $01
	db $03, $01
	db $06, $01
	db $0f, $01
	db $09, $01
	db $06, $01
	db $07, $01
	db $03, $01
	db $0a, $01
	db $06, $05
	db $07, $02
	db $05, $01
	db $07, $02
	db $06, $01
	db $05, $01
	db $04, $01
	db $0b, $01
	db $0d, $01
	db $0c, $01
	db $07, $01
	db $05, $01
	db $0e, $01
	db $07, $02
	db $06, $0a
	db $07, $01
	db $03, $01
	db $04, $02
	db $0a, $01
	db $06, $01
	db $0b, $01
	db $04, $01
	db $06, $01
	db $05, $01
	db $07, $02
	db $05, $01
	db $06, $01
	db $05, $01
	db $06, $05
	db $0c, $01
	db $08, $01
	db $04, $06
	db $0a, $01
	db $06, $02
	db $0b, $01
	db $07, $01
	db $06, $01
	db $0c, $01
	db $06, $02
	db $18, $01
	db $06, $02
	db $07, $01
	db $06, $01
	db $04, $0a
	db $0c, $01
	db $07, $01
	db $05, $01
	db $07, $02
	db $05, $01
	db $07, $03
	db $0b, $01
	db $04, $0d
	db $10, $01
	db $04, $01
	db $0a, $01
	db $0b, $01
	db $04, $01
	db $10, $01
	db $04, $01
	db $00
	
SECTION "engine/dumps/bank02.asm@Data8a17", ROMX

Data8a17: ; 02:4a17
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

Data8a53: ; 02:4a53
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

OpenPokegear: ; 02:4aab
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ldh a, [hJoypadSum]
	push af
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	call Function8ae0
	call DelayFrame
.sub_8ac9
	call Function8ba3
	jr nc, .sub_8ac9
	pop af
	ld [wVramState], a
	pop af
	ldh [hJoypadSum], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wce5f], a
	call ClearJoypad
	ret

Function8ae0: ; 02:4ae0
	call ClearBGPalettes
	call DisableLCD
	call ClearSprites
	ld b, $13
	call GetSGBLayout
	ld hl, PokegearGFX
	ld de, vChars2
	ld bc, $0200
	ld a, $02
	call FarCopyData
	call Function8b2a
	call Function8b7e
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld [wJumptableIndex], a
	ld [wFlyDestination], a
	ld a, $ff
	ld [wcb60], a
	ld a, $07
	ldh [hWX], a
	ld a, $08
	call UpdateSoundNTimes
	ld a, $e3
	ldh [rLCDC], a
	call WaitBGMap
	call SetPalettes
	ld a, $e0
	ldh [rOBP1], a
	ret

Function8b2a: ; 02:4b2a
	ld hl, wTileMap
	ld bc, $0168
	ld a, $7f
	call ByteFill
	ld de, wTileMap
	ld hl, $4b42
	ld bc, $003c
	call CopyBytes
	ret

Data8b42: ; 02:4b42
	db $0d, $1c, $1d, $0b, $1c, $1d, $0b, $1c
	db $1d, $0c, $01, $05, $05, $05, $05, $05
	db $05, $05, $05, $02, $08, $1e, $1f, $0a
	db $1e, $1f, $0a, $1e, $1f, $07, $08, $7f
	db $7f, $0f, $7f, $7f, $0f, $7f, $7f, $07
	db $03, $06, $06, $09, $06, $06, $09, $06
	db $06, $04, $03, $06, $06, $06, $06, $06
	db $06, $06, $06, $04

Function8b7e: ; 02:4b7e
	ld hl, $c2a1
	ld a, $10
	call Function8b97
	ld hl, $c2a4
	ld a, $14
	call Function8b97
	ld hl, $c2a7
	ld a, $18
	call Function8b97
	ret

Function8b97: ; 02:4b97
	ld [hli], a
	inc a
	ld [hld], a
	ld bc, $0014
	add hl, bc
	inc a
	ld [hli], a
	inc a
	ld [hld], a
	ret

Function8ba3: ; 02:4ba3
	call UpdateTime
	call GetJoypadDebounced
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .sub_8bc3
	call Function8bfd
	ld a, $23
	ld hl, $4d13
	call FarCall_hl
	call Function8bd5
	call DelayFrame
	and a
	ret
.sub_8bc3
	ld hl, $4cfd
	ld a, $23
	call FarCall_hl
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

Function8bd5: ; 02:4bd5
	ld hl, $c2bf
	ld a, $7f
	ld [hli], a
	ld [hl], a
	ld de, hRTCHours
	ld hl, $c2bf
	ld bc, $0102
	call PrintNumber
	inc hl
	ld de, hRTCMinutes
	ld bc, $8102
	call PrintNumber
	inc hl
	ld de, hRTCSeconds
	ld bc, $8102
	call PrintNumber
	ret
	
Function8bfd: ; 02:4bfd
	ld a, [wJumptableIndex]
	ld e, a
	ld d, $00
	ld hl, Table8c0c
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table8c0c: ; 02:4c0c
	dw Function8c21
	dw Function8c49
	dw DrawMap
	dw Function8cab
	dw Function8cb7
	dw Function8d62
	dw Function8e6c
	dw Function8e9e
	
Function8c1c: ; 02:4c1c
	ld hl, wJumptableIndex
	inc [hl]
	ret

Function8c21: ; 02:4c21
	ld hl, $4cfd
	ld a, $23
	call FarCall_hl
	ld de, $56b0
	ld hl, $87c0
	ld bc, $2104
	call Request2bpp
	ld a, $29
	ld hl, wTileMapBackup
	ld [hli], a
	ld [hl], $7c
	ld de, $241c
	ld a, $44
	call InitSpriteAnimStruct
	call Function8c1c
	ret

Function8c49: ; 02:4c49
	ld hl, hJoySum
	ld a, [hl]
	and $02
	jr nz, .sub_8c59
	ld a, [hl]
	and $01
	ret z
	call Function8c5f
	ret
.sub_8c59
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Function8c5f: ; 02:4c5f
	ld a, [wFlyDestination]
	ld hl, wcb60
	cp [hl]
	ret z
	ld [wcb60], a
	and $03
	ld e, a
	ld d, $00
	ld hl, $4c78
	add hl, de
	ld a, [hl]
	ld [wJumptableIndex], a
	ret

Unknown8c78: ; 02:4c78
	db $02, $04, $06, $02

DrawMap: ; 02:4c7c
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $14
	call GetSGBLayout
	ld de, PokedexLocationGFX
	ld hl, vTilesetEnd
	lb bc, BANK(PokedexLocationGFX), $1f
	call Request2bpp
	ld hl, $c2dc
	call DecompTownMapTilemap
	call WaitBGMap
	call Function886a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	add $18
	ld [hl], a
	ret
	
Function8cab: ; 02:4cab
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret
	
Function8cb7: ; 02:4cb7
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $15
	call GetSGBLayout
	ld de, $5132
	ld hl, vTilesetEnd
	ld bc, $0209
	call Request2bpp
	ld de, $51b2
	ld hl, vChars0
	ld bc, $0201
	call Request2bpp
	ld hl, $c2dc
	ld bc, $00b4
	ld a, $0e
	call ByteFill
	ld hl, $c341
	ld bc, $0412
	call Function8ef9
	ld hl, $c2e0
	ld bc, $060e
	call Function8ef9
	ld a, $05
	ld hl, $c37c
	ld [hl], a
	ld hl, $c38f
	ld [hl], a
	ld hl, $c306
	ld a, $60
	ld [hli], a
	inc a
	ld [hld], a
	inc a
	ld bc, $0014
	add hl, bc
	ld [hli], a
	inc a
	ld [hld], a
	ld hl, $c2f2
	ld a, $64
	ld [hli], a
	inc a
	ld [hl], a
	ld hl, $c309
	ld bc, $000c
	ld a, $66
	call ByteFill
	ld hl, $c31d
	ld bc, $000c
	ld a, $67
	call ByteFill
	ld hl, $51c2
	call PrintText
	call WaitBGMap
	ld de, $4c23
	ld a, $44
	call InitSpriteAnimStruct
	ld hl, $0002
	add hl, bc
	ld [hl], $00
	ld hl, $0003
	add hl, bc
	ld [hl], $7c
	ld de, $4030
	ld a, $4b
	call InitSpriteAnimStruct
	ld hl, $0003
	add hl, bc
	ld [hl], $00
	xor a
	ld [wcb61], a
	ret
	
Function8d62: ; 02:4d62
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret
	
Function8d6e: ; 02:4d6e
	ld hl, wcb61
	ld e, [hl]
	ld d, $00
	ld hl, Table8d7d
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table8d7d: ; 02:4d7d
	dw Function8d85
	dw Function8d91
	dw Function8d85
	dw Function8db9

Function8d85: ; 02:4d85
	ld hl, hJoyDown
	ld a, [hl]
	and $01
	ret z
	ld hl, wcb61
	inc [hl]
	ret

Function8d91: ; 02:4d91
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8da6
	call Function8dfd
	jr c, .sub_8db1
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_8dab
.sub_8da6
	ld hl, $ffc0
	jr Function8de3
.sub_8dab
	ld a, $03
	ld [wcb61], a
	ret
.sub_8db1
	call .sub_8da6
	xor a
	ld [wcb61], a
	ret

Function8db9: ; 02:4db9
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_8dcf
	call Function8dfd
	jr c, .sub_8dda
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	cp $60
	jr z, .sub_8dd4
.sub_8dcf
	ld hl, $0040
	jr Function8de3
.sub_8dd4
	ld a, $01
	ld [wcb61], a
	ret
.sub_8dda
	call .sub_8dcf
	ld a, $02
	ld [wcb61], a
	ret

Function8de3: ; 02:4de3
	push hl
	ld hl, $0006
	add hl, bc
	ld d, [hl]
	ld hl, $000c
	add hl, bc
	ld e, [hl]
	pop hl
	add hl, de
	ld e, l
	ld d, h
	ld hl, $000c
	add hl, bc
	ld [hl], e
	ld hl, $0006
	add hl, bc
	ld [hl], d
	ret

Function8dfd: ; 02:4dfd
	ld hl, $0006
	add hl, bc
	push bc
	ld c, [hl]
	ld a, [wMapGroup]
	ld e, a
	ld d, $00
	ld hl, Table8e2f
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
.sub_8e11
	ld a, [hl]
	and a
	jr z, .sub_8e1e
	cp c
	jr z, .sub_8e21
	ld de, $0006
	add hl, de
	jr .sub_8e11
.sub_8e1e
	pop bc
	and a
	ret
.sub_8e21
	ld de, Function8e2c
	push de
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
	
Function8e2c: ; 02:4e2c
	pop bc
	scf
	ret
	
Table8e2f: ; 02:4e2f
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d
	dw Data8e4d

Data8e4d: ; 02:4e4d
	db $10, $02
	dw Function8e66
	dw Function8e66
	
	db $20, $05
	dw Function8e66
	dw Function8e66
	
	db $40, $07
	dw Function8e66
	dw Function8e66
	
	db $48, $09
	dw Function8e66
	dw Function8e66
	
	db $00
	
Function8e66: ; 02:4e66
	ld d, $00
	call PlayMusic
	ret

Function8e6c: ; 02:4e6c
	call Function8c1c
	call Function8eaa
	call WaitForAutoBgMapTransfer
	ld b, $13
	call GetSGBLayout
	call LoadFontExtra
	ld de, Text8e90
	ld hl, $c333
	call PlaceString
	ld hl, Text8e95
	call PrintText
	call WaitBGMap
	ret

Text8e90: ; 02:4e90
	db "けんがい@"

Text8e95: ; 02:4e95
	text "ちぇっ⋯⋯⋯⋯"
	done

Function8e9e: ; 02:4e9e
	ld hl, hJoyDown
	ld a, [hl]
	and $02
	ret z
	xor a
	ld [wJumptableIndex], a
	ret

Function8eaa: ; 02:4eaa
	ld hl, $4cfd
	ld a, $23
	call FarCall_hl
	call ClearSprites
	call WaitForAutoBgMapTransfer
	ld hl, $c2dc
	ld bc, $012c
	ld a, $7f
	call ByteFill
	call WaitBGMap
	call WaitBGMap
	ret

Function8eca: ; 02:4eca
	ld hl, wFlyDestination
	ld de, hJoySum
	ld a, [de]
	and $20
	jr nz, .sub_8edc
	ld a, [de]
	and $10
	jr nz, .sub_8ee2
	jr .sub_8ee7
.sub_8edc
	ld a, [hl]
	and a
	ret z
	dec [hl]
	jr .sub_8ee7
.sub_8ee2
	ld a, [hl]
	cp $02
	ret nc
	inc [hl]
.sub_8ee7
	ld e, [hl]
	ld d, $00
	ld hl, Data8ef5
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ret

Data8ef5: ; 02:4ef5
	db $00, $18, $30, $00
	
Function8ef9: ; 02:4ef9
	dec c
	dec c
	dec b
	dec b
	ld de, $0014
	push bc
	push hl
	ld a, $01
	ld [hli], a
	ld a, $05
.sub_8f07
	ld [hli], a
	dec c
	jr nz, .sub_8f07
	ld a, $02
	ld [hl], a
	pop hl
	pop bc
	add hl, de
.sub_8f11
	push bc
	push hl
	ld a, $08
	ld [hli], a
	ld a, $7f
.sub_8f18
	ld [hli], a
	dec c
	jr nz, .sub_8f18
	ld a, $07
	ld [hli], a
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .sub_8f11
	ld a, $03
	ld [hli], a
	ld a, $06
.sub_8f2a
	ld [hli], a
	dec c
	jr nz, .sub_8f2a
	ld a, $04
	ld [hli], a
	ret
