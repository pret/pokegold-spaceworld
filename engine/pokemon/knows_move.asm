INCLUDE "constants.asm"

SECTION "engine/pokemon/knows_move.asm", ROMX

KnowsMove:
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, KnowsMoveText
	call PrintText
	scf
	ret

KnowsMoveText:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Bank03_FillerStart::
Unreferenced_BootedHMTextfde0:
	db "います"
	prompt
; This is missing the preceeding "text_from_ram" byte
	dw wStringBuffer2
	text "を　おぼえています"
	prompt
	db $28, $3c

Unreferenced_KnowsMoveText_Old:
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .KnowsMoveText
	call PrintText
	scf
	ret

.KnowsMoveText
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Unreferenced_Fillerfe23:
	db $e0, $22, $47, $24, $80, $a3, $01, $50
	db $02, $85, $b0, $09, $35, $51, $2c, $08
	db $24, $25, $0b, $84, $84, $00, $4e, $3b
	db $4b, $02, $60, $2a, $26, $21, $01, $40
	db $10, $1f, $31, $44, $80, $08, $02, $3c
	db $41, $00, $68, $49, $57, $41, $94, $00
	db $34, $36, $9c, $e4, $01, $0c, $60, $01
	db $81, $23, $a2, $26, $43, $05, $81, $5f
	db $16, $a2, $80, $34, $0c, $82, $63, $91
	db $44, $52, $02, $ce, $00, $10, $44, $01
	db $96, $0e, $ac, $10, $23, $84, $28, $00
	db $22, $45, $22, $55, $00, $ef, $ff, $77
	db $5b, $fe, $87, $db, $df, $b5, $bf, $d7
	db $1f, $d9, $fc, $e9, $fd, $df, $79, $96
	db $7d, $af, $d7, $5e, $17, $37, $e7, $ef
	db $3e, $ff, $f9, $d4, $7d, $bf, $fb, $df
	db $bb, $fe, $db, $53, $fb, $cc, $d3, $fe
	db $92, $7f, $bb, $bc, $d7, $3b, $dd, $6f
	db $7b, $2f, $b7, $ff, $b9, $d0, $b7, $e5
	db $7b, $e0, $c7, $bf, $dd, $df, $6d, $bb
	db $f6, $f7, $73, $f9, $ff, $bc, $bb, $f7
	db $fd, $bd, $db, $e7, $be, $7b, $35, $5b
	db $f3, $98, $df, $f4, $2f, $fb, $ff, $6b
	db $fe, $ef, $6b, $ec, $1f, $7a, $3e, $ea
	db $9b, $dd, $df, $ed, $ff, $fe, $bf, $26
	db $7d, $9e, $ef, $be, $ff, $77, $fb, $ff
	db $ff, $5e, $f2, $bc, $fd, $7a, $aa, $fa
	db $af, $9d, $ed, $f1, $fd, $10, $10, $2d
	db $d1, $00, $21, $14, $d3, $1b, $27, $22
	db $85, $45, $5a, $43, $0c, $b1, $74, $61
	db $48, $40, $2f, $8c, $84, $08, $c2, $90
	db $f7, $44, $45, $80, $90, $12, $c5, $93
	db $1c, $11, $6e, $c8, $26, $25, $c1, $25
	db $00, $1e, $55, $02, $54, $04, $0f, $10
	db $20, $d7, $a2, $3c, $04, $3b, $02, $01
	db $22, $00, $c0, $00, $13, $d2, $05, $02
	db $48, $2a, $89, $40, $1f, $3e, $44, $12
	db $40, $16, $d8, $91, $10, $01, $54, $87
	db $1f, $99, $40, $d0, $79, $f8, $25, $4c
	db $d0, $a0, $02, $13, $1c, $02, $03, $11
	db $a0, $19, $06, $0e, $70, $97, $44, $0e
	db $11, $24, $0f, $80, $60, $06, $09, $01
	db $c5, $e1, $30, $13, $15, $14, $59, $02
	db $4c, $a9, $11, $08, $04, $eb, $df, $9d
	db $55, $ff, $b7, $57, $fb, $78, $7e, $7e
	db $c7, $3a, $e1, $ff, $5f, $7d, $5f, $fd
	db $5f, $f8, $6d, $2f, $bd, $75, $6f, $3f
	db $ff, $9f, $fc, $b5, $f6, $c5, $14, $fa
	db $d9, $ff, $9d, $fb, $7f, $f3, $ff, $6b
	db $fb, $9f, $eb, $5f, $df, $de, $ed, $bf
	db $7f, $59, $26, $df, $ee, $b3, $5f, $fd
	db $f7, $ff, $ff, $ff, $5b, $f8, $db, $fa
	db $7f, $de, $af, $5f, $df, $9f, $d8, $be
	db $ea, $bf, $fe, $eb, $dd, $eb, $f9, $e5
	db $bd, $f3, $ff, $fe, $ff, $f7, $f7, $d5
	db $f5, $f9, $5f, $bf, $fd, $5e, $df, $de
	db $ff, $bf, $bb, $93, $fc, $ff, $cc, $af
	db $f5, $d7, $7f, $ff, $fe, $b5, $ff, $9f
	db $95, $7a, $6b, $7b, $ff, $6f, $bb, $c7
	db $ef, $34, $ff, $d7, $3d
