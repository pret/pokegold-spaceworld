TrainerCardLoop:
	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a
	call ClearTrainerCardJumptable
.loop
	call UpdateTime
	call HandleTrainerCardJumptable
	jr c, .escape
	call DelayFrame
	jr .loop
.escape
	pop af
	ld [wStateFlags], a
	ret

ClearTrainerCardJumptable:
; sets four bytes at wJumpTableIndex to 0
	call ClearPalettes
	ld hl, wJumptableIndex
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call ClearTileMap
	call ClearSprites
	ld b, SGB_TRAINER_CARD
	call GetSGBLayout
	ret

HandleTrainerCardJumptable:
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, .TrainerCardJumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.TrainerCardJumptable:
	dw TrainerCardMainPage
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw .SetPalAndIncJumpTable
	dw TrainerCardMainInputs
	dw TrainerCardScroll
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw TrainerCardClearTileMap
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw TrainerCardSetWindowY
	dw TrainerCardBadgePage
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw .SetPalAndIncJumpTable
	dw TrainerCardBadgeInput
	dw TrainerCardSetClearFlag

.SetPalAndIncJumpTable:
	call SetDefaultBGPAndOBP
.IncreaseJumpTableIndex:
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

TrainerCardMainPage:
	call ClearPalettes
	call ClearTileMap
	call TrainerCardDrawProtag
	call DisableLCD
	call PlaceMiscTilesTrainerCard
	ld hl, AllTrainerCardGFX
	ld de, vTileset
	ld bc, AllTrainerCardGFXEnd - AllTrainerCardGFX
	ld a, BANK(AllTrainerCardGFX)
	call FarCopyData
	call DrawTrainerCardMainPage
	call EnableLCD
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	xor a
	ld [wFlyDestination], a
	and a
	ret

TrainerCardMainInputs:
	call EmptyTrainerCardFunction
	call GetJoypad
	ld hl, hJoyDown
	ld a, [hl]
	and PAD_LEFT
	jr nz, .left
	ld a, [hl]
	and PAD_RIGHT
	jr nz, .right
	ld a, [hl]
	and PAD_A
	jr nz, .a
	ld a, [hl]
	and PAD_B
	jr nz, .exit
	and a
	ret
.a
	ld a, [wFlyDestination]
	and a
	jr z, .exit
	ld a, 5
	ld [wJumptableIndex], a
	and a
	ret
.exit
	ld a, $11
	ld [wJumptableIndex], a
	and a
	ret
.left
	hlcoord 4, 16
	ld [hl], '▶'
	hlcoord 11, 16
	ld [hl], '　'
	xor a
	ld [wFlyDestination], a
	and a
	ret
.right
	hlcoord 4, 16
	ld [hl], '　'
	hlcoord 11, 16
	ld [hl], '▶'
	ld a, 1
	ld [wFlyDestination], a
	and a
	ret

EmptyTrainerCardFunction:
	ret

TrainerCardScroll:
	ld a, $90
	ldh [hWY], a
	ld a, $9C
	ldh [hBGMapAddress +1], a
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardClearTileMap:
	xor a
	ldh [hWY], a
	ld a, $98
	ldh [hBGMapAddress +1], a
	call ClearTileMap
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardSetWindowY:
	ldh a, [hWY]
	cp $90
	jr nc, TrainerCardClearPals
	add a, 4
	ldh [hWY], a
	and a
	ret

TrainerCardClearPals:
	call ClearPalettes
	ld a, $90
	ldh [hWY], a
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardBadgePage:
	call ClearPalettes
	call DisableLCD
	ld hl, TrainerCardLeadersGFX
	ld de, vTileset
	ld bc, TrainerCardLeadersGFXEnd - TrainerCardLeadersGFX
	ld a, BANK(TrainerCardLeadersGFX)
	call FarCopyData
	call ClearTileMap
	call DrawTrainerCaseBadgePage
	call EnableLCD
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardBadgeInput:
	call GetJoypad
	ld hl, hJoyDown
	ld a, [hl]
	and 3
	jr z, .skip
	ld a, $11
	ld [wJumptableIndex], a
