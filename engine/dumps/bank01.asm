INCLUDE "constants.asm"

SECTION "engine/dumps/bank01.asm@Function40fd", ROMX

Function40fd:
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

SECTION "engine/dumps/bank01.asm@Table416b", ROMX

Table416b:
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41ef
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41ef
	dw Unknown420f
	dw Unknown41f3
	dw Unknown4203
	dw Unknown41f7
	dw Unknown4203
	dw Unknown41f3
	dw Unknown4203
	dw Unknown41f7
	dw Unknown420f
	dw Unknown41fb
	dw Unknown4203
	dw Unknown41ff
	dw Unknown4203
	dw Unknown41fb
	dw Unknown4203
	dw Unknown41ff
	dw Unknown4203
	dw Unknown41fb
	dw Unknown420f
	dw Unknown41ff
	dw Unknown420f
	dw Unknown41fb
	dw Unknown420f
	dw Unknown41ff
	dw Unknown420f
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203
	dw Unknown41eb
	dw Unknown4203

Unknown41eb:
	db $00, $01, $02, $03

Unknown41ef:
	db $80, $81, $82, $83

Unknown41f3:
	db $04, $05, $06, $07

Unknown41f7:
	db $84, $85, $86, $87

Unknown41fb:
	db $08, $09, $0a, $0b

Unknown41ff:
	db $88, $89, $8a, $8b

Unknown4203:
	db $00, $00, $00, $00
	db $08, $00, $08, $00
	db $02, $08, $08, $03

Unknown420f:
	db $00, $08, $20, $00
	db $00, $20, $08, $08
	db $22, $08, $00, $23

Table421b:
	dw Unknown423b
	dw Unknown424b
	dw Unknown423b
	dw Unknown425b
	dw Unknown426b
	dw Unknown427b
	dw Unknown426b
	dw Unknown428b
	dw Unknown429b
	dw Unknown42bb
	dw Unknown429b
	dw Unknown42bb
	dw Unknown42ab
	dw Unknown42cb
	dw Unknown42ab
	dw Unknown42cb

Unknown423b:
	db $00, $00, $00, $00
	db $00, $08, $01, $00
	db $08, $00, $02, $02
	db $08, $08, $03, $03

Unknown424b:
	db $00, $00, $80, $00
	db $00, $08, $81, $00
	db $08, $00, $82, $02
	db $08, $08, $83, $03

Unknown425b:
	db $00, $08, $80, $20
	db $00, $00, $81, $20
	db $08, $08, $82, $22
	db $08, $00, $83, $23

Unknown426b:
	db $00, $00, $04, $00
	db $00, $08, $05, $00
	db $08, $00, $06, $02
	db $08, $08, $07, $03

Unknown427b:
	db $00, $00, $84, $00
	db $00, $08, $85, $00
	db $08, $00, $86, $02
	db $08, $08, $87, $03

Unknown428b:
	db $00, $08, $84, $20
	db $00, $00, $85, $20
	db $08, $08, $86, $22
	db $08, $00, $87, $23

Unknown429b:
	db $00, $00, $08, $00
	db $00, $08, $09, $00
	db $08, $00, $0a, $02
	db $08, $08, $0b, $03

Unknown42ab:
	db $00, $08, $08, $20
	db $00, $00, $09, $20
	db $08, $08, $0a, $22
	db $08, $00, $0b, $23

Unknown42bb:
	db $00, $00, $88, $00
	db $00, $08, $89, $00
	db $08, $00, $8a, $02
	db $08, $08, $8b, $03

Unknown42cb:
	db $00, $08, $88, $20
	db $00, $00, $89, $20
	db $08, $08, $8a, $22
	db $08, $00, $8b, $23

Function42db:
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

Function4333:
	ret

Function4334:
	ret

Function4335:
	push bc
	ld h, b
	ld l, c
	ld bc, $0010
	xor a
	call ByteFill
	pop bc
	ret

Function4341:
	ld hl, $000a
	add hl, bc
	inc [hl]
	ret

Function4347:
	pop hl
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, $000a
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Function4358:
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	add a
	ld l, a
	ld h, $00
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Function4366:
	push bc
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	dec a
	call GetObjectStruct
	ld d, b
	ld e, c
	pop bc
	ret

Function4374:
	ld de, Table437a
	jp Function4358

Table437a:
	dw Function437e
	dw Function439b

Function437e:
	call Function4341
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	ld hl, $000b
	add hl, bc
	ld [hl], a
	ld hl, $0006
	add hl, bc
	ld [hl], $00
	ld hl, $000f
	add hl, bc
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a

Function439b:
	jp Function4402

Function439e:
	ld de, Table43a4
	jp Function4358

Table43a4:
	dw Function43a8
	dw Function43c6

Function43a8:
	call Function4341
	call Function4366
	ld hl, $0009
	add hl, de
	ld a, [hl]
	add a
	dec a
	ld hl, $000b
	add hl, bc
	ld [hl], a
	ld hl, $0006
	add hl, bc
	ld [hl], $00
	ld hl, $0007
	add hl, bc
	ld [hl], $08

Function43c6:
	jp Function4402

Function43c9:
	ld de, Table43cf
	jp Function4358

Table43cf:
	dw Function43d3
	dw Function43ff

Function43d3:
	call Function4366
	ld hl, $0009
	add hl, de
	ld a, [hl]
	add $01
	ld hl, $000b
	add hl, bc
	ld [hl], a
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ld hl, $000f
	add hl, bc
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ld hl, $000d
	add hl, bc
	ldh a, [rOBP1]
	ld [hl], a
	ldh [rOBP1], a

Function43ff:
	jp Function4402

Function4402:
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_440e
	dec [hl]
	jp z, Function4335
.sub_440e
	call Function4366
	ld hl, $0018
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	add [hl]
	ld hl, $0004
	add hl, bc
	ld [hl], a
	ld hl, $0019
	add hl, de
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	add [hl]
	ld hl, $0005
	add hl, bc
	ld [hl], a
	ret

Function4430:
	ld hl, Table4436
	jp Function4358

Table4436:
	dw Function443a
	dw Function444f

Function443a:
	call Function4341
	ld hl, $000b
	add hl, bc
	ld [hl], $31
	ld hl, $0006
	add hl, bc
	ld [hl], $00
	ld hl, $0007
	add hl, bc
	ld [hl], $f0

Function444f:
	jp Function4402

Function4452:
	ld hl, $000c
	add hl, bc
	ld [hl], $02
	ret

Function4459:
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	cp $30
	ld a, $01
	jr c, .sub_4466
	ld a, $00
.sub_4466
	ld hl, $000c
	add hl, bc
	ld [hl], a
	ret

Function446c:
	ld hl, $0009
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp $05
	jr c, .sub_4480
	xor a
	ld [hl], a
	ld hl, $0008
	add hl, bc
	ld a, [hl]
	xor $01
	ld [hl], a
.sub_4480
	ld hl, $0008
	add hl, bc
	ld a, $00
	bit 0, [hl]
	jr z, .sub_448f
	ld hl, $000d
	add hl, bc
	ld a, [hl]
.sub_448f
	ld hl, $000c
	add hl, bc
	ld [hl], a
	ret

Function4495:
	ld hl, $0009
	add hl, bc
	inc [hl]
	ld a, [hl]
	cp $03
	ld a, $03
	jr nz, .sub_44a5
	xor a
	ld [hl], a
	ld a, $04
.sub_44a5
	ld hl, $000c
	add hl, bc
	ld [hl], a
	ret

Table44ab:
	dw Unknown44b5
	dw Unknown44b6
	dw Unknown44c7
	dw Unknown44d0
	dw Unknown44e1

Unknown44b5:
	db $00

Unknown44b6:
	db $04, $00, $00, $00
	db $00, $00, $08, $01
	db $00, $08, $00, $02
	db $00, $08, $08, $03, $00

Unknown44c7:
	db $02, $00, $00, $00
	db $00, $00, $08, $00, $20

