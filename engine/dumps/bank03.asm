INCLUDE "constants.asm"

SECTION "engine/dumps/bank03.asm@GetFlyPointMapLocation", ROMX

GetFlyPointMapLocation:
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, SpawnPoints
	add hl, de
	ld b, [hl] ; SpawnPoints + (wFlyDestination * 4)
	inc hl
	ld c, [hl]
	call GetWorldMapLocation
	ld e, a
	ret

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
	ld a, [wItemAttributeValue]
	and a
	jr nz, .sub_d45f
	ld a, [wCurItem]
	ld [wce37], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, ItemsThrowAwayText
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
	ld hl, ItemsDiscardedText
	call MenuTextBox
	call CloseWindow
	and a
	ret
.sub_d45f
	ld hl, ItemsTooImportantText
	call MenuTextBox
	call CloseWindow
.sub_d468
	pop hl
	scf
	ret

ItemsDiscardedText:
	text_from_ram wStringBuffer1
	text "を" ; "Threw away"
	line "すてました！" ; "(item?)!"
	prompt

ItemsThrowAwayText:
	text_from_ram wStringBuffer2
	text "を　すてます" ; "Are you sure you want"
	line "ほんとに　よろしいですか？" ; "to throw (item?) away?"
	prompt

ItemsTooImportantText:
	text "それは　とても　たいせつなモノです" ; "You can't throw away"
	line "すてることは　できません！" ; "something that special!"
	prompt

Functiond4b2:
	push hl
	push bc
	ld a, $01
	ld [wItemAttributeValue], a
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
	ld [wItemAttributeValue], a
.sub_d4e3
	pop bc
	pop hl
	ret

Functiond4e6:
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .sub_d4f8
	bit PLAYERSTEP_STOP_F, a
	jr nz, Functiond519
	bit PLAYERSTEP_CONTINUE_F, a
	jr nz, Functiond543
	ret
.sub_d4f8
	jr Functiond505

Functiond4fa:
	call Functiond51e
	callfar EmptyFunction8261

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
	ld a, [wPlayerStepVectorX]
	ld d, a
	ld a, [wPlayerStepVectorY]
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
	ld bc, wMinorObjects
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
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .sub_d6f7
	bit PLAYERSTEP_STOP_F, a
	jr nz, .sub_d702
	bit PLAYERSTEP_CONTINUE_F, a
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
	ld de, wOTPartyCount
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
	ld a, [wCurPartySpecies]
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
	ld a, [wCurPartySpecies]
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
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wMonHeader]
	ld [de], a
	inc de
	ld a, [wBattleMode]
	and a
	jr z, .sub_d91b
	ld a, [wEnemyMonItem]
	ld [de], a
.sub_d91b
	inc de
	push de
	xor a
	ld [wFieldMoveScriptID], a
	predef FillMoves
	pop de
	inc de
	inc de
	inc de
	inc de
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	ld hl, CalcExpAtLevel
	ld a, BANK(CalcExpAtLevel)
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
	ld a, [wCurPartySpecies]
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
	ld hl, wEndPokedexCaught
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
	call CalcMonStatC
	ldh a, [hDividend+2]
	ld [de], a
	inc de
	ldh a, [hDividend+3]
	ld [de], a
	inc de
	jr .sub_da0a
.sub_d9d3
	ld a, [wEnemyMonDVs]
	ld [de], a
	inc de
	ld a, [wEnemyMonDVs + 1]
	ld [de], a
	inc de
	push hl
	ld hl, wEnemyMonPP
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
	ld a, [wEnemyMonStatus]
	ld [de], a
	inc de
	ld a, [wEnemyMonStatus + 1]
	ld [de], a
	inc de
	ld a, [wEnemyMonHP]
	ld [de], a
	inc de
	ld a, [wEnemyMonHP + 1]
	ld [de], a
	inc de
.sub_da0a
	ld a, [wBattleMode]
	dec a
	jr nz, .sub_da1c
	ld hl, wEnemyMonMaxHP
	ld bc, $000c
	call CopyBytes
	pop hl
	jr .sub_da26
.sub_da1c
	pop hl
	ld bc, $000a
	add hl, bc
	ld b, $00
	call CalcMonStats
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
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld [hl], $ff
	ld hl, wPartyMon1
	ld a, [wPartyCount]
	dec a
	ld bc, $0030
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wTempMon
	call CopyBytes
	ld hl, wPartyMon6StatsEnd
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, $0006
	call CopyBytes
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, $0006
	call CopyBytes
	ld a, [wCurPartySpecies]
	ld [wce37], a
	dec a
	ld c, a
	ld b, $01
	ld hl, wPartyMonNicknamesEnd
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wEndPokedexCaught
	call SmallFarFlagAction
	and a
	ret

Functiondac8:
	ld a, [wPokemonWithdrawDepositParameter]
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
	ld a, [wPokemonWithdrawDepositParameter]
	cp $02
	ld a, [wd882]
	jr z, .sub_db00
	ld a, [wCurPartySpecies]
.sub_db00
	ld [hli], a
	ld [hl], $ff
	ld a, [wPokemonWithdrawDepositParameter]
	dec a
	ld hl, wPartyMon1
	ld bc, $0030
	ld a, [wPartyCount]
	jr nz, .sub_db1b
	ld hl, wBoxMon1
	ld bc, $0020
	ld a, [wBoxListLength]
.sub_db1b
	dec a
	call AddNTimes
.sub_db1f
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .sub_db3b
	cp $02
	ld hl, wd882
	jr z, .sub_db41
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
.sub_db3b
	ld a, [wCurPartyMon]
	call AddNTimes
.sub_db41
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp $03
	ld de, wBufferMonOT
	jr z, .sub_db66
	dec a
	ld hl, wPartyMon6StatsEnd
	ld a, [wPartyCount]
	jr nz, .sub_db60
	ld hl, wBoxMonOT
	ld a, [wBoxListLength]
