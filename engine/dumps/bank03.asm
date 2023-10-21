INCLUDE "constants.asm"

SECTION "engine/dumps/bank03.asm@Functionc77d", ROMX

Functionc77d:
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, SpawnPoints
	add hl, de
	ld b, [hl]
	inc hl
	ld c, [hl]
	call GetWorldMapLocation
	ld e, a
	ret

SECTION "engine/dumps/bank03.asm@SpawnPoints", ROMX
; Map, Warp ID
SpawnPoints:
	db $01, $04
	db $05, $05
	db $02, $02
	db $1b, $1d
	db $03, $01
	db $19, $0f
	db $04, $03
	db $1f, $0b
	db $05, $07
	db $03, $0d
	db $06, $04
	db $0f, $05
	db $07, $04
	db $07, $09
	db $08, $02
	db $09, $0b
	db $09, $04
	db $0d, $13
	db $0a, $02
	db $21, $15
	db $0b, $02
	db $31, $1f
	db $0c, $02
	db $05, $05
	db $0d, $02
	db $05, $05
	db $0e, $01
	db $21, $0f
	db $0f, $01
	db $0d, $0b
	db $07, $01
	db $09, $0b
	db $07, $03
	db $0d, $1d
	db $10, $01
	db $06, $06
	db $10, $02
	db $06, $06
	db $10, $03
	db $04, $10
	db $10, $04
	db $06, $06
	db $10, $05
	db $09, $0d
	db $10, $06
	db $17, $2f
	db $10, $07
	db $06, $0a
	db $10, $08
	db $06, $06
	db $10, $09
	db $06, $06
	db $10, $0a
	db $06, $06
	db $10, $0b
	db $06, $06
	db $10, $0c
	db $06, $06
	db $10, $0d
	db $06, $06
	db $10, $0e
	db $10, $0d
	db $10, $0f
	db $08, $08
	db $10, $10
	db $08, $08
	db $10, $11
	db $09, $0b
	db $10, $12
	db $09, $23
	db $02, $07
	db $06, $06
	db $03, $11
	db $06, $06
	db $04, $08
	db $06, $06
	db $06, $0e
	db $06, $06
	db $07, $0d
	db $06, $06
	db $09, $0e
	db $06, $06
	db $0a, $0d
	db $06, $06
	db $0b, $07
	db $06, $06
	db $0b, $25
	db $06, $06
	db $01, $0f
	db $10, $10
	db $ff, $ff
	db $ff, $ff


SECTION "engine/dumps/bank03.asm@Functionc9c1", ROMX

Functionc9c1:
	xor a
	ld bc, $0020
	ld hl, wCurrMapInlineTrainers
	call ByteFill
	ld de, wMap2Object
	ld a, $02
.sub_c9d0
	push af
	push de
	ld hl, $0008
	add hl, de
	ld a, [hl]
	cp $00
	jr nz, .sub_c9e7
	ld hl, $0000
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .sub_c9e7
	call .sub_c9f5
.sub_c9e7
	pop de
	ld hl, $0010
	add hl, de
	ld d, h
	ld e, l
	pop af
	inc a
	cp $10
	jr nz, .sub_c9d0
	ret
.sub_c9f5
	jp CheckInlineTrainer

Functionc9f8:
	ld a, [wItemQuantity]
	push af
	push bc
	push de
	push hl
	push hl
	ld d, $32
	push hl
	ld bc, $2e62
	add hl, bc
	ld a, h
	or l
	pop hl
	jr nz, .sub_ca0e
	ld d, $14
.sub_ca0e
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hli]
	and a
	jr z, .sub_ca24
.sub_ca15
	ld a, [hli]
	ld b, a
	ld a, [wCurItem]
	cp b
	jp z, .sub_ca3e
	inc hl
	ld a, [hl]
	cp $ff
	jr nz, .sub_ca15
.sub_ca24
	pop hl
	ld a, d
	and a
	jr z, .sub_ca5f
	inc [hl]
	ld a, [hl]
	add a
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wItemQuantity]
	ld [hli], a
	ld [hl], $ff
	jp .sub_ca5e
.sub_ca3e
	ld a, [wItemQuantity]
	ld b, a
	ld a, [hl]
	add b
	cp $64
	jp c, .sub_ca5c
	sub $63
	ld [wItemQuantity], a
	ld a, d
	and a
	jr z, .sub_ca58
	ld a, $63
	ld [hli], a
	jp .sub_ca15
.sub_ca58
	pop hl
	and a
	jr .sub_ca5f
.sub_ca5c
	ld [hl], a
	pop hl
.sub_ca5e
	scf
.sub_ca5f
	pop hl
	pop de
	pop bc
	pop bc
	ld a, b
	ld [wItemQuantity], a
	ret

Functionca68:
	push hl
	inc hl
	ld a, [wItemIndex]
	ld e, a
	ld d, $00
	add hl, de
	add hl, de
	inc hl
	ld a, [wItemQuantity]
	ld e, a
	ld a, [hl]
	sub e
	ld [hld], a
	ld [wItemQuantityBuffer], a
	and a
	jr nz, .sub_ca9f
	ld e, l
	ld d, h
	inc de
	inc de
.sub_ca84
	ld a, [de]
	inc de
	ld [hli], a
	cp $ff
	jr nz, .sub_ca84
	xor a
	ld [wMenuScrollPosition], a
	ld [wRegularItemsCursor], a
	pop hl
	ld a, [hl]
	dec a
	ld [hl], a
	ld [wCurPartyLevel+1], a
	cp $02
	jr c, .sub_caa0
	jr .sub_caa0
.sub_ca9f
	pop hl
.sub_caa0
	ret


SECTION "engine/dumps/bank03.asm@Functiond41d", ROMX

Functiond41d:
	push hl
	call Functiond4b2
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .sub_d45f
	ld a, [wCurItem]
	ld [wce37], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, Textd478
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .sub_d468
	ld a, [wItemIndex]
	pop hl
	call TossItem
	ld a, [wCurItem]
	ld [wce37], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, Textd46b
	call MenuTextBox
	call CloseWindow
	and a
	ret
.sub_d45f
	ld hl, Textd491
	call MenuTextBox
	call CloseWindow
.sub_d468
	pop hl
	scf
	ret

Textd46b:
	text_from_ram wStringBuffer1
	text "を"
	line "すてました！"
	prompt

Textd478:
	text_from_ram wStringBuffer2
	text "を　すてます"
	line "ほんとに　よろしいですか？"
	prompt

Textd491:
	text "それは　とても　たいせつなモノです"
	line "すてることは　できません！"
	prompt

Functiond4b2:
	push hl
	push bc
	ld a, $01
	ld [wItemAttributeParamBuffer], a
	ld a, [wCurItem]
	cp $c4
	jr nc, .sub_d4d7
	ld hl, ItemAttributes +  4
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, BANK(ItemAttributes)
	call GetFarByte
	bit 0, a
	jr nz, .sub_d4e3
	jr .sub_d4df
.sub_d4d7
	ld a, [wCurItem]
	call IsHM
	jr c, .sub_d4e3
.sub_d4df
	xor a
	ld [wItemAttributeParamBuffer], a
.sub_d4e3
	pop bc
	pop hl
	ret

Functiond4e6:
	ld a, [wcb6e]
	and a
	ret z
	bit 7, a
	jr nz, .sub_d4f8
	bit 6, a
	jr nz, Functiond519
	bit 5, a
	jr nz, Functiond543
	ret
.sub_d4f8
	jr Functiond505

Functiond4fa:
	call Functiond51e
	ld hl, Function8261
	ld a, BANK(Function8261)
	call FarCall_hl

Functiond505:
	ld a, $04
	ld [wcdb2], a
	ldh a, [hOverworldFlashlightEffect]
	and a
	jr nz, .sub_d514
	call Functiond5f3
	jr Functiond543
.sub_d514
	call Functiond708
	jr Functiond543

Functiond519:
	call Functiond51e
	jr Functiond543

Functiond51e:
	ld a, [wPlayerStepDirection]
	and a
	jr nz, .sub_d529
	ld hl, wYCoord
	inc [hl]
	ret
.sub_d529
	cp $01
	jr nz, .sub_d532
	ld hl, wYCoord
	dec [hl]
	ret
.sub_d532
	cp $02
	jr nz, .sub_d53b
	ld hl, wXCoord
	dec [hl]
	ret
.sub_d53b
	cp $03
	ret nz
	ld hl, wXCoord
	inc [hl]
	ret

Functiond543:
	call .sub_d5bf
	ld a, [wcb6c]
	ld d, a
	ld a, [wcb6d]
	ld e, a
	call .sub_d55f
	call .sub_d591
	ldh a, [hSCX]
	add d
	ldh [hSCX], a
	ldh a, [hSCY]
	add e
	ldh [hSCY], a
	ret
.sub_d55f
	ld bc, wObjectStructs
	xor a
.sub_d563
	ldh [hConnectionStripLength], a
	ld hl, $0000
	add hl, bc
	ld a, [hl]
	and a
	jr z, .sub_d583
	ld hl, $0004
	add hl, bc
	bit 7, [hl]
	jr nz, .sub_d583
	ld hl, $0018
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, $0019
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
.sub_d583
	ld hl, $0028
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $0a
	jr nz, .sub_d563
	ret
.sub_d591
	ld bc, wCmdQueue
	ld a, $01
.sub_d596
	ldh [hConnectionStripLength], a
	ld hl, $0000
	add hl, bc
	ld a, [wCenteredObject]
	inc a
	cp [hl]
	jr z, .sub_d5b1
	ld hl, $0004
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, $0005
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
.sub_d5b1
	ld hl, $0010
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hConnectionStripLength]
	inc a
	cp $05
	jr nz, .sub_d596
	ret
.sub_d5bf
	ld hl, wcdb2
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	add a
	ld e, a
	ld d, $00
	ld hl, Tabled5d3
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Tabled5d3:
	dw RefreshTiles
	dw Functiond5ea
	dw BufferScreen
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9
	dw Functiond5e9

Functiond5e9:
	ret

Functiond5ea:
	ld hl, Functionc9c1
	ld a, BANK(Functionc9c1)
	call FarCall_hl
	ret

Functiond5f3:
	ld a, [wPlayerStepDirection]
	and a
	jr z, .sub_d606
	cp $01
	jr z, .sub_d610
	cp $02
	jr z, .sub_d61a
	cp $03
	jr z, .sub_d624
	ret
.sub_d606
	call Functiond62e
	call LoadMapPart
	call ScheduleSouthRowRedraw
	ret
.sub_d610
	call Functiond65f
	call LoadMapPart
	call ScheduleNorthRowRedraw
	ret
.sub_d61a
	call Functiond692
	call LoadMapPart
	call ScheduleWestColumnRedraw
	ret
.sub_d624
	call Functiond6bb
	call LoadMapPart
	call ScheduleEastColumnRedraw
	ret

Functiond62e:
	ld a, [wBGMapAnchor]
	add $40
	ld [wBGMapAnchor], a
	jr nc, .sub_d643
	ld a, [wBGMapAnchor+1]
	inc a
	and $03
	or $98
	ld [wBGMapAnchor+1], a
.sub_d643
	ld hl, wMetatileNextY
	inc [hl]
	ld a, [hl]
	cp $02
	jr nz, .sub_d651
	ld [hl], $00
	call .sub_d652
.sub_d651
	ret
.sub_d652
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add $06
	add [hl]
	ld [hli], a
	ret nc
	inc [hl]
	ret

Functiond65f:
	ld a, [wBGMapAnchor]
	sub $40
	ld [wBGMapAnchor], a
	jr nc, .sub_d674
	ld a, [wBGMapAnchor+1]
	dec a
	and $03
	or $98
	ld [wBGMapAnchor+1], a
.sub_d674
	ld hl, wMetatileNextY
	dec [hl]
	ld a, [hl]
	cp $ff
	jr nz, .sub_d682
	ld [hl], $01
	call .sub_d683
.sub_d682
	ret
.sub_d683
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add $06
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ret nc
	dec [hl]
	ret

Functiond692:
	ld a, [wBGMapAnchor]
	ld e, a
	and $e0
	ld d, a
	ld a, e
	sub $02
	and $1f
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	dec [hl]
	ld a, [hl]
	cp $ff
	jr nz, .sub_d6b0
	ld [hl], $01
	call .sub_d6b1
.sub_d6b0
	ret
.sub_d6b1
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	sub $01
	ld [hli], a
	ret nc
	dec [hl]
	ret

Functiond6bb:
	ld a, [wBGMapAnchor]
	ld e, a
	and $e0
	ld d, a
	ld a, e
	add $02
	and $1f
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	inc [hl]
	ld a, [hl]
	cp $02
	jr nz, .sub_d6d9
	ld [hl], $00
	call .sub_d6da
.sub_d6d9
	ret
.sub_d6da
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	add $01
	ld [hli], a
	ret nc
	inc [hl]
	ret

Functiond6e4:
	ld a, [wcb6e]
	and a
	ret z
	bit 7, a
	jr nz, .sub_d6f7
	bit 6, a
	jr nz, .sub_d702
	bit 5, a
	jp nz, Functiond543
	ret
.sub_d6f7
	ld a, $04
	ld [wcdb2], a
	call Functiond708
	jp Functiond543
.sub_d702
	call Functiond51e
	jp Functiond543

Functiond708:
	ld a, [wPlayerStepDirection]
	and a
	jr z, .sub_d71b
	cp $01
	jr z, .sub_d727
	cp $02
	jr z, .sub_d733
	cp $03
	jr z, .sub_d73f
	ret
.sub_d71b
	call Functiond62e
	call LoadMapPart
	ld a, $02
	call .sub_d74b
	ret