.skip
	and a
	ret

TrainerCardSetClearFlag:
	scf
	ret

TrainerCardDrawProtag:
	ld de, ProtagonistPic
	ld a, BANK(ProtagonistPic)
	call UncompressSpriteFromDE
	ld a, 0
	call OpenSRAM
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, 7 * 7 tiles
	call CopyBytes
	call CloseSRAM
	ld de, vChars2 tile $30
	call InterlaceMergeSpriteBuffers
	ret

PlaceMiscTilesTrainerCard:
	ld a, $30
	ldh [hGraphicStartTile], a
	hlcoord 13, 1
	lb bc, 7, 7
	predef PlaceGraphic
	ret

DrawTrainerCardMainPage:
	hlcoord 0, 0
	ld d, 5
	call PlaceTrainerCardBGTile
	hlcoord 0, 8
	ld d, 6
	call PlaceTrainerCardBGTile
	hlcoord 2, 2
	ld de, TrainerCardText
	call PlaceString
	hlcoord 16, 10
	ld de, TrainerCardDexEntriesText
	call PlaceString
	hlcoord 6, 2
	ld de, wPlayerName
	call PlaceString
	hlcoord 5, 4
	ld de, wPlayerID
	lb bc, 2, 5
	call PrintNumber
	hlcoord 7, 6
	ld de, wMoney
	lb bc, 3, 6
	call PrintNumber
	ld [hl], $F0
	ld hl, wPokedexCaught
	ld b, $1C
	call CountSetBits
	ld de, wNamedObjectIndexBuffer
	hlcoord 13, 10
	lb bc, 1, 3
	call PrintNumber
	hlcoord 1, 0
	ld de, TrainerCardNameTiles
	call PlaceTrainerCardTiles
	hlcoord 2, 4
	ld de, TrainerCardIDNoTiles
	call PlaceTrainerCardTiles
	hlcoord 1, 3
	ld de, TrainerCardNameUnderlineTiles
	call PlaceTrainerCardTiles
	hlcoord 1, 8
	ld de, TrainerCardStatusTiles
	call PlaceTrainerCardTiles
	hlcoord 0, 13
	ld de, TrainerCardBadgesOutlineTiles
	call PlaceTrainerCardTiles
	hlcoord 5, 16
	ld de, TrainerCardBadgesTextTiles
	call PlaceTrainerCardTiles
	hlcoord 4, 16
	ld [hl], '▶'
	ret

TrainerCardText:
	db   "なまえ／"
	next ""
	next "おこづかい"
	next ""
	next "#ずかん@"

TrainerCardDexEntriesText:
	db "ひき@"

TrainerCardNameTiles:
	db $0A, $0C, $0D, $0E, $0F, $FF

TrainerCardIDNoTiles:
	db $22, $23, $FF

TrainerCardNameUnderlineTiles:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0B, $FF

TrainerCardStatusTiles:
	db $0A, $10, $11, $12, $13, $FF

TrainerCardBadgesOutlineTiles:
	db $03, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $7F, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $7F, $7F, $7F, $FE, $BA, $7F, $7F, $7F, $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $FF

TrainerCardBadgesTextTiles:
	db $1E, $1F, $20, $7F, $7F, $7F, $7F, $1B, $1C, $1D, $FF

DrawTrainerCaseBadgePage:
	hlcoord 0, 0
	ld d, $0E
	call PlaceTrainerCardBGTile
	hlcoord 5, 2
	ld de, TrainerCardLeagueBadgesTextTiles
	call PlaceString
	hlcoord 1, 0
	ld de, TrainerCardBadgesTiles
	call PlaceTrainerCardTiles
	hlcoord 0, 3
	ld de, TrainerCardBadgeSilhouettesTiles
	call PlaceTrainerCardTiles
	ret