.sub_db60
	dec a
	call SkipNames
	ld d, h
	ld e, l
.sub_db66
	ld hl, wBoxMonOT
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_db79
	ld hl, wBufferMonOT
	cp $02
	jr z, .sub_db7f
	ld hl, wPartyMon6StatsEnd
.sub_db79
	ld a, [wCurPartyMon]
	call SkipNames
.sub_db7f
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp $03
	ld de, wBufferMonNickname
	jr z, .sub_dba4
	dec a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	jr nz, .sub_db9e
	ld hl, wBoxMonNicknames
	ld a, [wBoxListLength]
.sub_db9e
	dec a
	call SkipNames
	ld d, h
	ld e, l
.sub_dba4
	ld hl, wBoxMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_dbb7
	ld hl, wBufferMonNickname
	cp $02
	jr z, .sub_dbbd
	ld hl, wPartyMonNicknames
.sub_dbb7
	ld a, [wCurPartyMon]
	call SkipNames
.sub_dbbd
	ld bc, $0006
	call CopyBytes
	pop hl
	ld a, [wPokemonWithdrawDepositParameter]
	cp $01
	jr z, .sub_dc14
	cp $03
	jr z, .sub_dc14
	push hl
	srl a
	add $02
	ld [wMonType], a
	predef CopyMonToTempMon
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
	call CalcMonStats
	pop bc
	ld a, [wPokemonWithdrawDepositParameter]
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
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wd882]
	ld de, wBufferMonNickname
	jr z, .sub_dc42
	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname
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
	call GetBaseData
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
	call CalcMonStats
	pop hl
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jr .sub_dce9
.sub_dcad
	ld hl, wBoxMonNicknames
	ld a, [wBoxListLength]
	ld bc, $0006
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl
	ld hl, wBoxMonOT
	ld a, [wBoxListLength]
	ld bc, $0006
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	ld hl, wBoxMon1
	ld a, [wBoxListLength]
	ld bc, $0030
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, $0020
	call CopyBytes
.sub_dce9
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ret z
	ld hl, wBreedMon2Nickname
	ld de, wBreedMon1Nickname
	ld bc, $002c
	call CopyBytes
	and a
	ret

Functiondcfc:
	ld a, [wPokemonWithdrawDepositParameter]
	ld de, wBufferMonNickname
	and a
	jr z, .sub_dd2c
	ld hl, wBreedMon1Nickname
	ld de, wBreedMon2Nickname
	ld bc, $0006
	call CopyBytes
	ld hl, wBreedMon1OT
	ld de, wBreedMon2OT
	ld bc, $0006
	call CopyBytes
	ld hl, wBreedMon1
	ld de, wBreedMon2
	ld bc, $0020
	call CopyBytes
	ld de, wBreedMon1Nickname
.sub_dd2c
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, $0006
	call AddNTimes
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMon6StatsEnd
	ld bc, $0006
	call AddNTimes
	call CopyBytes
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1
	ld bc, $0030
	call AddNTimes
	ld bc, $0020
	jp CopyBytes

Functiondd5c:
	ld de, wBoxListLength
	ld a, [de]
	cp MONS_PER_BOX
	ret nc
	inc a
	ld [de], a
	ld a, [wCurPartySpecies]
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
	call GetBaseData
	ld hl, wBoxMonOT
	ld bc, PLAYER_NAME_LENGTH
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
	ld de, wBoxMonOT
	ld bc, $0006
	call CopyBytes
	ld a, [wBoxListLength]
	dec a
	jr z, .sub_dde5
	ld hl, wBoxMonNicknames
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
	ld a, [wCurPartySpecies]
	ld [wce37], a
	call GetPokemonName
	ld de, wBoxMonNicknames
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
	ld a, [wBoxListLength]
	dec a
	jr z, .sub_de2a
	ld hl, wBoxMon1
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
	ld hl, wEnemyMon
	ld de, wBoxMon1
	ld bc, $0006
	call CopyBytes
	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	ld hl, CalcExpAtLevel
	ld a, BANK(CalcExpAtLevel)
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
	ld hl, wEnemyMonDVs
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
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	xor a
	ld [wEnemySubStatus5], a
	ld hl, LoadEnemyMon
	ld a, BANK(LoadEnemyMon)
	call FarCall_hl
	call Functiondd5c
	ld de, wBoxMonNicknames
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
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_ded9
	ld hl, wBoxListLength
.sub_ded9
	ld a, [hl]
	dec a
	ld [hli], a
	ld a, [wCurPartyMon]
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
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_defc
	ld hl, wBoxMonOT
	ld d, $1d
.sub_defc
	ld a, [wCurPartyMon]
	call SkipNames
	ld a, [wCurPartyMon]
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
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_df1d
	ld bc, wBoxMonNicknames
.sub_df1d
	call CopyDataUntil
	ld hl, wPartyMon1
	ld bc, $0030
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_df32
	ld hl, wBoxMon1
	ld bc, $0020
.sub_df32
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_df49
	ld bc, $0020
	add hl, bc
	ld bc, wBoxMonOT
	jr .sub_df50
.sub_df49
	ld bc, $0030
	add hl, bc
	ld bc, wPartyMon6StatsEnd
.sub_df50
	call CopyDataUntil
	ld hl, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_df5f
	ld hl, wBoxMonNicknames
.sub_df5f
	ld bc, $0006
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, $0006
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .sub_df7a
	ld bc, wBoxMonNicknamesEnd
.sub_df7a
	jp CopyDataUntil

CalcMonStats:
	ld c, $00
.loop
	inc c
	call CalcMonStatC
	ldh a, [hMultiplicand + 1]
	ld [de], a
	inc de
	ldh a, [hMultiplicand + 2]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret

CalcMonStatC:
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld a, b
	ld d, a

	push hl
	ld hl, wMonHBaseStats
	dec hl
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld e, a
	pop hl
	push hl
	ld a, c
