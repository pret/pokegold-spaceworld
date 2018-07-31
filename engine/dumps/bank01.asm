SECTION "engine/dumps/bank01.asm@Function40fd", ROMX

Function40fd: ; 01:40fd
	ld hl, wd41a
	set 5, [hl]
	ld hl, wd41a
	set 7, [hl]
	ld hl, wd41a
	set 0, [hl]
	ld hl, wd41a
	set 3, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41a
	set 6, [hl]
	ld hl, wd41e
	set 5, [hl]
	ld hl, wd41b
	set 1, [hl]
	ld hl, wd41c
	set 4, [hl]
	ld hl, wd41d
	set 2, [hl]
	ld hl, wd41b
	set 2, [hl]
	ld a, $01
	ld [wd29a], a
	ld a, $01
	ld [wd29b], a
	ld a, $06
	ld [wd29c], a
	ld a, $12
	ld [wd29d], a
	ld a, $06
	ld [wd29e], a
	ld a, $02
	ld [wd2a0], a
	ret

SECTION "engine/dumps/bank01.asm@Function42db", ROMX

Function42db: ; 01:42db
	ld bc, wCmdQueue
	ld a, $01
.sub_42e0
	ldh [hConnectedMapWidth], a
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_42ed
	call .sub_42fb
.sub_42ed
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectedMapWidth]
	inc a
	cp $05
	jr nz, .sub_42e0
	ret
.sub_42fb
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	ld hl, Table431d
	call CallJumptable
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld hl, $0002
	add hl, bc
	ld e, [hl]
	ld d, $00
	ld hl, Table4329
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
	
Table431d::
	dw Function4333
	dw Function439e
	dw Function4430
	dw Function4374
	dw Function4374
	dw Function43c9
	
Table4329::
	dw Function4334
	dw Function4452
	dw Function4459
	dw Function446c
	dw Function4495
	
SECTION "engine/dumps/bank01.asm@Function44f2", ROMX

Function44f2: ; 01:44f2
	ld hl, $0008
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_44fd
	call Function486a
.sub_44fd
	ld e, a
	ld d, $00
	ld hl, Table4545
	push hl
	ld hl, $0005
	add hl, bc
	bit 5, [hl]
	jp nz, Function453e
	ld hl, Table4516
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
	
Table4516::
	dw Function486a
	dw Function47b8
	dw Function4b88
	dw Function4b65
	dw Function4b78
	dw Function4bc9
	dw Function4baa
	dw Function484d
	dw Function4856
	dw Function4859
	dw Function485c
	dw Function485f
	dw Function485f
	dw Function485f
	dw Function485f
	
SECTION "engine/dumps/bank01.asm@Function453e", ROMX

Function453e: ; 01:453e
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ret

SECTION "engine/dumps/bank01.asm@Function486a", ROMX

Function486a: ; 01:486a
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	push bc
	call GetCoordTile
	pop bc
	ld hl, $000e
	add hl, bc
	ld [hl], a
	call Function45d4
	call Function4678
	ld a, $01
	ld hl, $0008
	add hl, bc
	ld [hl], a
	ret
	
SECTION "engine/dumps/bank01.asm@Function5007", ROMX

Function5007: ; 01:5007
	ld bc, wObjectStructs
	xor a
.sub_500b
	ldh [hConnectionStripLength], a
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_5034
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	and a
	ld a, $ff
	jr z, .sub_502f
	push bc
	call .sub_5042
	pop bc
	ld a, $ff
	jr c, .sub_502f
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	and $0c
.sub_502f
	ld hl, $000d
	add hl, bc
	ld [hl], a
.sub_5034
	ld hl, $0028
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $0a
	jr nz, .sub_500b
	ret
.sub_5042
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	ld a, [wXCoord]
	cp d
	jr z, .sub_5059
	jr nc, .sub_50b7
	add $09
	cp d
	jr c, .sub_50b7
.sub_5059
	ld a, [wYCoord]
	cp e
	jr z, .sub_5066
	jr nc, .sub_50b7
	add $08
	cp e
	jr c, .sub_50b7
.sub_5066
	ld hl, $0018
	add hl, bc
	ld a, [hl]
	and $07
	ld d, $02
	jr z, .sub_5073
	ld d, $03
.sub_5073
	ld a, d
	ldh [hffc9], a
	ld a, [hl]
	srl a
	srl a
	srl a
	ldh [hffc7], a
	ld hl, $0019
	add hl, bc
	ld a, [hl]
	and $07
	ld e, $02
	jr z, .sub_508c
	ld e, $03
.sub_508c
	ld a, [hl]
	srl a
	srl a
	srl a
	ldh [hffc8], a
	ldh a, [hffc7]
	ld c, a
	ldh a, [hffc8]
	ld b, a
	call Coord2Tile
	ld bc, $0014
.sub_50a1
	push hl
	ldh a, [hffc9]
	ld d, a
.sub_50a5
	ld a, [hli]
	cp $60
	jr nc, .sub_50b4
	dec d
	jr nz, .sub_50a5
	pop hl
	add hl, bc
	dec e
	jr nz, .sub_50a1
	and a
	ret
.sub_50b4
	pop hl
	jr .sub_50b7
.sub_50b7
	scf
	ret

Function50b9: ; 01:50b9
	call .sub_50c3
	call .sub_50d3
	call Function42db
	ret
.sub_50c3
	xor a
	ld [wcb6c], a
	ld [wcb6d], a
	ld [wcb6e], a
	ld a, $ff
	ld [wPlayerStepDirection], a
	ret
.sub_50d3
	ld bc, wObjectStructs
	xor a
.sub_50d7
	ldh [hConnectionStripLength], a
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_50e9
	call .sub_50f7
	jr c, .sub_50e9
	call Function44f2
.sub_50e9
	ld hl, $0028
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $0a
	jr nz, .sub_50d7
	ret
.sub_50f7
	ld hl, $0005
	add hl, bc
	res 6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_5123
	cp $0c
	jr nc, .sub_5123
	ld a, [wYCoord]
	ld e, a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_5123
	cp $0b
	jr nc, .sub_5123
	jr .sub_514d
.sub_5123
	ld hl, $0005
	add hl, bc
	set 6, [hl]
	ld a, [wXCoord]
	ld e, a
	ld hl, $0014
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_514f
	cp $0c
	jr nc, .sub_514f
	ld a, [wYCoord]
	ld e, a
	ld hl, $0015
	add hl, bc
	ld a, [hl]
	add $01
	sub e
	jr c, .sub_514f
	cp $0b
	jr nc, .sub_514f
.sub_514d
	and a
	ret
.sub_514f
	ldh a, [hConnectionStripLength]
	cp $01
	jr z, .sub_5162
	ld hl, $0004
	add hl, bc
	bit 1, [hl]
	jr nz, .sub_5162
	call .sub_516a
	scf
	ret
.sub_5162
	ld hl, $0005
	add hl, bc
	set 6, [hl]
	and a
	ret
.sub_516a
	push bc
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	push af
	ld h, b
	ld l, c
	ld bc, $0028
	xor a
	call ByteFill
	pop af
	cp $ff
	jr z, .sub_518e
	ld hl, wMapObjects
	ld bc, $0010
	call AddNTimes
	ld bc, $0000
	add hl, bc
	ld [hl], $ff
.sub_518e
	pop bc
	ret