.sub_d727
	call Functiond65f
	call LoadMapPart
	ld a, $01
	call .sub_d74b
	ret
.sub_d733
	call Functiond692
	call LoadMapPart
	ld a, $03
	call .sub_d74b
	ret
.sub_d73f
	call Functiond6bb
	call LoadMapPart
	ld a, $04
	call .sub_d74b
	ret
.sub_d74b
	push af
	call .sub_d758
	call Functiond873
	pop af
	add $02
	ldh [hRedrawRowOrColumnMode], a
	ret
.sub_d758
	dec a
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	add hl, hl
	ldh a, [hOverworldFlashlightEffect]
	dec a
	swap a
	sla a
	ld e, a
	ld d, $00
	add hl, de
	ld de, Datad7b1
	add hl, de
	call Functiond831
	ld a, e
	ld [wOverworldMapBlocksEnd], a
	ld a, d
	ld [wRedrawFlashlightDst0+1], a
	call Functiond85f
	ld a, e
	ld [wRedrawFlashlightSrc0], a
	ld a, d
	ld [wRedrawFlashlightSrc0+1], a
	call Functiond831
	ld a, e
	ld [wRedrawFlashlightBlackDst0], a
	ld a, d
	ld [wRedrawFlashlightBlackDst0+1], a
	call Functiond831
	ld a, e
	ld [wRedrawFlashlightDst1], a
	ld a, d
	ld [wRedrawFlashlightDst1+1], a
	call Functiond85f
	ld a, e
	ld [wRedrawFlashlightSrc1], a
	ld a, d
	ld [wRedrawFlashlightSrc1+1], a
	call Functiond831
	ld a, e
	ld [wRedrawFlashlightBlackDst1], a
	ld a, d
	ld [wRedrawFlashlightBlackDst1+1], a
	ret

Datad7b1:
	db $02, $03, $02, $11, $02, $02, $02, $10
	db $02, $0e, $02, $00, $02, $0f, $02, $01
	db $03, $02, $11, $02, $02, $02, $10, $02
	db $0e, $02, $00, $02, $0f, $02, $01, $02
	db $04, $05, $04, $0f, $04, $04, $04, $0e
	db $04, $0c, $04, $02, $04, $0d, $04, $03
	db $05, $04, $0f, $04, $04, $04, $0e, $04
	db $0c, $04, $02, $04, $0d, $04, $03, $04
	db $06, $07, $06, $0d, $06, $06, $06, $0c
	db $06, $0a, $06, $04, $06, $0b, $06, $05
	db $07, $06, $0d, $06, $06, $06, $0c, $06
	db $0a, $06, $04, $06, $0b, $06, $05, $06
	db $08, $09, $08, $0b, $08, $08, $08, $0a
	db $08, $08, $08, $06, $08, $09, $08, $07
	db $09, $08, $0b, $08, $08, $08, $0a, $08
	db $08, $08, $06, $08, $09, $08, $07, $08

Functiond831:
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	push hl
	push bc
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor+1]
	ld d, a
.sub_d83f
	ld a, $20
	add e
	ld e, a
	jr nc, .sub_d846
	inc d
.sub_d846
	ld a, d
	and $03
	or $98
	ld d, a
	dec b
	jr nz, .sub_d83f
.sub_d84f
	ld a, e
	inc a
	and $1f
	ld b, a
	ld a, e
	and $e0
	or b
	ld e, a
	dec c
	jr nz, .sub_d84f
	pop bc
	pop hl
	ret

Functiond85f:
	push hl
	ld hl, wTileMap
	ld de, $0014
.sub_d866
	ld a, b
	and a
	jr z, .sub_d86e
	add hl, de
	dec b
	jr .sub_d866
.sub_d86e
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ret

Functiond873:
	ldh a, [hOverworldFlashlightEffect]
	dec a
	ld l, a
	ld h, $00
	ld de, Datad882
	add hl, de
	ld a, [hl]
	ld [wRedrawFlashlightWidthHeight], a
	ret

Datad882:
	db $07, $05, $03, $01

Functiond886:
	ld de, wPartyCount
	ld a, [wMonType]
	and $0f
	jr z, .sub_d893
	ld de, wd913
.sub_d893
	ld a, [de]
	inc a
	cp $07
	ret nc
	ld [de], a
	ld a, [de]
	ldh [hMoveMon], a
	add e
	ld e, a
	jr nc, .sub_d8a1
	inc d
.sub_d8a1
	ld a, [wMonDexIndex]
	ld [de], a
	inc de
	ld a, $ff
	ld [de], a
	ld hl, wPartyMon6StatsEnd
	ld a, [wMonType]
	and $0f
	jr z, Functiond8b6
	ld hl, wOTPartyMonOT

Functiond8b6:
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, $0006
	call CopyBytes
	ld a, [wMonType]
	and a
	jr nz, .sub_d8ea
	ld a, [wMonDexIndex]
	ld [wce37], a
	call GetPokemonName
	ld hl, wPartyMonNicknames
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_d8ea
	ld hl, wPartyMon1
	ld a, [wMonType]
	and $0f
	jr z, .sub_d8f7
	ld hl, wWildMons
.sub_d8f7
	ldh a, [hMoveMon]
	dec a
	ld bc, $0030
	call AddNTimes
	ld e, l
	ld d, h
	push hl
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	call GetMonHeader
	ld a, [wMonHeader]
	ld [de], a
	inc de
	ld a, [wBattleMode]
	and a
	jr z, .sub_d91b
	ld a, [wcdda]
	ld [de], a
.sub_d91b
	inc de
	push de
	xor a
	ld [wFieldMoveScriptID], a
	ld a, $2a
	call Predef
	pop de
	inc de
	inc de
	inc de
	inc de
	ld a, [wce73]
	ld [de], a
	inc de
	ld a, [wce74]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	ld hl, Function50cd1
	ld a, BANK(Function50cd1)
	call FarCall_hl
	pop de
	ldh a, [hMultiplicand]
	ld [de], a
	inc de
	ldh a, [hDividend+2]
	ld [de], a
	inc de
	ldh a, [hDividend+3]
	ld [de], a
	inc de
	xor a
	ld b, $0a
.sub_d952
	ld [de], a
	inc de
	dec b
	jr nz, .sub_d952
	pop hl
	push hl
	ld a, [wMonType]
	and $0f
	ld a, $98
	ld b, $88
	jr nz, .sub_d99a
	ld a, [wMonDexIndex]
	ld [wce37], a
	dec a
	ld c, a
	ld b, $02
	ld hl, wPartyMonNicknamesEnd
	push de
	ld d, $03
	call SmallFarFlagAction
	pop de
	ld a, c
	ld a, [wce37]
	dec a
	ld c, a
	ld b, $01
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexOwnedEnd
	call SmallFarFlagAction
	pop hl
	push hl
	ld a, [wBattleMode]
	and a
	jr nz, .sub_d9d3
	call Random
	ld b, a
	call Random
.sub_d99a
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de
	push hl
	push de
	inc hl
	inc hl
	call FillPP
	pop de
	pop hl
	inc de
	inc de
	inc de
	inc de
	ld a, $46
	ld [de], a
	inc de
	inc de
	inc de
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld bc, $000a
	add hl, bc
	ld a, $01
	ld c, a
	xor a
	ld b, a
	call Functiondf91
	ldh a, [hDividend+2]
	ld [de], a
	inc de
	ldh a, [hDividend+3]
	ld [de], a
	inc de
	jr .sub_da0a
.sub_d9d3
	ld a, [wcddf]
	ld [de], a
	inc de
	ld a, [wcde0]
	ld [de], a
	inc de
	push hl
	ld hl, wcde1
	ld b, $04
.sub_d9e3
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .sub_d9e3
	pop hl
	ld a, $46
	ld [de], a
	inc de
	inc de
	inc de
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de
	ld a, [wcde7]
	ld [de], a
	inc de
	ld a, [wcde8]
	ld [de], a
	inc de
	ld a, [wcde9]
	ld [de], a
	inc de
	ld a, [wcdea]
	ld [de], a
	inc de
.sub_da0a
	ld a, [wBattleMode]
	dec a
	jr nz, .sub_da1c
	ld hl, wcdeb
	ld bc, $000c
	call CopyBytes
	pop hl
	jr .sub_da26
.sub_da1c
	pop hl
	ld bc, $000a
	add hl, bc
	ld b, $00
	call Functiondf7d
.sub_da26
	scf
	ret

FillPP:
	ld b, $04
.sub_da2a
	ld a, [hli]
	and a
	jr z, .sub_da49
	dec a
	push hl
	push de
	push bc
	ld hl, Functiond8b6
	ld bc, $0007
	call AddNTimes
	ld de, wStringBuffer1
	ld a, $10
	call FarCopyBytes
	pop bc
	pop de
	pop hl
	ld a, [wStringBuffer1+5]
.sub_da49
	ld [de], a
	inc de
	dec b
	jr nz, .sub_da2a
	ret


Functionda4f:
	ld hl, wPartyCount
	ld a, [hl]
	cp $06
	scf
	ret z
	inc a
	ld [hl], a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [wMonDexIndex]
	ld [hli], a
	ld [hl], $ff
	ld hl, wPartyMon1
	ld a, [wPartyCount]
	dec a
	ld bc, $0030
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wcd7f
	call CopyBytes
	ld hl, wPartyMon6StatsEnd
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld a, [wWhichPokemon]
	call SkipNames
	ld bc, $0006
	call CopyBytes
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wda5f
	ld a, [wWhichPokemon]
	call SkipNames
	ld bc, $0006
	call CopyBytes
	ld a, [wMonDexIndex]
	ld [wce37], a
	dec a
	ld c, a
	ld b, $01
	ld hl, wPartyMonNicknamesEnd
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexOwnedEnd
	call SmallFarFlagAction
	and a
	ret

Functiondac8:
	ld a, [wcd7c]
	and a
	jr z, .sub_dae3
	cp $02
	jr z, .sub_dae3
	cp $03
	ld hl, wd882
	jr z, .sub_db1f
	ld hl, wBoxListLength
	ld a, [hl]
	cp $1e
	jr nz, .sub_daed
	jr .sub_daeb
.sub_dae3
	ld hl, wPartyCount
	ld a, [hl]
	cp $06
	jr nz, .sub_daed
.sub_daeb
	scf
	ret
.sub_daed
	inc a
	ld [hl], a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [wcd7c]
	cp $02
	ld a, [wd882]
	jr z, .sub_db00
	ld a, [wMonDexIndex]
.sub_db00
	ld [hli], a
	ld [hl], $ff
	ld a, [wcd7c]
	dec a
	ld hl, wPartyMon1
	ld bc, $0030
	ld a, [wPartyCount]
	jr nz, .sub_db1b
	ld hl, wdaa3
	ld bc, $0020
	ld a, [wBoxListLength]
.sub_db1b
	dec a
	call AddNTimes
.sub_db1f
	push hl
	ld e, l
	ld d, h
	ld a, [wcd7c]
	and a
	ld hl, wdaa3
	ld bc, $0020
	jr z, .sub_db3b
	cp $02
	ld hl, wd882
	jr z, .sub_db41
	ld hl, wPartyMon1
	ld bc, $0030
.sub_db3b
	ld a, [wWhichPokemon]
	call AddNTimes
.sub_db41
	ld bc, $0020
	call CopyBytes
	ld a, [wcd7c]
	cp $03
	ld de, wd87c
	jr z, .sub_db66
	dec a
	ld hl, wPartyMon6StatsEnd
	ld a, [wPartyCount]
	jr nz, .sub_db60
	ld hl, wde63
	ld a, [wBoxListLength]
.sub_db60
	dec a
	call SkipNames
	ld d, h
	ld e, l
.sub_db66
	ld hl, wde63
	ld a, [wcd7c]
	and a
	jr z, .sub_db79
	ld hl, wd87c
	cp $02
	jr z, .sub_db7f
	ld hl, wPartyMon6StatsEnd
.sub_db79
	ld a, [wWhichPokemon]
	call SkipNames
.sub_db7f
	ld bc, $0006
	call CopyBytes
	ld a, [wcd7c]
	cp $03
	ld de, wd876
	jr z, .sub_dba4
	dec a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	jr nz, .sub_db9e
	ld hl, wdf17
	ld a, [wBoxListLength]
.sub_db9e
	dec a
	call SkipNames
	ld d, h
	ld e, l
.sub_dba4
	ld hl, wdf17
	ld a, [wcd7c]
	and a
	jr z, .sub_dbb7
	ld hl, wd876
	cp $02
	jr z, .sub_dbbd
	ld hl, wPartyMonNicknames
.sub_dbb7
	ld a, [wWhichPokemon]
	call SkipNames
.sub_dbbd
	ld bc, $0006
	call CopyBytes
	pop hl
	ld a, [wcd7c]
	cp $01
	jr z, .sub_dc14
	cp $03
	jr z, .sub_dc14
	push hl
	srl a
	add $02
	ld [wMonType], a
	ld a, $31
	call Predef
	ld a, BANK(Function50caa)
	ld hl, Function50caa
	call FarCall_hl
	ld a, d
	ld [wCurPartyLevel], a
	pop hl
	ld b, h
	ld c, l
	ld hl, $001f
	add hl, bc
	ld [hl], a
	ld hl, $0024
	add hl, bc
	ld d, h
	ld e, l
	ld hl, $000a
	add hl, bc
	push bc
	ld b, $01
	call Functiondf7d
	pop bc
	ld a, [wcd7c]
	and a
	jr nz, .sub_dc14
	ld hl, $0022
	add hl, bc
	ld d, h
	ld e, l
	inc hl
	inc hl
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	inc de
	ld [de], a
.sub_dc14
	and a
	ret