; Special defense shares stat exp with special attack
	cp STAT_SDEF
	jr nz, .not_spdef
	dec hl
	dec hl
	
.not_spdef
	sla c
	ld a, d
	and a
	jr z, .no_stat_exp
	add hl, bc

.sqrt_loop
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	inc b
	ld a, b
	cp -1
	jr z, .no_stat_exp

	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	call Multiply

	ld a, [hld]
	ld d, a
	ldh a, [hProduct + 3]
	sub d
	ld a, [hli]
	ld d, a
	ldh a, [hProduct + 2]
	sbc d
	jr c, .sqrt_loop

.no_stat_exp
	srl c
	pop hl
	push bc
	ld bc, MON_DVS - MON_HP_EXP + 1
	add hl, bc
	pop bc
	ld a, c
	cp STAT_ATK
	jr z, .Attack
	cp STAT_DEF
	jr z, .Defense
	cp STAT_SPD
	jr z, .Speed
	cp STAT_SATK
	jr z, .Special
	cp STAT_SDEF
	jr z, .Special
; DV_HP = (DV_ATK & 1) << 3 | (DV_DEF & 1) << 2 | (DV_SPD & 1) << 1 | (DV_SPC & 1)
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
	jr .GotDV

.Attack
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Defense
	ld a, [hl]
	and $f
	jr .GotDV

.Speed
	inc hl
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Special
	inc hl
	ld a, [hl]
	and $f

.GotDV
	ld d, $00
	add e
	ld e, a
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	sla e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_2
	inc d
	
