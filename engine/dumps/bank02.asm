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