Functiondc16:
	ld hl, wPartyCount
	ld a, [hl]
	cp $06
	push af
	jr nz, .sub_dc2a
	ld hl, wBoxListLength
	ld a, [hl]
	cp $1e
	jr nz, .sub_dc2a
	pop af
	scf
	ret
.sub_dc2a
	inc a
	ld [hl], a
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [wcd7c]
	and a
	ld a, [wd882]
	ld de, wd876
	jr z, .sub_dc42
	ld a, [wd8b1]
	ld de, wd8a5
.sub_dc42
	ld [hli], a
	ld [wCurSpecies], a
	ld a, $ff
	ld [hl], a
	pop af
	jr z, .sub_dcad
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, $0006
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl
	ld hl, wPartyMon6StatsEnd
	ld a, [wPartyCount]
	dec a
	ld bc, $0006
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	ld hl, wPartyMon1
	ld a, [wPartyCount]
	dec a
	ld bc, $0030
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, $0020
	call CopyBytes
	call GetMonHeader
	ld h, d
	ld l, e
	dec hl
	ld a, [hl]
	ld [wCurPartyLevel], a
	inc de
	inc de
	push de
	inc de
	inc de
	push de
	ld bc, hFFEB
	add hl, bc
	ld b, $01
	call Functiondf7d
	pop hl
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jr .sub_dce9
.sub_dcad
	ld hl, wdf17
	ld a, [wBoxListLength]
	ld bc, $0006
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl
	ld hl, wde63
	ld a, [wBoxListLength]
	ld bc, $0006
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	ld hl, wdaa3
	ld a, [wBoxListLength]
	ld bc, $0030
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, $0020
	call CopyBytes
.sub_dce9
	ld a, [wcd7c]
	and a
	ret z
	ld hl, wd8d1
	ld de, wd8a5
	ld bc, $002c
	call CopyBytes
	and a
	ret

Functiondcfc:
	ld a, [wcd7c]
	ld de, wd876
	and a
	jr z, .sub_dd2c
	ld hl, wd8a5
	ld de, wd8d1
	ld bc, $0006
	call CopyBytes
	ld hl, wd8ab
	ld de, wd8d7
	ld bc, $0006
	call CopyBytes
	ld hl, wd8b1
	ld de, wd8dd
	ld bc, $0020
	call CopyBytes
	ld de, wd8a5
.sub_dd2c
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	ld bc, $0006
	call AddNTimes
	call CopyBytes
	ld a, [wWhichPokemon]
	ld hl, wPartyMon6StatsEnd
	ld bc, $0006
	call AddNTimes
	call CopyBytes
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1
	ld bc, $0030
	call AddNTimes
	ld bc, $0020
	jp CopyBytes

Functiondd5c:
	ld de, wBoxListLength
	ld a, [de]
	cp $1e
	ret nc
	inc a
	ld [de], a
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	ld c, a
.sub_dd6c
	inc de
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp $ff
	jr nz, .sub_dd6c
	call GetMonHeader
	ld hl, wde63
	ld bc, $0006
	ld a, [wBoxListLength]
	dec a
	jr z, .sub_dda9
	dec a
	call AddNTimes
	push hl
	ld bc, $0006
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxListLength]
	dec a
	ld b, a
.sub_dd96
	push bc
	push hl
	ld bc, $0006
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, $fffa
	add hl, bc
	pop bc
	dec b
	jr nz, .sub_dd96
.sub_dda9
	ld hl, wPlayerName
	ld de, wde63
	ld bc, $0006
	call CopyBytes
	ld a, [wBoxListLength]
	dec a
	jr z, .sub_dde5
	ld hl, wdf17
	ld bc, $0006
	dec a
	call AddNTimes
	push hl
	ld bc, $0006
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxListLength]
	dec a
	ld b, a
.sub_ddd2
	push bc
	push hl
	ld bc, $0006
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, $fffa
	add hl, bc
	pop bc
	dec b
	jr nz, .sub_ddd2
.sub_dde5
	ld a, [wMonDexIndex]
	ld [wce37], a
	call GetPokemonName
	ld de, wdf17
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
	ld a, [wBoxListLength]
	dec a
	jr z, .sub_de2a
	ld hl, wdaa3
	ld bc, $0020
	dec a
	call AddNTimes
	push hl
	ld bc, $0020
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxListLength]
	dec a
	ld b, a
.sub_de17
	push bc
	push hl
	ld bc, $0020
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, hBGMapAddress
	add hl, bc
	pop bc
	dec b
	jr nz, .sub_de17
.sub_de2a
	ld hl, wcdd9
	ld de, wdaa3
	ld bc, $0006
	call CopyBytes
	ld hl, wce73
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	ld hl, Function50cd1
	ld a, BANK(Function50cd1)
	call FarCall_hl
	pop de
	ldh a, [hMultiplicand]
	ld [de], a
	inc de
	ldh a, [hDividend+2]
	ld [de], a
	inc de
	ldh a, [hDividend+3]
	ld [de], a
	inc de
	xor a
	ld b, $0a
.sub_de5c
	ld [de], a
	inc de
	dec b
	jr nz, .sub_de5c
	ld hl, wcddf
	ld b, $07
.sub_de66
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .sub_de66
	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	scf
	ret

Functionde79:
	ld a, [wPartyCount]
	cp $06
	jr z, .sub_de8b
	call Functiond886
	ld de, wPartyMonNicknames
	ld hl, wPartyCount
	jr .sub_dead
.sub_de8b
	ld a, [wBoxListLength]
	cp $1e
	scf
	ret z
	ld a, [wMonDexIndex]
	ld [wcdd7], a
	xor a
	ld [wca44], a
	ld hl, AddPokemonToBox
	ld a, BANK(AddPokemonToBox)
	call FarCall_hl
	call Functiondd5c
	ld de, wdf17
	ld hl, wBoxListLength
.sub_dead
	ld a, [hl]
	push af
	ld b, $00
	ld c, a
	add hl, bc
	ld a, $fd
	ld [hl], a
	pop af
	dec a
	ld h, d
	ld l, e
	ld bc, $0006
	call AddNTimes
	ld a, $c0
	ld [hli], a
	ld a, $cf
	ld [hli], a
	ld a, $2a
	ld [hli], a
	ld [hl], $50
	and a
	ret

Functiondecd:
	ld hl, wPartyCount
	ld a, [wcd7c]
	and a
	jr z, .sub_ded9
	ld hl, wBoxListLength
.sub_ded9
	ld a, [hl]
	dec a
	ld [hli], a
	ld a, [wWhichPokemon]
	ld c, a
	ld b, $00
	add hl, bc
	ld e, l
	ld d, h
	inc de
.sub_dee6
	ld a, [de]
	inc de
	ld [hli], a
	inc a
	jr nz, .sub_dee6
	ld hl, wPartyMon6StatsEnd
	ld d, $05
	ld a, [wcd7c]
	and a
	jr z, .sub_defc
	ld hl, wde63
	ld d, $1d
.sub_defc
	ld a, [wWhichPokemon]
	call SkipNames
	ld a, [wWhichPokemon]
	cp d
	jr nz, .sub_df0b
	ld [hl], $ff
	ret
.sub_df0b
	ld d, h
	ld e, l
	ld bc, $0006
	add hl, bc
	ld bc, wPartyMonNicknames
	ld a, [wcd7c]
	and a
	jr z, .sub_df1d
	ld bc, wdf17
.sub_df1d
	call CopyDataUntil
	ld hl, wPartyMon1
	ld bc, $0030
	ld a, [wcd7c]
	and a
	jr z, .sub_df32
	ld hl, wdaa3
	ld bc, $0020
.sub_df32
	ld a, [wWhichPokemon]
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [wcd7c]
	and a
	jr z, .sub_df49
	ld bc, $0020
	add hl, bc
	ld bc, wde63
	jr .sub_df50
.sub_df49
	ld bc, $0030
	add hl, bc
	ld bc, wPartyMon6StatsEnd
.sub_df50
	call CopyDataUntil
	ld hl, wPartyMonNicknames
	ld a, [wcd7c]
	and a
	jr z, .sub_df5f
	ld hl, wdf17
.sub_df5f
	ld bc, $0006
	ld a, [wWhichPokemon]
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, $0006
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wcd7c]
	and a
	jr z, .sub_df7a
	ld bc, wdfcb
.sub_df7a
	jp CopyDataUntil

Functiondf7d:
	ld c, $00
.sub_df7f
	inc c
	call Functiondf91
	ldh a, [hDividend+2]
	ld [de], a
	inc de
	ldh a, [hDividend+3]
	ld [de], a
	inc de
	ld a, c
	cp $06
	jr nz, .sub_df7f
	ret

Functiondf91:
	push hl
	push de
	push bc
	ld a, b
	ld d, a
	push hl
	ld hl, wMonHBaseHP
	dec hl
	ld b, $00
	add hl, bc
	ld a, [hl]
	ld e, a
	pop hl
	push hl
	ld a, c
	cp $06
	jr nz, .sub_dfa9
	dec hl
	dec hl
.sub_dfa9
	sla c
	ld a, d
	and a
	jr z, .sub_dfce
	add hl, bc
.sub_dfb0
	xor a
	ldh [hMultiplicand], a
	ldh [hDividend+2], a
	inc b
	ld a, b
	cp $ff
	jr z, .sub_dfce
	ldh [hDividend+3], a
	ldh [hDivisor], a
	call Multiply
	ld a, [hld]
	ld d, a
	ldh a, [hDividend+3]
	sub d
	ld a, [hli]
	ld d, a
	ldh a, [hDividend+2]
	sbc d
	jr c, .sub_dfb0
.sub_dfce
	srl c
	pop hl
	push bc
	ld bc, $000b
	add hl, bc
	pop bc
	ld a, c
	cp $02
	jr z, .sub_e00c
	cp $03
	jr z, .sub_e013
	cp $04
	jr z, .sub_e018
	cp $05
	jr z, .sub_e020
	cp $06
	jr z, .sub_e020
	push bc
	ld a, [hl]
	swap a
	and $01
	add a
	add a
	add a
	ld b, a
	ld a, [hli]
	and $01
	add a
	add a
	add b
	ld b, a
	ld a, [hl]
	swap a
	and $01
	add b
	add b
	ld b, a
	ld a, [hl]
	and $01
	add b
	pop bc
	jr .sub_e024
.sub_e00c
	ld a, [hl]
	swap a
	and $0f
	jr .sub_e024
.sub_e013
	ld a, [hl]
	and $0f
	jr .sub_e024
.sub_e018
	inc hl
	ld a, [hl]
	swap a
	and $0f
	jr .sub_e024
.sub_e020
	inc hl
	ld a, [hl]
	and $0f
.sub_e024
	ld d, $00
	add e
	ld e, a
	jr nc, .sub_e02b
	inc d
.sub_e02b
	sla e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .sub_e038
	inc d
.sub_e038
	ldh [hDividend+3], a
	ld a, d
	ldh [hDividend+2], a
	xor a
	ldh [hMultiplicand], a
	ld a, [wCurPartyLevel]
	ldh [hDivisor], a
	call Multiply
	ldh a, [hMultiplicand]
	ldh [hDividend], a
	ldh a, [hDividend+2]
	ldh [hMultiplicand], a
	ldh a, [hDividend+3]
	ldh [hDividend+2], a
	ld a, $64
	ldh [hDivisor], a
	ld a, $03
	ld b, a
	call Divide
	ld a, c
	cp $01
	ld a, $05
	jr nz, .sub_e077
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .sub_e075
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a
.sub_e075
	ld a, $0a
.sub_e077
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .sub_e084
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a
.sub_e084
	ldh a, [hDividend+2]
	cp $04
	jr nc, .sub_e094
	cp $03
	jr c, .sub_e09c
	ldh a, [hDividend+3]
	cp $e8
	jr c, .sub_e09c
.sub_e094
	ld a, $03
	ldh [hDividend+2], a
	ld a, $e7
	ldh [hDividend+3], a
.sub_e09c
	pop bc
	pop de
	pop hl
	ret

Function60a0:
	ld a, [wMonDexIndex]
	dec a
	ld c, a
	ld d, $00
	ld hl, wPartyMonNicknamesEnd
	ld b, $02
	ld a, $0c
	call Predef
	push bc
	xor a
	ld [wMonType], a
	call Functiond886
	jr nc, .sub_e0d2
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, $0006
	call AddNTimes
	ld d, h
	ld e, l
	pop bc
	ld a, c
	ld b, $00
	push bc
	push de
	jr .sub_e0e1
.sub_e0d2
	call Functiondd5c
	pop bc
	jp nc, .sub_e165
	ld a, c
	ld de, wdf17
	ld b, $01
	push bc
	push de
.sub_e0e1
	push af
	ld a, [wMonDexIndex]
	ld [wce37], a
	call GetPokemonName
	pop af
	and a
	jr nz, .sub_e10d
	ld hl, wd41c
	bit 4, [hl]
	jr z, .sub_e10d
	ld hl, Texte198
	call PrintText
	call ClearSprites
	ld a, [wMonDexIndex]
	ld [wce37], a
	ld a, $2e
	call Predef
	call LoadTilesetGFX_LCDOff
.sub_e10d
	ld hl, Texte1bb
	call PrintText
	call YesNoBox
	pop de
	jr c, .sub_e155
	push de
	ld b, $00
	callba NamingScreen
	pop de
	ld a, [de]
	cp $50
	jr nz, .sub_e133
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_e133
	call ClearBGPalettes
	ld hl, wcdaf
	ld a, [hl]
	push af
	res 7, [hl]
	set 6, [hl]
	call RedrawPlayerSprite
	pop af
	ld [wcdaf], a
	call LoadFontExtra
	call LoadMapPart
	call GetMemSGBLayout
	call WaitBGMap
	call GBFadeInFromWhite