.no_overflow_2
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	call Multiply

	ldh a, [hProduct + 1]
	ldh [hDividend], a
	ldh a, [hMultiplicand + 1]
	ldh [hDividend + 1], a
	ldh a, [hMultiplicand + 2]
	ldh [hDividend + 2], a
	ld a, MAX_LEVEL
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide

	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_3
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_3
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_4
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_4
	ldh a, [hDividend+2]
	cp HIGH(MAX_STAT_VALUE + 1) + 1
	jr nc, .max_stat
	cp HIGH(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay
	ldh a, [hDividend+3]
	cp LOW(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hDividend+2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hDividend+3], a

.stat_value_okay
	pop bc
	pop de
	pop hl
	ret

Function60a0:
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, $00
	ld hl, wPartyMonNicknamesEnd
	ld b, $02
	predef SmallFarFlagAction
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
	ld de, wBoxMonNicknames
	ld b, $01
	push bc
	push de
.sub_e0e1
	push af
	ld a, [wCurPartySpecies]
	ld [wce37], a
	call GetPokemonName
	pop af
	and a
	jr nz, .sub_e10d
	ld hl, wd41c
	bit 4, [hl]
	jr z, .sub_e10d
	ld hl, NewDexDataText
	call PrintText
	call ClearSprites
	ld a, [wCurPartySpecies]
	ld [wce37], a
	predef NewPokedexEntry
	call LoadTilesetGFX_LCDOff
.sub_e10d
	ld hl, GotItText
	call PrintText
	call YesNoBox
	pop de
	jr c, .sub_e155
	push de
	ld b, NAME_MON
	farcall NamingScreen
	pop de
	ld a, [de]
	cp $50
	jr nz, .sub_e133
	ld hl, wStringBuffer1
	ld bc, $0006
	call CopyBytes
.sub_e133
	call ClearBGPalettes
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res SPRITES_SKIP_STANDING_GFX_F, [hl]
	set SPRITES_SKIP_WALKING_GFX_F, [hl]
	call RedrawPlayerSprite
	pop af
	ld [wSpriteFlags], a
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
	ld hl, BallSentToPCText
	ld hl, BallSentToSomeonesPCText
	call PrintText
	ld b, $01
	ret
.sub_e165
	ld b, $02
	ret

BallSentToPCText:
	text_from_ram wStringBuffer1
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

BallSentToSomeonesPCText:
	text_from_ram wStringBuffer1
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText:
	text_from_ram wStringBuffer1
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"

Texte1b8:
	db "ドギ@"

GotItText:
	text "ゲットした　@" ; "Got it!"

AskGiveNicknameText:
	text_from_ram wStringBuffer1
	text "に" ; "Would you like to"
	line "なまえを　つけますか？" ; "give it a name?"
	done

_BillsPC:
	call Functione284
	ret c
	call LoadStandardMenuHeader
	call ClearTileMap
	call LoadFontsBattleExtra
	ld hl, vChars2 tile $78
	ld de, PokeBallsGFX
	lb bc, BANK(PokeBallsGFX), $01
	call Request2bpp
	ld hl, WhatAreYouGoingToDoText
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
	call RestoreScreenAndReloadTiles
	call LoadFontExtra
	call CloseWindow
	ret

WhatAreYouGoingToDoText:
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
	dw LookAtPokemonText

LookAtPokemonText:
	db "#の　ようすをみる@" ; (lit "look at Pokemon")

WithdrawMonText:
	db "#を　つれていく@" ; "Withdraw (Pokemon)"

DepositMonText:
	db "#を　あずける@" ; "Deposit (Pokemon)"

ReleaseMonText:
	db "#を　にがす@" ; "Release (Pokemon)"

ChangeBoxText:
	db "ボックスを　かえる@" ; "Change Box"

GoodbyeText:
	db "さようなら@" ; "Goodbye"

Tablee270:
	dw Functione5c5
	dw Functione31b
	dw BillsPC_DepositMon
	dw BillsPC_ReleaseMon
	dw BillsPC_ChangeBoxMenu
	dw BillsPC_SeeYa

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

BillsPC_SeeYa:
	scf
	ret

BillsPC_DepositMon:
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
	ld hl, YouDontEventHaveOnePokemonText
	call MenuTextBoxBackup
	scf
	ret
.sub_e2c4
	ld hl, CantDepositLastMonText
	call MenuTextBoxBackup
	scf
	ret

YouDontEventHaveOnePokemonText:
	text "１ぴきも　もってへんやんか！" ; (lit: "I can't even have one!")
	prompt

CantDepositLastMonText:
	text "それ　あずけたら" ; "You can't deposit"
	line "こまるんとちゃう？" ; "the last #MON!"
	prompt

Functione2f0:
	call LoadStandardMenuHeader
	ld hl, Tablee6da
	call Functione6a4
	call CloseWindow
	ret c
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	predef Functiondac8
	xor a
	ld [wPokemonWithdrawDepositParameter], a
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
	call Functione6a4
	call CloseWindow
	ret c
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef Functiondac8
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	call Functiondecd
	ret

BillsPC_ReleaseMon:
	call .sub_e380
	and a
	ret
.sub_e380
	call LoadStandardMenuHeader
	ld hl, Datae6f8
	call Functione6a4
	call CloseWindow
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ret c
	ld hl, OnceReleasedText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	call Functiondecd
	ret

OnceReleasedText:
	text_from_ram wStringBuffer1
	text "　をほんとうに" ; "Are you sure you"
	next "にがしますか？" ; "want to release (MON)?"
	done

BillsPC_ChangeBoxMenu:
	call _ChangeBox
	and a
	ret

_ChangeBox:
	call BoxSelectFunc
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
	call BoxEditMenu
	jr .sub_e3d4
.sub_e3e9
	call CloseWindow
	ret

BoxSelectFunc:
	ld hl, wd4b9
	ld c, $00
.sub_e3f2
	push hl
	ld de, DummyBoxText
	call CopyString
	ld a, "０"
	add c
	dec hl
	ld [hli], a
	ld [hl], "@"
	pop hl
	ld de, $0009
	add hl, de
	inc c
	ld a, c
	cp $0a
	jr c, .sub_e3f2
	ret

DummyBoxText:
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
	db "№．０１　@"
	db "№．０２　@"
	db "№．０３　@"
	db "№．０４　@"
	db "№．０５　@"
	db "№．０６　@"
	db "№．０７　@"
	db "№．０８　@"
	db "№．０９　@"
	db "№．１０　@"

Functione49d: ; change box screen items
	ld h, d
	ld l, e
	ld de, MonInMyCareText
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
	ld de, OutOfThirtyText
	call PlaceString
	ret

MonInMyCareText: ; unfinished feature to show how many mon are in your box
	db "あずかっている#" ; "Mon in my care"
	next "　@"

OutOfThirtyText: ; max mon per box
	db "／３０@"

Functione4ce: ; counts available mon in highlighted box
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

Datae4e7: ; checks box slots for mon counting
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

BoxEditMenu:
	ld hl, BoxEditMenuList
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [w2DMenuDataEnd]
	cp $01
	jr z, PromptChangeBoxWillYouSave
	cp $02
	jr z, ChangeBoxName
	and a
	ret

PrintBoxChangeUnderDev:
	ld hl, BoxChangeUnderDevText
	call MenuTextBox
	call CloseWindow
	ret

BoxChangeUnderDevText:
	text "バンクチェンジは" ; "Box change is"
	next "かいはつちゅうです！" ; "under development!"
	prompt

PromptChangeBoxWillYouSave:
	ld hl, WhenYouChangeBoxText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	jr PrintBoxChangeUnderDev

Functione54d:
	ld a, [wMenuSelection]
	ret

WhenYouChangeBoxText:
	text "#　ボックスを　かえると" ; "When you change a box"
	line "どうじに　レポートが　かかれます" ; "data will be saved."
	para "<⋯⋯>　それでも　いいですか？" ; "Is that okay?"
	done

ChangeBoxName:
	ld b, NAME_BOX
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

BoxEditMenuList:
	db $40, $06, $00, $0e, $0e
	dw BoxEditMenuListItems
	db $01

BoxEditMenuListItems:
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
	ld [wCurPartyMon], a
	ld a, $02
	ld [wMonType], a
	call LoadStandardMenuHeader
	call LowVolume
	predef Function502b5
	call MaxVolume
	call ExitMenu
	ret
.sub_e62a
	ld hl, wOptions
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
	ld de, CurrentBoxText
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
	ld de, SpeciesNameLevelText
	call PlaceString
	ld hl, WhichOneWouldYouLikeToSeeText
	call PrintText
	pop af
	ld [wOptions], a
	ret

CurrentBoxText:
	db "ボックス／いまの　ボックス@" ; "Box/Current Box (Name)"

SpeciesNameLevelText:
	db "しゅるい　　なまえ　　　レべル@" ; "Species Name Level"

WhichOneWouldYouLikeToSeeText:
	text "どの#が　みたいねん？" ; "Which would you like to see?"
	done

Functione6a4: ; has something to do with releasing mon from PC
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	coord hl, 4, 2
	ld b, $09
	ld c, $0e
	call DrawTextBox
	ld hl, wListPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call Function3810 ; in home/scrolling_menu.asm and appears to be related to the smaller mon selection box like G1 (still investigating)
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e6ce
	ld hl, MonSelectedText
	call MenuTextBoxBackup
	and a
	ret
.sub_e6ce
	scf
	ret

MonSelectedText:
	text "#を　えらんだ！" ; "(MON) selected!"
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
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearBGPalettes
	call ClearSprites
	call LoadStandardMenuHeader
	ld hl, LoadPokeDexGraphics
	ld a, BANK(LoadPokeDexGraphics)
	call FarCall_hl
	call ClearTileMap
	ld hl, _NewPokedexEntry
	ld a, BANK(_NewPokedexEntry)
	call FarCall_hl
	call ClearBGPalettes
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call ExitMenu
	call LoadTilesetGFX_LCDOff
	call RestoreScreenAndReloadTiles
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	call MaxVolume
	call Function1fea
	ret

_UseItem:
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld a, $01
	ld [wItemEffectSucceeded], a
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
	dw PokeBallEffect    ; ITEM_MASTER_BALL
	dw PokeBallEffect    ; ITEM_ULTRA_BALL
	dw Functionf66f
	dw PokeBallEffect    ; ITEM_GREAT_BALL
	dw PokeBallEffect    ; ITEM_POKE_BALL
	dw TownMapEffect     ; ITEM_TOWN_MAP 
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

PokeBallEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nz, .room_in_party

	ld a, [wBoxListLength]
	cp MONS_PER_BOX
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	call ReturnToBattle_UseBall

	ld hl, ItemUsedText
	call PrintText

	ld a, [wEnemyMonCatchRate]
	ld b, a
	ld a, [wCurItem]
	cp ITEM_MASTER_BALL
	jp z, .sub_e9d6

	cp ITEM_ULTRA_BALL
	jr z, .ultra_ball_modifier

	cp ITEM_GREAT_BALL
	jr z, .great_ball_modifier

	; POKE_BALL
	jr .regular_ball

; 1.5x modifier
.great_ball_modifier
	ld a, b
	srl a
	add b
	ld b, a
	jr nc, .regular_ball
	ld b, $ff
	jr .regular_ball

; 2.0x modifier
.ultra_ball_modifier
	sla b
	jr nc, .regular_ball
	ld b, $ff

.regular_ball
	ld a, b
	ldh [hMultiplicand + 2], a
	ld hl, wEnemyMonHP
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
	ldh [hQuotient], a
	ldh [hQuotient + 1], a
	ldh [hQuotient + 2], a
	call Multiply
	pop bc
	ld a, b
	ldh [hDivisor], a
	ld b, $04
	call Divide
	ldh a, [hQuotient + 3]
	and a
	jr nz, .sub_e998
	ld a, $01
.sub_e998
	ld b, a
	ld a, [wEnemyMonStatus]
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
	ld a, [wBattleMonItem]
	ld hl, GetItemHeldEffect
	ld a, BANK(GetItemHeldEffect)
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
	ld a, [wEnemyMonSpecies]
.sub_e9d9
	ld [wWildMon], a
	ld c, $14
	call DelayFrames
	ld a, [wCurItem]
	ld [wBattleAnimParam], a
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ldh [hBattleTurn], a
	ld [wMapBlocksAddress], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld a, [wWildMon]
	and a
	jr nz, .sub_ea29
	ld a, [wMapBlocksAddress]
	cp $01
	ld hl, BallBrokeFreeText
	jp z, .sub_eb59
	cp $02
	ld hl, BallAppearedCaughtText
	jp z, .sub_eb59
	cp $03
	ld hl, BallAlmostHadItText
	jp z, .sub_eb59
	cp $04
	ld hl, BallSoCloseText
	jp z, .sub_eb59
.sub_ea29
	ld hl, wEnemyMonHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	inc hl
	ld a, [hl]
	push af
	push hl
	ld hl, wEnemyMonItem
	ld a, [hl]
	push af
	push hl
	ld hl, wEnemySubStatus5
	bit 3, [hl]
	jr z, .sub_ea48
	ld a, $84
	ld [wTempEnemyMonSpecies], a
	jr .sub_ea55
.sub_ea48
	set 3, [hl]
	ld hl, wEnemyBackupDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a
.sub_ea55
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	ld hl, LoadEnemyMon
	ld a, BANK(LoadEnemyMon)
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
	ld a, [wEnemyMonSpecies]
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wce37], a
	ld a, [wce03]
	dec a
	jp z, .sub_eb56
	ld hl, GotchaText
	call PrintText
	call ClearSprites
	ld a, [wce37]
	dec a
	ld c, a
	ld d, $00
	ld hl, wPartyMonNicknamesEnd
	ld b, $02
	predef SmallFarFlagAction
	ld a, c
	push af
	ld a, [wce37]
	dec a
	ld c, a
	ld b, $01
	predef SmallFarFlagAction
	pop af
	and a
	jr nz, .sub_eac7
	ld hl, NewDexDataText_2
	call PrintText
	call ClearSprites
	ld a, [wEnemyMonSpecies]
	ld [wce37], a
	predef NewPokedexEntry
