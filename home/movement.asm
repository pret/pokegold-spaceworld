INCLUDE "constants.asm"

SECTION "home/movement.asm", ROM0

InitMovementBuffer::
	ld [wMovementBufferObject], a
	xor a
	ld [wMovementBufferCount], a
	ld a, BANK(wMovementBuffer)
	ld [wMovementBufferPointerBank], a
	ld a, LOW(wMovementBuffer)
	ld [wMovementBufferPointerAddr], a
	ld a, HIGH(wMovementBuffer)
	ld [wMovementBufferPointerAddr + 1], a
	ret

DecrementMovementBufferCount::
	ld a, [wMovementBufferCount]
	and a
	ret z
	dec a
	ld [wMovementBufferCount], a
	ret

AppendToMovementBuffer:: ; 00:19f2
	push hl
	push de
	ld hl, wMovementBufferCount
	ld e, [hl]
	inc [hl]
	ld d, $0
	ld hl, wMovementBuffer
	add hl, de
	ld [hl], a
	pop de
	pop hl
	ret

AppendToMovementBufferNTimes:: ; 00:1a03
	push af
	ld a, c
	and a
	jr nz, .asm_1a0a
	pop af
	ret

.asm_1a0a: ; 00:1a0a
	pop af
.asm_1a0b: ; 00:1a0b
	call AppendToMovementBuffer
	dec c
	jr nz, .asm_1a0b
	ret

ComputePathToWalkToPlayer::
	push af
	ld a, b
	sub d
	ld h, LEFT
	jr nc, .asm_1a1d
	dec a
	cpl
	ld h, RIGHT
.asm_1a1d: ; 00:1a1d
	ld d, a
	ld a, c
	sub e
	ld l, UP
	jr nc, .asm_1a28
	dec a
	cpl
	ld l, DOWN
.asm_1a28: ; 00:1a28
	ld e, a
	cp d
	jr nc, .asm_1a32
	ld a, h
	ld h, l
	ld l, a
	ld a, d
	ld d, e
	ld e, a
.asm_1a32: ; 00:1a32
	pop af
	ld b, a
	ld a, h
	call .GetMovementData
	ld c, d
	call AppendToMovementBufferNTimes
	ld a, l
	call .GetMovementData
	ld c, e
	call AppendToMovementBufferNTimes
	ret

.GetMovementData: ; 00:1a45
	push de
	push hl
	ld l, b
	ld h, $0
	add hl, hl
	add hl, hl
	ld e, a
	ld d, $0
	add hl, de
	ld de, .Data
	add hl, de
	ld a, [hl]
	pop hl
	pop de
	ret

.Data: ; 00:1a58
	db $04, $05, $06, $07
	db $08, $09, $0a, $0b
	db $0c, $0d, $0e, $0f
	
; 	slow_step DOWN
; 	slow_step UP
; 	slow_step LEFT
; 	slow_step RIGHT
; 	step DOWN
; 	step UP
; 	step LEFT
; 	step RIGHT
; 	big_step DOWN
; 	big_step UP
; 	big_step LEFT
; 	big_step RIGHT