Unknown44d0:
	db $04, $00, $00, $00
	db $00, $00, $08, $00
	db $00, $08, $00, $00
	db $00, $08, $08, $00, $00

Unknown44e1:
	db $04, $00, $00, $00
	db $40, $00, $08, $00
	db $40, $08, $00, $00
	db $40, $08, $08, $00, $40

Function44f2:
	ld hl, $0008
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .sub_44fd
	call Function486a
.sub_44fd
	ld e, a
	ld d, $00
	ld hl, Function4545
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
	dw Function4ed5
	dw Function4f14
	dw Function4a05
	dw Function4a8b
	dw Function4869

Function453e:
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ret

Function4545:
	ld hl, $0005
	add hl, bc
	bit 6, [hl]
	jr nz, Function4560
	ld hl, $000a
	add hl, bc
	ld a, [hl]
	ld hl, Table4558
	jp CallJumptable

Table4558:
	dw Function4560
	dw Function4567
	dw Function4593
	dw Function45a0

Function4560:
	ld hl, $000d
	add hl, bc
	ld [hl], $ff
	ret

Function4567:
	ld hl, $0004
	add hl, bc
	bit 3, [hl]
	jr nz, Function4593
	ld hl, $0005
	add hl, bc
	bit 5, [hl]
	jr nz, Function4593
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	inc a
	and $0f
	ld [hl], a
	rrca
	rrca
	and $03
	ld d, a
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	and $0c
	or d
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function4593:
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	and $0c
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Function45a0:
	ld hl, $000b
	add hl, bc
	ld a, [hl]
	and $f0
	ld e, a
	ld a, [hl]
	inc a
	and $0f
	ld d, a
	cp $04
	jr c, .sub_45b9
	ld d, $00
	ld a, e
	add $10
	and $30
	ld e, a
.sub_45b9
	ld a, d
	or e
	ld [hl], a
	swap e
	ld d, $00
	ld hl, Unknown45d0
	add hl, de
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ld hl, $000d
	add hl, bc
	ld [hl], a
	ret

Unknown45d0:
	db $00, $0C, $04, $08

Function45d4:
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	ld hl, $0012
	add hl, bc
	ld [hl], a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	ld hl, $0013
	add hl, bc
	ld [hl], a
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	ld hl, $000f
	add hl, bc
	ld [hl], a
	call Function464c
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	call Function4636
	ret

Function45fe:
	ld hl, $0012
	add hl, bc
	ld a, [hl]
	ld hl, $0010
	add hl, bc
	ld [hl], a
	ld hl, $0013
	add hl, bc
	ld a, [hl]
	ld hl, $0011
	add hl, bc
	ld [hl], a
	ret

Function4613:
	ld hl, $0005
	add hl, bc
	bit 3, [hl]
	jr z, .sub_4623
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	call Function464c
.sub_4623
	nop
	ld hl, $000e
	add hl, bc
	ld a, [hl]
	call Function4636
	ret c
	ld hl, $000f
	add hl, bc
	ld a, [hl]
	call Function4636
	ret

Function4636:
	and $f0
	cp $70
	nop
	nop
	ld hl, $0005
	add hl, bc
	res 7, [hl]
	and a
	ret

Function4644:
	ld hl, $0005
	add hl, bc
	set 7, [hl]
	scf
	ret

Function464c:
	call .sub_465f
	jr c, .sub_4658
	ld hl, $0005
	add hl, bc
	set 3, [hl]
	ret
.sub_4658
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	ret
.sub_465f
	ld d, a
	and $f0
	cp $10
	jr z, .sub_466c
	cp $20
	jr z, .sub_4672
	scf
	ret
.sub_466c
	ld a, d
	and $07
	ret z
	scf
	ret
.sub_4672
	ld a, d
	and $07
	ret z
	scf
	ret

Function4678:
	xor a
	ld hl, $000a
	add hl, bc
	ld [hl], a
	ld hl, $000b
	add hl, bc
	ld [hl], a
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ret

Function468a:
	and $0f
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ld hl, $0004
	add hl, bc
	bit 2, [hl]
	jr nz, Function46a2
	ld hl, $0007
	add hl, bc
	add a
	add a
	and $0c
	ld [hl], a

Function46a2:
	call Function46e5
	ld hl, $0009
	add hl, bc
	ld [hl], a
	ld a, d
	call Function4748
	ld hl, $0012
	add hl, bc
	add [hl]
	ld hl, $0010
	add hl, bc
	ld [hl], a
	ld d, a
	ld a, e
	call Function4748
	ld hl, $0013
	add hl, bc
	add [hl]
	ld hl, $0011
	add hl, bc
	ld [hl], a
	ld e, a
	push bc
	call GetCoordTile
	pop bc
	ld hl, $000e
	add hl, bc
	ld [hl], a
	ret

Function46d3:
	call Function46e5
	ld hl, $0018
	add hl, bc
	ld a, [hl]
	add d
	ld [hl], a
	ld hl, $0019
	add hl, bc
	ld a, [hl]
	add e
	ld [hl], a
	ret

Function46e5:
	ld hl, $0006
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, Table4708
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ret

Function46f9:
	ld hl, $0006
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, Table470b
	add hl, de
	ld a, [hl]
	ret

Table4708:
	db $00, $01, $10

Table470b:
	db $01, $00, $ff
	db $10, $01, $ff
	db $00, $10, $01
	db $01, $00, $10
	db $01, $00, $02
	db $08, $02, $00
	db $fe, $08, $02
	db $fe, $00, $08
	db $02, $02, $00
	db $08, $02, $00
	db $04, $04, $04
	db $00, $fc, $04
	db $04, $fc, $00
	db $04, $04, $04
	db $00, $04, $04
	db $00, $08, $02
	db $08, $00, $f8
	db $02, $08, $f8
	db $00, $02, $08
	db $08, $00, $02
	db $08

Function4748:
	add a
	ret z
	ld a, $01
	ret nc
	ld a, $ff
	ret

Function4750:
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	and $03
	ld [wPlayerStepDirection], a
	call Function46e5
	ld a, d
	ld [wcb6c], a
	ld a, e
	ld [wcb6d], a
	ld hl, wcb6e
	set 5, [hl]
	ret

Function476b:
	ld a, [wXCoord]
	ld d, a
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	sub d
	and $0f
	swap a
	ld hl, $0018
	add hl, bc
	ld [hl], a
	ld a, [wYCoord]
	ld e, a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	sub e
	and $0f
	swap a
	ld hl, $0019
	add hl, bc
	ld [hl], a
	ret

Function4792:
	ld hl, $001d
	add hl, bc
	ld [hl], $00
	ret

Function4799:
	ld hl, $001d
	add hl, bc
	inc [hl]
	ret

Function479f:
	ld hl, $001d
	add hl, bc
	ld a, [hl]
	ret

Function47a5:
	ld hl, $001d
	add hl, bc
	ld [hl], a
	ret

Function47ab:
	ld hl, $001d
	add hl, bc
	ld l, [hl]
	ld h, $00
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Function47b8:
	ld hl, $0003
	add hl, bc
	ld a, [hl]
	and $1f
	ld hl, Table47c5
	jp CallJumptable

Table47c5:
	dw Function47fb
	dw Function4812
	dw Function481c
	dw Function47fc
	dw Function4806
	dw Function482b
	dw Function482f
	dw Function4833
	dw Function4837
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw $0000
	dw Function484d
	dw Function4856
	dw Function4859
	dw Function485c
	dw Function485f
	dw Function485f
	dw Function485f
	dw Function485f
	dw Function4862
	dw Function4865
	dw Function4868

Function47fb:
	ret

Function47fc:
	call Random
	ldh a, [hRandomAdd]
	and $01
	jp Function48a9

Function4806:
	call Random
	ldh a, [hRandomAdd]
	and $01
	or $02
	jp Function48a9