.sub_eac7
	ld a, [wPartyCount]
	cp $06
	jr z, .sub_eb13
	xor a
	ld [wMonType], a
	call ClearSprites
	predef Functiond886
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb5f
	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	push de
	call FarCall_hl
	call GBFadeOutToWhite
	pop de
	ld a, [de]
	cp "@"
	jr nz, .sub_eb5f
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	jr .sub_eb5f
.sub_eb13
	call ClearSprites
	predef Functiondd5c
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb47
	ld de, wBoxMonNicknames
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	call FarCall_hl
	call GBFadeOutToWhite
	ld de, wBoxMonNicknames
	ld a, [de]
	cp "@"
	jr nz, .sub_eb47
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.sub_eb47
	ld hl, Textec0e
	bit 0, a
	jr nz, .sub_eb51
	ld hl, BallSentToSomeonesPCText_2
.sub_eb51
	call PrintText
	jr .sub_eb5f
.sub_eb56
	ld hl, GotchaText
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

BallDodgedText:
	text "よけられた！" ; "It dodged the thrown BALL!"
	line "こいつは　つかまりそうにないぞ！" ; "This MON can't be caught!"
	prompt

BallMissedText:
	text "#に" ; "You missed the"
	line "うまく　あたらなかった！" ; "(MON)!"
	prompt

BallBrokeFreeText:
	text "だめだ！　#が" ; "Oh no! The (MON)"
	line "ボールから　でてしまった！" ; "broke free!"
	prompt

BallAppearedCaughtText:
	text "ああ！" ; "Aww! It appeared"
	line "つかまえたと　おもったのに！" ; "to be caught!"
	prompt