.sub_e155
	pop bc
	ld a, b
	and a
	ret z
	ld hl, Texte168
	ld hl, Texte181
	call PrintText
	ld b, $01
	ret
.sub_e165
	ld b, $02
	ret

Texte168:
	text_from_ram wStringBuffer1
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

Texte181:
	text_from_ram wStringBuffer1
	text "は　だれかの　<PC>に"
	line "てんそうされた！"
	prompt

Texte198:
	text_from_ram wStringBuffer1
	text "の　データが　あたらしく"
	line "#ずかんに　セーブされます！@"

Texte1b8:
	db "ドギ@"

Texte1bb:
	text "ゲットした　@"

Texte1c3:
	text_from_ram wStringBuffer1
	text "に"
	line "なまえを　つけますか？"
	done

_BillsPC:
	call Functione284
	ret c
	call LoadStandardMenuHeader
	call ClearTileMap
	call LoadFontsBattleExtra
	ld hl, vChars2 + $780
	ld de, PokeBallsGFX
	lb bc, BANK(PokeBallsGFX), $01
	call Request2bpp
	ld hl, Texte224
	call MenuTextBox
	ld hl, Datae22e
	call LoadMenuHeader
.sub_e1fa
	call SetPalettes
	xor a
	ld [wActiveBackpackPocket], a
	call OpenMenu
	jr c, .sub_e211
	ld a, [wMenuSelection]
	ld hl, Tablee270
	call CallJumptable
	jr nc, .sub_e1fa
.sub_e211
	call CloseWindow
	call CloseWindow
	call LoadTilesetGFX
	call Function360b
	call LoadFontExtra
	call CloseWindow
	ret

Texte224:
	text "なんに　するん？" ; (lit. "What are you going to do?")
	done

Datae22e:
	db $40, $00, $00, $11, $0e
	dw Datae236
	db $01

Datae236:
	db $80, $00
	dw Datae27c
	db $8a, $1f
	dw Texte23e

Texte23e:
	db "#の　ようすをみる@" ; (lit "look at Pokemon")

Texte248:
	db "#を　つれていく@" ; "Withdrawal (Pokemon)"

Texte251:
	db "#を　あずける@" ; "Deposit (Pokemon)"

Texte259:
	db "#を　にがす@" ; "Release (Pokemon)"

Texte260:
	db "ボックスを　かえる@" ; "Change Box"

Texte26a:
	db "さようなら@"

Tablee270:
	dw Functione5c5
	dw Functione31b
	dw Functione2a6 ; Bill's PC > Deposit Pokemon menu item
	dw Functione37b ; Bill's PC > Release Pokemon menu item
	dw Functione3c3 ; Bill's PC > Box Change menu item
	dw Functione2a4

Datae27c:
	db $05, $00, $01, $02, $03, $04, $05, $ff

Functione284:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, Texte291
	call MenuTextBoxBackup
	scf
	ret

Texte291:
	text "#もってへんやつは"
	line "おことわりや！"
	prompt

Functione2a4:
	scf
	ret

Functione2a6: ; Bill's PC > Deposit Pokemon menu item
	call Functione2b0
	jr c, .sub_e2ae
	call Functione2f0
.sub_e2ae
	and a
	ret

Functione2b0:
	ld a, [wPartyCount]
	and a
	jr z, .sub_e2bc
	cp $02
	jr c, .sub_e2c4
	and a
	ret
.sub_e2bc
	ld hl, Texte2cc
	call MenuTextBoxBackup
	scf
	ret
.sub_e2c4
	ld hl, Texte2dc ; failed deposit last mon
	call MenuTextBoxBackup
	scf
	ret

Texte2cc:
	text "１ぴきも　もってへんやんか！"
	prompt

Texte2dc: ; failed deposit last mon
	text "それ　あずけたら" ; telling you that you can't deposit your last mon
	line "こまるんとちゃう？"
	prompt

Functione2f0:
	call LoadStandardMenuHeader
	ld hl, Tablee6da
	call Functione6a4 ; has something to do with releasing mon from PC
	call CloseWindow
	ret c
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	ld a, [wMenuSelection]
	ld [wMonDexIndex], a
	ld a, $01
	ld [wcd7c], a
	ld a, $12
	call Predef
	xor a
	ld [wcd7c], a
	call Functiondecd
	ret

Functione31b:
	call .sub_e325
	jr c, .sub_e323
	call Functione350
.sub_e323
	and a
	ret
.sub_e325
	ld a, [wPartyCount]
	cp $06
	jr nc, .sub_e32e
	and a
	ret
.sub_e32e
	ld hl, Texte336
	call MenuTextBoxBackup
	scf
	ret

Texte336:
	text "それいじょう　よくばったって"
	line "#　もたれへんで！"
	prompt

Functione350:
	call LoadStandardMenuHeader
	ld hl, Datae6f8
	call Functione6a4 ; has something to do with releasing mon from PC
	call CloseWindow
	ret c
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	ld a, [wMenuSelection]
	ld [wMonDexIndex], a
	xor a
	ld [wcd7c], a
	ld a, $12
	call Predef
	ld a, $01
	ld [wcd7c], a
	call Functiondecd
	ret

Functione37b: ; Bill's PC > Release Pokemon menu item
	call .sub_e380
	and a
	ret
.sub_e380
	call LoadStandardMenuHeader
	ld hl, Datae6f8
	call Functione6a4 ; has something to do with releasing mon from PC
	call CloseWindow
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	ld a, [wMenuSelection]
	ld [wMonDexIndex], a
	ret c
	ld hl, Texte3af ; confirm release of mon
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	ld a, $01
	ld [wcd7c], a
	call Functiondecd
	ret

Texte3af: ; confirm release of mon
	text_from_ram wStringBuffer1
	text "　をほんとうに" ; essentially confirming if you want to release the mon
	next "にがしますか？"
	done

Functione3c3: ; Bill's PC > Box Change menu item?
	call Functione3c8 ; has something to do with dummy boxes in box change screen
	and a
	ret

Functione3c8: ; has something to do with dummy boxes in box change screen
	call Functione3ed ; probably creating the 4 dummy boxes in change box screen but unsure
	call LoadStandardMenuHeader
	call ClearPalettes
	call ClearTileMap
.sub_e3d4
	ld hl, Datae414
	call CopyMenuHeader
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e3e9
	call Functione505 ; box editing menu function
	jr .sub_e3d4
.sub_e3e9
	call CloseWindow
	ret

Functione3ed: ; probably creating the 4 dummy boxes in change box screen but unsure
	ld hl, wd4b9
	ld c, $00
.sub_e3f2
	push hl
	ld de, Texte40c ; used for name of 4 dummy boxes (all clones of box 1)
	call CopyString
	ld a, $f6
	add c
	dec hl
	ld [hli], a
	ld [hl], $50
	pop hl
	ld de, $0009
	add hl, de
	inc c
	ld a, c
	cp $0a
	jr c, .sub_e3f2
	ret

Texte40c: ; used for name of 4 dummy boxes (all clones of box 1)
	db "ダミーボックス@" ; "Dummy Box"

Datae414:
	db $40, $00, $00, $0c, $13, $1c, $64, $01
	db $20, $04, $00, $01, $03, $2c, $64, $03
	db $38, $64, $00, $00, $00, $03, $9d, $64
	db $0a, $01, $02, $03, $04, $05, $06, $07
	db $08, $09, $0a, $ff

Functione438:
	push de
	ld a, [wMenuSelection]
	dec a
	ld bc, $0006
	ld hl, Texte461
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	push bc
	ld a, [wMenuSelection]
	dec a
	ld bc, $0009
	ld hl, wd4b9
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

Texte461:
	db "・．０１　@"
	db "・．０２　@"
	db "・．０３　@"
	db "・．０４　@"
	db "・．０５　@"
	db "・．０６　@"
	db "・．０７　@"
	db "・．０８　@"
	db "・．０９　@"
	db "・．１０　@"

Functione49d:
	ld h, d
	ld l, e
	ld de, Texte4bf
	call PlaceString
	ld hl, $0003
	add hl, bc
	push hl
	call Functione4ce
	pop hl
	ld de, wStringBuffer1
	ld [de], a
	ld bc, $0102
	call PrintNumber
	ld de, Texte4ca
	call PlaceString
	ret

Texte4bf:
	db "あずかっている#"
	next "　@"

Texte4ca:
	db "／３０@"

Functione4ce:
	ld a, [wMenuSelection]
	dec a
	ld c, a
	ld b, $00
	ld hl, Datae4e7
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ret

Datae4e7:
	db $02, $00, $a0
	db $02, $48, $a5
	db $02, $90, $aa
	db $02, $d8, $af
	db $02, $20, $b5
	db $03, $00, $a0
	db $03, $48, $a5
	db $03, $90, $aa
	db $03, $d8, $af
	db $03, $20, $b5

Functione505: ; box editing menu function
	ld hl, Datae5a5 ; box editing menu list
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [w2DMenuDataEnd]
	cp $01
	jr z, Functione53e ; box change function
	cp $02
	jr z, Functione57e ; box name change screen display function
	and a
	ret

Functione51f:
	ld hl, Texte529
	call MenuTextBox
	call CloseWindow
	ret

Texte529: ; confirming box was changed successfully
	text "バンクチェンジは"
	next "かいはつちゅうです！"
	prompt

Functione53e: ; box change function
	ld hl, Texte551 ; asking to save game data before box change
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	jr Functione51f ; confirming box was changed successfully

Functione54d:
	ld a, [wMenuSelection]
	ret

Texte551: ; asking to save game data before box change
	text "#　ボックスを　かえると"
	line "どうじに　レポートが　かかれます"
	para "<⋯⋯>　それでも　いいですか？"
	done

Functione57e: ; box name change screen display function
	ld b, $04
	ld de, wMovementBufferCount
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	call FarCall_hl
	ld a, [wMovementBufferCount]
	cp $50
	ret z
	ld hl, wd4b9
	ld bc, $0009
	ld a, [wMenuSelection]
	dec a
	call AddNTimes
	ld de, wMovementBufferCount
	call CopyString
	ret

Datae5a5: ; box editing menu list
	db $40, $06, $00, $0e, $0e
	dw Datae5ad ; box editing menu list items
	db $01

Datae5ad: ; box editing menu list items
	db $80, $03
	db "ボックスきりかえ@" ; "Change Box"
	db "なまえを　かえる@" ; " Change Name"
	db "やめる@" ; (lit "stop")

Functione5c5:
	call LoadStandardMenuHeader
	call Functione5d3
	call ClearPalettes
	call CloseWindow
	and a
	ret

Functione5d3:
	call ClearBGPalettes
	call .sub_e62a
	call SetPalettes
	ld hl, Datae71c
	call CopyMenuHeader
	ld a, [wcd3c]
	ld [wMenuCursorBuffer], a
	ld a, [wcd46]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wcd46], a
	ld a, [w2DMenuDataEnd]
	ld [wcd3c], a
	call ClearPalettes
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e60c
	call .sub_e60d
	jr Functione5d3
.sub_e60c
	ret
.sub_e60d
	ld a, [wScrollingMenuCursorPosition]
	ld [wWhichPokemon], a
	ld a, $02
	ld [wMonType], a
	call LoadStandardMenuHeader
	call LowVolume
	ld a, $3b
	call Predef
	call MaxVolume
	call ExitMenu
	ret
.sub_e62a
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	call ClearTileMap
	ld a, [wd4b6]
	ld hl, wd4b9
	ld bc, $0009
	call AddNTimes
	ld d, h
	ld e, l
	coord hl, 1, 1
	ld de, Texte679
	call PlaceString
	coord hl, 0, 3
	ld a, $79
	ld [hli], a
	ld a, $7a
	ld c, $13
.sub_e655
	ld [hli], a
	dec c
	jr nz, .sub_e655
	ld de, $0014
	ld a, $7c
	ld c, $08
.sub_e660
	ld [hl], a
	add hl, de
	dec c
	jr nz, .sub_e660
	coord hl, 2, 3
	ld de, Texte687
	call PlaceString
	ld hl, Texte697
	call PrintText
	pop af
	ld [wce5f], a
	ret

Texte679:
	db "ボックス／いまの　ボックス@"

Texte687:
	db "しゅるい　　なまえ　　　レべル@"

Texte697:
	text "どの#が　みたいねん？"
	done

Functione6a4: ; has something to do with releasing mon from PC
	ld a, l
	ld [wcd70], a
	ld a, h
	ld [wcd71], a
	coord hl, 4, 2
	ld b, $09
	ld c, $0e
	call DrawTextBox
	ld hl, wcd70
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Function3810 ; in home/scrolling_menu.asm but likely calls the select mon choice for release
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e6ce
	ld hl, Texte6d0 ; text after selecting mon to release
	call MenuTextBoxBackup
	and a
	ret
.sub_e6ce
	scf
	ret

Texte6d0: ; text after selecting mon to release
	text "#を　えらんだ！" ; (lit. "I choose <mon name>")
	prompt

Tablee6da:
	dw Datae6e0
	dw wcd3c
	dw wcd46

Datae6e0:
	db $40, $03, $05, $0b, $12
	dw Datae6e8
	db $01

Datae6e8:
	db $00, $04

Datae6ea:
	db $08, $01, $00, $aa, $d6, $09, $a6
	db $47, $09, $ba, $47, $00, $00, $00

Datae6f8:
	dw Datae6fe
	dw wcd3c
	dw wcd46

Datae6fe:
	db $40, $03, $05, $0b, $12
	dw Datae706
	db $01