Function4812:
	call Random
	ldh a, [hRandomAdd]
	and $03
	jp Function48a9

Function481c:
	call Random
	ldh a, [hRandomAdd]
	and $0c
	ld hl, $0007
	add hl, bc
	ld [hl], a
	jp Function48da

Function482b:
	ld a, $00
	jr Function4839

Function482f:
	ld a, $04
	jr Function4839

Function4833:
	ld a, $08
	jr Function4839

Function4837:
	ld a, $0c

Function4839:
	ld hl, $0007
	add hl, bc
	ld [hl], a
	call Function45fe
	call Function4678
	ld hl, $0008
	add hl, bc
	ld [hl], $04
	jp Function4b78

Function484d:
	ld hl, $0008
	add hl, bc
	ld [hl], $07
	jp Function4bed

Function4856:
	jp Function4bf9

Function4859:
	jp Function4c0c

Function485c:
	jp Function4fbc

Function485f:
	jp Function4bf3

Function4862:
	jp Function4fbc

Function4865:
	jp Function4c1f

Function4868:
	ret

Function4869:
	ret

Function486a:
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

Function488c:
	call Function468a
	call Function771e
	jr c, Function48d4
	call Function4613
	ldh a, [hConnectionStripLength]
	ld d, a
	ld a, [wCenteredObject]
	cp d
	jr z, Function48c6
	ld hl, $0008
	add hl, bc
	ld [hl], $02
	jp Function4b88

Function48a9:
	call Function468a
	call Function771e
	jr c, Function48d4
	call Function4613
	ldh a, [hConnectionStripLength]
	ld d, a
	ld a, [wCenteredObject]
	cp d
	jr z, Function48c6
	ld hl, $0008
	add hl, bc
	ld [hl], $06
	jp Function4baa

Function48c6:
	ld hl, $0008
	add hl, bc
	ld [hl], $05
	ld hl, wcb6e
	set 7, [hl]
	jp Function4bc9

Function48d4:
	call Function4678
	call Function45fe

Function48da:
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ld hl, $0008
	add hl, bc
	ld [hl], $03
	call Random
	ldh a, [hRandomAdd]
	and $7f
	ld hl, $0009
	add hl, bc
	ld [hl], a
	jp Function4b65

Function48f5:
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $001c
	add hl, bc
	ld a, [hl]
	and $07
	cp $04
	ld a, $07
	jr nc, .sub_490a
	ld a, $06
.sub_490a
	call Function468a
	call Function771e
	jr c, .sub_4920
	ld hl, $0008
	add hl, bc
	ld [hl], $02
	ld hl, $001c
	add hl, bc
	inc [hl]
	jp Function4b88
.sub_4920
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ld hl, $000a
	add hl, bc
	ld [hl], $01
	call Function45fe
	ret

Function4930:
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	ld hl, $0010
	add hl, bc
	ld a, d
	sub [hl]
	ld d, a
	ld hl, $0011
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	jr z, .sub_495b
	ld a, d
	and a
	jr z, .sub_4965
	push de
	ld a, d
	call .sub_4973
	ld d, a
	ld a, e
	call .sub_4973
	ld e, a
	cp d
	pop de
	jr nc, .sub_4965
.sub_495b
	ld a, $08
	bit 7, d
	jr nz, .sub_496d
	ld a, $0c
	jr .sub_496d
.sub_4965
	ld a, $04
	bit 7, e
	jr nz, .sub_496d
	ld a, $00
.sub_496d
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ret
.sub_4973
	bit 7, a
	ret z
	dec a
	cpl
	ret

Function4979:
	ret

