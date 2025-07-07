INCLUDE "constants.asm"

SECTION "engine/overworld/init_map.asm", ROMX

ReanchorBGMap_NoOAMUpdate::
	xor a
	ldh [hLCDCPointer], a
	ld hl, wToolgearFlags
	set 7, [hl] ; hide toolgear
	res 2, [hl] ; transfer toolgear to window
	ld a, SCREEN_HEIGHT_PX
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
	call .Transfer
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

.Transfer
	ld a, $60 ; blank tile?
	ld hl, wTileMapBackup
	ld bc, (SCREEN_WIDTH * 6) + 8
	call ByteFill
	ld hl, vBGMap0
	ld c, 8
.loop
	push bc
	push hl
	ld de, wTileMapBackup
	lb bc, BANK(wTileMapBackup), 8
	call Request2bpp
	pop hl
	ld bc, BG_MAP_WIDTH * 4
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	ret

LoadFonts_NoOAMUpdate:
	call UpdateSprites
	call LoadFont
	call LoadFontExtra
	ld a, SCREEN_HEIGHT_PX
	ldh [hWY], a
	ret