Datae706:
	db $00, $04, $08, $01, $00, $83, $da, $09
	db $ab, $47, $09, $c1, $47, $00, $00, $00

Datae716:
	dw Datae71c
	dw wcd3c
	dw wcd46

Datae71c:
	db $40, $04, $01, $0b, $13, $24, $67, $01
	db $00, $04, $00, $01, $00, $83, $da, $09
	db $d8, $47, $00, $00, $00, $00, $00, $00

Function6734:
	call RefreshScreen
	call LowVolume
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wVramState
	res 0, [hl]
	call ClearBGPalettes
	call ClearSprites
	call LoadStandardMenuHeader
	ld hl, LoadPokeDexGraphics
	ld a, BANK(LoadPokeDexGraphics)
	call FarCall_hl
	call ClearTileMap
	ld hl, Function40b07
	ld a, BANK(Function40b07)
	call FarCall_hl
	call ClearBGPalettes
	ld hl, wVramState
	set 0, [hl]
	call ExitMenu
	call LoadTilesetGFX_LCDOff
	call Function360b
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	call MaxVolume
	call Function1fea
	ret

_UseItem:
	ld a, [wCurItem]
	ld [wce37], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld a, $01
	ld [wFieldMoveSucceeded], a
	ld a, [wCurItem]
	cp $c4
	jp nc, Functionf678
	ld hl, Tablee7a5
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Tablee7a5:
	dw Functione8f9
	dw Functione8f9
	dw Functionf66f
	dw Functione8f9
	dw Functione8f9
	dw Functionec95
	dw Functioneca4
	dw Functioned00
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionefee
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf2b5
	dw Functionf2cc
	dw Functionf4d1
	dw Functioned00
	dw Functioned00
	dw Functioned00
	dw Functionf66f
	dw Functioned37
	dw Functioned37
	dw Functioned37
	dw Functioned37
	dw Functionf66f
	dw Functioned37
	dw Functionee42
	dw Functionf2dc
	dw Functioned00
	dw Functionf66f
	dw Functionf66c
	dw Functionf2eb
	dw Functionef02
	dw Functionef8c
	dw Functionef8c
	dw Functionf2fa
	dw Functionf2c2
	dw Functionf2c7
	dw Functionf309
	dw Functionf66f
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf318
	dw Functionf66f
	dw Functionf318
	dw Functionf318
	dw Functionf318
	dw Functionf413
	dw Functionf4ca
	dw Functionf354
	dw Functionf66f
	dw Functionf437
	dw Functionf444
	dw Functionf66f
	dw Functionf46e
	dw Functionf4ca
	dw Functionf4d1
	dw Functionf4d1
	dw Functionf4d1
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf65d
	dw Functionfd45
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672

Functione8f9:
	ld a, [wBattleMode]
	and a
	jp z, Functionf7dd
	dec a
	jp nz, Functionf7ae
	ld a, [wPartyCount]
	cp $06
	jr nz, .sub_e913
	ld a, [wBoxListLength]
	cp $1e
	jp z, Functionf7d8
.sub_e913
	xor a
	ld [wce35], a
	call Functionec7a
	ld hl, Textf8c6
	call PrintText
	ld a, [wcdfe]
	ld b, a
	ld a, [wCurItem]
	cp $01
	jp z, .sub_e9d6
	cp $02
	jr z, .sub_e941
	cp $04
	jr z, .sub_e936
	jr .sub_e947
.sub_e936
	ld a, b
	srl a
	add b
	ld b, a
	jr nc, .sub_e947
	ld b, $ff
	jr .sub_e947
.sub_e941
	sla b
	jr nc, .sub_e947
	ld b, $ff
.sub_e947
	ld a, b
	ldh [hQuotient+2], a
	ld hl, wcde9
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	sla c
	rl b
	ld h, d
	ld l, e
	add hl, de
	add hl, de
	ld d, h
	ld e, l
	ld a, d
	and a
	jr z, .sub_e978
	srl d
	rr e
	srl d
	rr e
	srl b
	rr c
	srl b
	rr c
	ld a, c
	and a
	jr nz, .sub_e978
	ld c, $01
.sub_e978
	ld b, e
	push bc
	ld a, b
	sub c
	ldh [hDivisor], a
	xor a
	ldh [hDividend], a
	ldh [hMultiplicand], a
	ldh [hQuotient+1], a
	call Multiply
	pop bc
	ld a, b
	ldh [hDivisor], a
	ld b, $04
	call Divide
	ldh a, [hQuotient+2]
	and a
	jr nz, .sub_e998
	ld a, $01
.sub_e998
	ld b, a
	ld a, [wcde7]
	and $27
	ld c, $0a
	jr nz, .sub_e9a9
	and a
	ld c, $05
	jr nz, .sub_e9a9
	ld c, $00
.sub_e9a9
	ld a, b
	add c
	jr nc, .sub_e9af
	ld a, $ff
.sub_e9af
	ld d, a
	push de
	ld a, [wca03]
	ld hl, Function37e3d
	ld a, BANK(Function37e3d)
	call FarCall_hl
	ld a, b
	cp $46
	pop de
	ld a, d
	jr nz, .sub_e9c8
	add c
	jr nc, .sub_e9c8
	ld a, $ff
.sub_e9c8
	ld b, a
	ld [wFieldMoveScriptID], a
	call Random
	cp b
	ld a, $00
	jr z, .sub_e9d6
	jr nc, .sub_e9d9
.sub_e9d6
	ld a, [wcdd9]
.sub_e9d9
	ld [wce35], a
	ld c, $14
	call DelayFrames
	ld a, [wCurItem]
	ld [wca5c], a
	ld de, $0100
	ld a, e
	ld [wccc0], a
	ld a, d
	ld [wccc1], a
	xor a
	ldh [hBattleTurn], a
	ld [wMapBlocksAddress], a
	ld [wcccd], a
	ld a, $51
	call Predef
	ld a, [wce35]
	and a
	jr nz, .sub_ea29
	ld a, [wMapBlocksAddress]
	cp $01
	ld hl, Texteb98
	jp z, .sub_eb59
	cp $02
	ld hl, Textebaf
	jp z, .sub_eb59
	cp $03
	ld hl, Textebc3
	jp z, .sub_eb59
	cp $04
	ld hl, Textebdc
	jp z, .sub_eb59
.sub_ea29
	ld hl, wcde9
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	inc hl
	ld a, [hl]
	push af
	push hl
	ld hl, wcdda
	ld a, [hl]
	push af
	push hl
	ld hl, wca44
	bit 3, [hl]
	jr z, .sub_ea48
	ld a, $84
	ld [wcdd7], a
	jr .sub_ea55
.sub_ea48
	set 3, [hl]
	ld hl, wcad0
	ld a, [wcddf]
	ld [hli], a
	ld a, [wcde0]
	ld [hl], a
.sub_ea55
	ld a, [wcdd7]
	ld [wMonDexIndex], a
	ld a, [wcde6]
	ld [wCurPartyLevel], a
	ld hl, AddPokemonToBox
	ld a, BANK(AddPokemonToBox)
	call FarCall_hl
	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ld a, [wcdd9]
	ld [wce35], a
	ld [wMonDexIndex], a
	ld [wce37], a
	ld a, [wce03]
	dec a
	jp z, .sub_eb56
	ld hl, Textebf5
	call PrintText
	call ClearSprites
	ld a, [wce37]
	dec a
	ld c, a
	ld d, $00
	ld hl, wPartyMonNicknamesEnd
	ld b, $02
	ld a, $0c
	call Predef
	ld a, c
	push af
	ld a, [wce37]
	dec a
	ld c, a
	ld b, $01
	ld a, $0c
	call Predef
	pop af
	and a
	jr nz, .sub_eac7
	ld hl, Textec3e
	call PrintText
	call ClearSprites
	ld a, [wcdd9]
	ld [wce37], a
	ld a, $2e
	call Predef
.sub_eac7
	ld a, [wPartyCount]
	cp $06
	jr z, .sub_eb13
	xor a
	ld [wMonType], a
	call ClearSprites
	ld a, $10
	call Predef
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb5f
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	ld bc, $0006
	call AddNTimes
	ld d, h
	ld e, l
	ld b, $00
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	push de
	call FarCall_hl
	call GBFadeOutToWhite
	pop de
	ld a, [de]
	cp $50
	jr nz, .sub_eb5f
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
	jr .sub_eb5f
.sub_eb13
	call ClearSprites
	ld a, $15
	call Predef
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb47
	ld de, wdf17
	ld b, $00
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	call FarCall_hl
	call GBFadeOutToWhite
	ld de, wdf17
	ld a, [de]
	cp $50
	jr nz, .sub_eb47
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_eb47
	ld hl, Textec0e
	bit 0, a
	jr nz, .sub_eb51
	ld hl, Textec27
.sub_eb51
	call PrintText
	jr .sub_eb5f
.sub_eb56
	ld hl, Textebf5
.sub_eb59
	call PrintText
	call ClearSprites
.sub_eb5f
	ld a, [wce03]
	and a
	ret nz
	ld hl, wItems
	inc a
	ld [wItemQuantity], a
	jp TossItem

Texteb6e:
	text "よけられた！"
	line "こいつは　つかまりそうにないぞ！"
	prompt

Texteb87:
	text "#に"
	line "うまく　あたらなかった！"
	prompt

Texteb98:
	text "だめだ！　#が"
	line "ボールから　でてしまった！"
	prompt

Textebaf:
	text "ああ！"
	line "つかまえたと　おもったのに！"
	prompt

Textebc3:
	text "ざんねん！"
	line "もうすこしで　つかまえられたのに！"
	prompt

Textebdc:
	text "おしい！"
	line "あと　ちょっとの　ところだったのに！"
	prompt

Textebf5:
	text "やったー！"
	line "@"

Textebfd:
	text_from_ram wBattleMonNickname
	text "を　つかまえたぞ！@"

Textec0b:
	sound_caught_mon
	text_waitbutton
	text_end

Textec0e:
	text_from_ram wdf17
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

Textec27:
	text_from_ram wdf17
	text "は　だれかの　<PC>に"
	line "てんそうされた！"
	prompt

Textec3e:
	text_from_ram wBattleMonNickname
	text "の　データが　あたらしく"
	line "#ずかんに　セーブされます！@"

Textec5e:
	sound_slot_machine_start
	text_waitbutton
	text_end

Textec61:
	text "つかまえた　@"

Textec69:
	text_from_ram wStringBuffer1
	text "に"
	line "なまえを　つけますか"
	done

Functionec7a:
	call ClearPalettes
	ld hl, Function3e39f
	ld a, BANK(Function3e39f)
	call FarCall_hl
	call GetMemSGBLayout
	call CloseWindow
	call LoadStandardMenuHeader
	call WaitBGMap
	call SetPalettes
	ret

Functionec95:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, BANK(Function86a0)
	ld hl, Function86a0
	jp FarCall_hl

Functioneca4:
	xor a
	ld [wFieldMoveSucceeded], a
	call .sub_ecba
	ret c
	ldh a, [hROMBank]
	ld hl, Functionecd5
	call QueueScript
	ld a, $01
	ld [wFieldMoveSucceeded], a
	ret
.sub_ecba
	call GetMapEnvironment
	cp $01
	jr z, .sub_eccb
	cp $02
	jr z, .sub_eccb
	cp $04
	jr z, .sub_eccb
	jr .sub_ecd3
.sub_eccb
	ld a, [wPlayerState]
	and a
	ret z
	cp $01
	ret z
.sub_ecd3
	scf
	ret

Functionecd5:
	call RefreshScreen
	ld a, [wPlayerState]
	cp $01
	jr z, .sub_ece9
	ld a, $01
	ld [wPlayerState], a
	ld hl, Textf8d7
	jr .sub_ecf0
.sub_ece9
	xor a
	ld [wPlayerState], a
	ld hl, Textf8e6
.sub_ecf0
	call MenuTextBox
	call CloseWindow
	call RedrawPlayerSprite
	call PlayMapMusic
	call Function1fea
	ret

Functioned00:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, $05
	call Functionf0cf
	jr c, .sub_ed32
	ld a, $01
	ld [wcab9], a
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call WaitSFX
	pop de
	ld hl, Function4af93
	ld a, BANK(Function4af93)
	call FarCall_hl
	ld a, [wce3a]
	and a
	jr z, .sub_ed2f
	jp Functionf7a2
.sub_ed2f
	call Functionf7e2
.sub_ed32
	xor a
	ld [wFieldMoveSucceeded], a
	ret

Functioned37:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	push hl
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	ld [wce37], a
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetMonHeader
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	call GetNick
	call Functionee26
	pop hl
	push hl
	add hl, bc
	ld bc, $000b
	add hl, bc
	ld a, [hl]
	cp $64
	jr nc, Functioneda1
	add $0a
	ld [hl], a
	pop hl
	call Functionedab
	call Functionee26
	ld hl, Tableedf7
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wHPBarTempHP
	ld bc, $000a
	call CopyBytes
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Textedcb
	call PrintText
	jp Functionf7a2

Functioneda1:
	pop hl
	ld hl, Textede7
	call PrintText
	jp ClearPalettes

Functionedab:
	push hl
	ld bc, $0024
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, $000a
	add hl, bc
	ld b, $01
	ld a, $18
	jp Predef

Functionedbe:
	xor a
	ld [wFieldMoveSucceeded], a
	call ClearPalettes
	call z, GetMemSGBLayout
	jp ReloadFontAndTileset

Textedcb:
	text_from_ram wStringBuffer1
	text "の　@"

Textedd2:
	text_from_ram wStringBuffer2
	text "の"
	line "きそ　ポイントが　あがった！"
	prompt



Textede7:
	text "つかっても　こうかが　ないよ"
	prompt

Tableedf7:
	dw Textee01
	dw Textee07
	dw Textee0f
	dw Textee17
	dw Textee1c

Textee01:
	db "たいりょく@"

Textee07:
	db "こうげきりょく@"

Textee0f:
	db "ぼうぎょりょく@"

Textee17:
	db "すばやさ@"

Textee1c:
	db "とくしゅのうりょく@"

Functionee26:
	ld a, [wCurItem]
	ld hl, Dataee38
.sub_ee2c
	cp [hl]
	inc hl
	jr z, .sub_ee33
	inc hl
	jr .sub_ee2c
.sub_ee33
	ld a, [hl]
	ld c, a
	ld b, $00
	ret

Dataee38:
	db $1a, $00
	db $1b, $02
	db $1c, $04
	db $1d, $06
	db $1f, $08

Functionee42:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	ld [wce37], a
	push hl
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetMonHeader
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl
	push hl
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	cp $64
	jp nc, Functioneda1
	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	ld hl, Function50cd1
	ld a, BANK(Function50cd1)
	call FarCall_hl
	pop de
	pop hl
	push hl
	ld bc, $0008
	add hl, bc
	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hQuotient+1]
	ld [hli], a
	ldh a, [hQuotient+2]
	ld [hl], a
	pop hl
	push hl
	ld bc, $0024
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call Functionedab
	pop hl
	ld bc, $0025
	add hl, bc
	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	dec hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a
	ld a, $f8
	ld [wcdb9], a
	ld hl, Function5087e
	ld a, BANK(Function5087e)
	call FarCall_hl
	xor a
	ld [wMonType], a
	ld a, $31
	call Predef
	ld d, $01
	ld hl, Function50628
	ld a, BANK(Function50628)
	call FarCall_hl
	call TextboxWaitPressAorB_BlinkCursor
	xor a
	ld [wMonType], a
	ld a, [wMonDexIndex]
	ld [wce37], a
	ld a, $29
	call Predef
	xor a
	ld [wcab9], a
	ld hl, Function4af93
	ld a, BANK(Function4af93)
	call FarCall_hl
	jp Functionf7a2

Functionef02:
	ld a, [wPartyCount]
	and a
	jp z, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionf100
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a

Functionef17:
	call .sub_ef61
	ld a, $20
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jp z, Functionf0fb
	xor a
	ld [hl], a
	ld a, b
	ld [wcdb9], a
	call Functionf113
	jr nc, .sub_ef50
	xor a
	ld [wca10], a
	ld hl, wca3f
	res 0, [hl]
	ld hl, wca3b
	res 0, [hl]
	ld a, $24
	call GetPartyParamLocation
	ld de, wca14
	ld bc, $000a
	call CopyBytes
	ld a, $24
	call Predef
.sub_ef50
	call Functionf7a2
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	call Functionf0d8
	jp Functionf104
.sub_ef61
	push hl
	ld a, [wCurItem]
	ld hl, Dataef77
	ld bc, $0003
.sub_ef6b
	cp [hl]
	jr z, .sub_ef71
	add hl, bc
	jr .sub_ef6b
.sub_ef71
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

Dataef77:
	db $09, $f0, $08
	db $0a, $f1, $10
	db $0b, $f2, $20
	db $0c, $f3, $07
	db $0d, $f4, $40
	db $26, $f6, $ff
	db $ff, $00, $00

Functionef8c:
	ld a, [wPartyCount]
	and a
	jp z, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp nz, Functionf0fb
	ld a, [wBattleMode]
	and a
	jr z, .sub_efc9
	ld a, [wWhichPokemon]
	ld c, a
	ld d, $00
	ld hl, wcada
	ld b, $02
	ld a, $0c
	call Predef
	ld a, c
	and a
	jr z, .sub_efc9
	ld a, [wWhichPokemon]
	ld c, a
	ld hl, wca37
	ld b, $01
	ld a, $0c
	call Predef
.sub_efc9
	xor a
	ld [wccc4], a
	ld a, [wCurItem]
	cp $27
	jr z, .sub_efd9
	call Functionf130
	jr .sub_efdc
.sub_efd9
	call Functionf127
.sub_efdc
	call Functionf0b0
	ld a, $f7
	ld [wcdb9], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionefed:
	ret

Functionefee:
	ld a, [wPartyCount]
	and a
	jp z, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp z, Functionf0fb
	call Functionf171
	jr c, .sub_f01a
	ld a, $20
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jp z, Functionf0fb
	ld a, $26
	ld [wCurItem], a
	jp Functionef17
.sub_f01a
	xor a
	ld [wccc4], a
	call Functionf130
	ld a, $20
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call Functionf113
	jr nc, .sub_f049
	ld hl, wca3f
	res 0, [hl]
	ld hl, wca3b
	res 0, [hl]
	xor a
	ld [wca10], a
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wca12], a
	ld a, [hld]
	ld [wca13], a
.sub_f049
	call Functionf0b0
	ld a, $f5
	ld [wcdb9], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionf05a:
	ret

Functionf05b:
	ld a, [wPartyCount]
	and a
	jp z, Functionf7dd
	ld a, $01
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp z, Functionf0fb
	call Functionf171
	jp nc, Functionf0fb
	xor a
	ld [wccc4], a
	ld a, [wCurItem]
	cp $0f
	jr nz, .sub_f086
	call Functionf130
	jr .sub_f08c
.sub_f086
	call Functionf1e9
	call Functionf13f
.sub_f08c
	call Functionf113
	jr nc, .sub_f09e
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wca12], a
	ld a, [hld]
	ld [wca13], a
.sub_f09e
	call Functionf0b0
	ld a, $f5
	ld [wcdb9], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionf0af:
	ret

Functionf0b0:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wWhichPokemon]
	coord hl, 11, 0
	ld bc, $0028
	call AddNTimes
	ld a, $02
	ld [wHPBarType], a
	ld a, $17
	call Predef
	ret

Functionf0cf:
	ld [wcdb9], a
	ld a, $36
	call Predef
	ret

Functionf0d8:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, VBlank.return
	ld a, $7f
	call ByteFill
	ld hl, Function5087e
	ld a, BANK(Function5087e)
	call FarCall_hl
	ld a, $01
	ldh [hBGMapMode], a
	ld c, $32
	call DelayFrames
	call TextboxWaitPressAorB_BlinkCursor
	ret

Functionf0fb:
	call Functionf7e2
	jr Functionf104

Functionf100:
	xor a
	ld [wFieldMoveSucceeded], a

Functionf104:
	call ClearPalettes
	call z, GetMemSGBLayout
	ld a, [wBattleMode]
	and a
	ret nz
	call ReloadFontAndTileset
	ret

Functionf113:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wWhichPokemon]
	push hl
	ld hl, wcd41
	cp [hl]
	pop hl
	jr nz, .sub_f125
	scf
	ret
.sub_f125
	xor a
	ret

Functionf127:
	call Functionf1c5
	srl d
	rr e
	jr Functionf133

Functionf130:
	call Functionf1c5

Functionf133:
	ld a, $22
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	call Functionf17e
	ret

Functionf13f:
	ld a, $23
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	call Functionf17e
	ld a, $23
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, $25
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .sub_f164
	call Functionf130
.sub_f164
	ret

Functionf165:
	call Functionf1b5
	call Functionf19e
	call Functionf1ac
	ld a, d
	or e
	ret

Functionf171:
	call Functionf1ac
	ld h, d
	ld l, e
	call Functionf1c5
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

Functionf17e:
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBarNewHP+1], a
	ld a, [hl]
	ld [wHPBarNewHP], a
	ret

Functionf18c:
	ld a, d
	ld [wHPBarNewHP+1], a
	ld a, e
	ld [wHPBarNewHP], a
	ret

Functionf195:
	ld a, [wHPBarNewHP+1]
	ld d, a
	ld a, [wHPBarNewHP]
	ld e, a
	ret

Functionf19e:
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wReplacementBlock], a
	ld a, [hl]
	ld [wHPBarOldHP], a
	ret

Functionf1ac:
	ld a, [wReplacementBlock]
	ld d, a
	ld a, [wHPBarOldHP]
	ld e, a
	ret

Functionf1b5:
	push hl
	ld a, $24
	call GetPartyParamLocation
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld a, [hl]
	ld [wFieldMoveScriptID], a
	pop hl
	ret

Functionf1c5:
	ld a, [wMapBlocksAddress]
	ld d, a
	ld a, [wFieldMoveScriptID]
	ld e, a
	ret

Functionf1ce:
	ld a, $24
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hQuotient], a
	ld a, $05
	ldh [hMultiplier], a
	ld b, $02
	call Divide
	ldh a, [hQuotient+1]
	ld d, a
	ldh a, [hQuotient+2]
	ld e, a
	ret

Functionf1e9:
	push hl
	ld a, [wCurItem]
	ld hl, Dataf203
	ld d, a
.sub_f1f1
	ld a, [hli]
	cp $ff
	jr z, .sub_f1fd
	cp d
	jr z, .sub_f1fe
	inc hl
	inc hl
	jr .sub_f1f1
.sub_f1fd
	scf
.sub_f1fe
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

Dataf203:
	db $2e, $32, $00
	db $2f, $3c, $00
	db $30, $50, $00
	db $10, $c8, $00
	db $11, $32, $00
	db $12, $14, $00
	db $ff, $00, $00

Functionf218:
	ld a, [wcd3c]
	dec a
	ld b, a
.sub_f21d
	push bc
	ld a, $01
	ld [wcdb9], a
	ld a, $37
	call Predef
	pop bc
	jr c, .sub_f28c
	ld a, [wcd3c]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .sub_f21d
	push bc
	ld a, c
	ld [wWhichPokemon], a
	call Functionf165
	jr z, .sub_f292
	call Functionf171
	jp nc, .sub_f29c
	pop bc
	push bc
	ld a, b
	ld [wWhichPokemon], a
	call Functionf165
	call Functionf1ce
	push de
	ld a, $23
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld e, a
	ld a, [hl]
	sbc d
	ld [hl], a
	ld d, a
	call Functionf18c
	call Functionf0b0
	pop de
	pop bc
	push bc
	push de
	ld a, c
	ld [wWhichPokemon], a
	call Functionf165
	pop de
	call Functionf13f
	call Functionf0b0
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	ld a, $f5
	ld [wcdb9], a
	ld a, $38
	call Predef
	ld c, $c8
	call Function3872
	pop bc
.sub_f28c
	ld a, b
	inc a
	ld [wcd3c], a
	ret
.sub_f292
	ld hl, Textf2a6
	call Function385a
	pop bc
	jp .sub_f21d
.sub_f29c
	ld hl, Textf2a6
	call Function385a
	pop bc
	jp .sub_f21d

Textf2a6:
	text "その#には　"
	line "つかえません"
	done

Functionf2b5:
	xor a
	ld [wFieldMoveSucceeded], a
	ld hl, DigFunction
	ld a, $03
	call FarCall_hl
	ret

Functionf2c2:
	ld b, $c8
	jp Functionf2ce

Functionf2c7:
	ld b, $fa
	jp Functionf2ce

Functionf2cc:
	ld b, $64

Functionf2ce:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, b
	ld [wce2d], a
	jp Functionf793

Functionf2dc:
	ld a, [wBattleMode]
	and a
	jp z, Functionf7dd
	ld hl, wca3e
	set 0, [hl]
	jp Functionf793

Functionf2eb:
	ld a, [wBattleMode]
	dec a
	jp nz, Functionf7dd
	ld a, $01
	ld [wce06], a
	jp Functionf793

Functionf2fa:
	ld a, [wBattleMode]
	and a
	jp z, Functionf7dd
	ld hl, wca3e
	set 1, [hl]
	jp Functionf793

Functionf309:
	ld a, [wBattleMode]
	and a
	jp z, Functionf7dd
	ld hl, wca3e
	set 2, [hl]
	jp Functionf793

Functionf318:
	ld a, [wBattleMode]
	and a
	jr nz, .sub_f327
	call Functionf7dd
	ld a, $02
	ld [wFieldMoveSucceeded], a
	ret
.sub_f327
	ld hl, wc9ef
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, [wCurItem]
	sub $37
	ld [hl], a
	call Functionf793
	ld a, $ae
	ld [wc9ef], a
	call ReloadTilesFromBuffer
	call WaitBGMap
	xor a
	ldh [hBattleTurn], a
	ld a, BANK(Function3e5bf)
	ld hl, Function3e5bf
	call FarCall_hl
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ret

Functionf354:
	ret

Functionf355:
	xor a
	ld [wMovementBufferCount], a
	ld b, $f8
	ld hl, wPartyMon1Status
	call Functionf397
	ld a, [wBattleMode]
	cp $01
	jr z, .sub_f36e
	ld hl, wd93b
	call Functionf397
.sub_f36e
	ld hl, wca10
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wcde7
	ld a, [hl]
	and b
	ld [hl], a
	ld a, [wMovementBufferCount]
	and a
	ld hl, Textf3bd
	jp z, PrintText
	ld hl, Textf3ec
	call PrintText
	ld a, [wccc4]
	and $80
	jr nz, .sub_f391
.sub_f391
	ld hl, Textf3da
	jp PrintText

Functionf397:
	ld de, $0030
	ld c, $06
.sub_f39c
	ld a, [hl]
	push af
	and $07
	jr z, .sub_f3a7
	ld a, $01
	ld [wMovementBufferCount], a
.sub_f3a7
	pop af
	and b
	ld [hl], a
	add hl, de
	dec c
	jr nz, .sub_f39c
	ret

Dataf3af:
	db $3e, $09
	db $3d, $0a
	db $3f, $0a
	db $3e, $0b
	db $ff

Dataf3b8:
	db $0a, $1b
	db $0a, $19
	db $ff