TrainerCardLeagueBadgesTextTiles:
	db "#リーグバッジ@"

TrainerCardBadgesTiles:
	db $0A, $0B, $0C, $0D, $0E, $FF

TrainerCardBadgeSilhouettesTiles:
	db $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $07, $07, $02, $18, $58, $59, $5A, $19, $5B, $5C, $5D, $1A, $6B, $6C, $6D, $1B, $78, $79, $7A, $7F, $07, $07, $02, $7F, $20, $21, $22, $7F, $23, $24, $25, $7F, $26, $27, $28, $7F, $29, $2A, $2B, $7F, $07, $07, $02, $7F, $30, $31, $32, $7F, $33, $34, $35, $7F, $36, $37, $38, $7F, $39, $3A, $3B, $7F, $07, $07, $02, $7F, $40, $41, $42, $7F, $43, $44, $45, $7F, $46, $47, $48, $7F, $49, $4A, $4B, $7F, $07, $07, $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $04, $07, $07, $7F, $1C, $68, $69, $6A, $1D, $7E, $6F, $6F, $1E, $5E, $5F, $6E, $1F, $7B, $7C, $7D, $02, $07, $07, $7F, $7F, $2C, $2D, $2E, $7F, $2F, $50, $51, $7F, $52, $53, $54, $7F, $55, $56, $57, $02, $07, $07, $7F, $7F, $3C, $3D, $3E, $7F, $3F, $60, $61, $7F, $62, $63, $64, $7F, $65, $66, $67, $02, $07, $07, $7F, $7F, $4C, $4D, $4E, $7F, $4F, $70, $71, $7F, $72, $73, $74, $7F, $75, $76, $77, $02, $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $07, $7F, $7F, $10, $7F, $11, $7F, $12, $7F, $13, $7F, $14, $7F, $15, $7F, $16, $7F, $17, $7F, $02, $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $06, $07, $FF

PlaceTrainerCardTiles:
; takes the tiles from de and places them at hl until FF is found.
	ld a, [de]
	cp $FF
	ret z
	ld [hli], a
	inc de
	jr PlaceTrainerCardTiles

PlaceTrainerCardBGTile:
; puts tile $07 (chequered background) at coord hl.
; d controls how many times biggerloop loops.
	ld e, $14
.loop
	ld a, $07
	ld [hli], a
	dec e
	jr nz, .loop

	ld a, $07
	ld [hli], a
	ld e, $11
.ScanLoop
	inc hl
	dec e
	jr nz, .ScanLoop

	ld a, 9
	ld [hli], a
	ld a, 7
	ld [hli], a
.OuterLoop
	ld a, 7
	ld [hli], a
	ld e, $12
.InnerLoop
	inc hl
	dec e
	jr nz, .InnerLoop

	ld a, 7
	ld [hli], a
	dec d
	jr nz, .OuterLoop

	ld a, 7
	ld [hli], a
	ld a, 8
	ld [hli], a
	ld e, $11
.ScanLoop2
	inc hl
	dec e
	jr nz, .ScanLoop2

	ld a, 7
	ld [hli], a
	ld e, $14
.LastLoop
	ld a, 7
	ld [hli], a
	dec e
	jr nz, .LastLoop
	ret

AllTrainerCardGFX:
TrainerCardBorderGFX:
INCBIN "gfx/trainer_card/border.2bpp"
TrainerCardGFX::
INCBIN "gfx/trainer_card/trainer_card.2bpp"
TrainerCardColonGFX:
INCBIN "gfx/trainer_card/colon.2bpp"
TrainerCardIDNoGFX:
INCBIN "gfx/trainer_card/id_no.2bpp"
AllTrainerCardGFXEnd:

TrainerCardLeadersGFX:
INCBIN "gfx/trainer_card/leaders.2bpp"
TrainerCardLeadersGFXEnd:
