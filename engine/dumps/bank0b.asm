INCLUDE "constants.asm"

SECTION "engine/dumps/bank0b.asm", ROMX

ShowItemDescription::
	push de
	ld hl, ItemDescriptions
	ld a, [wSelectedItem]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/items/descriptions.inc"

Function2d2fc:
	ld a, $1
	ldh [hInMenu], a
	call sub_2d436
	ld a, $0
	ldh [hInMenu], a
	ret nc
	call PlaceHollowCursor
	call WaitBGMap
	ld a, $1
	ldh [hBGMapMode], a
	ld a, [wCurItem]
	cp $3a
	ret nc
	ld [wce37], a
	ld a, $1b
	call Predef
	ld a, [wce37]
	ld [wce32], a
	call Unreferenced_GetMoveName
	call CopyStringToStringBuffer2
	ld hl, text_2d3bf
	call PrintText
	ld hl, text_2d3d9
	call PrintText
	call YesNoBox
	jp c, asm_2d3a8

asm_2d33e:
	ld hl, wStringBuffer2
	ld de, wcd1d
	ld bc, $8
	call CopyBytes
	ld hl, wVramState
	res 0, [hl]
	ld a, $3
	ld [wPartyMenuActionText], a
	ld a, $36
	call Predef
	push af
	ld hl, wcd1d
	ld de, wStringBuffer2
	ld bc, $8
	call CopyBytes
	pop af
	jr nc, asm_2d36c
	jp asm_2d3ad

asm_2d36c:
	ld a, $1a
	call Predef
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc
	ld a, c
	and a
	jr nz, asm_2d390
	push de
	ld de, $14
	call PlaySFX
	pop de
	ld hl, text_2d404
	call PrintText
	jr asm_2d33e

asm_2d390:
	callfar Functionfdab
	jr c, asm_2d33e
	ld a, $0
	call Predef
	ld a, b
	and a
	jr z, asm_2d3a8
	call sub_2d64e
	jr asm_2d3ad

asm_2d3a8:
	ld a, $2
	ld [wFieldMoveSucceeded], a

asm_2d3ad:
	call ClearBGPalettes
	call ClearSprites
	ld hl, wVramState
	set 0, [hl]
	call Function360b
	call GetMemSGBLayout
	ret

text_2d3bf:
	text "<TM>を　きどうした！"
	prompt
	text "ひでんマシンを　きどうした！"

text_2d3d9:
	text "なかには　@"
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"
	para "@"
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

text_2d404:
	text_from_ram wStringBuffer1
	text "と　@"
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"
	para "@"
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt
	db $02, $04, $00, $01
	db $0c, $20
	db $c3

sub_2d436:
	xor a
	ldh [hBGMapMode], a
	call sub_2d577
	ld a, $2
	ld [w2DMenuCursorInitY], a
	ld a, $4
	ld [w2DMenuCursorInitY + 1], a
	ld a, $1
	ld [w2DMenuNumCols], a
	ld a, $4
	sub d
	inc a
	cp $5
	jr nz, asm_2d454
	dec a

asm_2d454:
	ld [w2DMenuNumRows], a
	ld a, $c
	ld [w2DMenuFlags], a
	xor a
	ld [w2DMenuFlags + 1], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, $c3
	ld [w2DMenuCursorOffsets + 1], a
	ld a, [wcd42]
	inc a
	ld [wMenuCursorY], a
	ld a, $1
	ld [wMenuCursorX], a
	jr asm_2d4a3

asm_2d478:
	call sub_2d577

asm_2d47b:
	call WaitBGMap
	ld a, $1
	ldh [hBGMapMode], a
	call Get2DMenuJoypad
	ld b, a
	ld a, [wMenuCursorY]
	dec a
	ld [wcd42], a
	xor a
	ldh [hBGMapMode], a
	ld a, [w2DMenuFlags + 1]
	bit 7, a
	jp nz, asm_2d537
	ld a, b
	bit 0, a
	jp nz, sub_2d51a
	bit 1, a
	jp nz, asm_2d535

asm_2d4a3:
	call sub_2d51a
	ld hl, $c368
	ld b, $6
	ld c, $12
	call DrawTextBox
	call UpdateSprites
	ld a, [wCurItem]
	cp $3a
	jr nc, asm_2d47b
	ld [wce37], a
	ld hl, $c391
	ld de, string_2d572
	call PlaceString
	ld a, $1b
	call Predef
	ld a, [wce37]
	ld [wCurSpecies], a
	ld b, a
	ld hl, $c395
	predef PrintMoveType
	ld hl, $c3b9
	call Function2d663
	ld hl, $c39b
	ld de, string_2d568
	call PlaceString
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld hl, $c3a0
	cp $2
	jr c, asm_2d511
	ld [wce37], a
	ld de, wce37
	ld bc, $103
	call PrintNumber
	jp asm_2d478

asm_2d511:
	ld de, string_2d56e
	call PlaceString
	jp asm_2d478

sub_2d51a:
	call sub_2d5f8
	ld a, [wMenuCursorY]
	ld b, a

asm_2d521:
	inc c
	ld a, c
	cp $3a
	jr nc, asm_2d52f
	ld a, [hli]
	and a
	jr z, asm_2d521
	dec b
	jr nz, asm_2d521
	ld a, c

asm_2d52f:
	ld [wCurItem], a
	cp $ff
	ret

asm_2d535:
	and a
	ret

asm_2d537:
	ld a, b
	bit 7, a
	jr nz, asm_2d54b
	ld hl, wcd47
	ld a, [hl]
	and a
	jp z, asm_2d478
	dec [hl]
	call sub_2d577
	jp asm_2d4a3

asm_2d54b:
	call sub_2d5f8
	ld b, $5

asm_2d550:
	inc c
	ld a, c
	cp $3a
	jp nc, asm_2d478
	ld a, [hli]
	and a
	jr z, asm_2d550
	dec b
	jr nz, asm_2d550
	ld hl, wcd47
	inc [hl]
	call sub_2d577
	jp asm_2d4a3

string_2d568:
	db "いりょく／@"

string_2d56e:
	db "ーーー@"

string_2d572:
	db "タイプ／@"

sub_2d577:
	ld hl, $c2a3
	ld b, $8
	ld c, $f
	call DrawTextBox
	call sub_2d5f8
	ld d, $4

asm_2d586:
	inc c
	ld a, c
	cp $3a
	jr nc, asm_2d5dd
	ld a, [hli]
	and a
	jr z, asm_2d586
	ld b, a
	ld a, c
	ld [wce37], a
	push hl
	push de
	push bc
	call sub_2d5e9
	push hl
	ld de, wce37
	ld bc, $8102
	call PrintNumber
	ld a, $1b
	call Predef
	ld a, [wce37]
	ld [wce32], a
	call Unreferenced_GetMoveName
	pop hl
	ld bc, $3
	add hl, bc
	push hl
	call PlaceString
	pop hl
	ld bc, $8
	add hl, bc
	ld [hl], $f1
	inc hl
	ld a, $f6
	pop bc
	push bc
	ld a, b
	ld [wce37], a
	ld de, wce37
	ld bc, $102
	call PrintNumber
	pop bc
	pop de
	pop hl
	dec d
	jr nz, asm_2d586
	jr asm_2d5e8

asm_2d5dd:
	call sub_2d5e9
	ld a, $d4
	ld [hli], a
	ld a, $d2
	ld [hli], a
	ld [hl], $d9

asm_2d5e8:
	ret

sub_2d5e9:
	ld hl, $c2a5
	ld bc, $28
	ld a, $5
	sub d
	ld d, a

asm_2d5f3:
	add hl, bc
	dec d
	jr nz, asm_2d5f3
	ret

sub_2d5f8:
	ld hl, wTMsHMs
	ld a, [wcd47]
	ld b, a
	inc b
	ld c, $0

asm_2d602:
	inc c
	ld a, [hli]
	and a
	jr z, asm_2d602
	dec b
	jr nz, asm_2d602
	dec hl
	dec c
	ret
	call sub_2d63c
	ld hl, text_2d61b
	jr nc, asm_2d618
	ld hl, text_2d62f

asm_2d618:
	jp PrintText

text_2d61b:
	text_from_ram wStringBuffer1
	text "は　これいじょう"
	line "もてません！"
	prompt

text_2d62f:
	text_from_ram wStringBuffer1
	text "を　てにいれた！"
	prompt

sub_2d63c:
	ld a, [wCurItem]
	dec a
	ld hl, wTMsHMs
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	inc a
	cp $a
	ret nc
	ld [hl], a
	ret

sub_2d64e:
	ld a, [wCurItem]
	dec a
	ld hl, wTMsHMs
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	and a
	ret z
	dec a
	ld [hl], a
	ret nz
	ld [wcd47], a
	ret

Function2d663:
	push hl
	ld hl, MoveDescriptions
	ld a, [wCurSpecies]
	dec a
	ld c, a
	ld b, $0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld e, a
	ld d, [hl]
	pop hl
	jp PlaceString

INCLUDE "data/moves/descriptions.inc"