BallAlmostHadItText:
	text "ざんねん！" ; "Aargh!"
	line "もうすこしで　つかまえられたのに！" ; "Almost had it!"
	prompt

BallSoCloseText:
	text "おしい！" ; "Shoot! It was so"
	line "あと　ちょっとの　ところだったのに！" ; "close too!"
	prompt

GotchaText:
	text "やったー！" ; "Gotcha"
	line "@"

Textebfd:
	text_from_ram wEnemyMonNickname
	text "を　つかまえたぞ！@"

Textec0b:
	sound_caught_mon
	text_waitbutton
	text_end

Textec0e:
	text_from_ram wBoxMonNicknames
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

BallSentToSomeonesPCText_2:
	text_from_ram wBoxMonNicknames
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText_2:
	text_from_ram wEnemyMonNickname
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"

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

ReturnToBattle_UseBall:
	call ClearPalettes
	ld hl, Call_LoadBattleFontsHPBar
	ld a, BANK(Call_LoadBattleFontsHPBar)
	call FarCall_hl
	call GetMemSGBLayout
	call CloseWindow
	call LoadStandardMenuHeader
	call WaitBGMap
	call SetPalettes
	ret

TownMapEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	farjp TownMap

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
	ld hl, ItemGotOnText
	jr .sub_ecf0
.sub_ece9
	xor a
	ld [wPlayerState], a
	ld hl, ItemGotOffText
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
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_EVO_STONE
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
	call WontHaveAnyEffectMessage
.sub_ed32
	xor a
	ld [wFieldMoveSucceeded], a
	ret

Functioned37:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wce37], a
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
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
	predef_jump CalcMonStats

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
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wce37], a
	push hl
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
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
	ld hl, CalcExpAtLevel
	ld a, BANK(CalcExpAtLevel)
	call FarCall_hl
	pop de
	pop hl
	push hl
	ld bc, $0008
	add hl, bc
	ldh a, [hQuotient + 1]
	ld [hli], a
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
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
	ld a, PARTYMENUTEXT_LEVEL_UP
	ld [wPartyMenuActionText], a
	callfar Function5087e
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld d, $01
	ld hl, Function50628
	ld a, BANK(Function50628)
	call FarCall_hl
	call TextboxWaitPressAorB_BlinkCursor
	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wce37], a
	predef Function421f8
	xor a
	ld [wcab9], a
	ld hl, Function4af93
	ld a, BANK(Function4af93)
	call FarCall_hl
	jp Functionf7a2

Functionef02:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	ld a, [wCurPartySpecies]
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
	ld [wPartyMenuActionText], a
	call Functionf113
	jr nc, .sub_ef50
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPlayerSubStatus5
	res 0, [hl]
	ld hl, wPlayerSubStatus1
	res 0, [hl]
	ld a, $24
	call GetPartyParamLocation
	ld de, wBattleMonMaxHP
	ld bc, $000a
	call CopyBytes
	predef Function3e1a4
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
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp nz, Functionf0fb
	ld a, [wBattleMode]
	and a
	jr z, .sub_efc9
	ld a, [wCurPartyMon]
	ld c, a
	ld d, $00
	ld hl, wBattleParticipantsIncludingFainted
	ld b, $02
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .sub_efc9
	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, $01
	predef SmallFarFlagAction
.sub_efc9
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp $27
	jr z, .sub_efd9
	call Functionf130
	jr .sub_efdc
.sub_efd9
	call Functionf127
.sub_efdc
	call Functionf0b0
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionefed:
	ret

Functionefee:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
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
	ld [wLowHealthAlarmBuffer], a
	call Functionf130
	ld a, $20
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call Functionf113
	jr nc, .sub_f049
	ld hl, wPlayerSubStatus5
	res 0, [hl]
	ld hl, wPlayerSubStatus1
	res 0, [hl]
	xor a
	ld [wBattleMonStatus], a
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.sub_f049
	call Functionf0b0
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionf05a:
	ret

Functionf05b:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp z, Functionf0fb
	call Functionf171
	jp nc, Functionf0fb
	xor a
	ld [wLowHealthAlarmBuffer], a
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
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.sub_f09e
	call Functionf0b0
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
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
	ld a, [wCurPartyMon]
	coord hl, 11, 0
	ld bc, $0028
	call AddNTimes
	ld a, $02
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ret

Functionf0cf:
	ld [wPartyMenuActionText], a
	predef PartyMenuInBattle_Setup
	ret

Functionf0d8:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, VBlank.return
	ld a, $7f
	call ByteFill
	callfar Function5087e
	ld a, $01
	ldh [hBGMapMode], a
	ld c, $32
	call DelayFrames
	call TextboxWaitPressAorB_BlinkCursor
	ret

Functionf0fb:
	call WontHaveAnyEffectMessage
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
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
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
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, $05
	ldh [hDivisor], a
	ld b, $02
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
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
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	predef PartyMenuInBattle
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
	ld [wCurPartyMon], a
	call Functionf165
	jr z, .sub_f292
	call Functionf171
	jp nc, .sub_f29c
	pop bc
	push bc
	ld a, b
	ld [wCurPartyMon], a
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
	ld [wCurPartyMon], a
	call Functionf165
	pop de
	call Functionf13f
	call Functionf0b0
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	predef Function5081f
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
	jp nz, IsntTheTimeMessage
	ld a, b
	ld [wce2d], a
	jp Functionf793

Functionf2dc:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 0, [hl]
	jp Functionf793

Functionf2eb:
	ld a, [wBattleMode]
	dec a
	jp nz, IsntTheTimeMessage
	ld a, LOSE
	ld [wBattleResult], a
	jp Functionf793

Functionf2fa:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 1, [hl]
	jp Functionf793

Functionf309:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 2, [hl]
	jp Functionf793

