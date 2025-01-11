INCLUDE "constants.asm"


SECTION "home/tileset.asm", ROM0

LoadTilesetGFX::
	call GetMapEnvironment
	cp TOWN
	jr z, .exterior
	cp ROUTE
	jr z, .exterior
	ld a, [wMapTileset]
	cp TILESET_FOREST
	jr z, .exterior

	ld a, [wTilesetTilesAddress]
	ld e, a
	ld a, [wTilesetTilesAddress + 1]
	ld d, a
	ld hl, vTileset
	ld a, [wTilesetBank]
	ld b, a
	ld c, $60
	call Get2bpp
	xor a
	ldh [hTileAnimFrame], a
	ret

.exterior
	ld de, CommonExteriorTilesGFX
	ld hl, vTileset
	lb bc, BANK(CommonExteriorTilesGFX), $20
	call Get2bpp

	ld a, [wTilesetTilesAddress]
	ld e, a
	ld a, [wTilesetTilesAddress + 1]
	ld d, a
	ld hl, vExteriorTileset
	ld a, [wTilesetBank]
	ld b, a
	ld c, $40
	call Get2bpp
	xor a
	ldh [hTileAnimFrame], a
	ret


RefreshPlayerCoords::
	ld a, [wXCoord]
	add a, 4
	ld d, a
	ld hl, wPlayerMapX
	sub [hl]
	ld [hl], d
	ld hl, wPlayerObjectXCoord
	ld [hl], d
	ld hl, wPlayerLastMapX
	ld [hl], d
	ld d, a
	ld a, [wYCoord]
	add a, 4
	ld e, a
	ld hl, wPlayerMapY
	sub [hl]
	ld [hl], e
	ld hl, wPlayerObjectYCoord
	ld [hl], e
	ld hl, wPlayerLastMapY
	ld [hl], e
	ld e, a

	ld a, [wObjectFollow_Leader]
	cp 1
	ret nz
	ld a, [wObjectFollow_Follower]
	and a
	ret z

	; This piece of code has been removed in pokegold (note that the conditions above were altered, as well)
	call GetObjectStruct
	ld hl, 16 ; TODO: constantify this
	add hl, bc
	ld a, [hl]
	add a, d
	ld [hl], a
	ld [wMap1ObjectXCoord], a
	ld hl, 18 ; TODO: constantify this
	add hl, bc
	ld a, [hl]
	add a, d
	ld [hl], a
	ld hl, 17 ; TODO: constantify this
	add hl, bc
	ld a, [hl]
	add a, e
	ld [hl], a
	ld [wMap1ObjectYCoord], a
	ld hl, 19
	add hl, bc
	ld a, [hl]
	add a, e
	ld [hl], a
	ret

BufferScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	ld c, 5
	ld b, 6
.row
	push bc
	push hl
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .col
	pop hl
	ld a, [wMapWidth]
	add a, 6
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row
	ret

SaveScreen::
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	ld a, [wMapWidth]
	add 6
	ldh [hMapObjectIndex], a
	ld a, [wPlayerStepDirection]
	and a
	jr z, .down
	cp UP
	jr z, .up
	cp LEFT
	jr z, .left
	cp RIGHT
	jr z, .right
	ret

.up
	ld de, wScreenSave + 6
	ldh a, [hMapObjectIndex]
	ld c, a
	ld b, 0
	add hl, bc
	jr .vertical

.down
	ld de, wScreenSave
.vertical
	ld b, 6
	ld c, 4
	jr .load_neighbor

.left
	ld de, wScreenSave + 1
	inc hl
	jr .horizontal

.right
	ld de, wScreenSave
.horizontal
	ld b, 5
	ld c, 5

.load_neighbor
.row
	push bc
	push hl
	push de
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .col
	pop de
	ld a, e
	add a, 6
	ld e, a
	jr nc, .okay
	inc d

