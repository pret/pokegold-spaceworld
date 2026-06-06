INCLUDE "constants.asm"

SECTION "engine/tileset_anims.asm", ROMX

_AnimateTileset:
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
	
INCLUDE "data/tileset_anims.inc"

WaitTileAnimation:
; Do nothing this frame.
	ret

DoneTileAnimation:
; Reset the animation command loop.
	xor a
	ldh [hTileAnimFrame], a
	jp TransferToolgearRow

ScrollTileRightLeft:
	ld a, [wTileAnimationTimer]
	inc a
	and %111
	ld [wTileAnimationTimer], a
	and %100
	jr nz, ScrollTileLeft
	jr ScrollTileRight

ScrollTileLeft:
	ld h, d
	ld l, e
	ld c, 16 / 4
.loop
rept 4
	ld a, [hl]
	rlca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

ScrollTileRight:
	ld h, d
	ld l, e
	ld c, 16 / 4
.loop
rept 4
	ld a, [hl]
	rrca
	ld [hli], a
endr
	dec c
	jr nz, .loop
	ret

ScrollTileUp:
	ld h, d
	ld l, e
	ld d, [hl]
	inc hl
	ld e, [hl]
	ld bc, 16 - 2
	add hl, bc
	ld a, 16 / 4
.loop
	ld c, [hl]
	ld [hl], e
	dec hl
	ld b, [hl]
	ld [hl], d
	dec hl
	ld e, [hl]
	ld [hl], c
	dec hl
	ld d, [hl]
	ld [hl], b
	dec hl
	dec a
	jr nz, .loop
	ret

ScrollTileDown:
	ld h, d
	ld l, e
	ld de, 16 - 2
	push hl
	add hl, de
	ld d, [hl]
	inc hl
	ld e, [hl]
	pop hl
	ld a, 16 / 4
.loop
	ld b, [hl]
	ld [hl], d
	inc hl
	ld c, [hl]
	ld [hl], e
	inc hl
	ld d, [hl]
	ld [hl], b
	inc hl
	ld e, [hl]
	ld [hl], c
	inc hl
	dec a
	jr nz, .loop
	ret

AnimateFlowerTile:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

;  A cycle of 2 frames, updating every other tick
	ld a, [wTileAnimationTimer]
	and %10
	ld hl, FlowerTileFrame1
	jr nz, .end
	ld hl, FlowerTileFrame2

.end
; Write the tile graphic from hl (now sp) to tile $38 (now hl)
	ld sp, hl
	ld hl, vTileset tile $38
	jr WriteTile
	
FlowerTileFrame1:
	INCBIN "gfx/tilesets/flower/flower1.2bpp"
FlowerTileFrame2:
	INCBIN "gfx/tilesets/flower/flower2.2bpp"

WriteTileFromAnimBuffer:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; Write the tile graphic from wTileAnimBuffer (now sp) to de (now hl)
	ld hl, wTileAnimBuffer
	ld sp, hl
	ld h, d
	ld l, e
	jr WriteTile

ReadTileToAnimBuffer:
; Save the stack pointer in bc for WriteTile to restore
	ld hl, sp+0
	ld b, h
	ld c, l

; Write the tile graphic from de (now sp) to wTileAnimBuffer (now hl)
	ld h, d
	ld l, e
	ld sp, hl
	ld hl, wTileAnimBuffer
	; fallthrough

WriteTile:
; Write one tile from sp to hl.
; The stack pointer has been saved in bc.

; This function cannot be called, only jumped to,
; because it relocates the stack pointer to quickly
; copy data with a "pop slide".

	pop de
	ld [hl], e
	inc hl
	ld [hl], d
rept (16 - 2) / 2
	pop de
	inc hl
	ld [hl], e
	inc hl
	ld [hl], d
endr

; Restore the stack pointer from bc
	ld h, b
	ld l, c
	ld sp, hl
	ret