Function497a:
	ld hl, $001e
	add hl, bc
	inc [hl]
	ld a, [hl]
	srl a
	srl a
	and $07
	ld l, a
	ld h, $00
	ld de, Table4994
	add hl, de
	ld a, [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ret

Table4994:
	db $00, $FF, $FE, $FD
	db $FC, $FD, $FE, $FF

Function499c:
	call Function46f9
	ld hl, $001f
	add hl, bc
	ld e, [hl]
	add e
	ld [hl], a
	ld d, $00
	ld hl, Unknown49dc
	add hl, de
	ld a, [hl]
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ldh a, [hConnectionStripLength]
	cp $01
	ret nz
	ldh a, [hJoypadState]
	and $f0
	ret z
	ld d, $00
	bit 7, a
	jr nz, .sub_49d0
	ld d, $04
	bit 6, a
	jr nz, .sub_49d0
	ld d, $08
	bit 5, a
	jr nz, .sub_49d0
	ld d, $0c
.sub_49d0
	ld hl, $0007
	add hl, bc
	ld [hl], d
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ret

Unknown49dc:
	db $FC, $FB, $FA, $F9
	db $F8, $F7, $F6, $F5
	db $F5, $F5, $F4, $F4
	db $F4, $F4, $F4, $F4
	db $F5, $F5, $F6, $F6
	db $F7, $F7, $F8, $F8
	db $FA, $FB, $FC, $FE
	db $FF, $00, $00, $00

Function49fc:
	ld hl, $0008
	add hl, bc
	ld [hl], $11
	call Function4792

Function4a05:
	ld de, Table4a0b
	jp Function47ab

Table4a0b:
	dw Function4a13
	dw Function4a28
	dw Function4a38
	dw Function4a53

Function4a13:
	ld hl, $001e
	add hl, bc
	ld [hl], $04
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $10
	call Function4799

Function4a28:
	ld hl, $000a
	add hl, bc
	ld [hl], $03
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function4799
	ret

Function4a38:
	ld hl, $001e
	add hl, bc
	ld [hl], $04
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $001f
	add hl, bc
	ld [hl], $10
	ld hl, $0009
	add hl, bc
	ld [hl], $10
	call Function4799

Function4a53:
	ld hl, $000a
	add hl, bc
	ld [hl], $03
	ld hl, $001f
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Function17cd
	ld a, h
	sub $60
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	call Function4792
	ret

Function4a82:
	ld hl, $0008
	add hl, bc
	ld [hl], $12
	call Function4792

Function4a8b:
	ld de, Table4a91
	jp Function47ab

Table4a91:
	dw Function4a9f
	dw Function4aaf
	dw Function4ab8
	dw Function4ad4
	dw Function4af6
	dw Function4b00
	dw Function4b0c

Function4a9f:
	ld hl, $000a
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $10
	call Function4799
	ret

Function4aaf:
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function4799

Function4ab8:
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $001e
	add hl, bc
	ld [hl], $04
	ld hl, $001f
	add hl, bc
	ld [hl], $00
	ld hl, $0009
	add hl, bc
	ld [hl], $10
	call Function4799
	ret

Function4ad4:
	ld hl, $000a
	add hl, bc
	ld [hl], $03
	ld hl, $001f
	add hl, bc
	inc [hl]
	ld a, [hl]
	ld d, $60
	call Function17cd
	ld a, h
	sub $60
	ld hl, $001b
	add hl, bc
	ld [hl], a
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function4799

Function4af6:
	ld hl, $0009
	add hl, bc
	ld [hl], $10
	call Function4799
	ret

Function4b00:
	ld hl, $000a
	add hl, bc
	ld [hl], $03
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz

Function4b0c:
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $000b
	add hl, bc
	ld [hl], $00
	ld hl, $001b
	add hl, bc
	ld [hl], $00
	call Function4792
	ret

Function4b22:
	call Function4792

Function4b25:
	ret

Function4b26:
	ld a, $01
	ld [wcb70], a
	push bc
	ld de, Unknown4b42
	call PushToCmdQueue
	ld d, b
	ld e, c
	pop bc
	ld hl, $0009
	add hl, bc
	ld a, [hl]
	add a
	dec a
	ld hl, $000e
	add hl, de
	ld [hl], a
	ret

Unknown4b42:
	db $01, $01, $FC, $02, $00, $08

Function4b48:
	ld e, a
	add a
	add e
	ld e, a
	ld d, $00
	ld hl, Unknown4b5f
	add hl, de
	ld d, h
	ld e, l
	push bc
	call PushToCmdQueue
	pop bc
	ld a, $06
	ld [wcb70], a
	ret

Unknown4b5f:
	db $05, $04, $FC, $02, $02, $08

Function4b65:
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ret

Function4b78:
	call Function4979
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ret

Function4b88:
	call Function4979
	ld hl, $000a
	add hl, bc
	ld [hl], $01
	call Function46d3
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function45d4
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ret

Function4baa:
	ld hl, $000a
	add hl, bc
	ld [hl], $01
	call Function46d3
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function45d4
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ret

Function4bc9:
	ld hl, $000a
	add hl, bc
	ld [hl], $01
	call Function4750
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	ld hl, wcb6e
	set 6, [hl]
	call Function45d4
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ret

Function4bed:
	ld a, [wPlayerMovement]
	jp Function4c37

Function4bf3:
	ld a, [wMovementObject]
	jp Function4c37

Function4bf9:
	ld hl, $001c
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, $00
	ld hl, wMovementObject
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	jp Function4c37

Function4c0c:
	ld hl, $001c
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, $00
	ld hl, wcb7c
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [hl]
	jp Function4c37

Function4c1f:
	ld hl, $001c
	add hl, bc
	ld e, [hl]
	inc [hl]
	ld d, $00
	ld hl, wMovementDataAddr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld a, [wMovementDataBank]
	call GetFarByte
	jp Function4c37

Function4c37:
	push af
	call Function4f86
	pop af
	ld l, a
	ld h, $00
	add hl, hl
	ld de, Table4c48
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Table4c48:
	dw Function4d94
	dw Function4d98
	dw Function4d9c
	dw Function4da0
	dw Function4db6
	dw Function4dbb
	dw Function4dc0
	dw Function4dc5
	dw Function4dca
	dw Function4dcf
	dw Function4dd4
	dw Function4dd9
	dw Function4dde
	dw Function4de3
	dw Function4de8
	dw Function4ded
	dw Function4df2
	dw Function4df7
	dw Function4dfc
	dw Function4e01
	dw Function4e06
	dw Function4e0b
	dw Function4e10
	dw Function4e15
	dw Function4e1a
	dw Function4e1f
	dw Function4e24
	dw Function4e29
	dw Function4e2e
	dw Function4e33
	dw Function4e38
	dw Function4e3d
	dw Function4e42
	dw Function4e47
	dw Function4e4c
	dw Function4e51
	dw Function4d5e
	dw Function4d67
	dw Function4d70
	dw Function4d79
	dw Function4d82
	dw Function4d8b
	dw Function4d2c
	dw Function4d30
	dw Function4d34
	dw Function4d38
	dw Function4d3c
	dw Function4d40
	dw Function4d44
	dw Function4d48
	dw Function4cc1
	dw Function4cef
	dw Function4cb8
	dw Function4d1a
	dw Function49fc
	dw Function4a82

Function4cb8:
	ld hl, $001c
	add hl, bc
	ld [hl], $00
	jp Function47b8

Function4cc1:
	ld hl, $0001
	add hl, bc
	ld a, [hl]
	cp $ff
	jr nz, .sub_4cce
	ld a, $05
	jr .sub_4cd8
.sub_4cce
	push bc
	call GetMapObject
	ld hl, $0004
	add hl, bc
	ld a, [hl]
	pop bc
.sub_4cd8
	ld hl, $0003
	add hl, bc
	ld [hl], a
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	ld hl, $001c
	add hl, bc
	ld [hl], $00
	ld hl, wVramState
	res 7, [hl]
	ret

Function4cef:
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
	call GetMapObject
	ld hl, $0000
	add hl, bc
	ld [hl], $ff
	pop bc
	ld hl, wObjectFollow_Leader
	ldh a, [hConnectionStripLength]
	cp [hl]
	jr nz, .sub_4d14
	ld [hl], $ff
.sub_4d14
	ld hl, wVramState
	res 7, [hl]
	ret

Function4d1a:
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ld hl, $0008
	add hl, bc
	ld [hl], $04
	ld hl, wVramState
	res 7, [hl]
	ret

Function4d2c:
	ld a, $01
	jr Function4d4a

Function4d30:
	ld a, $02
	jr Function4d4a

Function4d34:
	ld a, $03
	jr Function4d4a

Function4d38:
	ld a, $04
	jr Function4d4a

Function4d3c:
	ld a, $05
	jr Function4d4a

Function4d40:
	ld a, $06
	jr Function4d4a

Function4d44:
	ld a, $07
	jr Function4d4a

Function4d48:
	ld a, $08

Function4d4a:
	ld hl, $0009
	add hl, bc
	ld [hl], a
	ld hl, $0008
	add hl, bc
	ld [hl], $03
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	jp Function4b65

Function4d5e:
	ld hl, $0004
	add hl, bc
	res 3, [hl]
	jp Function47b8

Function4d67:
	ld hl, $0004
	add hl, bc
	set 3, [hl]
	jp Function47b8

Function4d70:
	ld hl, $0004
	add hl, bc
	res 2, [hl]
	jp Function47b8

Function4d79:
	ld hl, $0004
	add hl, bc
	set 2, [hl]
	jp Function47b8

Function4d82:
	ld hl, $0005
	add hl, bc
	res 0, [hl]
	jp Function47b8

Function4d8b:
	ld hl, $0005
	add hl, bc
	set 0, [hl]
	jp Function47b8

Function4d94:
	ld a, $00
	jr Function4da4

Function4d98:
	ld a, $04
	jr Function4da4

Function4d9c:
	ld a, $08
	jr Function4da4

Function4da0:
	ld a, $0c
	jr Function4da4

Function4da4:
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ld hl, $0006
	add hl, bc
	ld [hl], $ff
	ret

Function4db6:
	ld a, $00
	jp Function4e56

Function4dbb:
	ld a, $01
	jp Function4e56

Function4dc0:
	ld a, $02
	jp Function4e56

Function4dc5:
	ld a, $03
	jp Function4e56

Function4dca:
	ld a, $04
	jp Function4e56

Function4dcf:
	ld a, $05
	jp Function4e56

Function4dd4:
	ld a, $06
	jp Function4e56

Function4dd9:
	ld a, $07
	jp Function4e56

Function4dde:
	ld a, $08
	jp Function4e56

Function4de3:
	ld a, $09
	jp Function4e56

Function4de8:
	ld a, $0a
	jp Function4e56

Function4ded:
	ld a, $0b
	jp Function4e56

Function4df2:
	ld a, $0c
	jp Function4e56

Function4df7:
	ld a, $0d
	jp Function4e56

Function4dfc:
	ld a, $0e
	jp Function4e56

Function4e01:
	ld a, $0f
	jp Function4e56

Function4e06:
	ld a, $00
	jp Function4e7c

Function4e0b:
	ld a, $01
	jp Function4e7c

Function4e10:
	ld a, $02
	jp Function4e7c

Function4e15:
	ld a, $03
	jp Function4e7c

Function4e1a:
	ld a, $04
	jp Function4e7c

Function4e1f:
	ld a, $05
	jp Function4e7c

Function4e24:
	ld a, $06
	jp Function4e7c

Function4e29:
	ld a, $07
	jp Function4e7c

Function4e2e:
	ld a, $08
	jp Function4e7c

Function4e33:
	ld a, $09
	jp Function4e7c

Function4e38:
	ld a, $0a
	jp Function4e7c

Function4e3d:
	ld a, $0b
	jp Function4e7c

Function4e42:
	ld a, $0c
	jp Function4e7c

Function4e47:
	ld a, $0d
	jp Function4e7c

Function4e4c:
	ld a, $0e
	jp Function4e7c

Function4e51:
	ld a, $0f
	jp Function4e7c

Function4e56:
	call Function468a
	call Function4613
	ld a, [wCenteredObject]
	ld d, a
	ldh a, [hConnectionStripLength]
	cp d
	jr z, .sub_4e6e
	ld hl, $0008
	add hl, bc
	ld [hl], $02
	jp Function4b88
.sub_4e6e
	ld hl, wcb6e
	set 7, [hl]
	ld hl, $0008
	add hl, bc
	ld [hl], $05
	jp Function4bc9

Function4e7c:
	call Function468a
	ld hl, $001f
	add hl, bc
	ld [hl], $00
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	call Function4792
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	call Function4b26
	ld a, [wCenteredObject]
	ld d, a
	ldh a, [hConnectionStripLength]
	cp d
	jr z, .sub_4ea9
	ld hl, $0008
	add hl, bc
	ld [hl], $0f
	jp Function4ed5
.sub_4ea9
	ld hl, wcb6e
	set 7, [hl]
	ld hl, $0008
	add hl, bc
	ld [hl], $10
	jp Function4f14

Function4eb7:
	call Function468a
	ld hl, $0008
	add hl, bc
	ld [hl], $0f
	ld hl, $000a
	add hl, bc
	ld [hl], $02
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	ld hl, $001f
	add hl, bc
	ld [hl], $00
	call Function4792

Function4ed5:
	ld de, Table4edb
	jp Function47ab

Table4edb:
	dw Function4edf
	dw Function4efb

Function4edf:
	call Function46d3
	call Function499c
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function4799
	call Function45d4
	call Function46a2
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	ret

Function4efb:
	call Function46d3
	call Function499c
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	call Function45d4
	call Function4792
	ret

Function4f14:
	ld de, Table4f1a
	jp Function47ab

Table4f1a:
	dw Function4f20
	dw Function4f40
	dw Function4f4b

Function4f20:
	call Function499c
	call Function4750
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	call Function45d4
	ld hl, $0005
	add hl, bc
	res 3, [hl]
	ld hl, wcb6e
	set 6, [hl]
	set 4, [hl]
	call Function4799
	ret

Function4f40:
	call Function46a2
	ld hl, wcb6e
	set 7, [hl]
	call Function4799

Function4f4b:
	call Function499c
	call Function4750
	ld hl, $0009
	add hl, bc
	dec [hl]
	ret nz
	ld hl, $0008
	add hl, bc
	ld [hl], $01
	call Function45d4
	ld hl, wcb6e
	set 6, [hl]
	call Function4792
	ldh a, [hConnectionStripLength]
	cp $01
	jp z, .sub_4f70
	ret
.sub_4f70
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	rra
	rra
	and $03
	ld d, a
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	and $03
	cp d
	ret z
	jp Function4b25

Function4f86:
	ld e, a
	ld a, [wObjectFollow_Follower]
	and a
	ret z
	cp $ff
	ret z
	ld a, [wObjectFollow_Leader]
	ld d, a
	ldh a, [hConnectionStripLength]
	cp d
	ret nz
	ld a, e
	cp $2a
	ret z
	cp $00
	ret z
	cp $01
	ret z
	cp $02
	ret z
	cp $03
	ret z
	cp $32
	ret z
	cp $35
	ret z
	push af
	ld hl, wFollowerMovementQueueLength
	inc [hl]
	ld e, [hl]
	ld d, $00
	ld hl, wFollowMovementQueue
	add hl, de
	pop af
	ld [hl], a
	ret

Function4fbc:
	call .sub_4fc5
	ld hl, Table4c48
	jp CallJumptable
.sub_4fc5
	ld hl, wFollowerMovementQueueLength
	ld a, [hl]
	and a
	jr z, .sub_4fe2
	cp $ff
	jr z, .sub_4fe2
	ld e, a
	dec [hl]
	ld d, $00
	ld hl, wFollowMovementQueue
	add hl, de
	inc e
	ld a, $ff
.sub_4fdb
	ld d, [hl]
	ld [hld], a
	ld a, d
	dec e
	jr nz, .sub_4fdb
	ret
.sub_4fe2
	call .sub_4fe9
	ret c
	ld a, $2a
	ret
.sub_4fe9
	ld a, [wObjectFollow_Leader]
	cp $ff
	jr z, .sub_4fff
	push bc
	call GetObjectStruct
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	pop bc
	and a
	jr z, .sub_4fff
	and a
	ret
.sub_4fff
	xor a
	ld [wObjectFollow_Follower], a
	ld a, $32
	scf
	ret

Function5007:
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
	ldh [hFFC9], a
	ld a, [hl]
	srl a
	srl a
	srl a
	ldh [hFFC7], a
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
	ldh [hFFC8], a
	ldh a, [hFFC7]
	ld c, a
	ldh a, [hFFC8]
	ld b, a
	call Coord2Tile
	ld bc, $0014
.sub_50a1
	push hl
	ldh a, [hFFC9]
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

Function50b9:
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

_UpdateSprites:
	ld a, [wVramState]
	bit 0, a
	ret z
	xor a
	ldh [hFFC7], a
	call .sub_51a3
	call .sub_5258
	call .sub_5243
	ret
.sub_51a3
	xor a
	ld bc, wObjectStructs
.sub_51a7
	push af
	push bc
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jp z, .sub_5234
	ld hl, $0005
	add hl, bc
	bit 0, [hl]
	jp nz, .sub_5234
	xor a
	bit 7, [hl]
	jr z, .sub_51c2
	add $80
.sub_51c2
	bit 4, [hl]
	jr z, .sub_51c8
	add $10
.sub_51c8
	ld d, a
	xor a
	bit 3, [hl]
	jr z, .sub_51d0
	or $80
.sub_51d0
	ldh [hFFCC], a
	ld hl, $0002
	add hl, bc
	ld a, [hl]
	ldh [hFFCB], a
	ld hl, $0018
	add hl, bc
	ld a, [hl]
	ld hl, $001a
	add hl, bc
	add [hl]
	add $08
	ldh [hFFC9], a
	ld hl, $0019
	add hl, bc
	ld a, [hl]
	ld hl, $001b
	add hl, bc
	add [hl]
	add $10
	ldh [hFFCA], a
	ld hl, $000d
	add hl, bc
	ld a, [hl]
	cp $ff
	jp z, .sub_5234
	ld l, a
	ld h, $00
	add hl, hl
	ld bc, Table421b
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hFFC7]
	ld c, a
	ld b, $c2