.okay
	pop hl
	ldh a, [hConnectionStripLength]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row
	ret


RefreshTiles::
	call .left_right
	call .up_down
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	call GetCoordTile
	ld [wPlayerTile], a
	ret

.up_down
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	push de
	inc e
	call GetCoordTile
	ld [wTileDown], a
	pop de
	dec e
	call GetCoordTile
	ld [wTileUp], a
	ret

.left_right
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	push de
	dec d
	call GetCoordTile
	ld [wTileLeft], a
	pop de
	inc d
	call GetCoordTile
	ld [wTileRight], a
	ret


GetFacingTileCoord::
	ld a, [wPlayerDirection] ; TODO: wPlayerDirection in Crystal. Not here?
	and %1100
	srl a
	srl a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, .directions
	add hl, de

	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wPlayerMapX]
	add a, d
	ld d, a
	ld a, [wPlayerMapY]
	add a, e
	ld e, a
	ld a, [hl]
	ret

.directions
	db 0, 1
	dw wTileDown

	db 0, -1
	dw wTileUp

	db -1, 0
	dw wTileLeft

	db 1, 0
	dw wTileRight

GetCoordTile::
; Get the collision byte for tile d, e
	call GetBlockLocation
	ld a, [hl]
	and a
	jr z, .nope
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld a, [wTilesetCollisionAddress]
	ld c, a
	ld a, [wTilesetCollisionAddress + 1]
	ld b, a
	add hl, bc
	rr d
	jr nc, .nocarry
	inc hl

.nocarry
	rr e
	jr nc, .nocarry2
	inc hl
	inc hl

.nocarry2
	ld a, [wTilesetBank]
	call GetFarByte
	ret

.nope
	ld a, -1
	ret

GetBlockLocation::
	ld a, [wMapWidth]
	add a, 6
	ld c, a
	ld b, 0
	ld hl, wOverworldMapBlocks + 1
	add hl, bc
	ld a, e
	srl a
	jr z, .nope
	and a
.loop
	srl a
	jr nc, .ok
	add hl, bc

.ok
	sla c
	rl b
	and a
	jr nz, .loop

.nope
	ld c, d
	srl c
	ld b, 0
	add hl, bc
	ret

GetFacingSignpost::
	call GetFacingTileCoord
	ld b, a
GetSignpost::
	ld a, d
	sub $4
	ld d, a
	ld a, e
	sub $4
	ld e, a
	ld a, [wCurrMapSignCount]
	and a
	ret z
	ld c, a
	ld hl, wCurrMapSigns
.asm_2f32:
	ld a, [hli]
	cp e
	jr nz, .asm_2f3e
	ld a, [hli]
	cp d
	jr nz, .asm_2f3f
	ld a, [hli]
	cp b ; useless comparison
	jr .asm_2f46

.asm_2f3e:
	inc hl
.asm_2f3f:
	inc hl
	inc hl
	dec c
	jr nz, .asm_2f32
	xor a
	ret

.asm_2f46:
	scf
	ret

LoadTileset::
	push hl
	push bc

	ld hl, Tilesets
	ld bc, wTilesetEnd - wTileset
	ld a, [wMapTileset]
	call AddNTimes

	ld de, wTileset
	ld bc, wTilesetEnd - wTileset

	ld a, BANK(Tilesets)
	call FarCopyBytes

	ld a, 1
	ldh [hMapAnims], a
	xor a
	ldh [hTileAnimFrame], a

	pop bc
	pop hl
	ret

ReloadFontAndTileset::
	call DisableLCD
	ldh a, [hROMBank]
	push af
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	call SwitchToAnyMapBank
	call LoadFontExtra
	call LoadMapPart
	call LoadTilesetGFX
	pop af
	call Bankswitch

	call EnableLCD
	ret

LoadTilesetGFX_LCDOff::
	call DisableLCD
	call LoadTilesetGFX
	call EnableLCD
	ret