Functionf318:
	ld a, [wBattleMode]
	and a
	jr nz, .sub_f327
	call IsntTheTimeMessage
	ld a, $02
	ld [wFieldMoveSucceeded], a
	ret
.sub_f327
	ld hl, wPlayerMoveStruct
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
	ld [wPlayerMoveStruct], a
	call ReloadTilesFromBuffer
	call WaitBGMap
	xor a
	ldh [hBattleTurn], a
; wrong bank
	ld a, $f
	ld hl, BattleCommand_StatUp
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
	ld hl, wOTPartyMon1Status
	call Functionf397
.sub_f36e
	ld hl, wBattleMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld a, [wMovementBufferCount]
	and a
	ld hl, Textf3bd
	jp z, PrintText
	ld hl, Textf3ec
	call PrintText
	ld a, [wLowHealthAlarmBuffer]
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
	jp nz, IsntTheTimeMessage
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
	jp c, IsntTheTimeMessage
	ld bc, $0585
	ld a, $01
	jr Functionf478

Functionf444:
	call Functionf49f
	jp c, IsntTheTimeMessage
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
	jp c, IsntTheTimeMessage
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
	ld hl, ItemUsedText
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
	jp nz, IsntTheTimeMessage

Functionf4d1:
	ld a, [wCurItem]
	ld [wMovementBufferCount], a
.sub_f4d7
	ld a, PARTYMENUACTION_HEALING_ITEM
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
	callfar Function3daa7
	jr nz, .sub_f4d7
	ld hl, wPartyMon1Moves
	ld bc, $0030
	call GetMthMoveOfNthPartymon
	push hl
	ld a, [hl]
	ld [wce37], a
	call GetMoveName
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
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .sub_f572
	ld hl, wPartyMon1PP
	ld bc, $0030
	call AddNTimes
	ld de, wBattleMonPP
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
	call GetMaxPPOfMove
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
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
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
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
	call WontHaveAnyEffectMessage

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
	jp nz, IsntTheTimeMessage
	ld hl, TryTeleport
	ld a, $0b
	jp FarCall_hl

Functionf66c:
	jp IsntTheTimeMessage

Functionf66f:
	jp IsntTheTimeMessage

Functionf672:
	jp IsntTheTimeMessage

Functionf675:
	jp Functionfaba

Functionf678:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, [wCurItem]
	sub $c9
	push af
	jr nc, .sub_f689
	add $37
.sub_f689
	inc a
	ld [wce37], a
	predef GetTMHMMove
	ld a, [wce37]
	ld [wPutativeTMHMMove], a
	call GetMoveName
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
	ld de, wMonOrItemNameBuffer
	ld bc, $0008
	call CopyBytes
	ld a, PARTYMENUACTION_TEACH_TMHM
	call Functionf0cf
	push af
	ld hl, wMonOrItemNameBuffer
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
	predef CanLearnTMHMMove
	push bc
	ld a, [wCurPartyMon]
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
	predef LearnMove
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
	ld hl, ItemUsedText
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

UseBallInTrainerBattle:
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BallBlockedText
	call PrintText
	ld hl, BallDontBeAThiefText
	call PrintText
	jr Functionf7a2

Ball_BoxIsFullMessage:
	ld hl, BallBoxFullText
	jr CantUseItemMessage

IsntTheTimeMessage:
	ld hl, ItemOakWarningText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, ItemWontHaveAnyEffectText
	jr CantUseItemMessage

BelongsToSomeoneElseMessage:	; unreferenced
	ld hl, ItemBelongsToSomeoneElseText
	jr CantUseItemMessage

CyclingIsntAllowedMessage:	; unreferenced
	ld hl, NoCyclingText
	jr CantUseItemMessage

CantGetOnYourBikeMessage:	; unreferenced
	ld hl, ItemCantGetOnText

CantUseItemMessage:
	xor a
	ld [wItemEffectSucceeded], a
	jp PrintText

ItemOakWarningText:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！"
	prompt

ItemBelongsToSomeoneElseText:
	text "たいせつな　あずかりものです！"

Unreferenced_CantUseText:
	db ""
	next "つかうことは　できません！"
	prompt

ItemWontHaveAnyEffectText:
	text "つかっても　こうかがないよ"
	prompt

BallBlockedText:
	text "<TRAINER>に　ボールを　はじかれた！"
	prompt

BallDontBeAThiefText:
	text "ひとの　ものを　とったら　どろぼう！"
	prompt

NoCyclingText:
	text "ここでは　じてんしゃに"
	next "のることは　できません"
	prompt

ItemCantGetOnText:
	text "ここでは@"
Textf893:
	text_from_ram wStringBuffer1
	text "に"
	line "のることは　できません"
	prompt

BallBoxFullText:
	text "ボックスに　あずけている　#が"
	line "いっぱいなので　つかえません！"
	prompt

ItemUsedText:
	text "<PLAYER>は@"
Textf8ca:
	text_low
	text_from_ram wStringBuffer2
	text "を　つかった！"
	done

ItemGotOnText:
	text "<PLAYER>は@"
Textf8db:
	text_low
	text_from_ram wStringBuffer2
	text "に　のった"
	prompt

ItemGotOffText:
	text "<PLAYER>は@"
Textf8ea:
	text_low
	text_from_ram wStringBuffer2
	text "から　おりた"
	prompt

SECTION "engine/dumps/bank03.asm@GetMaxPPOfMove", ROMX

GetMaxPPOfMove:
	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	jr z, .got_partymon ; BOXMON

	ld hl, wd884
	dec a
	jr z, .got_nonpartymon ; TEMPMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; TEMPMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON, BOXMON
	call GetMthMoveOfNthPartymon

.gotdatmove
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
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, $0006
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wce37], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wce37], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes

GetMthMoveOfCurrentMon:
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
	ld hl, Breeder_NoEggYetText
	call PrintText
