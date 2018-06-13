INCLUDE "constants.asm"

SECTION "Copy Routines used by VBlank ISR", ROM0[$123a]

RedrawRowOrColumn:: ; 123a (0:123a)
; This function redraws a BG row of height 2 or a BG column of width 2.
; One of its main uses is redrawing the row or column that will be exposed upon
; scrolling the BG when the player takes a step. Redrawing only the exposed
; row or column is more efficient than redrawing the entire screen.
; However, this function is also called repeatedly to redraw the whole screen
; when necessary. It is also used in trade animation and elevator code.
; This also implements the flashlight drawing distance effect, which takes
; multiple frames in either direction to complete
	ldh a, [hRedrawRowOrColumnMode]
	and a
	ret z
	cp $03
	jr nc, .flashlight_effect
	ld b, a
	xor a
	ldh [hRedrawRowOrColumnMode], a
	dec b
	jr nz, .redrawRow
.redrawColumn
	ld hl, wRedrawRowOrColumnSrcTiles
	ldh a, [hRedrawRowOrColumnDest]
	ld e, a
	ldh a, [hRedrawRowOrColumnDest + 1]
	ld d, a
	ld c, SCREEN_HEIGHT
.col_loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, BG_MAP_WIDTH - 1
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
; the following 4 lines wrap us from bottom to top if necessary
	ld a, d
	and HIGH(vBGMap1 - vBGMap0 - $01)
	or HIGH(vBGMap0)
	ld d, a
	dec c
	jr nz, .col_loop
	xor a
	ldh [hRedrawRowOrColumnMode], a
	ret
.redrawRow
	ld hl, wRedrawRowOrColumnSrcTiles
	ldh a, [hRedrawRowOrColumnDest]
	ld e, a
	ldh a, [hRedrawRowOrColumnDest + 1]
	ld d, a
	push de
	call .DrawHalf
	pop de
	ld a, BG_MAP_WIDTH ; width of VRAM background map
	add e
	ld e, a
	; fallthrough (draw lower half)

.DrawHalf
	ld c, SCREEN_WIDTH / 2
.row_loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, e
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and BG_MAP_WIDTH - 1            ; mask lower address bits
	ld b, a
	ld a, e
	and ($FF ^ (BG_MAP_WIDTH - 1))  ; mask upper address bits
	or b
	ld e, a
	dec c
	jr nz, .row_loop
	ret
.flashlight_effect
	dec a
	dec a
	dec a
	ld c, a
	ld b, $00
	ld hl, .flashlight_effect_table
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.flashlight_effect_table
	dw RedrawFlashlightRow0    ; $1310
	dw RedrawFlashlightRow0    ; $1310
	dw RedrawFlashlightColumn0 ; $12C3
	dw RedrawFlashlightColumn0 ; $12C3
	dw RedrawFlashlightRow1    ; $1329
	dw RedrawFlashlightRow1    ; $1329
	dw RedrawFlashlightColumn1 ; $12DC
	dw RedrawFlashlightColumn1 ; $12DC
	dw RedrawFlashlightRow2    ; $1335
	dw RedrawFlashlightRow2    ; $1335
	dw RedrawFlashlightColumn2 ; $12E8
	dw RedrawFlashlightColumn2 ; $12E8
	dw RedrawFlashlightRow3    ; $134E
	dw RedrawFlashlightRow3    ; $134E
	dw RedrawFlashlightColumn3 ; $1301
	dw RedrawFlashlightColumn3 ; $1301

RedrawFlashlightColumn0:: ; 12c3 (0:12c3)
	ldh a, [hSCX]
	and $07
	ret nz        ; wait till we moved one complete tile in X
	ld a, [wRedrawFlashlightDst0]
	ld e, a
	ld a, [wRedrawFlashlightDst0 + 1]
	ld d, a
	ld a, [wRedrawFlashlightSrc0]
	ld l, a
	ld a, [wRedrawFlashlightSrc0 + 1]
	ld h, a
	call _RedrawFlashlightColumn
	ret

RedrawFlashlightColumn1:: ; 12dc (0:12dc)
	ld a, [wRedrawFlashlightBlackDst0]
	ld e, a
	ld a, [wRedrawFlashlightBlackDst0 + 1]
	ld d, a
	call _RedrawFlashlightColumnBlack
	ret
