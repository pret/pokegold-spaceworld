INCLUDE "constants.asm"

SECTION "Video Copy functions", ROM0[$0D02]

Function0d02::
	jpab Function14000

LoadFont:: ; 00:0d0a
	jpab LoadFontGraphics

LoadFontsBattleExtra::
	jpab LoadPokemonMenuGraphics

LoadFontExtra:: ; 00:0d1a
	jpab LoadFontExtraGraphicsWithCursor

LoadToolgearGraphics::
	jpab LoadToolgearGraphicsDebug

FarCopyData: ; d2a (0:d2a)
; Identical to FarCopyBytes except for tail call optimization
; Copy bc 2bpp bytes from a:hl to de.
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	call Bankswitch
	call CopyBytes
	pop af
	call Bankswitch
	ret

FarCopyDataDouble: ; d3e (0:d3e)
; Copy and expand bc 1bpp bytes from a:hl to de.
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

Request2bpp:: ; d68 (0:d68)
; Wait for the next VBlank, then copy c 2bpp
; tiles from b:de to hl, 8 tiles at a time.
; This takes c/8 frames.
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
	cp $8
	jr nc, .keepgoing
	ld [wVBCopySize], a
	call DelayFrame
	pop af
	call Bankswitch
	pop af
	ldh [hBGMapMode], a
	ret
.keepgoing
	ld a, $8
	ld [wVBCopySize], a
	call DelayFrame
	ld a, c
	sub $8
	ld c, a
	jr .loop

Request1bpp:: ; da6 (0:da6)
; Wait for the next VBlank, then copy c 1bpp
; tiles from b:de to hl, 8 tiles at a time.
; This takes c/8 frames.
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
	cp $8
	jr nc, .keepgoing
	ld [wVBCopyDoubleSize], a
	call DelayFrame
	pop af
	call Bankswitch
	pop af
	ldh [hBGMapMode], a
	ret
.keepgoing
	ld a, $8
	ld [wVBCopyDoubleSize], a
	call DelayFrame
	ld a, c
	sub $8
	ld c, a
	jr .loop

Get2bpp:: ; de4 (0:de4)
; Copy c 2bpp tiles from b:de to hl in VRAM
; using VBlank service or direct copy in
; case LCD is off
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jp nz, Request2bpp ; copy video data during vblank while screen is on
Copy2bpp:: ; 0deb
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

Get1bpp: ; dff (0:dff)
; Copy c 1bpp tiles from b:de to hl in VRAM
; using VBlank service or direct copy in
; case LCD is off
	ldh a, [rLCDC]
	bit rLCDC_ENABLE, a
	jp nz, Request1bpp
Copy1bpp:: ; 0e06
	push de
	ld d, h
	ld e, l
	ld a, b
	push af
	ld h, 0
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
