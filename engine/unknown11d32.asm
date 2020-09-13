INCLUDE "constants.asm"

SECTION "engine/unknown11d32.asm", ROMX

Unknown11d32: ; 04:5D32
	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .upJump
	ld a, [hl] 
	and D_DOWN
	jr nz, .downJump
	ld a, [hl]
	and D_LEFT
	jr nz, .leftJump
	ld a, [hl] 
	and D_RIGHT
	jr nz, .rightJump
	ret
	
.rightJump; 04:5D4A
	ld hl, $000C
	add hl, bc
	ld a, [hl]
	cp $0D
	jr nc, .skip
	inc [hl]
	jr .escape
.skip
	ld [hl], 0
	jr .escape
.leftJump
	ld hl, $000C
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip2
	dec [hl]
	jr .escape
.skip2
	ld [hl], $0D
	jr .escape
.downJump
	ld hl, $000D
	add hl, bc
	ld a, [hl]
	cp 4
	jr nc, .skip3
	inc [hl]
	jr .escape
.skip3
	ld [hl], 00
	jr .escape
.upJump
	ld hl, $000D
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip4
	dec [hl]
	jr .escape
.skip4
	ld [hl], 4
	jr .escape
.escape
	ld hl, $000C
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Offsets1
	add hl, de
	ld a, [hl]
	ld hl, $0006
	add hl, bc
	ld [hl], a
	ld hl, $000D
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Offsets2
	add hl, de
	ld a, [hl]
	ld hl, $0007
	add hl, bc
	ld [hl], a
	ret
	
.Offsets1: ; 04:5DAB
	db $00, $08, $10, $18, $20, $28, $30, $48, $50, $58, $60, $68, $70, $78 
	
.Offsets2: ; 04:5DB9
	db $00, $08, $18, $20, $30