; 0x12e8

RedrawFlashlightColumn2:: ; 12e8 (0:12e8)
	ldh a, [hSCX]
	and $0f
	ret nz        ; wait till we moved two complete tiles in X
	ld a, [wRedrawFlashlightDst1]
	ld e, a
	ld a, [wRedrawFlashlightDst1 + 1]
	ld d, a
	ld a, [wRedrawFlashlightSrc1]
	ld l, a
	ld a, [wRedrawFlashlightSrc1 + 1]
	ld h, a
	call _RedrawFlashlightColumn
	ret

RedrawFlashlightColumn3:: ; 1301 (0:1301)
	ld a, [wRedrawFlashlightBlackDst1]
	ld e, a
	ld a, [wRedrawFlashlightBlackDst1 + 1]
	ld d, a
	call _RedrawFlashlightColumnBlack
	xor a
	ldh [hRedrawRowOrColumnMode], a ; end flashlight redraw
	ret

RedrawFlashlightRow0:: ; 1310 (0:1310)
	ldh a, [hSCY]
	and $07
	ret nz        ; wait till we moved one complete tile in Y
	ld a, [wRedrawFlashlightDst0]
	ld e, a
	ld a, [wRedrawFlashlightDst0 + 1]
	ld d, a
	ld a, [wRedrawFlashlightSrc0]
	ld l, a
	ld a, [wRedrawFlashlightSrc0 + 1]
	ld h, a
	call _RedrawFlashlightRow
	ret

RedrawFlashlightRow1:: ; 1329 (0:1329)
	ld a, [wRedrawFlashlightBlackDst0]
	ld e, a
	ld a, [wRedrawFlashlightBlackDst0 + 1]
	ld d, a
	call _RedrawFlashlightRowBlack
	ret
; 0x12e8

RedrawFlashlightRow2:: ; 1335 (0:1335)
	ldh a, [hSCY]
	and $0f
	ret nz        ; wait till we moved two complete tiles in Y
	ld a, [wRedrawFlashlightDst1]
	ld e, a
	ld a, [wRedrawFlashlightDst1 + 1]
	ld d, a
	ld a, [wRedrawFlashlightSrc1]
	ld l, a
	ld a, [wRedrawFlashlightSrc1 + 1]
	ld h, a
	call _RedrawFlashlightRow
	ret

RedrawFlashlightRow3:: ; 134e (0:134e)
	ld a, [wRedrawFlashlightBlackDst1]
	ld e, a
	ld a, [wRedrawFlashlightBlackDst1 + 1]
	ld d, a
	call _RedrawFlashlightRowBlack
	xor a
	ldh [hRedrawRowOrColumnMode], a ; end flashlight redraw
	ret

_RedrawFlashlightColumn:: ; 135d (0:135d)
	ld a, [wRedrawFlashlightWidthHeight]
	add a
	ld c, a
.loop
	ld a, [hli]
	ld [de], a
	ld a, SCREEN_WIDTH - 1
	add l
	ld l, a
	jr nc, .noCarryScreen
	inc h
.noCarryScreen
	ld a, BG_MAP_WIDTH
	add e
	ld e, a
	jr nc, .noCarryBG
	inc d
.noCarryBG
; the following 4 lines wrap us from bottom to top if necessary
	ld a, d
	and HIGH(vBGMap1 - vBGMap0 - $01)
	or HIGH(vBGMap0)
	ld d, a
	dec c
	jr nz, .loop
	ldh a, [hRedrawRowOrColumnMode]
	add $04                         ; inc by 4, because flashlight redraw
	ldh [hRedrawRowOrColumnMode], a ; has four directions
	ret

_RedrawFlashlightRow:: ; 1382 (0:1382)
	ld a, [wRedrawFlashlightWidthHeight]
	ld c, a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld a, e
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and BG_MAP_WIDTH - 1            ; mask lower address bits
	ld b, a
	ld a, e
	and ($FF ^ (BG_MAP_WIDTH - 1))  ; mask upper address bits
	or b
	ld e, a
	dec c
	jr nz, .loop
	ldh a, [hRedrawRowOrColumnMode]
	add $04                         ; inc by 4, because flashlight redraw
	ldh [hRedrawRowOrColumnMode], a ; has four directions
	ret