.sub_fade
	ld hl, Breeder_IntroText
	call PrintText
	ld hl, Breeder_Menu
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
	ld hl, Breeder_CheckOnPokemonText
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	jr .sub_fb22
.sub_fb19
	ld hl, Breeder_DoesntHavePokemonText
	call PrintText
	jp Functionfbde
.sub_fb22
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	predef Functiondc16
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
	ld hl, Breeder_WithdrawnText
	call PrintText
	jp Functionfbde
.sub_fb4c
	ld a, [wd8a2]
	cp $02
	jp nc, .sub_fbd6
	add PARTYMENUACTION_GIVE_MON
	call Functionf0cf
	jp c, Functionfbde
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wMonType], a
	predef GetGender
	ld a, [wd8fd]
	rla
	ld [wd8fd], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	predef Functiondcfc
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	ld hl, Functiondecd
	ld a, BANK(Functiondecd)
	call FarCall_hl
	ld a, [wCurPartySpecies]
	call PlayCry
	ld hl, Breeder_DepositedText
	call PrintText
	ld a, [wd8a2]
	inc a
	ld [wd8a2], a
	cp $02
	jr nz, Functionfbde
	ld hl, Breeder_LetsMakeBabiesText
	call PrintText
	call Functionfbf0
	ld a, [wce37]
	cp $50
	ld hl, Breeder_SeemToGetAlongText
	call z, PrintText
	ld a, [wce37]
	cp $14
	ld hl, Breeder_DontSeemToGetAlongText
	call z, PrintText
	ld a, [wce37]
	and a
	ld hl, Breeder_GendersDontMatchText
	call z, PrintText
	jr Functionfbde
.sub_fbd6
	ld hl, Breeder_AlreadyHasTwoPokemonText
	call PrintText
	jr Functionfbde

Functionfbde:
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
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
	ld a, [wBreedMon1ID]
	ld b, a
	ld a, [wBreedMon2ID]
	cp b
	jr nz, .sub_fc13
	ld a, [wBreedMon1ID + 1]
	ld b, a
	ld a, [wBreedMon2ID + 1]
	cp b
	jr nz, .sub_fc13
	ld a, $14
	jr .sub_fc15
.sub_fc13
	ld a, $50
.sub_fc15
	ld [wce37], a
	ret

Breeder_IntroText:
	text "わたしは　こずくりやさん"
	line "さて　どうする？"
	done

Breeder_Menu:
	db $40, $04, $0d, $0b, $13
	dw Breeder_MenuOptions
	db $01

Breeder_MenuOptions:
	db $80, $03
	db "あずける@"	; Deposit
	db "ひきとる@"	; Withdraw
	db "やめる@"	; Cancel

Breeder_DepositedText:
	text "あずけた！"
	prompt

Breeder_AlreadyHasTwoPokemonText:
	text "すでに　２ひきの#を"
	line "あずかっています"
	prompt

Breeder_CheckOnPokemonText:
	text "こずくりを　ちゅうししますか？"
	done

Breeder_DoesntHavePokemonText:
	text "#は　いっぴきも"
	line "あずかってませんが"
	prompt

Breeder_WithdrawnText:
	text "ひきとった！"
	prompt

Textfc91:
	text "てもちも　マサキの　<PC>も"
	line "#で　いっぱいのようです"
	prompt

Breeder_LetsMakeBabiesText:
	text "それでは　こづくりします！"
	prompt

Breeder_SeemToGetAlongText:
	text "あいしょうが　いいようです"
	prompt

Breeder_DontSeemToGetAlongText:
	text "あいしょうが　わるいようです"
	prompt

Breeder_GendersDontMatchText:
	text "せいべつが　あわないようです"
	prompt

Breeder_NoEggYetText:
	text "ざんねんながら　まだ　うまれて"
	line "こないようです"
	prompt

Functionfd03:
	ld hl, Breeder_EggLaidText
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	ld a, $04
	ld [wd8a2], a
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	call PlayCry
	xor a
	ld [wMonType], a
	ld a, $05
	ld [wCurPartyLevel], a
	predef Functionde79
	jp Functionfbde

Breeder_EggLaidText:
	text "タマゴが　うまれました！"
	line "ひきとりますか？"
	done

Functionfd45:
	ret

GetPokeBallWobble:
; Returns whether a Poke Ball will wobble in the catch animation.
; Whether a Pokemon is caught is determined beforehand.

	ld a, [wThrownBallWobbleCount]
	inc a
	ld [wThrownBallWobbleCount], a

; Wobble up to 3 times.
	cp 3 + 1
	jr z, .finished
	ld a, [wWildMon]
	and a
	ld c, 0 ; next
	ret nz
	ld hl, WobbleProbabilities
	ld a, [wFinalCatchRate]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr nc, .checkwobble
	inc hl
	jr .loop
.checkwobble
	ld b, [hl]
	call Random
	cp b
	ld c, 0 ; next
	ret c
	ld c, 2 ; escaped
	ret

.finished
	ld a, [wWildMon]
	and a
	ld c, 1 ; caught
	ret nz
	ld c, 2 ; escaped
	ret

WobbleProbabilities:
; catch rate, chance of wobbling / 255
; nLeft/255 = (nRight/255) ** 4
	db   1,  63
	db   2,  75
	db   3,  84
	db   4,  90
	db   5,  95
	db   7, 103
	db  10, 113
	db  15, 126
	db  20, 134
	db  30, 149
	db  40, 160
	db  50, 169
	db  60, 177
	db  80, 191
	db 100, 201
	db 120, 211
	db 140, 220
	db 160, 227
	db 180, 234
	db 200, 240
	db 220, 246
	db 240, 251
	db 254, 253
	db 255, 255

Functionfdab:
	ld a, $02
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
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
	ld hl, .knows_move_text
	call PrintText
	scf
	ret

.knows_move_text
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
	ld a, [wPutativeTMHMMove]
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
	ld hl, .knows_move_text
	call PrintText
	scf
	ret

.knows_move_text
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
