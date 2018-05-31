INCLUDE "constants.asm"

SECTION "Video Copy functions", ROM0[$0D2A]

; Identical to FarCopyBytes except for tail call optimization
; Copy bc 2bpp bytes from a:hl to de.
FarCopyData: ; d2a (0:d2a)
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	call CopyBytes
	pop af
	call Bankswitch
	ret

; Copy and expand bc 1bpp bytes from a:hl to de.
FarCopyDataDouble: ; d3e (0:d3e)
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	ld a, h
	ld h, d
	ld d, a
	ld a, l
	ld l, e
	ld e, a
	ld a, b
	and a
	jr z, .copy_small
	ld a, c
	and a
	jr z, .next
.copy_small
	inc b
.next
	ld a, [de]
	inc de
	ld [hli], a
	ld [hli], a
	dec c
	jr nz, .next
	dec b
	jr nz, .next
	pop af
	call Bankswitch
	ret

; Wait for the next VBlank, then copy c 2bpp
; tiles from b:de to hl, 8 tiles at a time.
; This takes c/8 frames.
CopyVideoData:: ; d68 (0:d68)
	ldh a, [hBGMapMode]
	push af
	xor a ; disable auto-transfer while copying
	ldh [hBGMapMode], a
	ldh a, [hROMBank]
	push af
	ld a, b
	call Bankswitch
	ld a, e
	ld [wVBCopySrc], a
	ld a, d
	ld [wVBCopySrc + 1], a
	ld a, l
	ld [wVBCopyDst], a
	ld a, h
	ld [wVBCopyDst + 1], a
.loop
	ld a, c
	cp $08
	jr nc, .keepgoing
	ld [wVBCopySize], a
	call DelayFrame
	pop af
	call Bankswitch
	pop af
	ldh [hBGMapMode], a
	ret
.keepgoing
	ld a, $08
	ld [wVBCopySize], a
	call DelayFrame
	ld a, c
	sub $08
	ld c, a
	jr .loop

; Wait for the next VBlank, then copy c 1bpp
; tiles from b:de to hl, 8 tiles at a time.
; This takes c/8 frames.
CopyVideoDataDouble:: ; da6 (0:da6)
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh a, [hROMBank]
	push af
	ld a, b
	call Bankswitch
	ld a, e
	ld [wVBCopyDoubleSrc], a
	ld a, d
	ld [wVBCopyDoubleSrc + 1], a
	ld a, l
	ld [wVBCopyDoubleDst], a
	ld a, h
	ld [wVBCopyDoubleDst + 1], a
.loop
	ld a, c
	cp $08
	jr nc, .keepgoing
	ld [wVBCopyDoubleSize], a
	call DelayFrame
	pop af
	call Bankswitch
	pop af
	ldh [hBGMapMode], a
	ret
.keepgoing
	ld a, $08
	ld [wVBCopyDoubleSize], a
	call DelayFrame
	ld a, c
	sub $08
	ld c, a
	jr .loop

; Copy c 2bpp tiles from b:de to hl in VRAM
; using VBlank service or direct copy in
; case LCD is off
CopyVideoDataOptimized:: ; de4 (0:de4)
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jp nz, CopyVideoData ; copy video data during vblank while screen is on
	push hl              ; convert to FarCopyData call
	ld h, d
	ld l, e
	pop de
	ld a, b
	push af
	swap c
	ld a, $0f
	and c
	ld b, a
	ld a, $f0
	and c
	ld c, a
	pop af
	jp FarCopyData

; Copy c 1bpp tiles from b:de to hl in VRAM
; using VBlank service or direct copy in
; case LCD is off
CopyVideoDataDoubleOptimized: ; dff (0:dff)
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jp nz, CopyVideoDataDouble
	push de
	ld d, h
	ld e, l
	ld a, b
	push af
	ld h, $00
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	ld b, h
	ld c, l
	pop af
	pop hl
	jp FarCopyDataDouble
; 0xe18