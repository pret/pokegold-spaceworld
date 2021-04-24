INCLUDE "constants.asm"

SECTION "engine/games/picross_minigame.asm", ROMX

; PicrossSprites constants
	const_def
	const PATTERN_NORMAL
	const PATTERN_TILESET    ; The bottom part's data is offset by $100

PicrossMinigame:
	call .Init
	call DelayFrame

.loop:
	call .GameLoop
	jr nc, .loop
	call ClearJoypad
	ret

.Init:
	call DisableLCD
	ld a, BANK(InitEffectObject)
	ld hl, InitEffectObject
	call FarCall_hl
	call .InitGFX
	call .PlacePlayerBG
	call .InitRAM

	ld de, $4040
	ld a, $33
	call InitSpriteAnimStruct

	ld a, c
	ld [wPicrossCursorSpritePointer], a
	ld a, b
	ld [wPicrossCursorSpritePointer+1], a

	depixel 5, 4, 4, 4
	ld a, $35
	call InitSpriteAnimStruct
	
	ld a, $FF
	ld [wPicrossCurrentTileType], a
	call PicrossMinigame_InitPicrossTable
	call PicrossMinigame_InitPicrossDigits
	
	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ld [rWY], a
	ld [wJumptableIndex], a
	
	ld a, 1
	ldh [hBGMapMode], a
	
	ld a, %11100011
	ld [rLCDC], a
	ld a, %11100100
	ld [rBGP], a
	ld a, %11010000
	ld [rOBP0], a
	
	xor a
	ld [wPicrossCurrentTileType], a
	ret

.InitGFX:
	ld hl, PicrossBackgroundGFX
	ld de, $8800
	ld bc, $40
	ld a, BANK(PicrossBackgroundGFX)
	call FarCopyData
	ld de, $8840
	ld b, 4

.column_outer_loop
	push bc
	ld b, 4