.sub_520f
	ldh a, [hFFCA]
	add [hl]
	inc hl
	ld [bc], a
	inc c
	ldh a, [hFFC9]
	add [hl]
	inc hl
	ld [bc], a
	inc c
	ldh a, [hFFCB]
	add [hl]
	inc hl
	ld [bc], a
	inc c
	ld a, [hl]
	bit 1, a
	jr z, .sub_5229
	ldh a, [hFFCC]
	or [hl]
.sub_5229
	inc hl
	or d
	ld [bc], a
	inc c
	bit 0, a
	jr z, .sub_520f
	ld a, c
	ldh [hFFC7], a
.sub_5234
	pop bc
	ld hl, $0028
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp $0a
	jp nz, .sub_51a7
	ret
.sub_5243
	ld b, $a0
	ldh a, [hFFC7]
	cp b
	ret nc
	ld l, a
	ld h, $c2
	ld de, $0004
	ld a, b
	ld c, $a0
.sub_5252
	ld [hl], c
	add hl, de
	cp l
	jr nz, .sub_5252
	ret
.sub_5258
	ld bc, wCmdQueue
	ld a, $04
.sub_525d
	push af
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_52cf
	ld hl, $0004
	add hl, bc
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	add [hl]
	add $08
	ldh [hFFC9], a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	add [hl]
	add $10
	ldh [hFFCA], a
	ld hl, $0003
	add hl, bc
	ld a, [hl]
	ldh [hFFCB], a
	ld hl, $000c
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_52cf
	ld e, a
	ld d, $00
	ld hl, Table44ab
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ldh a, [hFFC7]
	ld d, a
	ld a, [hl]
	and a
	jr z, .sub_52cf
	add a
	add a
	add d
	cp $a0
	jr nc, .sub_52da
	ldh a, [hFFC7]
	ld e, a
	ld d, $c2
	ld a, [hli]