_RedrawFlashlightColumnBlack:: ; 139f (0:139f)
	ld l, e
	ld h, d
	ld b, "■"
	ld de, BG_MAP_WIDTH
	ld a, [wRedrawFlashlightWidthHeight]
	add a
	ld c, a
.loop
	ld [hl], b
	add hl, de
; the following 4 lines wrap us from bottom to top if necessary
	ld a, h
	and HIGH(vBGMap1 - vBGMap0 - $01)
	or HIGH(vBGMap0)
	ld h, a
	dec c
	jr nz, .loop
	ldh a, [hRedrawRowOrColumnMode]
	add $04                         ; inc by 4, because flashlight redraw
	ldh [hRedrawRowOrColumnMode], a ; has four directions
	ret

_RedrawFlashlightRowBlack:: ; 13bd (0:13bd)
	ld l, e
	ld h, d
	ld b, "■"
	ld a, [wRedrawFlashlightWidthHeight]
	ld c, a
.loop
	ld [hl], b
	inc hl
	ld [hl], b
	ld a, l
	inc a
; the following 6 lines wrap us from the right edge to the left edge if necessary
	and BG_MAP_WIDTH - 1            ; mask lower address bits
	ld d, a
	ld a, l
	and ($FF ^ (BG_MAP_WIDTH - 1))  ; mask upper address bits
	or d
	ld l, a
	dec c
	jr nz, .loop
	ldh a, [hRedrawRowOrColumnMode]
	add $04                         ; inc by 4, because flashlight redraw
	ldh [hRedrawRowOrColumnMode], a ; has four directions
	ret

WaitForAutoBgMapTransfer:: ; 13dc (0:13dc)
.loop
	ldh a, [hBGMapMode]
	and a
	ret z
	ldh a, [hBGMapTransferPosition]
	and a
	jr z, .done
	call DelayFrame
	jr .loop
.done
	xor a
	ldh [hBGMapMode], a
	ret

; This function automatically transfers tile number data from the tile map at
; wTileMap to VRAM during V-blank. Note that it only transfers one third of the
; background per V-blank. It cycles through which third it draws.
; This transfer is turned off when walking around the map, but is turned
; on when talking to sprites, battling, using menus, etc. This is because
; the above function, RedrawRowOrColumn, is used when walking to
; improve efficiency.
AutoBgMapTransfer:: ; 13ee (0:13ee)
	ldh a, [hBGMapMode]
	and a
	ret z
	ld [hSPTemp], sp
	ldh a, [hBGMapTransferPosition]
	and a
	jr z, .transferTopThird
	dec a
	jr z, .transferMiddleThird
.transferBottomThird
	coord hl, 0, 12
	ld sp, hl
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
	ld de, 12 * BG_MAP_WIDTH
	add hl, de
	xor a
	jr .doTransfer
.transferTopThird
	coord hl, 0, 0
	ld sp, hl
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
	ld a, $01
	jr .doTransfer
.transferMiddleThird
	coord hl, 0, 6
	ld sp, hl
	ldh a, [hBGMapAddress + 1]
	ld h, a
	ldh a, [hBGMapAddress]
	ld l, a
	ld de, 6 * BG_MAP_WIDTH
	add hl, de
	ld a, $02
.doTransfer
	ldh [hBGMapTransferPosition], a
	ld a, $06                 ; 6 rows of SCREEN_WIDTH each
	; fallthrough

TransferBgRows:: ; 1430 (0:1430)
	ld bc, BG_MAP_WIDTH - SCREEN_WIDTH + 1
.loop

	rept SCREEN_WIDTH / 2 - 1 ; two bytes per pop minus last block
	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	endr

	pop de
	ld [hl], e
	inc l
	ld [hl], d
	add hl, bc
	dec a
	jr nz, .loop
	ldh a, [hSPTemp]
	ld l, a
	ldh a, [hSPTemp + 1]
	ld h, a
	ld sp, hl
	ret

VBlankCopyDouble:: ; 1470 (0:1470)
; Copy [wVBCopyDoubleSize] 1bpp tiles
; from wVBCopyDoubleSrc to wVBCopyDoubleDst.
; wVBCopyDoubleDst must be aligned to 0x10 bytes.