.column_inner_loop
	push bc
	ld hl, PicrossColumnsGFX
	ld bc, $30
	ld a, BANK(PicrossColumnsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .column_inner_loop
	pop bc
	dec b
	jr nz, .column_outer_loop
	ld de, $8B40
	ld b, 4

.row_outer_loop
	push bc
	ld b, 3

.row1:
	push bc
	ld hl, PicrossRow1GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row1
	ld b, 3

.row2:
	push bc
	ld hl, PicrossRow2GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row2
	ld b, 3

.row3:
	push bc
	ld hl, PicrossRow3GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row3
	ld b, 2

.row4:
	push bc
	ld hl, PicrossRow1GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row4
	ld b, 2

.row5:
	push bc
	ld hl, PicrossRow2GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row5
	ld b, 2

.row6:
	push bc
	ld hl, PicrossRow3GFX
	ld bc, $10
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .row6
	pop bc
	dec b
	jr nz, .row_outer_loop
	ld de, $8F00
	ld b, $10

.load_grid:
	push bc
	ld hl, PicrossGridGFX
	ld bc, $90
	ld a, $38
	call FarCopyData
	pop bc
	dec b
	jr nz, .load_grid
	ld de, $8000
	ld hl, PicrossCursorGFX
	ld bc, $90
	ld a, $38
	call FarCopyData
	ld de, $8100
	ld hl, $4040 ; GoldSpriteGFX tile 4
	ld bc, $40 	; 4 tiles
	ld a, $30
	call FarCopyData
	ld de, $8140
	ld hl, $4100 ; GoldSpriteGFX tile $10
	ld bc, $40
	ld a, $30
	call FarCopyData
	ld a, $25
	ld hl, wSpriteAnimDict
	ldi [hl], a
	ld [hl], 0
	inc hl
	ld a, $22
	ldi [hl], a
	ld [hl], $10
	ret

.PlacePlayerBG:
	ld hl, $C2A0
	ld bc, $168
	ld a, $80
	call ByteFill
	ld hl, $C2B5
	ld bc, 5
	ld a, $81
	call ByteFill
	ld hl, $C2C9
	ld bc, 5
	ld a, $81
	call ByteFill
	ld hl, $C2DD
	ld bc, 5
	ld a, $82
	call ByteFill
	ld hl, $C2F1
	ld bc, 5
	ld a, $83
	call ByteFill
	ret

.InitRAM:
	ld hl, wPicrossMarkedTiles
	ld bc, $514
	xor a
	call ByteFill
	ret

.GameLoop:
	call .GetJoypadState
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .quit
	call .ExecuteJumptable
	ld a, $23 ; '#'
	ld hl, EffectObjectJumpNoDelay
	call FarCall_hl
	call DelayFrame
	and a
	ret

.quit:
	scf
	ret

.GetJoypadState:
	call GetJoypadDebounced
	ldh a, [hJoyState]
	ld [wc606], a
	ld hl, wc607
	ld a, [hl]
	and a
	ret z
	dec [hl]
	xor a
	ld [wc606], a
	ret

.ExecuteJumptable:
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw .InitMode
	dw .RunMode
	dw .ExitMode

.InitMode:
	call .PlaceBGMapTiles
	ld hl, wJumptableIndex
	inc [hl]
	ret

.RunMode:
	call PicrossMinigame_CheckPuzzleSolved
	jr c, .solved
	call PicrossMinigame_ProcessJoypad
	ret

.solved
	ld hl, wPicrossCursorSpritePointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, 0
	add hl, bc
	ld [hl], 0
	ld hl, wJumptableIndex
	inc [hl]

.ExitMode:
	ldh a, [hJoyDown]
	and START
	ret z
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.PlaceBGMapTiles:
	xor a
	ldh [hBGMapMode], a
	call .PlacePlayerBG
	call .PlaceColumnNumbers
	call .PlaceRowNumbers
	call .PlaceTable
	call .HandleError
	ld a, 1
	ldh [hBGMapMode], a
	ret

.PlaceTable:
	ld hl, .TableCoords
	ld c, $10
	ld a, $F0

.place_table_loop
	push bc
	push hl
	ld e, [hl]
	inc hl
	ld h, [hl]
	ld l, e
	call .PlaceTableTile
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .place_table_loop
	ret

.PlaceTableTile:
	ld de, $14
	ld b, 3

.place_table_outerloop
	push hl
	ld c, 3

.place_table_innerloop
	ldi [hl], a
	inc a
	dec c
	jr nz, .place_table_innerloop
	pop hl
	add hl, de
	dec b
	jr nz, .place_table_outerloop
	ret

.TableCoords:
	dwcoord 7, 6
	dwcoord 10, 6
	dwcoord 13, 6
	dwcoord 16, 6
	dwcoord 7, 9
	dwcoord 10, 9
	dwcoord 13, 9
	dwcoord 16, 9
	dwcoord 7, 12
	dwcoord 10, 12
	dwcoord 13, 12
	dwcoord 16, 12
	dwcoord 7, 15
	dwcoord 10, 15
	dwcoord 13, 15
	dwcoord 16, 15

.PlaceColumnNumbers:
	hlcoord 7, 1
	ld b, 4
	ld a, $84

.column_numbers_outer_loop
	push hl
	ld de, $12
	ld c, 4

.column_numbers_inner_loop
	ldi [hl], a
	inc a
	ldi [hl], a
	inc a
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .column_numbers_inner_loop
	pop hl
	inc hl
	inc hl
	inc hl
	dec b
	jr nz, .column_numbers_outer_loop
	ret

.PlaceRowNumbers:
	hlcoord 1, 6
	ld b, 4
	ld a, $B4

.row_numbers_loop1
	push hl
	push hl
	ld de, $12
	ld c, 3

.row_numbers_loop2
	ldi [hl], a
	inc a
	ldi [hl], a
	inc a
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .row_numbers_loop2
	pop hl
	inc hl
	inc hl
	inc hl
	ld de, $13
	ld c, 3

.row_numbers_loop3
	ldi [hl], a
	inc a
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .row_numbers_loop3
	pop hl
	ld de, $3C
	add hl, de
	dec b
	jr nz, .row_numbers_loop1
	ret

.HandleError:
	ld a, [wPicrossErrorCheck]
	and a
	ret z

; If something's gone wrong, print a big ol' "ERROR" in
; the middle of the game display.
	ld hl, .ErrorBitmap
	decoord 0, 9
	ld c, $64

.print_message:
	ldi a, [hl]
	add a, $80
	ld [de], a
	inc de
	dec c
	jr nz, .print_message
	ret
; End of function .HandleError

.ErrorBitmap:
	db 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 0, 0
	db 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
	db 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0, 0
	db 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0
	db 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0

PicrossMinigame_CheckPuzzleSolved:
	ld de, wPicrossBitmap
	ld hl, wPicrossMarkedTiles
	ld c, 0

.loop
	ld a, [de]
	and a
	jr z, .skip
	ld a, [hl]
	cp 1
	jr nz, .unsolved
	jr .continue

.skip
	ld a, [hl]
	cp 1
	jr z, .unsolved

.continue
	inc hl
	inc de
	dec c
	jr nz, .loop

; Puzzle is considered solved
	scf
	ret

.unsolved
	and a
	ret

PicrossMinigame_ProcessJoypad:
	ld hl, hJoySum
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed
	ret

.b_pressed
	ld a, 1
	jr .mark_tile

.a_pressed
	xor a

.mark_tile
	ld [wPicrossJoypadAction], a
	ld a, 1
	ld [wca59], a
	call PicrossMinigame_DetermineTileCoord
	call PicrossMinigame_MarkTile
	call PicrossMinigame_InitDustObject
	ret

PicrossMinigame_InitDustObject:
	ld hl, wPicrossCursorSpritePointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld e, [hl]
	inc e
	inc e
	inc e
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld d, [hl]
	inc d
	inc d
	ld a, [wPicrossCurrentTileType]
	cp 1
	ret nz

; Make dust object only if we are marking a tile
	ld a, $34
	call InitSpriteAnimStruct
	ret

PicrossMinigame_DetermineTileCoord:
	ld hl, wPicrossCursorSpritePointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	sub $40
	call PicrossMinigame_WriteXTileCoords
	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $40
	call PicrossMinigame_WriteYTileCoords
	ret

PicrossMinigame_WriteXTileCoords:
	cp $48
	jr nc, loc_386C61
	cp $30
	jr nc, loc_386C58
	cp $18
	jr nc, loc_386C4F

; first part
	call sub_386CA8
	ld a, 0
	jr loc_386C68

loc_386C4F:
	sub $18
	call sub_386CA8
	ld a, 1
	jr loc_386C68

loc_386C58:
	sub $30
	call sub_386CA8
	ld a, 2
	jr loc_386C68

loc_386C61:
	sub $48
	call sub_386CA8
	ld a, 3

loc_386C68:
	ld [$C602], a
	ret

PicrossMinigame_WriteYTileCoords:
	cp $48
	jr nc, loc_386C9A
	cp $30
	jr nc, loc_386C8E
	cp $18
	jr nc, loc_386C82
	call sub_386CC6
	ld a, [$C602]
	add a, 0
	jr loc_386CA4

loc_386C82:
	sub $18
	call sub_386CC6
	ld a, [$C602]
	add a, 4
	jr loc_386CA4

loc_386C8E:
	sub $30
	call sub_386CC6
	ld a, [$C602]
	add a, 8
	jr loc_386CA4

loc_386C9A:
	sub $48
	call sub_386CC6
	ld a, [$C602]
	add a, $C

loc_386CA4:
	ld [$C602], a
	ret

sub_386CA8:
	cp $12
	jr z, loc_386CC0
	cp $C
	jr z, loc_386CBC
	cp 6
	jr z, loc_386CB8
	ld a, 0
	jr loc_386CC2

loc_386CB8:
	ld a, 1
	jr loc_386CC2

loc_386CBC:
	ld a, 2
	jr loc_386CC2

loc_386CC0:
	ld a, 3

loc_386CC2:
	ld [$C603], a
	ret

sub_386CC6:
	cp $12
	jr z, loc_386CE7
	cp $C
	jr z, loc_386CE0
	cp 6
	jr z, loc_386CD9
	ld a, [$C603]
	add a, 0
	jr loc_386CEC

loc_386CD9:
	ld a, [$C603]
	add a, 4
	jr loc_386CEC

loc_386CE0:
	ld a, [$C603]
	add a, 8
	jr loc_386CEC

loc_386CE7:
	ld a, [$C603]
	add a, $C

loc_386CEC:
	ld [$C603], a
	ret

PicrossMinigame_MarkTile:
	call PicrossMinigame_SetTargetTileType
	ld hl, $8F00

; space between each grid tileset
	ld de, 144
	ld a, [wPicrossCurrentGridNumber]

loc_386CFC:
	and a
	jr z, loc_386D03
	dec a
	add hl, de
	jr loc_386CFC

loc_386D03:
	push hl
	ld e, l
	ld d, h
	ld hl, wPicrossRowGFX2bppBuffer
	ld c, 9
	ld b, $38 ; '8'
	call Request2bpp
	call PicrossMinigame_SetMarkedTileGFX
	pop hl
	ld de, wPicrossRowGFX2bppBuffer
	ld c, 9
	ld b, $38 ; '8'
	call Request2bpp
	ret

PicrossMinigame_SetTargetTileType:
	ld a, [wPicrossCurrentGridNumber]
	ld d, a
	and $C
	swap a
	ld e, a
	ld a, d
	and 3
	sla a
	sla a
	or e
	ld e, a
	ld a, [wPicrossCurrentTileNumber]
	ld d, a
	and $C
	sla a
	sla a
	or e
	ld e, a
	ld a, d
	and 3
	or e
	ld e, a
	ld d, 0
	ld hl, wPicrossMarkedTiles
	add hl, de
	ldh a, [hJoypadState]
	and %11111100
	jr z, loc_386D53
	ld a, [wPicrossCurrentTileType]
	ld [hl], a
	ret

loc_386D53:
	ld a, [wPicrossJoypadAction]
	and a
	jr z, loc_386D65
	ld a, [hl]
	cp B_BUTTON
	jr z, loc_386D71
	ld a, 2
	ld [wPicrossCurrentTileType], a
	ld [hl], a
	ret

loc_386D65:
	ld a, [hl]
	cp A_BUTTON
	jr z, loc_386D71
	ld a, 1
	ld [wPicrossCurrentTileType], a
	ld [hl], a
	ret

loc_386D71:
	xor a
	ld [wPicrossCurrentTileType], a
	ld [hl], a
	ret

PicrossMinigame_SetMarkedTileGFX:
	ld a, [wPicrossCurrentTileNumber]
	ld e, a
	ld d, 0
	ld hl, .BufferRoutineTable
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ldi a, [hl]
	ld [wPicrossBase2bppPointer], a
	ldi a, [hl]
	ld [wPicrossBase2bppPointer+1], a
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	jp hl

.BufferRoutineTable:
	dw $C958, PicrossMinigame_SetTileGFX_1
	dw $C958, PicrossMinigame_SetTileGFX_2
	dw $C968, PicrossMinigame_SetTileGFX_3
	dw $C978, PicrossMinigame_SetTileGFX_4
	dw $C958, PicrossMinigame_SetTileGFX_5
	dw $C958, PicrossMinigame_SetTileGFX_6
	dw $C968, PicrossMinigame_SetTileGFX_7
	dw $C978, PicrossMinigame_SetTileGFX_8
	dw $C988, PicrossMinigame_SetTileGFX_9
	dw $C988, PicrossMinigame_SetTileGFX_10
	dw $C998, PicrossMinigame_SetTileGFX_11
	dw $C9A8, PicrossMinigame_SetTileGFX_12
	dw $C9B8, PicrossMinigame_SetTileGFX_13
	dw $C9B8, PicrossMinigame_SetTileGFX_14
	dw $C9C8, PicrossMinigame_SetTileGFX_15
	dw $C9D8, PicrossMinigame_SetTileGFX_16

PicrossMinigame_InitPicrossTable:
	call Random
	and 3
	call PicrossMinigame_LoadLayout
	call PicrossMinigame_GoThroughLayout
	call PicrossMinigame_PopulateRAMBitmap
	ret

PicrossMinigame_PopulateRAMBitmap:
	ld de, wPicrossBitmap
	ld hl, wPicrossLayoutBuffer
	ld c, 8

.tiles:
	push bc
	push hl
	call PicrossMinigame_PopulateOneRow
	ld bc, $10
	add hl, bc
	call PicrossMinigame_PopulateOneRow
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .tiles
	ld hl, wPicrossLayoutBuffer2
	ld c, 8

.tiles2:
	push bc
	push hl
	call PicrossMinigame_PopulateOneRow
	ld bc, $10
	add hl, bc
	call PicrossMinigame_PopulateOneRow
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .tiles2
	ret

PicrossMinigame_PopulateOneRow:
	ld b, [hl]
	ld c, 8

.loop
	ld a, 0
	sla b
	rl a
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

PicrossMinigame_GoThroughLayout:
	ld hl, wPicrossLayoutBuffer - 1
	ld c, 32

.loop
	ldi a, [hl]
	and [hl]
	ldi [hl], a
	dec c
	jr nz, .loop
	ret

PicrossMinigame_InitPicrossDigits:
	call PicrossMinigame_InitDigitBuffer
	call PicrossMinigame_CountColumnDigits
	jr c, .errored
	
	call PicrossMinigame_ApplyColumnDigits
	call PicrossMinigame_InitDigitBuffer
	call PicrossMinigame_CountRowDigits
	jr c, .errored
	
	call PicrossMinigame_ApplyRowDigits
	xor a
	ld [wPicrossErrorCheck], a
	ret

.errored:
	ld a, 1
	ld [wPicrossErrorCheck], a
	ret

PicrossMinigame_InitDigitBuffer:
	ld hl, wPicrossNumbersBuffer
	ld c, 0
	ld a, $FF

.loop:
	ldi [hl], a
	dec c
	jr nz, .loop
	ret

PicrossMinigame_CountColumnDigits:
	ld hl, wPicrossBitmap
	ld de, wPicrossNumbersBuffer
	ld c, $10

.loop
	push bc
	push hl
	push de
	call .CountDigits
	jr nc, .error
	pop de
	ld hl, 5
	add hl, de
	ld e, l
	ld d, h
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	and a
	ret

.error
	pop de
	pop hl
	pop bc
	scf
	ret

.CountDigits:
	xor a
	ld [de], a
	ld b, 0
	ld c, $11

.loop1
	call .determine
	ret c
	and a
	jr z, .loop1
	xor a
	ld [de], a

.loop2
	ld a, [de]
	inc a
	ld [de], a
	call .determine
	ret c
	and a
	jr nz, .loop2
	inc de
	inc b
	ld a, b
	cp 5
	jr c, .loop1
	and a
	ret

.determine
	push de
	ld a, [hl]
	ld de, $10
	add hl, de
	pop de
	dec c
	jr z, .skip
	and a
	ret

.skip
	scf
	ret

PicrossMinigame_CountRowDigits:
	ld hl, wPicrossBitmap
	ld de, wPicrossNumbersBuffer
	ld c, $10

.loop
	push bc
	push hl
	push de
	call .CountDigits
	jr nc, .error
	pop de
	ld hl, 6
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld bc, $10
	add hl, bc
	pop bc
	dec c
	jr nz, .loop
	and a
	ret

.error
	pop de
	pop hl
	pop bc
	scf
	ret

.CountDigits:
	xor a
	ld [de], a
	ld b, 0
	ld c, 17

.loop1
	call .determine
	ret c
	and a
	jr z, .loop1
	xor a
	ld [de], a

.loop2
	ld a, [de]
	inc a
	ld [de], a
	call .determine
	ret c
	and a
	jr nz, .loop2
	inc de
	inc b
	ld a, b
	cp 6
	jr c, .loop1
	and a
	ret

.determine
	ldi a, [hl]
	dec c
	jr z, .skip
	and a
	ret

.skip
	scf
	ret


PicrossMinigame_ApplyColumnDigits:
	ld c, 80
	ld hl, PicrossMinigame_VRAMAndDigitRowPointers
	call PicrossMinigame_ApplyDigits
	ret

PicrossMinigame_VRAMAndDigitRowPointers:
	dw $8840, PicrossMinigame_SetTileGFX_1
	dw $8840, PicrossMinigame_SetTileGFX_5
	dw $8870, PicrossMinigame_SetTileGFX_9
	dw $88A0, PicrossMinigame_SetTileGFX_13
	dw $88D0, PicrossMinigame_SetTileGFX_1
	
	dw $8840, PicrossMinigame_SetTileGFX_2
	dw $8840, PicrossMinigame_SetTileGFX_6
	dw $8870, PicrossMinigame_SetTileGFX_10
	dw $88A0, PicrossMinigame_SetTileGFX_14
	dw $88D0, PicrossMinigame_SetTileGFX_2

	dw $8850, PicrossMinigame_SetTileGFX_3
	dw $8850, PicrossMinigame_SetTileGFX_7
	dw $8880, PicrossMinigame_SetTileGFX_11
	dw $88B0, PicrossMinigame_SetTileGFX_15
	dw $88E0, PicrossMinigame_SetTileGFX_3

	dw $8860, PicrossMinigame_SetTileGFX_4
	dw $8860, PicrossMinigame_SetTileGFX_8
	dw $8890, PicrossMinigame_SetTileGFX_12
	dw $88C0, PicrossMinigame_SetTileGFX_16
	dw $88F0, PicrossMinigame_SetTileGFX_4

	dw $8900, PicrossMinigame_SetTileGFX_1
	dw $8900, PicrossMinigame_SetTileGFX_5
	dw $8930, PicrossMinigame_SetTileGFX_9
	dw $8960, PicrossMinigame_SetTileGFX_13
	dw $8990, PicrossMinigame_SetTileGFX_1

	dw $8900, PicrossMinigame_SetTileGFX_2
	dw $8900, PicrossMinigame_SetTileGFX_6
	dw $8930, PicrossMinigame_SetTileGFX_10
	dw $8960, PicrossMinigame_SetTileGFX_14
	dw $8990, PicrossMinigame_SetTileGFX_2
	dw $8910, PicrossMinigame_SetTileGFX_3

	dw $8910, PicrossMinigame_SetTileGFX_7
	dw $8940, PicrossMinigame_SetTileGFX_11
	dw $8970, PicrossMinigame_SetTileGFX_15
	dw $89A0, PicrossMinigame_SetTileGFX_3
	dw $8920, PicrossMinigame_SetTileGFX_4

	dw $8920, PicrossMinigame_SetTileGFX_8
	dw $8950, PicrossMinigame_SetTileGFX_12
	dw $8980, PicrossMinigame_SetTileGFX_16
	dw $89B0, PicrossMinigame_SetTileGFX_4
	dw $89C0, PicrossMinigame_SetTileGFX_1

	dw $89C0, PicrossMinigame_SetTileGFX_5
	dw $89F0, PicrossMinigame_SetTileGFX_9
	dw $8A20, PicrossMinigame_SetTileGFX_13
	dw $8A50, PicrossMinigame_SetTileGFX_1
	dw $89C0, PicrossMinigame_SetTileGFX_2

	dw $89C0, PicrossMinigame_SetTileGFX_6
	dw $89F0, PicrossMinigame_SetTileGFX_10
	dw $8A20, PicrossMinigame_SetTileGFX_14
	
	dw $8A50, PicrossMinigame_SetTileGFX_2
	dw $89D0, PicrossMinigame_SetTileGFX_3
	dw $89D0, PicrossMinigame_SetTileGFX_7
	dw $8A00, PicrossMinigame_SetTileGFX_11
	dw $8A30, PicrossMinigame_SetTileGFX_15
	dw $8A60, PicrossMinigame_SetTileGFX_3
	
	dw $89E0, PicrossMinigame_SetTileGFX_4
	dw $89E0, PicrossMinigame_SetTileGFX_8
	dw $8A10, PicrossMinigame_SetTileGFX_12
	dw $8A40, PicrossMinigame_SetTileGFX_16
	dw $8A70, PicrossMinigame_SetTileGFX_4
	
	dw $8A80, PicrossMinigame_SetTileGFX_1
	dw $8A80, PicrossMinigame_SetTileGFX_5
	dw $8AB0, PicrossMinigame_SetTileGFX_9
	dw $8AE0, PicrossMinigame_SetTileGFX_13
	dw $8B10, PicrossMinigame_SetTileGFX_1
	
	dw $8A80, PicrossMinigame_SetTileGFX_2
	dw $8A80, PicrossMinigame_SetTileGFX_6
	dw $8AB0, PicrossMinigame_SetTileGFX_10
	dw $8AE0, PicrossMinigame_SetTileGFX_14
	dw $8B10, PicrossMinigame_SetTileGFX_2
	
	dw $8A90, PicrossMinigame_SetTileGFX_3
	dw $8A90, PicrossMinigame_SetTileGFX_7
	dw $8AC0, PicrossMinigame_SetTileGFX_11
	dw $8AF0, PicrossMinigame_SetTileGFX_15
	dw $8B20, PicrossMinigame_SetTileGFX_3
	
	dw $8AA0, PicrossMinigame_SetTileGFX_4
	dw $8AA0, PicrossMinigame_SetTileGFX_8
	dw $8AD0, PicrossMinigame_SetTileGFX_12
	dw $8B00, PicrossMinigame_SetTileGFX_16
	dw $8B30, PicrossMinigame_SetTileGFX_4

PicrossMinigame_ApplyRowDigits:
	ld c, 96
	ld hl, PicrossMinigame_VRAMAndDigitColumnPointers
	call PicrossMinigame_ApplyDigits
	ret

PicrossMinigame_VRAMAndDigitColumnPointers:
	dw $8B40, PicrossMinigame_SetTileGFX_1
	dw $8B40, PicrossMinigame_SetTileGFX_2
	dw $8B50, PicrossMinigame_SetTileGFX_3
	dw $8B60, PicrossMinigame_SetTileGFX_4
	dw $8BD0, PicrossMinigame_SetTileGFX_1
	dw $8BD0, PicrossMinigame_SetTileGFX_2
	
	dw $8B40, PicrossMinigame_SetTileGFX_5
	dw $8B40, PicrossMinigame_SetTileGFX_6
	dw $8B50, PicrossMinigame_SetTileGFX_7
	dw $8B60, PicrossMinigame_SetTileGFX_8
	dw $8BD0, PicrossMinigame_ApplyDigit_17
	dw $8BD0, PicrossMinigame_ApplyDigit_18
	
	dw $8B70, PicrossMinigame_SetTileGFX_9
	dw $8B70, PicrossMinigame_SetTileGFX_10
	dw $8B80, PicrossMinigame_SetTileGFX_11
	dw $8B90, PicrossMinigame_SetTileGFX_12
	dw $8BF0, PicrossMinigame_ApplyDigit_19
	dw $8BF0, PicrossMinigame_ApplyDigit_20
	
	dw $8BA0, PicrossMinigame_SetTileGFX_13
	dw $8BA0, PicrossMinigame_SetTileGFX_14
	dw $8BB0, PicrossMinigame_SetTileGFX_15
	dw $8BC0, PicrossMinigame_SetTileGFX_16
	dw $8C10, PicrossMinigame_SetTileGFX_13
	dw $8C10, PicrossMinigame_SetTileGFX_14
	
	dw $8C30, PicrossMinigame_SetTileGFX_1
	dw $8C30, PicrossMinigame_SetTileGFX_2
	dw $8C40, PicrossMinigame_SetTileGFX_3
	dw $8C50, PicrossMinigame_SetTileGFX_4
	dw $8CC0, PicrossMinigame_SetTileGFX_1
	dw $8CC0, PicrossMinigame_SetTileGFX_2
	
	dw $8C30, PicrossMinigame_SetTileGFX_5
	dw $8C30, PicrossMinigame_SetTileGFX_6
	dw $8C40, PicrossMinigame_SetTileGFX_7
	dw $8C50, PicrossMinigame_SetTileGFX_8
	dw $8CC0, PicrossMinigame_ApplyDigit_17
	dw $8CC0, PicrossMinigame_ApplyDigit_18
	
	dw $8C60, PicrossMinigame_SetTileGFX_9
	dw $8C60, PicrossMinigame_SetTileGFX_10
	dw $8C70, PicrossMinigame_SetTileGFX_11
	dw $8C80, PicrossMinigame_SetTileGFX_12
	dw $8CE0, PicrossMinigame_ApplyDigit_19
	dw $8CE0, PicrossMinigame_ApplyDigit_20
	
	dw $8C90, PicrossMinigame_SetTileGFX_13
	dw $8C90, PicrossMinigame_SetTileGFX_14
	dw $8CA0, PicrossMinigame_SetTileGFX_15
	dw $8CB0, PicrossMinigame_SetTileGFX_16
	dw $8D00, PicrossMinigame_SetTileGFX_13
	dw $8D00, PicrossMinigame_SetTileGFX_14
	
	dw $8D20, PicrossMinigame_SetTileGFX_1
	dw $8D20, PicrossMinigame_SetTileGFX_2
	dw $8D30, PicrossMinigame_SetTileGFX_3
	dw $8D40, PicrossMinigame_SetTileGFX_4
	dw $8DB0, PicrossMinigame_SetTileGFX_1
	dw $8DB0, PicrossMinigame_SetTileGFX_2
	
	dw $8D20, PicrossMinigame_SetTileGFX_5
	dw $8D20, PicrossMinigame_SetTileGFX_6
	dw $8D30, PicrossMinigame_SetTileGFX_7
	dw $8D40, PicrossMinigame_SetTileGFX_8
	dw $8DB0, PicrossMinigame_ApplyDigit_17
	dw $8DB0, PicrossMinigame_ApplyDigit_18
	
	dw $8D50, PicrossMinigame_SetTileGFX_9
	dw $8D50, PicrossMinigame_SetTileGFX_10
	dw $8D60, PicrossMinigame_SetTileGFX_11
	dw $8D70, PicrossMinigame_SetTileGFX_12
	dw $8DD0, PicrossMinigame_ApplyDigit_19
	dw $8DD0, PicrossMinigame_ApplyDigit_20
	
	dw $8D80, PicrossMinigame_SetTileGFX_13
	dw $8D80, PicrossMinigame_SetTileGFX_14
	dw $8D90, PicrossMinigame_SetTileGFX_15
	dw $8DA0, PicrossMinigame_SetTileGFX_16
	dw $8DF0, PicrossMinigame_SetTileGFX_13
	dw $8DF0, PicrossMinigame_SetTileGFX_14
	
	dw $8E10, PicrossMinigame_SetTileGFX_1
	dw $8E10, PicrossMinigame_SetTileGFX_2
	dw $8E20, PicrossMinigame_SetTileGFX_3
	dw $8E30, PicrossMinigame_SetTileGFX_4
	dw $8EA0, PicrossMinigame_SetTileGFX_1
	dw $8EA0, PicrossMinigame_SetTileGFX_2
	
	dw $8E10, PicrossMinigame_SetTileGFX_5
	dw $8E10, PicrossMinigame_SetTileGFX_6
	dw $8E20, PicrossMinigame_SetTileGFX_7
	dw $8E30, PicrossMinigame_SetTileGFX_8
	dw $8EA0, PicrossMinigame_ApplyDigit_17
	dw $8EA0, PicrossMinigame_ApplyDigit_18
	
	dw $8E40, PicrossMinigame_SetTileGFX_9
	dw $8E40, PicrossMinigame_SetTileGFX_10
	dw $8E50, PicrossMinigame_SetTileGFX_11
	dw $8E60, PicrossMinigame_SetTileGFX_12
	dw $8EC0, PicrossMinigame_ApplyDigit_19
	dw $8EC0, PicrossMinigame_ApplyDigit_20
	
	dw $8E70, PicrossMinigame_SetTileGFX_13
	dw $8E70, PicrossMinigame_SetTileGFX_14
	dw $8E80, PicrossMinigame_SetTileGFX_15
	dw $8E90, PicrossMinigame_SetTileGFX_16
	dw $8EE0, PicrossMinigame_SetTileGFX_13
	dw $8EE0, PicrossMinigame_SetTileGFX_14

PicrossMinigame_ApplyDigits:
	xor a
	ld [wPicrossDrawingRoutineCounter], a

.loop:
	push bc
	push hl
	call PicrossMinigame_ApplyDigit
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

PicrossMinigame_ApplyDigit:
	push hl
	ld hl, wPicrossDrawingRoutineCounter
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wPicrossNumbersBuffer
	add hl, de
	ld a, [hl]
	cp $FF
	jr z, .done_applying_digit
	
	swap a
	and $F0
	ld e, a
	ld a, [hl]
	swap a
	and $F
	ld d, a
	
	ld hl, PicrossGFX
	add hl, de
	ld a, l
	ld [wPicrossBaseGFXPointer], a
	ld a, h
	ld [wPicrossBaseGFXPointer+1], a
	pop hl
	
	ldi a, [hl]
	ld [wPicrossBase2bppPointer], a
	ldi a, [hl]
	ld [wPicrossBase2bppPointer+1], a
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	jp hl

.done_applying_digit
	pop hl
	ret

PicrossMinigame_SetTileGFX_1:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 0
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 5*2
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_SetTileGFX_2:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 0
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 5*2
	call PicrossMinigame_ApplyTileGFXTopRight1
	
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $10
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2*5
	call PicrossMinigame_ApplyTileGFXTopLeft1
	
	ret

PicrossMinigame_SetTileGFX_3:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 0
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 5*2
	call PicrossMinigame_ApplyTileGFXTopRight2
	
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $10
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 5*2
	call PicrossMinigame_ApplyTileGFXTopLeft2
	
	ret

PicrossMinigame_SetTileGFX_4:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 0
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 5*2
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ret

PicrossMinigame_SetTileGFX_5:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 6*2
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 3*2
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_SetTileGFX_6:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopRight1
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopRight1
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $1C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ld hl, $40 ; '@'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_SetTileGFX_7:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopRight2
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopRight2
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $1C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopLeft2
	ld hl, $40 ; '@'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopLeft2
	ret

PicrossMinigame_SetTileGFX_8:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ret

PicrossMinigame_SetTileGFX_9:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_SetTileGFX_10:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopRight1
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopRight1
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $18
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ld hl, $40 ; '@'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_SetTileGFX_11:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopRight2
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopRight2
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $18
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopLeft2
	ld hl, $40 ; '@'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopLeft2
	ret

PicrossMinigame_SetTileGFX_12:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ret

PicrossMinigame_SetTileGFX_13:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 4
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_SetTileGFX_14:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 4
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopRight1
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $14
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_SetTileGFX_15:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 4
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopRight2
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $14
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopLeft2
	ret

PicrossMinigame_SetTileGFX_16:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 4
	call PicrossMinigame_AddToHL2bppPointer
	ld c, $A
	call PicrossMinigame_ApplyTileGFXTopRightFull
	ret

PicrossMinigame_ApplyDigit_17:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ld hl, $20 ; ' '
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_ApplyDigit_18:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopRight1
	ld hl, $20 ; ' '
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopRight1
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $1C
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 4
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 6
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_ApplyDigit_19:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ld hl, $20 ; ' '
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_ApplyDigit_20:
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, 8
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopRight1
	ld hl, $20 ; ' '
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopRight1
	call PicrossMinigame_SetTileGFXPointerDE
	ld hl, $18
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 8
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ld hl, $30 ; '0'
	call PicrossMinigame_AddToHL2bppPointer
	ld c, 2
	call PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_AddToHL2bppPointer:
	push de
	ld a, [wPicrossBase2bppPointer]
	ld e, a
	ld a, [wPicrossBase2bppPointer+1]
	ld d, a
	add hl, de
	pop de
	ret

PicrossMinigame_ApplyTileGFXTopLeftFull:
	ld a, [de]
	inc de
	ld b, $F8 ; 'ø'
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopLeftFull
	ret

PicrossMinigame_ApplyTileGFXTopRight1:
	ld a, [de]
	inc de
	rlca
	rlca
	ld b, 3
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopRight1
	ret

PicrossMinigame_ApplyTileGFXTopLeft1:
	ld a, [de]
	inc de
	sla a
	sla a
	ld b, $E0 ; 'à'
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopLeft1
	ret

PicrossMinigame_ApplyTileGFXTopRight2:
	ld a, [de]
	inc de
	swap a
	ld b, $F
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopRight2
	ret

PicrossMinigame_ApplyTileGFXTopLeft2:
	ld a, [de]
	inc de
	swap a
	ld b, $80 ; '€'
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopLeft2
	ret

PicrossMinigame_ApplyTileGFXTopRightFull:
	ld a, [de]
	inc de
	srl a
	srl a
	ld b, 62
	call PicrossMinigame_ApplyTileGFXCommon
	dec c
	jr nz, PicrossMinigame_ApplyTileGFXTopRightFull
	ret

PicrossMinigame_ApplyTileGFXCommon:
	push de
	push af
	ld a, [wPicrossCurrentTileType]
	cp $FF
	jr nz, .skip
	pop af
	and b
	ld e, a
	ld a, [hl]
	or e
	ld [hl], a
	jr .finish

.skip:
	ld a, b
	xor $FF
	ld e, a
	ld a, [hl]
	and e
	ld [hl], a
	pop af
	and b
	ld e, a
	ld a, [hl]
	or e
	ld [hl], a
	jr .finish

.Unreferenced:
	ld a, b
	xor $FF
	ld e, a
	ld a, [hl]
	and e
	ld [hl], a
	pop af

.finish:
	pop de
	inc hl
	ret

PicrossMinigame_SetTileGFXPointerDE:
	ld a, [wPicrossCurrentTileType]
	cp -1
	jr z, .skip
	and 3
	ld e, a
	ld d, 0
	ld hl, .Tiles
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ret

.skip:
	ld a, [wPicrossBaseGFXPointer]
	ld e, a
	ld a, [wPicrossBaseGFXPointer+1]
	ld d, a
	ret

.Tiles:
	dw .empty
	dw .filled
	dw .crossed
	dw .empty
	
.empty:
	dw 0
	dw %1101000
	dw %1001000
	dw %1000
	dw %1111000

.filled:
	dw %1111100011111000
	dw %1111100010000000
	dw %1111100010000000
	dw %1111100010000000
	dw %1111100010000000

.crossed:
	dw %000000000000000
	dw %101000000101000
	dw %010000001001000
	dw %101000000001000
	dw %000000001111000

PicrossMinigame_LoadLayout:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, PicrossSprites
	add hl, de
	ldi a, [hl]
	and a
	jr z, .normal_pattern

.tileset_pattern
; Pattern originates from a tileset,
; its bottom part data is offset by exactly $100.

	ld b, [hl]
	inc hl
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	ld de, wPicrossLayoutBuffer - 1
	ld a, b
	ld bc, $20 	; 2 tiles
	push bc
	push af
	push hl
	call FarCopyData
	pop hl
	ld bc, $100
	add hl, bc
	pop af
	pop bc
	call FarCopyData
	ret

.normal_pattern
; Pattern originates from regular 2bpp data,
; load the top part and bottom part sequentially.

	ld b, [hl]
	inc hl
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	ld de, wPicrossLayoutBuffer - 1
	ld a, b
	ld bc, $40 	; 4 tiles
	call FarCopyData
	ret

picross_pattern: MACRO
if _NARG > 2
	db \1
	dbw \2, \3
else
	db \1
	dbw BANK(\2), \2
endc
ENDM

PicrossSprites:
	picross_pattern PATTERN_NORMAL, DiglettIcon
	picross_pattern PATTERN_NORMAL, GengarIcon
	picross_pattern PATTERN_NORMAL, AnnonIcon
	picross_pattern PATTERN_NORMAL, SnorlaxIcon
	picross_pattern PATTERN_TILESET, $C, Tileset_0c_GFX + $200 ; PC
	picross_pattern PATTERN_NORMAL, PoliwrathSpriteGFX

; TODO: Turn this into GFX files
PicrossGFX:	db $20, $20, $50, $50, $50, $50, $50, $50, $20, $20, 0
	db 0, 0, 0, 0, 0, $20, $20, $60, $60, $20, $20, $20, $20
	db $20, $20, 0, 0, 0, 0, 0, 0, $60, $60, $10, $10, $20
	db $20, $40, $40, $70, $70, 0, 0, 0, 0, 0, 0, $60, $60
	db $10, $10, $60, $60, $10, $10, $20, $20, 0, 0, 0, 0
	db 0, 0, $30, $30, $50, $50, $50, $50, $38, $38, $10, $10
	db 0, 0, 0, 0, 0, 0, $60, $60, $40, $40, $60, $60, $10
	db $10, $60, $60, 0, 0, 0, 0, 0, 0, $30, $30, $40, $40
	db $60, $60, $50, $50, $60, $60, 0, 0, 0, 0, 0, 0, $70
	db $70, $10, $10, $10, $10, $20, $20, $20, $20, 0, 0, 0
	db 0, 0, 0, $60, $60, $50, $50, $20, $20, $50, $50, $60
	db $60, 0, 0, 0, 0, 0, 0, $60, $60, $50, $50, $30, $30
	db $10, $10, $20, $20, 0, 0, 0, 0, 0, 0, $90, $90, $A8
	db $A8, $A8, $A8, $A8, $A8, $90, $90, 0, 0, 0, 0, 0, 0
	db $90, $90, $90, $90, $90, $90, $90, $90, $90, $90, 0
	db 0, 0, 0, 0, 0, $A0, $A0, $90, $90, $90, $90, $A0, $A0
	db $B8, $B8, 0, 0, 0, 0, 0, 0, $A0, $A0, $90, $90, $B0
	db $B0, $88, $88, $B0, $B0, 0, 0, 0, 0, 0, 0, $98, $98
	db $A8, $A8, $A8, $A8, $B8, $B8, $88, $88, 0, 0, 0, 0
	db 0, 0, $B0, $B0, $A0, $A0, $B0, $B0, $88, $88, $B0, $B0
	db 0, 0, 0, 0, 0, 0, $98, $98, $A0, $A0, $B0, $B0, $A8
	db $A8, $B0, $B0, 0, 0, 0, 0, 0, 0
PicrossBackgroundGFX:db $FE, 1, $8A, $75, $BA, $45, $FA, 5, $82, $7D, $BE, $41
	db $FE, 1, 0, $FF, 0, $FF, $20, $DF, 5, $FA, $A, $F5, $45
	db $BE, $22, $DF, $10, $FF, 0, $FF, 0, $FF, $48, $FF, $A2
	db $FF, $F5, $FF, $FF, $FF, $AF, $5F, $55, $AA, $F8, 5
	db $69, 0, $2A, 0, 1, 0, 8, 0, $45, 0, $AA, 0, $44, 0
	db $A0, 0
PicrossColumnsGFX:db $FC, 0, $FC, 0, $FC, 0, $FC, 0, $FC, 0, $FC, 0, $FC
	db 0, $FC, 0, $F, 0, $F, 0, $F, 0, $F, 0, $F, 0, $F, 0
	db $F, 0, $F, 0, $C0, 0, $C0, 0, $C0, 0, $C0, 0, $C0, 0
	db $C0, 0, $C0, 0, $C0, 0
PicrossRow1GFX:	db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, $FF, 0, $FF, 0
PicrossRow2GFX:	db $FF, 0, $FF, 0, $FF, 0, $FF, 0, 0, 0, 0, 0, 0, 0, 0
	db 0
PicrossRow3GFX:	db 0, 0, 0, 0, $FF, 0, $FF, 0, $FF, 0, $FF, 0, $FF, 0
	db $FF, 0
PicrossGridGFX:	db 4, 0, $6D, 0, $4D, 0, $C, 0, $7D, 0, $FF, 0, 4, 0, $6D
	db 0, $10, 0, $B6, 0, $34, 0, $30, 0, $F7, 0, $FF, 0, $10
	db 0, $B6, 0, $40, 1, $DA, 1, $D2, 1, $C2, 1, $DE, 1, $FE
	db 1, $40, 1, $DA, 1, $4D, 0, $C, 0, $7D, 0, $FF, 0, 4
	db 0, $6D, 0, $4D, 0, $C, 0, $34, 0, $30, 0, $F7, 0, $FF
	db 0, $10, 0, $B6, 0, $34, 0, $30, 0, $D2, 1, $C2, 1, $DE
	db 1, $FE, 1, $40, 1, $DA, 1, $D2, 1, $C2, 1, $7D, 0, $FF
	db 0, 4, 0, $6D, 0, $4D, 0, $C, 0, $7D, 0, 0, $FF, $F7
	db 0, $FF, 0, $10, 0, $B6, 0, $34, 0, $30, 0, $F7, 0, 0
	db $FF, $DE, 1, $FE, 1, $40, 1, $DA, 1, $D2, 1, $C2, 1
	db $DE, 1, 0, $FF
PicrossCursorGFX:db $FE, $FE, $82, $82, $82, $82, $82, $82, $82, $82, $82
	db $82, $FE, $FE, 0, 0, $10, $10, 0, $28, $26, $52, $36
	db $BD, $61, $D5, $39, $12, $14, $C, $10, $50, $10, $10
	db 0, 8, 2, $42, $10, 0, 0, $84, $21, 0, 0, 0, $10, $50
	db 0, 0, $20, $20, 0, $10, 0, $84, $20, 0, 8, 0, 0, 8
	db 0, 4
	db   5