.sub_52b0
	ldh [hFFC8], a
	ldh a, [hFFCA]
	add [hl]
	ld [de], a
	inc hl
	inc de
	ldh a, [hFFC9]
	add [hl]
	ld [de], a
	inc hl
	inc de
	ldh a, [hFFCB]
	add [hl]
	ld [de], a
	inc hl
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ldh a, [hFFC8]
	dec a
	jr nz, .sub_52b0
	ld a, e
	ldh [hFFC7], a
.sub_52cf
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	pop af
	dec a
	jr nz, .sub_525d
	ret
.sub_52da
	pop af
	ret

Function52dc:
	call MenuBoxCoord2Tile
	push hl
	ld de, $005a
	add hl, de
	call PrintNumBadges
	pop hl
	push hl
	ld de, $0081
	add hl, de
	call PrintNumOwnedMons
	pop hl
	ld de, $00a8
	add hl, de
	call PrintPlayTime
	ret

SECTION "engine/dumps/bank01.asm@Function5388", ROMX

Function5388:
	ld a, $00
	call OpenSRAM
	ld a, [s0_a600]
	ld [wce60], a
	call CloseSRAM
	ret

Function5397:
	ld a, $00
	call OpenSRAM
	ld hl, s0_a600
	ld a, [hli]
	ld [wce5f], a
	inc hl
	ld a, [hli]
	ld [wActiveFrame], a
	ld a, [hl]
	ld [wTextBoxFlags], a
	call CloseSRAM
	ret

Function53b0:
	ld a, $00
	call OpenSRAM
	ld hl, wDebugFlags
	ld a, [hli]
	ld [wDebugFlags], a
	ld a, [hli]
	ld [wce64], a
	ld a, [hli]
	ld [wce65], a
	ld a, [hl]
	ld [wce66], a
	call CloseSRAM
	ret

SECTION "engine/dumps/bank01.asm@ReanchorBGMap_NoOAMUpdate", ROMX

ReanchorBGMap_NoOAMUpdate:
	xor a
	ldh [hLCDCPointer], a
	ld hl, wToolgearFlags
	set 7, [hl]
	res 2, [hl]
	ld a, $90
	ldh [hWY], a
	xor a
	ldh [hBGMapMode], a
	xor a
	ldh [hBGMapAddress], a
	ld a, HIGH(vBGMap1)
	ldh [hBGMapAddress+1], a
	call LoadMapPart
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ldh [hWY], a
	call .sub_6412
	xor a ; LOW(vBGMap0)
	ld [wBGMapAnchor], a
	ld a, HIGH(vBGMap0)
	ldh [hBGMapAddress+1], a
	ld [wBGMapAnchor+1], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	call WaitBGMap
	ret
.sub_6412
	ld a, $60
	ld hl, wTileMapBackup
	ld bc, $0080
	call ByteFill
	ld hl, vBGMap0
	ld c, $08
.sub_6422
	push bc
	push hl
	ld de, wTileMapBackup
	ld bc, $0008
	call Request2bpp
	pop hl
	ld bc, $0080
	add hl, bc
	pop bc
	dec c
	jr nz, .sub_6422
	ret

LoadFonts_NoOAMUpdate:
	call UpdateSprites
	call LoadFont
	call LoadFontExtra
	ld a, $90
	ldh [hWY], a
	ret


Function6445:
	call BackUpTilesToBuffer
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld hl, wStringBuffer1
	ld de, wcd11
	ld bc, $0006
	call CopyBytes
.sub_645d
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld b, $04
.sub_646d
	ld a, [hl]
	and a
	jr z, .sub_648d
	inc hl
	dec b
	jr nz, .sub_646d
	push de
	call ForgetMove
	pop de
	jp c, .sub_64d6
	push hl
	push de
	ld [wce37], a
	call Unreferenced_GetMoveName
	ld hl, Text664b
	call PrintText
	pop de
	pop hl
.sub_648d
	ld a, [wce32]
	ld [hl], a
	ld bc, $0015
	add hl, bc
	push hl
	push de
	dec a
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	pop de
	pop hl
	ld [hl], a
	ld a, [wBattleMode]
	and a
	jp z, .sub_64eb
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jp nz, .sub_64eb
	ld h, d
	ld l, e
	ld de, wBattleMonMoves
	ld bc, $0004
	call CopyBytes
	ld bc, $0011
	add hl, bc
	ld de, wBattleMonPP
	ld bc, $0004
	call CopyBytes
	jp .sub_64eb
.sub_64d6
	ld hl, Text65b9
	call PrintText
	call YesNoBox
	jp c, .sub_645d
	ld hl, Text65d7
	call PrintText
	ld b, $00
	ret
.sub_64eb
	ld hl, Text658c
	call PrintText
	ld b, $01
	ret

ForgetMove::
	push hl
	ld hl, AskForgetMoveText
	call PrintText
	call YesNoBox
	pop hl
	ret c
	ld bc, -NUM_MOVES
	add hl, bc
	push hl
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	pop hl
.sub_650f
	push hl
	ld hl, MoveAskForgetText
	call PrintText
	coord hl, 10, 8
	ld b, $08
	ld c, $08
	call DrawTextBox
	coord hl, 12, 10
	ld a, SCREEN_WIDTH*2
	ld [wListMovesLineSpacing], a
	predef ListMoves
	ld a, $0a
	ld [w2DMenuCursorInitY], a
	ld a, $0b
	ld [w2DMenuCursorInitX], a
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	ld a, $01
	ld [w2DMenuNumCols], a
	ld [w2DMenuDataEnd], a
	ld [wMenuCursorX], a
	ld a, $03
	ld [wMenuJoypadFilter], a
	ld a, $20
	ld [w2DMenuFlags], a
	xor a
	ld [w2DMenuFlags+1], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	call Get2DMenuJoypad
	push af
	call ReloadTilesFromBuffer
	pop af
	pop hl
	bit 1, a
	jr nz, .sub_658a
	push hl
	ld a, [w2DMenuDataEnd]
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	push af
	push bc
	call IsHMMove
	pop bc
	pop de
	ld a, d
	jr c, .sub_6581
	pop hl
	add hl, bc
	and a
	ret
.sub_6581
	ld hl, Text6691
	call PrintText
	pop hl
	jr .sub_650f
.sub_658a
	scf
	ret

Text658c:
	text_from_ram wcd11
	text "は　あたらしく"
	line ""
	text_end

Text6599:
	text_from_ram wStringBuffer2
	text "を　おぼえた！"
	text_end

Text65a5:
	sound_dex_fanfare_50_79
	text_waitbutton
	text_end

MoveAskForgetText:
	text "どの　わざを"
	next "わすれさせたい？"
	done

Text65b9:
	text "それでは<⋯⋯>　"
	text_end

Text65c1:
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえるのを　あきらめますか？"
	done

Text65d7:
	text_from_ram wcd11
	text "は　"
	text_end

Text65de:
	text_from_ram wStringBuffer2
	text "を"
	line "おぼえずに　おわった！"
	prompt

AskForgetMoveText:
	text_from_ram wcd11
	text "は　あたらしく"
	line ""
	text_end
	text_from_ram wStringBuffer2
	text "を　おぼえたい<⋯⋯>！"
	para "しかし　"
	text_end
	text_from_ram wcd11
	text "は　わざを　４つ"
	line "おぼえるので　せいいっぱいだ！"
	para ""
	text_end
	text_from_ram wStringBuffer2
	text "の　かわりに"
	line "ほかの　わざを　わすれさせますか？"
	done

Text664b:
	text "１　２の　<⋯⋯>"
	text_end