Textf3bd:
	text "#のふえを　ふいた！"
	para "うーん！"
	line "すばらしい　ねいろだ！"
	prompt

Textf3da:
	text "すべての　#が"
	line "めを　さました！"
	prompt

Textf3ec:
	text "<PLAYER>は"
	line "#のふえを　ふいてみた！@"

Functionf3fd:
	ld b, $08
	ld a, [wBattleMode]
	and a
	jr nz, .sub_f410
	push de
	ld de, SFX_POKEFLUTE
	call WaitPlaySFX
	call WaitSFX
	pop de
.sub_f410
	jp Function32d0

Functionf413:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld hl, Textf424
	call MenuTextBox
	call CloseWindow
	ret

Textf424:
	text "あなたの　コイン"
	line "@"

Textf42f:
	deciram wCoins, 2, 4
	text "まい"
	prompt

Functionf437:
	call Functionf49f
	jp c, Functionf7dd
	ld bc, $0585
	ld a, $01
	jr Functionf478

Functionf444:
	call Functionf49f
	jp c, Functionf7dd
.sub_f44a
	call Random
	srl a
	jr c, .sub_f463
	and $03
	cp $02
	jr nc, .sub_f44a
	ld hl, Dataf46a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.sub_f463
	ld a, $00
	rla
	xor $01
	jr Functionf478

Dataf46a:
	db $0a, $9d, $0a, $47

Functionf46e:
	call Functionf49f
	jp c, Functionf7dd
	call Functionf9d9
	ld a, e

Functionf478:
	ld [wMovementBufferCount], a
	dec a
	jr nz, .sub_f48b
	ld a, $01
	ld [wca3a], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, c
	ld [wce01], a
.sub_f48b
	ld hl, wPlayerState
	ld a, [hl]
	push af
	ld [hl], $00
	push hl
	ld a, $23
	ld hl, PutItemInPocket.loop
	call FarCall_hl
	pop hl
	pop af
	ld [hl], a
	ret

Functionf49f:
	ld a, [wBattleMode]
	and a
	jr z, .sub_f4a7
	scf
	ret
.sub_f4a7
	call Functionf9d7
	ret c
	ld a, [wPlayerState]
	cp $02
	jr z, .sub_f4c8
	call Functionfab4
	ld hl, Textf8c6
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld c, $50
	call DelayFrames
	and a
	ret
.sub_f4c8
	scf
	ret

Functionf4ca:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd

Functionf4d1:
	ld a, [wCurItem]
	ld [wMovementBufferCount], a
.sub_f4d7
	ld a, $01
	call Functionf0cf
	jr nc, .sub_f4e1
	jp Functionf5f3
.sub_f4e1
	ld a, [wMovementBufferCount]
	cp $52
	jp nc, Functionf5bd
	ld a, $02
	ld [wcac0], a
	ld hl, Textf5ff
	ld a, [wMovementBufferCount]
	cp $50
	jr c, .sub_f4fb
	ld hl, Textf610
.sub_f4fb
	call PrintText
	ld hl, Function3daa7
	ld a, BANK(Function3daa7)
	call FarCall_hl
	jr nz, .sub_f4d7
	ld hl, wPartyMon1Moves
	ld bc, $0030
	call Functionf9c9
	push hl
	ld a, [hl]
	ld [wce37], a
	call Unreferenced_GetMoveName
	call CopyStringToStringBuffer2
	pop hl
	ld a, [wMovementBufferCount]
	cp $50
	jr nc, Functionf580
	ld bc, $0015
	add hl, bc
	ld a, [hl]
	cp $c0
	jr c, .sub_f535
	ld hl, Textf61f
	call PrintText
	jr .sub_f4e1
.sub_f535
	ld a, [hl]
	add $40
	ld [hl], a
	ld a, $01
	ld [wce37], a
	call ApplyPPUp
	ld hl, Textf639
	call PrintText

Functionf547:
	call ClearPalettes
	call GetMemSGBLayout
	jp Functionf7a2

Functionf550:
	ld a, [wBattleMode]
	and a
	jr z, .sub_f572
	ld a, [wWhichPokemon]
	ld b, a
	ld a, [wcd41]
	cp b
	jr nz, .sub_f572
	ld hl, wPartyMon1PP
	ld bc, $0030
	call AddNTimes
	ld de, wca0a
	ld bc, $0004
	call CopyBytes
.sub_f572
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Textf64c
	call PrintText
	jr Functionf547

Functionf580:
	call Functionf588
	jr nz, Functionf550
	jp Functionf5f0

Functionf588:
	xor a
	ld [wMonType], a
	call Functionf960
	ld hl, wPartyMon1Moves
	ld bc, $0030
	call Functionf9c9
	ld bc, $0015
	add hl, bc
	ld a, [wce37]
	ld b, a
	ld a, [wMovementBufferCount]
	cp $51
	jr z, .sub_f5b8
	ld a, [hl]
	and $3f
	cp b
	ret z
	add $0a
	cp b
	jr nc, .sub_f5b2
	ld b, a
.sub_f5b2
	ld a, [hl]
	and $c0
	add b
	ld [hl], a
	ret
.sub_f5b8
	ld a, [hl]
	cp b
	ret z
	jr .sub_f5b2

Functionf5bd:
	ld hl, wMovementBufferCount
	dec [hl]
	dec [hl]
	xor a
	ld hl, w2DMenuDataEnd
	ld [hli], a
	ld [hl], a
	ld b, $04
.sub_f5ca
	push bc
	ld hl, wPartyMon1Moves
	ld bc, $0030
	call Functionf9c9
	ld a, [hl]
	and a
	jr z, .sub_f5e1
	call Functionf588
	jr z, .sub_f5e1
	ld hl, wMenuCursorX
	inc [hl]
.sub_f5e1
	ld hl, w2DMenuDataEnd
	inc [hl]
	pop bc
	dec b
	jr nz, .sub_f5ca
	ld a, [wMenuCursorX]
	and a
	jp nz, Functionf550

Functionf5f0:
	call Functionf7e2

Functionf5f3:
	call ClearPalettes
	call GetMemSGBLayout
	pop af
	xor a
	ld [wFieldMoveSucceeded], a
	ret

Textf5ff:
	text "どのわざの"
	line "ポイントをふやす？"
	done

Textf610:
	text "どのわざを"
	line "かいふくする？"
	done

Textf61f:
	text_from_ram wStringBuffer2
	text "は　これいじょう"
	line "ふやすことが　できません"
	prompt

Textf639:
	text_from_ram wStringBuffer2
	text "の"
	line "わざポイントが　ふえた！"
	prompt

Textf64c:
	text "わざポイントが"
	line "かいふくした！"
	prompt

Functionf65d:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld hl, TryTeleport
	ld a, $0b
	jp FarCall_hl

Functionf66c:
	jp Functionf7dd

Functionf66f:
	jp Functionf7dd

Functionf672:
	jp Functionf7dd

Functionf675:
	jp Functionfaba

Functionf678:
	ld a, [wBattleMode]
	and a
	jp nz, Functionf7dd
	ld a, [wCurItem]
	sub $c9
	push af
	jr nc, .sub_f689
	add $37
.sub_f689
	inc a
	ld [wce37], a
	ld a, $1b
	call Predef
	ld a, [wce37]
	ld [wce32], a
	call Unreferenced_GetMoveName
	call CopyStringToStringBuffer2
	pop af
	ld hl, Textf723
	jr nc, .sub_f6a7
	ld hl, Textf72e
.sub_f6a7
	call PrintText
	ld hl, Textf73d
	call PrintText
	call YesNoBox
	jr nc, .sub_f6bb
	ld a, $02
	ld [wFieldMoveSucceeded], a
	ret
.sub_f6bb
	ld hl, wHPBarTempHP
	ld de, wcd11
	ld bc, $0008
	call CopyBytes
	ld a, $03
	call Functionf0cf
	push af
	ld hl, wcd11
	ld de, wHPBarTempHP
	ld bc, $0008
	call CopyBytes
	pop af
	jr nc, .sub_f6ea
	pop af
	pop af
	call ClearBGPalettes
	call ClearSprites
	call GetMemSGBLayout
	jp ReloadTilesFromBuffer
.sub_f6ea
	ld a, $1a
	call Predef
	push bc
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc
	ld a, c
	and a
	jr nz, .sub_f70c
	ld de, SFX_WRONG
	call WaitPlaySFX
	ld hl, Textf768
	call PrintText
	jr .sub_f6bb
.sub_f70c
	call Functionfdab
	jr c, .sub_f6bb
	ld a, $00
	call Predef
	ld a, b
	and a
	ret z
	ld a, [wCurItem]
	call IsHM
	ret c
	jp Functionf7a2

Textf723:
	text "<TM>を　きどうした！"
	prompt

Textf72e:
	text "ひでんマシンを　きどうした！"

Textf73d:
	text "なかには　@"

Textf744:
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"
	para "@"

Textf755:
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

Textf768:
	text_from_ram wStringBuffer1
	text "と　@"

Textf76f:
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"
	para "@"

Textf784:
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt

Functionf793:
	ld hl, Textf8c6
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call TextboxWaitPressAorB_BlinkCursor

Functionf7a2:
	ld hl, wItems
	ld a, $01
	ld [wItemQuantity], a
	call TossItem
	ret

Functionf7ae:
	call Functionec7a
	ld de, $0100
	ld a, e
	ld [wccc0], a
	ld a, d
	ld [wccc1], a
	xor a
	ld [wca5c], a
	ldh [hBattleTurn], a
	ld [wcccd], a
	ld a, $51
	call Predef
	ld hl, Textf850
	call PrintText
	ld hl, Textf860
	call PrintText
	jr Functionf7a2

Functionf7d8:
	ld hl, Textf8a5
	jr Functionf7f4

Functionf7dd:
	ld hl, Textf7fb
	jr Functionf7f4

Functionf7e2:
	ld hl, Textf841
	jr Functionf7f4

Functionf7e7:
	ld hl, Textf822
	jr Functionf7f4

Functionf7ec:
	ld hl, Textf874
	jr Functionf7f4

Functionf7f1:
	ld hl, Textf88d

Functionf7f4:
	xor a
	ld [wFieldMoveSucceeded], a
	jp PrintText

Textf7fb:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！"
	prompt

Textf822:
	text "たいせつな　あずかりものです！"

Textf832:
	db ""
	next "つかうことは　できません！"
	prompt

Textf841:
	text "つかっても　こうかがないよ"
	prompt

Textf850:
	text "<TRAINER>に　ボールを　はじかれた！"
	prompt

Textf860:
	text "ひとの　ものを　とったら　どろぼう！"
	prompt

Textf874:
	text "ここでは　じてんしゃに"
	next "のることは　できません"
	prompt

Textf88d:
	text "ここでは@"

Textf893:
	text_from_ram wStringBuffer1
	text "に"
	line "のることは　できません"
	prompt

Textf8a5:
	text "ボックスに　あずけている　#が"
	line "いっぱいなので　つかえません！"
	prompt

Textf8c6:
	text "<PLAYER>は@"

Textf8ca:
	text_low
	text_from_ram wStringBuffer2
	text "を　つかった！"
	done

Textf8d7:
	text "<PLAYER>は@"

Textf8db:
	text_low
	text_from_ram wStringBuffer2
	text "に　のった"
	prompt

Textf8e6:
	text "<PLAYER>は@"

Textf8ea:
	text_low
	text_from_ram wStringBuffer2
	text "から　おりた"
	prompt

SECTION "engine/dumps/bank03.asm@Functionf960", ROMX

Functionf960:
	ld a, [wMonType]
	and a
	ld hl, wPartyMon1Moves
	ld bc, $0030
	jr z, .sub_f989
	ld hl, wd91d
	dec a
	jr z, .sub_f989
	ld hl, wdaa5
	ld bc, $0020
	dec a
	jr z, .sub_f989
	ld hl, wd884
	dec a
	jr z, .sub_f984
	ld hl, wca04
.sub_f984
	call Functionf9cf
	jr .sub_f98c
.sub_f989
	call Functionf9c9
.sub_f98c
	ld a, [hl]
	dec a
	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl
	push bc
	ld bc, $0015
	ld a, [wMonType]
	cp $04
	jr nz, .sub_f9b1
	ld bc, $0006
.sub_f9b1
	add hl, bc
	ld a, [hl]
	and $c0
	pop bc
	or b
	ld hl, wcd27
	ld [hl], a
	xor a
	ld [wce37], a
	call ComputeMaxPP
	ld a, [hl]
	and $3f
	ld [wce37], a
	ret

Functionf9c9:
	ld a, [wWhichPokemon]
	call AddNTimes

Functionf9cf:
	ld a, [w2DMenuDataEnd]
	ld c, a
	ld b, $00
	add hl, bc
	ret

Functionf9d7:
	scf
	ret

Functionf9d9:
	ld a, [wMapId]
	ld de, $0003
	ld hl, Datafa08
	call FindItemInTable
	jr c, .sub_f9ea
	ld e, $02
	ret
.sub_f9ea
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, [hl]
	inc hl
	ld e, $00
.sub_f9f2
	call Random
	srl a
	ret c
	and $03
	cp b
	jr nc, .sub_f9f2
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld e, $01
	ret

