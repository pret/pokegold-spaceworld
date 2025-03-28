INCLUDE "constants.asm"

SECTION "engine/dumps/bank23.asm@AnimateTilesetImpl", ROMX

AnimateTilesetImpl:
	ldh a, [hMapAnims]
	and a
	ret z

	ld a, [wTilesetAnim]
	ld e, a
	ld a, [wTilesetAnim+1]
	ld d, a
	ldh a, [hTileAnimFrame]
	ld l, a
	inc a
	ldh [hTileAnimFrame], a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

SECTION "engine/dumps/bank23.asm@RestoreOverworldMapTiles", ROMX

RestoreOverworldMapTiles::
	xor a
	call OpenSRAM
	ld hl, wTileMap
	ld de, sScratch
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call CopyBytes
	call CloseSRAM
	farcall ReanchorBGMap_NoOAMUpdate

	xor a
	call OpenSRAM
	ld hl, sScratch
	ld de, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.loop
	ld a, [hl]
	cp $61
	jr c, .next
	ld [de], a
.next
	inc hl
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	
	call CloseSRAM
	call UpdateSprites
	call WaitBGMap
	ld a, 144
	ldh [hWY], a
	call DelayFrame

	xor a
	ldh [hBGMapMode], a
	call InitToolgearBuffer
	ld b, SGB_MAP_PALS
	call GetSGBLayout
	ret