Text6653:
	text_exit
	start_asm
	push de
	ld de, SFX_SWITCH_POKEMON
	call PlaySFX
	pop de
	ld hl, Text6661
	ret

Text6661:
	text "　ポカン！"
	text_end

Text6668:
	text_exit
	text ""
	para ""
	text_end

Text666c:
	text_from_ram wcd11
	text "は　"
	text_end

Text6673:
	text_from_ram wStringBuffer1
	text "の"
	line "つかいかたを　きれいに　わすれた！"
	para "そして<⋯⋯>！"
	prompt

Text6691:
	text "それは　たいせつなわざです"
	line "わすれさせることは　できません！"
	prompt

Function66b1:
	ld hl, wcd74
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurItem]
	cp $c4
	jr nc, .sub_66d2
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	inc hl
	ld a, [hld]
	ldh [hSpriteOffset], a
	ld a, [hld]
	ldh [hConnectedMapWidth], a
	ld a, [hl]
	ldh [hConnectionStripLength], a
	jr .sub_66d5
.sub_66d2
	call .sub_66d9
.sub_66d5
	ld de, hConnectionStripLength
	ret
.sub_66d9
	ld a, [wCurItem]
	sub $c9
	ret c
	ld d, a
	ld hl, Table66fa
	srl a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	srl d
	jr nc, .sub_66f0
	swap a
.sub_66f0
	and $f0
	ldh [hConnectedMapWidth], a
	xor a
	ldh [hConnectionStripLength], a
	ldh [hSpriteOffset], a
	ret

Table66fa:
	db $32, $21, $34, $24
	db $34, $21, $45, $55
	db $32, $32, $55, $52
	db $54, $52, $41, $21
	db $12, $42, $25, $24
	db $22, $52, $24, $34
	db $42

Function6713:
	push hl
	call LoadStandardMenuHeader
	ld a, [wBattleMode]
	dec a
	coord hl, 1, 0
	ld b, $04
	ld c, $0a
	call z, ClearBox
	ld a, [wCurPartySpecies]
	ld [wce37], a
	call GetPokemonName
	ld a, [wDebugFlags]
	bit 1, a
	pop hl
	push hl
	ld hl, Text6788
	call PrintText
	call YesNoBox
	pop hl
	jr c, .sub_6779
	push hl
	ld e, l
	ld d, h
	ld a, BANK(NamingScreen)
	ld b, $00
	ld hl, NamingScreen
	call FarCall_hl
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld a, [wBattleMode]
	and a
	jr nz, .sub_676b
	call LoadFontExtra
	call Function3657
	jr .sub_6773
.sub_676b
	callfar _LoadHPBar
.sub_6773
	pop hl
	ld a, [hl]
	cp $50
	jr nz, .sub_6784
.sub_6779
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_6784
	call CloseWindow
	ret

Text6788:
	text_from_ram wStringBuffer1
	text "に"
	line "ニックネームを　つけますか？"
	done

Function679d:
	ld de, wFieldMoveScriptID
	push de
	ld hl, NamingScreen
	ld b, $00
	ld a, BANK(NamingScreen)
	call FarCall_hl
	call ClearBGPalettes
	call Function360b
	call UpdateTimePals
	pop de
	ld a, [de]
	cp $50
	jr z, .sub_67d3
	ld hl, wPartyMonNicknames
	ld bc, $0006
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wFieldMoveScriptID
	ld bc, $0006
	call CopyBytes
	and a
	ret
.sub_67d3
	scf
	ret

CorrectNickErrors:
	push bc
	push de
	ld b, $06
.sub_67d9
	ld a, [de]
	cp $50
	jr z, .sub_6802
	ld hl, Table6805
	dec hl
.sub_67e2
	inc hl
	ld a, [hl]
	cp $ff
	jr z, .sub_67f5
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .sub_67e2
	cp [hl]
	jr nc, .sub_67e2
	ld a, $e6
	ld [de], a
	jr .sub_67e2
.sub_67f5
	inc de
	dec b
	jr nz, .sub_67d9
	pop de
	push de
	ld a, $e6
	ld [de], a
	inc de
	ld a, $50
	ld [de], a
.sub_6802
	pop de
	pop bc
	ret

Table6805::
	db $00, $05, $14, $19, $1d
	db $26, $35, $3a, $49, $7f
	db $ff

SECTION "engine/dumps/bank01.asm@Function771e", ROMX

Function771e:
	ld hl, $0004
	add hl, bc
	bit 4, [hl]
	jr z, .sub_772c
	push hl
	call _IsObjectCollisionTileSolid
	pop hl
	ret c
.sub_772c
	bit 6, [hl]
	jr z, .sub_7738
	push hl
	push bc
	call Function77a1
	pop bc
	pop hl
	ret c
.sub_7738
	bit 5, [hl]
	jr z, .sub_7748
	push hl
	call Function782c
	pop hl
	ret c
	push hl
	call Function786e
	pop hl
	ret c
.sub_7748
	and a
	ret

SECTION "engine/dumps/bank01.asm@Function776e", ROMX

Function776e:
	call GetFacingTileCoord
	cp $90
	jr z, .sub_7779
	cp $98
	jr nz, .sub_7789
.sub_7779
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
.sub_7789
	ld bc, wPlayerSprite
	ld a, $01
	ldh [hConnectionStripLength], a
	call _CheckObjectCollision
	ret nc
	ld hl, $0006
	add hl, bc
	ld a, [hl]
	cp $ff
	jr z, .sub_779f
	xor a
	ret
.sub_779f
	scf
	ret

Function77a1:
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	jr _CheckObjectCollision

Function77ad:
	ldh a, [hConnectionStripLength]
	call GetObjectStruct
	call .sub_77b9
	call _CheckObjectCollision
	ret
.sub_77b9
	ld hl, $0010
	add hl, bc
	ld d, [hl]
	ld hl, $0011
	add hl, bc
	ld e, [hl]
	ld hl, $0007
	add hl, bc
	ld a, [hl]
	and $0c
	and a
	jr z, .sub_77d7
	cp $04
	jr z, .sub_77d9
	cp $08
	jr z, .sub_77db
	inc d
	ret
.sub_77d7
	inc e
	ret
.sub_77d9
	dec e
	ret
.sub_77db
	dec d
	ret

SECTION "engine/dumps/bank01.asm@Function782c", ROMX

Function782c:
	ld hl, $0016
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_784b
	ld e, a
	ld d, a
	ld hl, $0014
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, $0010
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .sub_786c
	cp e
	jr z, .sub_786c
.sub_784b
	ld hl, $0017
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_786a
	ld e, a
	ld d, a
	ld hl, $0015
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hl]
	add e
	ld e, a
	ld hl, $0011
	add hl, bc
	ld a, [hl]
	cp d
	jr z, .sub_786c
	cp e
	jr z, .sub_786c
.sub_786a
	and a
	ret
.sub_786c
	scf
	ret

Function786e:
	ld hl, $0010
	add hl, bc
	ld a, [wXCoord]
	cp [hl]
	jr z, .sub_787f
	jr nc, .sub_7892
	add $09
	cp [hl]
	jr c, .sub_7892
.sub_787f
	ld hl, $0011
	add hl, bc
	ld a, [wYCoord]
	cp [hl]
	jr z, .sub_7890
	jr nc, .sub_7892
	add $08
	cp [hl]
	jr c, .sub_7892
.sub_7890
	and a
	ret
.sub_7892
	scf
	ret

SECTION "engine/dumps/bank01.asm@SettingsScreen", ROMX

SettingsScreen:
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

Function78ed:
	call Function7a93

Function78f0:
	call Function7a41
	ld [hl], $ed
	call Function7a55
	call WaitBGMap
.sub_78fb
	call DelayFrame
	call GetJoypadDebounced
	ldh a, [hJoySum]
	ld b, a
	and a
	jr z, .sub_78fb
	ld a, b
	and $0a
	jr nz, .sub_7924
	ld a, b
	and $04
	jr nz, .sub_7939
	ld a, b
	and $01
	jr z, Function7977
	ld a, [wc409]
	cp $10
	jr nz, Function78f0
	ld a, [wTileMapBackup]
	cp $07
	jr z, .sub_7956