; While we're here, convert to 2bpp.
; The process is straightforward:
; copy each byte twice.
	ld a, [wVBCopyDoubleSize]
	and a
	ret z
	ld [hSPTemp], sp
	ld hl, wVBCopyDoubleSrc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld hl, wVBCopyDoubleDst
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wVBCopyDoubleSize]
	ld b, a
	xor a
	ld [wVBCopyDoubleSize], a
.loop

	rept 16/4 - 1 ; 16 bytes per 2bpp tile at 2 bytes per pop
	pop de        ; copied twice minus last block
	ld [hl], e
	inc l
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	ld [hl], d
	inc l
	endr

	pop de
	ld [hl], e
	inc l
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	ld [hl], d
	inc hl
	dec b
	jr nz, .loop
	ld a, l
	ld [wVBCopyDoubleDst], a
	ld a, h
	ld [wVBCopyDoubleDst + 1], a
	ld [wVBCopyDoubleSrc], sp
	ldh a, [hSPTemp]
	ld l, a
	ldh a, [hSPTemp + 1]
	ld h, a
	ld sp, hl
	ret

VBlankCopy:: ; 14c7 (0:14c7)
; Copy 16 * [wVBCopySize] bytes
; from wVBCopySrc to wVBCopyDst.
; wVBCopyDst must be aligned to 0x10 bytes.

; Source and destination addresses are updated,
; so transfer can continue in subsequent calls.
	ld a, [wVBCopySize]
	and a
	ret z
	ld [hSPTemp], sp
	ld hl, wVBCopySrc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld hl, wVBCopyDst
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wVBCopySize]
	ld b, a
	xor a
	ld [wVBCopySize], a
.loop

	rept 16/2 - 1 ; 16 bytes per transfer at 2 bytes per pop
	pop de        ; minus last block
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	endr

	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc hl
	dec b
	jr nz, .loop
	ld a, l
	ld [wVBCopyDst], a
	ld a, h
	ld [wVBCopyDst + 1], a
	ld [wVBCopySrc], sp
	ldh a, [hSPTemp]
	ld l, a
	ldh a, [hSPTemp + 1]
	ld h, a
	ld sp, hl
	ret

AnimateTileset:: ; 1522 (0:1522)
	ldh a, [hROMBank]
	push af
	ld a, BANK(AnimateTilesetImpl)
	call Bankswitch
	call AnimateTilesetImpl
	pop af
	jp Bankswitch
; 0x1531

EnableSprites:: ; 1531 (0:1531)
	nop
	ld hl, rLCDC
	set rLCDC_SPRITES_ENABLE, [hl]
	ret
; 0x1538

TransferToolgearRow: ; 1538 (0:1538)
; TransferToolgearRow
; Copy second line of toolgear to window
	ld a, [wToolgearFlags]
	bit 0, a
	ret z
	bit 7, a
	ret nz
	bit 2, a
	res 2, a
	ret z
	ld [wToolgearFlags], a
	ld [hSPTemp], sp
	bgcoord hl, 0, 1, wToolgearBuffer
	ld sp, hl
	bgcoord hl, 0, 1, vBGMap1
	ld a, $01
	jp TransferBgRows

VBlankCopyFar:: ; 1558 (0:1558)
; Copy 0x10 * [wVBCopyFarSize] bytes
; from wVBCopyFarSrcBank::wVBCopyFarSrc to wVBCopyFarDst.
; wVBCopyFarDst must be aligned to 0x10 bytes.

; Source and destination addresses are updated,
; so transfer can continue in subsequent calls.
	ld a, [wVBCopyFarSize]
	and a
	ret z
	ld a, [wVBCopyFarSrcBank]
	call Bankswitch
	ld [hSPTemp], sp
	ld hl, wVBCopyFarSrc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld sp, hl
	ld hl, wVBCopyFarDst
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wVBCopyFarSize]
	ld b, a
	xor a
	ld [wVBCopyFarSize], a
.loop
	rept 16/2 - 1 ; 16 bytes per transfer at 2 bytes per pop
	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc l
	endr

	pop de
	ld [hl], e
	inc l
	ld [hl], d
	inc hl
	dec b
	jr nz, .loop
	ld [wVBCopyFarSrc], sp
	ld sp, hl
	ld [wVBCopyFarDst], sp
	ldh a, [hSPTemp]
	ld l, a
	ldh a, [hSPTemp + 1]
	ld h, a
	ld sp, hl
	ret
; 0x15b5