Datafa08:
	dbw $00, Datafa6c
	dbw $01, Datafa6c
	dbw $03, Datafa76
	dbw $05, Datafa7d
	dbw $06, Datafa82
	dbw $07, Datafaab
	dbw $08, Datafa99
	dbw $0f, Datafa76
	dbw $11, Datafa7d
	dbw $15, Datafa82
	dbw $16, Datafa7d
	dbw $17, Datafa90
	dbw $18, Datafa90
	dbw $1c, Datafa90
	dbw $1d, Datafa90
	dbw $1e, Datafa99
	dbw $1f, Datafa99
	dbw $20, Datafa99
	dbw $21, Datafa71
	dbw $22, Datafaa2
	dbw $23, Datafa76
	dbw $24, Datafa76
	dbw $41, Datafa76
	dbw $5e, Datafa7d
	dbw $a1, Datafa99
	dbw $a2, Datafa99
	dbw $d9, Datafa87
	dbw $da, Datafa87
	dbw $db, Datafa87
	dbw $dc, Datafa87
	dbw $e2, Datafaa2
	dbw $e3, Datafaa2
	dbw $e4, Datafaa2
	db $ff

Datafa6c:
	db $02, $0f, $18, $0f, $47

Datafa71:
	db $02, $0f, $9d, $0f, $47

Datafa76:
	db $03, $0f, $2f, $0f, $9d, $0f, $4e

Datafa7d:
	db $02, $0f, $4e, $0f, $17

Datafa82:
	db $02, $17, $6e, $0f, $25

Datafa87:
	db $04, $0f, $58, $0f, $4e, $0f, $2f, $0f, $25

Datafa90:
	db $04, $05, $18, $0f, $4e, $0f, $9d, $0f, $85

Datafa99:
	db $04, $0f, $1b, $0f, $5c, $0f, $17, $0f, $9d

Datafaa2:
	db $04, $17, $08, $17, $9e, $17, $8a, $17, $5d

Datafaab:
	db $04, $17, $9e, $0f, $4e, $0f, $9d, $0f, $85

Functionfab4:
	call LoadMapPart
	jp UpdateSprites

Functionfaba:
	ld a, [wd8a2]
	cp $02
	jr c, .sub_fade
	cp $03
	jp z, Functionfd03
	cp $04
	jr z, .sub_fade
	call Functionfbf0
	ld a, [wce37]
	and a
	jr z, .sub_fad8
	ld a, $03
	ld [wd8a2], a
.sub_fad8
	ld hl, Textfcea
	call PrintText
.sub_fade
	ld hl, Textfc19
	call PrintText
	ld hl, Datafc30
	call LoadMenuHeader
	call VerticalMenu
	push af
	call CloseWindow
	pop af
	jp c, Functionfbde
	ld a, [w2DMenuDataEnd]
	cp $03
	jp z, Functionfbde
	cp $01
	jr z, .sub_fb4c
	ld a, [wd8a2]
	and a
	jr z, .sub_fb19
	cp $02
	jr nz, .sub_fb22
	ld hl, Textfc64
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	jr .sub_fb22
.sub_fb19
	ld hl, Textfc75
	call PrintText
	jp Functionfbde
.sub_fb22
	ld a, $01
	ld [wcd7c], a
	ld a, $14
	call Predef
	jp c, Functionfbea
	ld a, [wd8a2]
	sub $01
	jr z, .sub_fb38
	ld a, $01
.sub_fb38
	ld [wd8a2], a
	ld a, [wd8fd]
	srl a
	ld [wd8fd], a
	ld hl, Textfc89
	call PrintText
	jp Functionfbde
.sub_fb4c
	ld a, [wd8a2]
	cp $02
	jp nc, .sub_fbd6
	add $06
	call Functionf0cf
	jp c, Functionfbde
	ld a, [wMonDexIndex]
	ld [wCurSpecies], a
	call GetMonHeader
	xor a
	ld [wMonType], a
	ld a, $3a
	call Predef
	ld a, [wd8fd]
	rla
	ld [wd8fd], a
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, $01
	ld [wcd7c], a
	ld a, $13
	call Predef
	xor a
	ld [wcd7c], a
	ld hl, Functiondecd
	ld a, BANK(Functiondecd)
	call FarCall_hl
	ld a, [wMonDexIndex]
	call PlayCry
	ld hl, Textfc48
	call PrintText
	ld a, [wd8a2]
	inc a
	ld [wd8a2], a
	cp $02
	jr nz, Functionfbde
	ld hl, Textfcac
	call PrintText
	call Functionfbf0
	ld a, [wce37]
	cp $50
	ld hl, Textfcbb
	call z, PrintText
	ld a, [wce37]
	cp $14
	ld hl, Textfcca
	call z, PrintText
	ld a, [wce37]
	and a
	ld hl, Textfcda
	call z, PrintText
	jr Functionfbde
.sub_fbd6
	ld hl, Textfc4f
	call PrintText
	jr Functionfbde

Functionfbde:
	call ClearBGPalettes
	call Function360b
	call GetMemSGBLayout
	jp ReloadFontAndTileset

Functionfbea:
	ld hl, Textfc91
	jp PrintText

Functionfbf0:
	ld a, [wd8fd]
	ld b, a
	srl b
	xor b
	and $01
	jr z, .sub_fc15
	ld a, [wd8b7]
	ld b, a
	ld a, [wd8e3]
	cp b
	jr nz, .sub_fc13
	ld a, [wd8b8]
	ld b, a
	ld a, [wd8e4]
	cp b
	jr nz, .sub_fc13
	ld a, $14
	jr .sub_fc15
.sub_fc13
	ld a, $50
.sub_fc15
	ld [wce37], a
	ret

Textfc19:
	text "わたしは　こずくりやさん"
	line "さて　どうする？"
	done

Datafc30:
	db $40, $04, $0d, $0b, $13
	dw Datafc38
	db $01

Datafc38:
	db $80, $03
	db "あずける@"

Textfc3f:
	db "ひきとる@"

Textfc44:
	db "やめる@"

Textfc48:
	text "あずけた！"
	prompt

Textfc4f:
	text "すでに　２ひきの#を"
	line "あずかっています"
	prompt

Textfc64:
	text "こずくりを　ちゅうししますか？"
	done

Textfc75:
	text "#は　いっぴきも"
	line "あずかってませんが"
	prompt

Textfc89:
	text "ひきとった！"
	prompt

Textfc91:
	text "てもちも　マサキの　<PC>も"
	line "#で　いっぱいのようです"
	prompt

Textfcac:
	text "それでは　こづくりします！"
	prompt

Textfcbb:
	text "あいしょうが　いいようです"
	prompt

Textfcca:
	text "あいしょうが　わるいようです"
	prompt

Textfcda:
	text "せいべつが　あわないようです"
	prompt

Textfcea:
	text "ざんねんながら　まだ　うまれて"
	line "こないようです"
	prompt

Functionfd03:
	ld hl, Textfd2e
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	ld a, $04
	ld [wd8a2], a
	ld a, [wd8b1]
	ld [wMonDexIndex], a
	call PlayCry
	xor a
	ld [wMonType], a
	ld a, $05
	ld [wCurPartyLevel], a
	ld a, $16
	call Predef
	jp Functionfbde

Textfd2e:
	text "タマゴが　うまれました！"
	line "ひきとりますか？"
	done

Functionfd45:
	ret

Functionfd46:
	ld a, [wMapBlocksAddress]
	inc a
	ld [wMapBlocksAddress], a
	cp $04
	jr z, .sub_fd71
	ld a, [wce35]
	and a
	ld c, $00
	ret nz
	ld hl, Datafd7b
	ld a, [wFieldMoveScriptID]
	ld b, a
.sub_fd5f
	ld a, [hli]
	cp b
	jr nc, .sub_fd66
	inc hl
	jr .sub_fd5f
.sub_fd66
	ld b, [hl]
	call Random
	cp b
	ld c, $00
	ret c
	ld c, $02
	ret
.sub_fd71
	ld a, [wce35]
	and a
	ld c, $01
	ret nz
	ld c, $02
	ret

Datafd7b:
	db $01, $3f
	db $02, $4b
	db $03, $54
	db $04, $5a
	db $05, $5f
	db $07, $67
	db $0a, $71
	db $0f, $7e
	db $14, $86
	db $1e, $95
	db $28, $a0
	db $32, $a9
	db $3c, $b1
	db $50, $bf
	db $64, $c9
	db $78, $d3
	db $8c, $dc
	db $a0, $e3
	db $b4, $ea
	db $c8, $f0
	db $dc, $f6
	db $f0, $fb
	db $fe, $fd
	db $ff, $ff

Functionfdab:
	ld a, $02
	call GetPartyParamLocation
	ld a, [wce32]
	ld b, a
	ld c, $04
.sub_fdb6
	ld a, [hli]
	cp b
	jr z, .sub_fdbf
	dec c
	jr nz, .sub_fdb6
	and a
	ret
.sub_fdbf
	ld hl, Textfdc7
	call PrintText
	scf
	ret

Textfdc7:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"

Textfdd2:
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Textfde0:
	db "います"
	prompt

; NOTE: This is missing the preceeding "text_from_ram"  byte
Textfde4:
	dw wStringBuffer2
	text "を　おぼえています"
	prompt

Datafdf1:
	db $28, $3c

Functionfdf3:
	ld a, [wce32]
	ld b, a
	ld c, $04
.sub_fdf9
	ld a, [hli]
	cp b
	jr z, .sub_fe02
	dec c
	jr nz, .sub_fdf9
	and a
	ret
.sub_fe02
	ld hl, Textfe0a
	call PrintText
	scf
	ret

Textfe0a:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"

Textfe15:
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Datafe23:
	db $e0, $22, $47, $24, $80, $a3, $01, $50
	db $02, $85, $b0, $09, $35, $51, $2c, $08
	db $24, $25, $0b, $84, $84, $00, $4e, $3b
	db $4b, $02, $60, $2a, $26, $21, $01, $40
	db $10, $1f, $31, $44, $80, $08, $02, $3c
	db $41, $00, $68, $49, $57, $41, $94, $00
	db $34, $36, $9c, $e4, $01, $0c, $60, $01
	db $81, $23, $a2, $26, $43, $05, $81, $5f
	db $16, $a2, $80, $34, $0c, $82, $63, $91
	db $44, $52, $02, $ce, $00, $10, $44, $01
	db $96, $0e, $ac, $10, $23, $84, $28, $00
	db $22, $45, $22, $55, $00, $ef, $ff, $77
	db $5b, $fe, $87, $db, $df, $b5, $bf, $d7
	db $1f, $d9, $fc, $e9, $fd, $df, $79, $96
	db $7d, $af, $d7, $5e, $17, $37, $e7, $ef
	db $3e, $ff, $f9, $d4, $7d, $bf, $fb, $df
	db $bb, $fe, $db, $53, $fb, $cc, $d3, $fe
	db $92, $7f, $bb, $bc, $d7, $3b, $dd, $6f
	db $7b, $2f, $b7, $ff, $b9, $d0, $b7, $e5
	db $7b, $e0, $c7, $bf, $dd, $df, $6d, $bb
	db $f6, $f7, $73, $f9, $ff, $bc, $bb, $f7
	db $fd, $bd, $db, $e7, $be, $7b, $35, $5b
	db $f3, $98, $df, $f4, $2f, $fb, $ff, $6b
	db $fe, $ef, $6b, $ec, $1f, $7a, $3e, $ea
	db $9b, $dd, $df, $ed, $ff, $fe, $bf, $26
	db $7d, $9e, $ef, $be, $ff, $77, $fb, $ff
	db $ff, $5e, $f2, $bc, $fd, $7a, $aa, $fa
	db $af, $9d, $ed, $f1, $fd, $10, $10, $2d
	db $d1, $00, $21, $14, $d3, $1b, $27, $22
	db $85, $45, $5a, $43, $0c, $b1, $74, $61
	db $48, $40, $2f, $8c, $84, $08, $c2, $90
	db $f7, $44, $45, $80, $90, $12, $c5, $93
	db $1c, $11, $6e, $c8, $26, $25, $c1, $25
	db $00, $1e, $55, $02, $54, $04, $0f, $10
	db $20, $d7, $a2, $3c, $04, $3b, $02, $01
	db $22, $00, $c0, $00, $13, $d2, $05, $02
	db $48, $2a, $89, $40, $1f, $3e, $44, $12
	db $40, $16, $d8, $91, $10, $01, $54, $87
	db $1f, $99, $40, $d0, $79, $f8, $25, $4c
	db $d0, $a0, $02, $13, $1c, $02, $03, $11
	db $a0, $19, $06, $0e, $70, $97, $44, $0e
	db $11, $24, $0f, $80, $60, $06, $09, $01
	db $c5, $e1, $30, $13, $15, $14, $59, $02
	db $4c, $a9, $11, $08, $04, $eb, $df, $9d
	db $55, $ff, $b7, $57, $fb, $78, $7e, $7e
	db $c7, $3a, $e1, $ff, $5f, $7d, $5f, $fd
	db $5f, $f8, $6d, $2f, $bd, $75, $6f, $3f
	db $ff, $9f, $fc, $b5, $f6, $c5, $14, $fa
	db $d9, $ff, $9d, $fb, $7f, $f3, $ff, $6b
	db $fb, $9f, $eb, $5f, $df, $de, $ed, $bf
	db $7f, $59, $26, $df, $ee, $b3, $5f, $fd
	db $f7, $ff, $ff, $ff, $5b, $f8, $db, $fa
	db $7f, $de, $af, $5f, $df, $9f, $d8, $be
	db $ea, $bf, $fe, $eb, $dd, $eb, $f9, $e5
	db $bd, $f3, $ff, $fe, $ff, $f7, $f7, $d5
	db $f5, $f9, $5f, $bf, $fd, $5e, $df, $de
	db $ff, $bf, $bb, $93, $fc, $ff, $cc, $af
	db $f5, $d7, $7f, $ff, $fe, $b5, $ff, $9f
	db $95, $7a, $6b, $7b, $ff, $6f, $bb, $c7
	db $ef, $34, $ff, $d7, $3d
