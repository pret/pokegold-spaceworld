INCLUDE "constants.asm"

SECTION "engine/dumps/bank0e.asm", ROMX

DrawPlayerHUDBorder::
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $77 ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawPlayerPartyIconHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 18, 10
	ld de, -1 ; start on right
	jr PlaceHUDBorderTiles

.tiles
	db $73 ; right side
	db $5c ; bottom right
	db $6f ; bottom left
	db $76 ; bottom side
.tiles_end

DrawEnemyHUDBorder:
	ld hl, .tiles
	ld de, wTrainerHUDTiles
	ld bc, .tiles_end - .tiles
	call CopyBytes
	hlcoord 1, 2
	ld de, 1 ; start on left
	jr PlaceHUDBorderTiles

.tiles
	db $6d ; left side
	db $74 ; bottom left
	db $78 ; bottom right
	db $76 ; bottom side
.tiles_end

PlaceHUDBorderTiles::
	ld a, [wTrainerHUDTiles]
	ld [hl], a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld a, [wTrainerHUDTiles + 1]
	ld [hl], a
	ld b, 8
.loop
	add hl, de
	ld a, [wTrainerHUDTiles + 3]
	ld [hl], a
	dec b
	jr nz, .loop
	add hl, de
	ld a, [wTrainerHUDTiles + 2]
	ld [hl], a
	ret

Function38431::
	call $4488
	ld hl, wPartyMon1HP
	ld de, wPartyCount
	call $4391
	ld hl, wPlaceBallsX
	ld a, 10 * TILE_WIDTH
	ld [hli], a
	ld [hl], 8 * TILE_WIDTH
	ld a, TILE_WIDTH
	ld [wPlaceBallsDirection], a
	ld hl, wShadowOAMSprite00
	call $4467

	ld hl, wOTPartyMon1HP
	ld de, wOTPartyCount
	call $4391

	ld hl, wPlaceBallsX
	ld a, 10 * TILE_WIDTH
	ld [hli], a
	ld [hl], 12 * TILE_WIDTH
	ld hl, wShadowOAMSprite00 + PARTY_LENGTH * SPRITEOAMSTRUCT_LENGTH
	jp LoadTrainerHudOAM

LoadTrainerHudOAM:
	ld de, wBattleHUDTiles
	ld c, PARTY_LENGTH
.loop
	ld a, [wPlaceBallsY]
	ld [hli], a ; y
	ld a, [wPlaceBallsX]
	ld [hli], a ; x
	ld a, [de]
	ld [hli], a ; tile id
	xor a
	ld [hli], a ; tile attributes
	ld a, [wPlaceBallsX]
	ld b, a
	ld a, [wPlaceBallsDirection]
	add b
	ld [wPlaceBallsX], a
	inc de
	dec c
	jr nz, .loop
	ret