.sub_7924
	push de
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	pop de
	pop af
	ld [wVramState], a
	ld hl, wd4a9
	bit 0, [hl]
	jp z, TitleSequenceStart
	ret
.sub_7939
	ld hl, wce5f
	ld a, [hl]
	xor $08
	ld [hl], a
	callfar UpdateSGBBorder
	call LoadFont
	call LoadFontExtra
	ld c, $70
	call DelayFrames
	jp Function78ed
.sub_7956
	ld a, [wActiveFrame]
	inc a
	and $07
	ld [wActiveFrame], a
	coord hl, 17, 16
	add $f7
	ld [hl], a
	call LoadFontExtra
	jr Function78f0

Function796a:
	push af
	call Function7a41
	ld [hl], $7f
	pop af
	ld [wTileMapBackup], a
	jp Function78f0

Function7977:
	ld a, [wc409]
	bit 7, b
	jr nz, .sub_799e
	bit 6, b
	jr nz, .sub_79c1
	cp $07
	jp z, .sub_7a10
	cp $0b
	jp z, .sub_7a1b
	cp $0d
	jp z, .sub_7a26
	cp $10
	jp z, .sub_7a31
	bit 5, b
	jp nz, .sub_79f6
	jp .sub_7a01
.sub_799e
	cp $10
	ld b, $f3
	ld hl, wc40a
	jr z, .sub_79e2
	cp $03
	ld b, $04
	inc hl
	jr z, .sub_79e2
	cp $07
	ld b, $04
	inc hl
	jr z, .sub_79e2
	cp $0b
	ld b, $02
	inc hl
	jr z, .sub_79e2
	ld b, $03
	inc hl
	jr .sub_79e2
.sub_79c1
	cp $07
	ld b, $fc
	ld hl, wc40a
	jr z, .sub_79e2
	cp $0b
	ld b, $fc
	inc hl
	jr z, .sub_79e2
	cp $0d
	ld b, $fe
	inc hl
	jr z, .sub_79e2
	cp $10
	ld b, $fd
	inc hl
	jr z, .sub_79e2
	ld b, $0d
	inc hl
.sub_79e2
	add b
	push af
	ld a, [hl]
	push af
	call Function7a41
	ld [hl], $ec
	pop af
	ld [wTileMapBackup], a
	pop af
	ld [wc409], a
	jp Function78f0
.sub_79f6
	ld a, [wc40a]
	cp $01
	jr z, .sub_7a0a
	sub $07
	jr .sub_7a0a
.sub_7a01
	ld a, [wc40a]
	cp $0f
	jr z, .sub_7a0a
	add $07
.sub_7a0a
	ld [wc40a], a
	jp Function796a
.sub_7a10
	ld a, [wWhichPicTest]
	xor $0b
	ld [wWhichPicTest], a
	jp Function796a
.sub_7a1b
	ld a, [wc40c]
	xor $0b
	ld [wc40c], a
	jp Function796a
.sub_7a26
	ld a, [wc40d]
	xor $0b
	ld [wc40d], a
	jp Function796a
.sub_7a31
	call Function7a41
	ld [hl], $ec
	ld a, [wTileMapBackup]
	xor $06
	ld [wTileMapBackup], a
	jp Function78f0

Function7a41:
	ld a, [wc409]
	ld hl, wTileMap
	ld bc, $0014
	call AddNTimes
	ld a, [wTileMapBackup]
	ld b, $00
	ld c, a
	add hl, bc
	ret

Function7a55:
	ld hl, Table7c22
	ld a, [wc40a]
	ld c, a
.sub_7a5c
	ld a, [hli]
	cp c
	jr z, .sub_7a63
	inc hl
	jr .sub_7a5c
.sub_7a63
	ld a, [hl]
	ld d, a
	ld a, [wWhichPicTest]
	dec a
	jr z, .sub_7a6f
	set 7, d
	jr .sub_7a71
.sub_7a6f
	res 7, d
.sub_7a71
	ld a, [wc40c]
	dec a
	jr z, .sub_7a7b
	set 6, d
	jr .sub_7a7d
.sub_7a7b
	res 6, d
.sub_7a7d
	ld a, [wc40d]
	dec a
	jr z, .sub_7a87
	set 5, d
	jr .sub_7a89
.sub_7a87
	res 5, d
.sub_7a89
	ld a, [wce5f]
	and $08
	or d
	ld [wce5f], a
	ret

Function7a93:
	call ClearBGPalettes
	call DisableLCD
	xor a
	ldh [hBGMapMode], a
	call .sub_7b26
	xor a
	ld hl, wc40a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	inc a
	ld [wTextBoxFlags], a
	ld hl, Table7c23
	ld a, [wce5f]
	ld c, a
	and $07
	push bc
	ld de, $0002
	call FindItemInTable
	pop bc
	dec hl
	ld a, [hl]
	ld [wc40a], a
	coord hl, 0, 3
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7ad0
	ld a, $0a
.sub_7ad0
	ld [wWhichPicTest], a
	coord hl, 0, 7
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7ae1
	ld a, $0a
.sub_7ae1
	ld [wc40c], a
	coord hl, 0, 11
	call .sub_7b1f
	sla c
	ld a, $01
	jr nc, .sub_7af2
	ld a, $0a
.sub_7af2
	ld [wc40d], a
	coord hl, 0, 13
	call .sub_7b1f
	ld a, $01
	ld [wc40e], a
	coord hl, 1, 16
	ld [hl], $ec
	coord hl, 7, 16
	ld [hl], $ec
	ld a, [wc40a]
	ld [wTileMapBackup], a
	ld a, $03
	ld [wc409], a
	call EnableLCD
	call WaitBGMap
	call SetPalettes
	ret
.sub_7b1f
	ld e, a
	ld d, $00
	add hl, de
	ld [hl], $ec
	ret
.sub_7b26
	ld de, vChars1 + $0700
	ld hl, TrainerCardGFX
	ld bc, $0010
	ld a, BANK(TrainerCardGFX)
	call FarCopyData
	ld hl, wTileMap
	ld bc, $0168
	ld a, $f0
	call ByteFill
	coord hl, 1, 1
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 5
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 9
	lb bc, 3, 18
	call ClearBox
	coord hl, 1, 13
	lb bc, 1, 18
	call ClearBox
	coord hl, 1, 1
	ld de, Text7bad
	call PlaceString
	coord hl, 1, 5
	ld de, Text7bc9
	call PlaceString
	coord hl, 1, 9
	ld de, Text7be8
	call PlaceString
	coord hl, 1, 13
	ld de, Text7c03
	call PlaceString
	coord hl, 1, 16
	ld de, Text7c12
	call PlaceString
	coord hl, 6, 15
	ld b, $01
	ld c, $0b
	call DrawTextBox
	coord hl, 7, 16
	ld de, Text7c17
	call PlaceString
	ld a, [wActiveFrame]
	coord hl, 17, 16
	add $f7
	ld [hl], a
	ret

Text7bad:
	db "はなしの　はやさ"
	next "　はやい　　　　ふつう　　　　おそい"
	text_end

Text7bc9:
	db "せんとう　アニメーション"
	next "　じっくり　みる　　とばして　みる"
	text_end

Text7be8:
	db "しあいの　ルール"
	next "　いれかえタイプ　　かちぬきタイプ"
	text_end

Text7c03:
	db "　モノラル　　　　　ステレオ"
	text_end

Text7c12:
	db "　おわり"
	text_end

Text7c17:
	db "　わく　を　かえる　"
	text_end

Table7c22:
	db $0F

Table7c23:
	db $05, $08, $03
	db $01, $01, $08
	db $FF

Unknown7c2a:
rept 491
	db $39, $00
endr
