include "constants.asm"


SECTION "LoadTilesetGFX", ROM0[$2D26]

LoadTilesetGFX:: ; 2d26
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
	ld de, CommonExteriorTiles ; TODO: maybe find a better name
	ld hl, vTileset
	lb bc, BANK(CommonExteriorTiles), $20
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


RefreshPlayerCoords:: ; 2d74
	ld a, [wXCoord]
	add a, 4
	ld d, a
	ld hl, wPlayerStandingMapX
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
	ld hl, wPlayerStandingMapY
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


BufferScreen:: ; 2dcd
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

SaveScreen:: ; 2df1
	ld hl, wOverworldMapAnchor
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wScreenSave
	ld a, [wMapWidth]
	add 6
	ldh [hMapObjectIndexBuffer], a
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
	ldh a, [hMapObjectIndexBuffer]
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

.load_neighbor ; 2e35
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


RefreshTiles:: ; 2e52
	call .left_right
	call .up_down
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
	ld e, a
	call GetCoordTile
	ld [wPlayerStandingTile], a
	ret

.up_down ; 2e67
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
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

.left_right ; 2e80
	ld a, [wPlayerStandingMapX]
	ld d, a
	ld a, [wPlayerStandingMapY]
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


GetFacingTileCoord:: ; 2e99
	ld a, [wPlayerWalking] ; TODO: wPlayerDirection in Crystal. Not here?
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

	ld a, [wPlayerStandingMapX]
	add a, d
	ld d, a
	ld a, [wPlayerStandingMapY]
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

GetCoordTile:: ; 2ece
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

GetBlockLocation:: ; 2ef8
	ld a, [wMapWidth]
	add a, 6
	ld c, a
	ld b, 0
	ld hl, wOverworldMap + 1
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

GetFacingSignpost:: ; 00:2f1d
	call GetFacingTileCoord
	ld b, a
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
.asm_2f32: ; 00:2f32
	ld a, [hli]
	cp e
	jr nz, .asm_2f3e
	ld a, [hli]
	cp d
	jr nz, .asm_2f3f
	ld a, [hli]
	cp b ; useless comparison
	jr .asm_2f46

.asm_2f3e: ; 00:2f3e
	inc hl
.asm_2f3f: ; 00:2f3f
	inc hl
	inc hl
	dec c
	jr nz, .asm_2f32
	xor a
	ret

.asm_2f46: ; 00:2f46
	scf
	ret

LoadTileset:: ; 2f48
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
