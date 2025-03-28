INCLUDE "constants.asm"

SECTION "engine/games/picross_minigame.asm", ROMX

; PicrossSprites constants
	const_def
	const PATTERN_NORMAL
	const PATTERN_TILESET

; PicrossMinigame.Jumptable constants
	const_def
	const PICROSS_INIT_MODE
	const PICROSS_RUN_MODE
	const PICROSS_EXIT_MODE
DEF PICROSS_END_LOOP_F EQU 7

; wPicrossCurrentCellType constants
	const_def
	const PICROSS_BLANK_CELL
	const PICROSS_COLORED_CELL
	const PICROSS_MARKED_CELL

DEF PICROSS_GFX_BGTILE EQU $80
DEF PICROSS_GFX_BUSHTILE EQU $81
DEF PICROSS_GFX_BUSHGROUNDTILE EQU $82
DEF PICROSS_GFX_GROUNDTILE EQU $83

DEF PICROSS_GFX_COLUMNS EQU $84
DEF PICROSS_GFX_ROWS EQU $b4
DEF PICROSS_GFX_TABLESTART equ $f0

; The Picross game area is referred as the "table" here.
; The table consists of 256 cells, divided into 4x4 "grids" of 16 cells each.

PicrossMinigame:
	call .Init
	call DelayFrame
.loop
	call .GameLoop
	jr nc, .loop
	call ClearJoypad
	ret

.Init:
	call DisableLCD
	farcall ClearSpriteAnims
	call .InitGFX
	call .PlacePlayerBG
	call .InitRAM

	depixel 8, 8, 0, 0
	ld a, SPRITE_ANIM_OBJ_MINIGAME_PICROSS_CURSOR
	call InitSpriteAnimStruct

	ld a, c
	ld [wPicrossCursorSpritePointer], a
	ld a, b
	ld [wPicrossCursorSpritePointer+1], a

	depixel 5, 4, 4, 4
	ld a, SPRITE_ANIM_OBJ_MINIGAME_PICROSS_GOLD
	call InitSpriteAnimStruct

	ld a, -1
	ld [wPicrossCurrentCellType], a
	call Picross_InitPicrossTable
	call Picross_InitPicrossDigits

	xor a
	ldh [hSCY], a
	ldh [hSCX], a
	ldh [rWY], a
	ld [wJumptableIndex], a

	ld a, 1
	ldh [hBGMapMode], a

	ld a, %11100011
	ldh [rLCDC], a
	ld a, %11100100
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a

	xor a ; PICROSS_BLANK_CELL
	ld [wPicrossCurrentCellType], a
	ret

.InitGFX:
	ld hl, PicrossBackgroundGFX
	ld de, vPicrossBackground
	ld bc, 4 tiles
	ld a, BANK(PicrossBackgroundGFX)
	call FarCopyData

; load column GFX
	ld de, vPicrossBackground tile 4
	ld b, 4
.column_outer_loop
	push bc
	ld b, 4
.column_inner_loop
	push bc
	ld hl, PicrossGridHighlightsGFX
	ld bc, 3 tiles
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .column_inner_loop
	pop bc
	dec b
	jr nz, .column_outer_loop

; load row GFX
	ld de, vPicrossBackground tile $34
	ld b, 4
.row_outer_loop
	push bc
	ld b, 3
.row1
	push bc
	ld hl, PicrossGridHighlightsGFX tile 3
	ld bc, 1 tiles
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row1
	ld b, 3
.row2
	push bc
	ld hl, PicrossGridHighlightsGFX tile 4
	ld bc, 1 tiles
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row2
	ld b, 3
.row3
	push bc
	ld hl, PicrossGridHighlightsGFX tile 5
	ld bc, LEN_2BPP_TILE
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row3
	ld b, 2
.row4
	push bc
	ld hl, PicrossGridHighlightsGFX tile 3
	ld bc, LEN_2BPP_TILE
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row4
	ld b, 2
.row5
	push bc
	ld hl, PicrossGridHighlightsGFX tile 4
	ld bc, LEN_2BPP_TILE
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row5
	ld b, 2
.row6
	push bc
	ld hl, PicrossGridHighlightsGFX tile 5
	ld bc, LEN_2BPP_TILE
	ld a, BANK(PicrossGridHighlightsGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .row6
	pop bc
	dec b
	jr nz, .row_outer_loop

; load Picross table
	ld de, vPicrossPlayArea
	ld b, 16
.load_grid
	push bc
	ld hl, PicrossGridGFX
	ld bc, 9 tiles
	ld a, BANK(PicrossGridGFX)
	call FarCopyData
	pop bc
	dec b
	jr nz, .load_grid

; load cursor GFX
	ld de, vSprites
	ld hl, PicrossCursorGFX
	ld bc, 9 tiles
	ld a, BANK(PicrossCursorGFX)
	call FarCopyData

; load Gold sprites
	ld de, vSprites + $100
	ld hl, GoldSpriteGFX + LEN_2BPP_TILE * 4	; Gold's back-facing standing sprite
	ld bc, 4 tiles
	ld a, BANK(GoldSpriteGFX)
	call FarCopyData

	ld de, vSprites + $140
	ld hl, GoldSpriteGFX + LEN_2BPP_TILE * 16	; Gold's back-facing walking sprite
	ld bc, 4 tiles
	ld a, BANK(GoldSpriteGFX)
	call FarCopyData

	ld a, SPRITE_ANIM_DICT_MINIGAME_PICROSS
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], SPRITE_ANIM_DICT_NULL
	inc hl
	ld a, SPRITE_ANIM_DICT_GS_INTRO_2
	ld [hli], a
	ld [hl], SPRITE_ANIM_DICT_TAUROS_ICON
	ret

.PlacePlayerBG:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, PICROSS_GFX_BGTILE
	call ByteFill

	hlcoord 1, 1
	ld bc, 5
	ld a, PICROSS_GFX_BUSHTILE
	call ByteFill

	hlcoord 1, 2
	ld bc, 5
	ld a, PICROSS_GFX_BUSHTILE
	call ByteFill

	hlcoord 1, 3
	ld bc, 5
	ld a, PICROSS_GFX_BUSHGROUNDTILE
	call ByteFill

	hlcoord 1, 4
	ld bc, 5
	ld a, PICROSS_GFX_GROUNDTILE
	call ByteFill
	ret

.InitRAM:
	ld hl, wPicrossMarkedCells
	ld bc, $514
	xor a
	call ByteFill
	ret

.GameLoop:
	call .GetJoypadState
	ld a, [wJumptableIndex]
	bit PICROSS_END_LOOP_F, a
	jr nz, .quit

	call .ExecuteJumptable
	farcall PlaySpriteAnimations
	call DelayFrame
	and a
	ret

.quit
	scf
	ret

.GetJoypadState:
	call GetJoypadDebounced
	ldh a, [hJoyState]
	ld [wPicrossJoyStateBuffer], a
	ld hl, wPicrossCursorMovementDelay
	ld a, [hl]
	and a
	ret z
	dec [hl]
	xor a
	ld [wPicrossJoyStateBuffer], a
	ret

.ExecuteJumptable:
	jumptable .Jumptable, wJumptableIndex

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
	call Picross_CheckPuzzleSolved
	jr c, .solved
	call Picross_ProcessJoypad
	ret

.solved
; Deallocate the cursor sprite
	ld hl, wPicrossCursorSpritePointer
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ld [hl], 0

; Exit Picross minigame
	ld hl, wJumptableIndex
	inc [hl]

.ExitMode:
	ldh a, [hJoyDown]
	and START
	ret z

; Game will truly exit once the Start button is pressed
	ld hl, wJumptableIndex
	set PICROSS_END_LOOP_F, [hl]
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
	ld c, 4 * 4
	ld a, PICROSS_GFX_TABLESTART
.place_table_loop
	push bc
	push hl
	ld e, [hl]
	inc hl
	ld h, [hl]
	ld l, e
	call .PlaceTableGrid
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .place_table_loop
	ret

.PlaceTableGrid:
	ld de, SCREEN_WIDTH
	ld b, 3
.placegrid_outerloop
	push hl
	ld c, 3
.placegrid_innerloop
	ld [hli], a
	inc a
	dec c
	jr nz, .placegrid_innerloop
	pop hl
	add hl, de
	dec b
	jr nz, .placegrid_outerloop
	ret

.TableCoords:
; row 1
	dwcoord 7, 6
	dwcoord 10, 6
	dwcoord 13, 6
	dwcoord 16, 6

; row 2
	dwcoord 7, 9
	dwcoord 10, 9
	dwcoord 13, 9
	dwcoord 16, 9

; row 3
	dwcoord 7, 12
	dwcoord 10, 12
	dwcoord 13, 12
	dwcoord 16, 12

; row 4
	dwcoord 7, 15
	dwcoord 10, 15
	dwcoord 13, 15
	dwcoord 16, 15

.PlaceColumnNumbers:
; Set up the tile map for the column numbers.
	hlcoord 7, 1
	ld b, 4
	ld a, PICROSS_GFX_COLUMNS
.column_numbers_outer_loop
	push hl
	ld de, SCREEN_HEIGHT
	ld c, 4
.column_numbers_inner_loop
	ld [hli], a
	inc a
	ld [hli], a
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
; Set up the tile map for the row numbers.
	hlcoord 1, 6
	ld b, 4
	ld a, PICROSS_GFX_ROWS
.row_numbers_loop1
	push hl
	push hl
	ld de, SCREEN_HEIGHT
	ld c, 3
.row_numbers_loop2
	ld [hli], a
	inc a
	ld [hli], a
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
	ld de, SCREEN_HEIGHT + 1
	ld c, 3
.row_numbers_loop3
	ld [hli], a
	inc a
	ld [hl], a
	inc a
	add hl, de
	dec c
	jr nz, .row_numbers_loop3
	pop hl
	ld de, $3c
	add hl, de
	dec b
	jr nz, .row_numbers_loop1
	ret

.HandleError:
	ld a, [wPicrossErrorCheck]
	and a
	ret z

; Print "ERROR" in the middle of the game display.
	ld hl, .ErrorBitmap
	decoord 0, 9
	ld c, .ErrorBitmapEnd - .ErrorBitmap

.print_message:
	ld a, [hli]
	add a, PICROSS_GFX_BGTILE
	ld [de], a
	inc de
	dec c
	jr nz, .print_message
	ret

.ErrorBitmap:
	pushc
	charmap " ", 0
	charmap "█", 1
	db " ██ ██  ██  ███ ██  "
	db " █  █ █ █ █ █ █ █ █ "
	db " ██ ██  ██  █ █ ██  "
	db " █  █ █ █ █ █ █ █ █ "
	db " ██ █ █ █ █ ███ █ █ "
	popc
.ErrorBitmapEnd:

Picross_CheckPuzzleSolved:
	ld de, wPicrossBitmap
	ld hl, wPicrossMarkedCells
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

; Puzzle is solved
	scf
	ret

.unsolved
	and a
	ret

Picross_ProcessJoypad:
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
	jr .mark_cell

.a_pressed
	xor a

.mark_cell
	ld [wPicrossJoypadAction], a
	ld a, 1
	ld [wPicrossAnimateDust], a
	call Picross_DetermineGridCoord
	call Picross_MarkCell
	call Picross_InitDustObject
	ret

Picross_InitDustObject:
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
	ld a, [wPicrossCurrentCellType]
	cp PICROSS_COLORED_CELL
	ret nz

; Make dust object only if we are marking a cell
	ld a, SPRITE_ANIM_OBJ_MINIGAME_PICROSS_DUST
	call InitSpriteAnimStruct
	ret

Picross_DetermineGridCoord:
; Determines wPicrossCurrentGridNumber and wPicrossCurrentCellNumber
; from the cursor's current X and Y position.
	ld hl, wPicrossCursorSpritePointer
	ld c, [hl]
	inc hl
	ld b, [hl]

	ld hl, SPRITEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	sub $40
	call .WriteXGridCoords

	ld hl, SPRITEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $40
	call .WriteYGridCoords
	ret

.WriteXGridCoords:
	cp $48
	jr nc, .fourth_grid_column
	cp $30
	jr nc, .third_grid_column
	cp $18
	jr nc, .second_grid_column

; first grid column
	call .WriteXCellCoords
	ld a, 0
	jr .grid_column_okay

.second_grid_column
	sub $18
	call .WriteXCellCoords
	ld a, 1
	jr .grid_column_okay

.third_grid_column
	sub $30
	call .WriteXCellCoords
	ld a, 2
	jr .grid_column_okay

.fourth_grid_column
	sub $48
	call .WriteXCellCoords
	ld a, 3

.grid_column_okay
	ld [wPicrossCurrentGridNumber], a
	ret

.WriteYGridCoords:
	cp $48
	jr nc, .fourth_grid_row
	cp $30
	jr nc, .third_grid_row
	cp $18
	jr nc, .second_grid_row

; first grid row
	call .WriteYCellCoords
	ld a, [wPicrossCurrentGridNumber]
	add a, 0
	jr .grid_row_okay

.second_grid_row
	sub $18
	call .WriteYCellCoords
	ld a, [wPicrossCurrentGridNumber]
	add a, 4
	jr .grid_row_okay

.third_grid_row
	sub $30
	call .WriteYCellCoords
	ld a, [wPicrossCurrentGridNumber]
	add a, 8
	jr .grid_row_okay

.fourth_grid_row
	sub $48
	call .WriteYCellCoords
	ld a, [wPicrossCurrentGridNumber]
	add a, 12

.grid_row_okay
	ld [wPicrossCurrentGridNumber], a
	ret

.WriteXCellCoords:
	cp $12
	jr z, .fourth_cell_column
	cp $c
	jr z, .third_cell_column
	cp $6
	jr z, .second_cell_column

; first cell column
	ld a, 0
	jr .cell_column_okay

.second_cell_column
	ld a, 1
	jr .cell_column_okay

.third_cell_column
	ld a, 2
	jr .cell_column_okay

.fourth_cell_column
	ld a, 3

.cell_column_okay
	ld [wPicrossCurrentCellNumber], a
	ret

.WriteYCellCoords:
	cp $12
	jr z, .fourth_cell_row
	cp $c
	jr z, .third_cell_row
	cp $6
	jr z, .second_cell_row

; first cell row
	ld a, [wPicrossCurrentCellNumber]
	add a, 0
	jr .cell_row_okay

.second_cell_row
	ld a, [wPicrossCurrentCellNumber]
	add a, 4
	jr .cell_row_okay

.third_cell_row
	ld a, [wPicrossCurrentCellNumber]
	add a, 8
	jr .cell_row_okay

.fourth_cell_row
	ld a, [wPicrossCurrentCellNumber]
	add a, 12

.cell_row_okay
	ld [wPicrossCurrentCellNumber], a
	ret

Picross_MarkCell:
	call Picross_SetTargetCellType
	ld hl, vPicrossPlayArea

; space between each grid in VRAM
	ld de, 9 tiles
	ld a, [wPicrossCurrentGridNumber]

.find_tile
	and a
	jr z, .update_tile
	dec a
	add hl, de
	jr .find_tile

.update_tile
	push hl
	ld e, l
	ld d, h
	ld hl, wPicrossRowGFX2bppBuffer
	ld c, 9
	ld b, BANK(@)
	call Request2bpp
	call Picross_SetMarkedCellGFX
	pop hl

	ld de, wPicrossRowGFX2bppBuffer
	ld c, 9
	ld b, BANK(@)
	call Request2bpp
	ret

Picross_SetTargetCellType:
	ld a, [wPicrossCurrentGridNumber]
	ld d, a
	and 12
	swap a
	ld e, a
	ld a, d
	and 3
	sla a
	sla a
	or e
	ld e, a

	ld a, [wPicrossCurrentCellNumber]
	ld d, a
	and 12
	sla a
	sla a
	or e
	ld e, a
	ld a, d
	and 3
	or e
	ld e, a
	ld d, 0

	ld hl, wPicrossMarkedCells
	add hl, de
	ldh a, [hJoypadState]
	and %11111100
	jr z, .check_b_pressed

	ld a, [wPicrossCurrentCellType]
	ld [hl], a
	ret

.check_b_pressed
	ld a, [wPicrossJoypadAction]
	and a
	jr z, .check_a_pressed
	ld a, [hl]
	cp B_BUTTON
	jr z, .done

	ld a, PICROSS_MARKED_CELL
	ld [wPicrossCurrentCellType], a
	ld [hl], a
	ret

.check_a_pressed
	ld a, [hl]
	cp A_BUTTON
	jr z, .done

	ld a, PICROSS_COLORED_CELL
	ld [wPicrossCurrentCellType], a
	ld [hl], a
	ret

.done
	xor a ; PICROSS_BLANK_CELL
	ld [wPicrossCurrentCellType], a
	ld [hl], a
	ret

Picross_SetMarkedCellGFX:
	ld a, [wPicrossCurrentCellNumber]
	ld e, a
	ld d, 0
	ld hl, .BufferRoutineTable
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wPicrossBase2bppPointer], a
	ld a, [hli]
	ld [wPicrossBase2bppPointer + 1], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.BufferRoutineTable:
	dw wPicrossRowGFX2bppBuffer,       Picross_SetCellGFX_1
	dw wPicrossRowGFX2bppBuffer,       Picross_SetCellGFX_2
	dw wPicrossRowGFX2bppBuffer + $10, Picross_SetCellGFX_3
	dw wPicrossRowGFX2bppBuffer + $20, Picross_SetCellGFX_4

	dw wPicrossRowGFX2bppBuffer,       Picross_SetCellGFX_5
	dw wPicrossRowGFX2bppBuffer,       Picross_SetCellGFX_6
	dw wPicrossRowGFX2bppBuffer + $10, Picross_SetCellGFX_7
	dw wPicrossRowGFX2bppBuffer + $20, Picross_SetCellGFX_8

	dw wPicrossRowGFX2bppBuffer + $30, Picross_SetCellGFX_9
	dw wPicrossRowGFX2bppBuffer + $30, Picross_SetCellGFX_10
	dw wPicrossRowGFX2bppBuffer + $40, Picross_SetCellGFX_11
	dw wPicrossRowGFX2bppBuffer + $50, Picross_SetCellGFX_12

	dw wPicrossRowGFX2bppBuffer + $60, Picross_SetCellGFX_13
	dw wPicrossRowGFX2bppBuffer + $60, Picross_SetCellGFX_14
	dw wPicrossRowGFX2bppBuffer + $70, Picross_SetCellGFX_15
	dw wPicrossRowGFX2bppBuffer + $80, Picross_SetCellGFX_16

Picross_InitPicrossTable:
; Pick between 4 available layouts at random.
	call Random
	and 3

	call Picross_LoadLayout
	call Picross_GoThroughLayout
	call Picross_PopulateRAMBitmap
	ret

Picross_PopulateRAMBitmap:
	ld de, wPicrossBitmap

; Populate top half
	ld hl, wPicrossLayoutBuffer
	ld c, 8
.tiles
	push bc
	push hl
	call .PopulateOneRow
	ld bc, LEN_2BPP_TILE
	add hl, bc
	call .PopulateOneRow
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .tiles

; Populate bottom half
	ld hl, wPicrossLayoutBuffer2
	ld c, 8
.tiles2
	push bc
	push hl
	call .PopulateOneRow
	ld bc, LEN_2BPP_TILE
	add hl, bc
	call .PopulateOneRow
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .tiles2
	ret

.PopulateOneRow:
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

Picross_GoThroughLayout:
	ld hl, wPicrossLayoutBuffer - 1
	ld c, $20
.loop
	ld a, [hli]
	and [hl]
	ld [hli], a
	dec c
	jr nz, .loop
	ret

Picross_InitPicrossDigits:
	call Picross_InitDigitBuffer
	call Picross_CountColumnDigits
	jr c, .errored

	call Picross_ApplyColumnDigits
	call Picross_InitDigitBuffer
	call Picross_CountRowDigits
	jr c, .errored

	call Picross_ApplyRowDigits
	xor a
	ld [wPicrossErrorCheck], a
	ret

.errored
	ld a, 1
	ld [wPicrossErrorCheck], a
	ret

Picross_InitDigitBuffer:
	ld hl, wPicrossNumbersBuffer
	ld c, 0
	ld a, $ff
.loop
	ld [hli], a
	dec c
	jr nz, .loop
	ret

Picross_CountColumnDigits:
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

Picross_CountRowDigits:
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
	ld a, [hli]
	dec c
	jr z, .skip
	and a
	ret

.skip
	scf
	ret

Picross_ApplyColumnDigits:
	ld c, 80
	ld hl, Picross_VRAMAndDigitRowPointers
	call Picross_ApplyDigits
	ret

Picross_VRAMAndDigitRowPointers:
; A huge table of VRAM locations and the subroutine to apply to it.
; This is used for printing the row digits in the proper positions.

; row 0
	dw vPicrossBackground tile  4, Picross_SetCellGFX_1
	dw vPicrossBackground tile  4, Picross_SetCellGFX_5
	dw vPicrossBackground tile  7, Picross_SetCellGFX_9
	dw vPicrossBackground tile 10, Picross_SetCellGFX_13
	dw vPicrossBackground tile 13, Picross_SetCellGFX_1
; row 1
	dw vPicrossBackground tile  4, Picross_SetCellGFX_2
	dw vPicrossBackground tile  4, Picross_SetCellGFX_6
	dw vPicrossBackground tile  7, Picross_SetCellGFX_10
	dw vPicrossBackground tile 10, Picross_SetCellGFX_14
	dw vPicrossBackground tile 13, Picross_SetCellGFX_2
; row 2
	dw vPicrossBackground tile  5, Picross_SetCellGFX_3
	dw vPicrossBackground tile  5, Picross_SetCellGFX_7
	dw vPicrossBackground tile  8, Picross_SetCellGFX_11
	dw vPicrossBackground tile 11, Picross_SetCellGFX_15
	dw vPicrossBackground tile 14, Picross_SetCellGFX_3
; row 3
	dw vPicrossBackground tile  6, Picross_SetCellGFX_4
	dw vPicrossBackground tile  6, Picross_SetCellGFX_8
	dw vPicrossBackground tile  9, Picross_SetCellGFX_12
	dw vPicrossBackground tile 12, Picross_SetCellGFX_16
	dw vPicrossBackground tile 15, Picross_SetCellGFX_4
; row 4
	dw vPicrossBackground tile 16, Picross_SetCellGFX_1
	dw vPicrossBackground tile 16, Picross_SetCellGFX_5
	dw vPicrossBackground tile 19, Picross_SetCellGFX_9
	dw vPicrossBackground tile 22, Picross_SetCellGFX_13
	dw vPicrossBackground tile 25, Picross_SetCellGFX_1
; row 5
	dw vPicrossBackground tile 16, Picross_SetCellGFX_2
	dw vPicrossBackground tile 16, Picross_SetCellGFX_6
	dw vPicrossBackground tile 19, Picross_SetCellGFX_10
	dw vPicrossBackground tile 22, Picross_SetCellGFX_14
	dw vPicrossBackground tile 25, Picross_SetCellGFX_2
	dw vPicrossBackground tile 17, Picross_SetCellGFX_3
; row 6
	dw vPicrossBackground tile 17, Picross_SetCellGFX_7
	dw vPicrossBackground tile 20, Picross_SetCellGFX_11
	dw vPicrossBackground tile 23, Picross_SetCellGFX_15
	dw vPicrossBackground tile 26, Picross_SetCellGFX_3
	dw vPicrossBackground tile 18, Picross_SetCellGFX_4
; row 7
	dw vPicrossBackground tile 18, Picross_SetCellGFX_8
	dw vPicrossBackground tile 21, Picross_SetCellGFX_12
	dw vPicrossBackground tile 24, Picross_SetCellGFX_16
	dw vPicrossBackground tile 27, Picross_SetCellGFX_4
	dw vPicrossBackground tile 28, Picross_SetCellGFX_1
; row 8
	dw vPicrossBackground tile 28, Picross_SetCellGFX_5
	dw vPicrossBackground tile 31, Picross_SetCellGFX_9
	dw vPicrossBackground tile 34, Picross_SetCellGFX_13
	dw vPicrossBackground tile 37, Picross_SetCellGFX_1
	dw vPicrossBackground tile 28, Picross_SetCellGFX_2
; row 9
	dw vPicrossBackground tile 28, Picross_SetCellGFX_6
	dw vPicrossBackground tile 31, Picross_SetCellGFX_10
	dw vPicrossBackground tile 34, Picross_SetCellGFX_14
; row 10
	dw vPicrossBackground tile 37, Picross_SetCellGFX_2
	dw vPicrossBackground tile 29, Picross_SetCellGFX_3
	dw vPicrossBackground tile 29, Picross_SetCellGFX_7
	dw vPicrossBackground tile 32, Picross_SetCellGFX_11
	dw vPicrossBackground tile 35, Picross_SetCellGFX_15
	dw vPicrossBackground tile 38, Picross_SetCellGFX_3
; row 11
	dw vPicrossBackground tile 30, Picross_SetCellGFX_4
	dw vPicrossBackground tile 30, Picross_SetCellGFX_8
	dw vPicrossBackground tile 33, Picross_SetCellGFX_12
	dw vPicrossBackground tile 36, Picross_SetCellGFX_16
	dw vPicrossBackground tile 39, Picross_SetCellGFX_4
; row 12
	dw vPicrossBackground tile 40, Picross_SetCellGFX_1
	dw vPicrossBackground tile 40, Picross_SetCellGFX_5
	dw vPicrossBackground tile 43, Picross_SetCellGFX_9
	dw vPicrossBackground tile 46, Picross_SetCellGFX_13
	dw vPicrossBackground tile 49, Picross_SetCellGFX_1
; row 13
	dw vPicrossBackground tile 40, Picross_SetCellGFX_2
	dw vPicrossBackground tile 40, Picross_SetCellGFX_6
	dw vPicrossBackground tile 43, Picross_SetCellGFX_10
	dw vPicrossBackground tile 46, Picross_SetCellGFX_14
	dw vPicrossBackground tile 49, Picross_SetCellGFX_2
; row 14
	dw vPicrossBackground tile 41, Picross_SetCellGFX_3
	dw vPicrossBackground tile 41, Picross_SetCellGFX_7
	dw vPicrossBackground tile 44, Picross_SetCellGFX_11
	dw vPicrossBackground tile 47, Picross_SetCellGFX_15
	dw vPicrossBackground tile 50, Picross_SetCellGFX_3
; row 15
	dw vPicrossBackground tile 42, Picross_SetCellGFX_4
	dw vPicrossBackground tile 42, Picross_SetCellGFX_8
	dw vPicrossBackground tile 45, Picross_SetCellGFX_12
	dw vPicrossBackground tile 48, Picross_SetCellGFX_16
	dw vPicrossBackground tile 51, Picross_SetCellGFX_4

Picross_ApplyRowDigits:
	ld c, 96
	ld hl, Picross_VRAMAndDigitColumnPointers
	call Picross_ApplyDigits
	ret

Picross_VRAMAndDigitColumnPointers:
; Another huge table of VRAM locations and the subroutine to apply to it.
; Used for printing the column digits in the proper positions.

; column 0
	dw vPicrossBackground tile  52, Picross_SetCellGFX_1
	dw vPicrossBackground tile  52, Picross_SetCellGFX_2
	dw vPicrossBackground tile  53, Picross_SetCellGFX_3
	dw vPicrossBackground tile  54, Picross_SetCellGFX_4
	dw vPicrossBackground tile  61, Picross_SetCellGFX_1
	dw vPicrossBackground tile  61, Picross_SetCellGFX_2
; column 1
	dw vPicrossBackground tile  52, Picross_SetCellGFX_5
	dw vPicrossBackground tile  52, Picross_SetCellGFX_6
	dw vPicrossBackground tile  53, Picross_SetCellGFX_7
	dw vPicrossBackground tile  54, Picross_SetCellGFX_8
	dw vPicrossBackground tile  61, Picross_ApplyDigit_17
	dw vPicrossBackground tile  61, Picross_ApplyDigit_18
; column 2
	dw vPicrossBackground tile  55, Picross_SetCellGFX_9
	dw vPicrossBackground tile  55, Picross_SetCellGFX_10
	dw vPicrossBackground tile  56, Picross_SetCellGFX_11
	dw vPicrossBackground tile  57, Picross_SetCellGFX_12
	dw vPicrossBackground tile  63, Picross_ApplyDigit_19
	dw vPicrossBackground tile  63, Picross_ApplyDigit_20
; column 3
	dw vPicrossBackground tile  58, Picross_SetCellGFX_13
	dw vPicrossBackground tile  58, Picross_SetCellGFX_14
	dw vPicrossBackground tile  59, Picross_SetCellGFX_15
	dw vPicrossBackground tile  60, Picross_SetCellGFX_16
	dw vPicrossBackground tile  65, Picross_SetCellGFX_13
	dw vPicrossBackground tile  65, Picross_SetCellGFX_14
; column 4
	dw vPicrossBackground tile  67, Picross_SetCellGFX_1
	dw vPicrossBackground tile  67, Picross_SetCellGFX_2
	dw vPicrossBackground tile  68, Picross_SetCellGFX_3
	dw vPicrossBackground tile  69, Picross_SetCellGFX_4
	dw vPicrossBackground tile  76, Picross_SetCellGFX_1
	dw vPicrossBackground tile  76, Picross_SetCellGFX_2
; column 5
	dw vPicrossBackground tile  67, Picross_SetCellGFX_5
	dw vPicrossBackground tile  67, Picross_SetCellGFX_6
	dw vPicrossBackground tile  68, Picross_SetCellGFX_7
	dw vPicrossBackground tile  69, Picross_SetCellGFX_8
	dw vPicrossBackground tile  76, Picross_ApplyDigit_17
	dw vPicrossBackground tile  76, Picross_ApplyDigit_18
; column 6
	dw vPicrossBackground tile  70, Picross_SetCellGFX_9
	dw vPicrossBackground tile  70, Picross_SetCellGFX_10
	dw vPicrossBackground tile  71, Picross_SetCellGFX_11
	dw vPicrossBackground tile  72, Picross_SetCellGFX_12
	dw vPicrossBackground tile  78, Picross_ApplyDigit_19
	dw vPicrossBackground tile  78, Picross_ApplyDigit_20
; column 7
	dw vPicrossBackground tile  73, Picross_SetCellGFX_13
	dw vPicrossBackground tile  73, Picross_SetCellGFX_14
	dw vPicrossBackground tile  74, Picross_SetCellGFX_15
	dw vPicrossBackground tile  75, Picross_SetCellGFX_16
	dw vPicrossBackground tile  80, Picross_SetCellGFX_13
	dw vPicrossBackground tile  80, Picross_SetCellGFX_14
; column 8
	dw vPicrossBackground tile  82, Picross_SetCellGFX_1
	dw vPicrossBackground tile  82, Picross_SetCellGFX_2
	dw vPicrossBackground tile  83, Picross_SetCellGFX_3
	dw vPicrossBackground tile  84, Picross_SetCellGFX_4
	dw vPicrossBackground tile  91, Picross_SetCellGFX_1
	dw vPicrossBackground tile  91, Picross_SetCellGFX_2
; column 9
	dw vPicrossBackground tile  82, Picross_SetCellGFX_5
	dw vPicrossBackground tile  82, Picross_SetCellGFX_6
	dw vPicrossBackground tile  83, Picross_SetCellGFX_7
	dw vPicrossBackground tile  84, Picross_SetCellGFX_8
	dw vPicrossBackground tile  91, Picross_ApplyDigit_17
	dw vPicrossBackground tile  91, Picross_ApplyDigit_18
; column 10
	dw vPicrossBackground tile  85, Picross_SetCellGFX_9
	dw vPicrossBackground tile  85, Picross_SetCellGFX_10
	dw vPicrossBackground tile  86, Picross_SetCellGFX_11
	dw vPicrossBackground tile  87, Picross_SetCellGFX_12
	dw vPicrossBackground tile  93, Picross_ApplyDigit_19
	dw vPicrossBackground tile  93, Picross_ApplyDigit_20
; column 11
	dw vPicrossBackground tile  88, Picross_SetCellGFX_13
	dw vPicrossBackground tile  88, Picross_SetCellGFX_14
	dw vPicrossBackground tile  89, Picross_SetCellGFX_15
	dw vPicrossBackground tile  90, Picross_SetCellGFX_16
	dw vPicrossBackground tile  95, Picross_SetCellGFX_13
	dw vPicrossBackground tile  95, Picross_SetCellGFX_14
; column 12
	dw vPicrossBackground tile  97, Picross_SetCellGFX_1
	dw vPicrossBackground tile  97, Picross_SetCellGFX_2
	dw vPicrossBackground tile  98, Picross_SetCellGFX_3
	dw vPicrossBackground tile  99, Picross_SetCellGFX_4
	dw vPicrossBackground tile 106, Picross_SetCellGFX_1
	dw vPicrossBackground tile 106, Picross_SetCellGFX_2
; column 13
	dw vPicrossBackground tile  97, Picross_SetCellGFX_5
	dw vPicrossBackground tile  97, Picross_SetCellGFX_6
	dw vPicrossBackground tile  98, Picross_SetCellGFX_7
	dw vPicrossBackground tile  99, Picross_SetCellGFX_8
	dw vPicrossBackground tile 106, Picross_ApplyDigit_17
	dw vPicrossBackground tile 106, Picross_ApplyDigit_18
; column 14
	dw vPicrossBackground tile 100, Picross_SetCellGFX_9
	dw vPicrossBackground tile 100, Picross_SetCellGFX_10
	dw vPicrossBackground tile 101, Picross_SetCellGFX_11
	dw vPicrossBackground tile 102, Picross_SetCellGFX_12
	dw vPicrossBackground tile 108, Picross_ApplyDigit_19
	dw vPicrossBackground tile 108, Picross_ApplyDigit_20
; column 15
	dw vPicrossBackground tile 103, Picross_SetCellGFX_13
	dw vPicrossBackground tile 103, Picross_SetCellGFX_14
	dw vPicrossBackground tile 104, Picross_SetCellGFX_15
	dw vPicrossBackground tile 105, Picross_SetCellGFX_16
	dw vPicrossBackground tile 110, Picross_SetCellGFX_13
	dw vPicrossBackground tile 110, Picross_SetCellGFX_14

Picross_ApplyDigits:
	xor a
	ld [wPicrossDrawingRoutineCounter], a
.loop
	push bc
	push hl
	call Picross_ApplyDigit
	pop hl
	inc hl
	inc hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
	ret

Picross_ApplyDigit:
	push hl
	ld hl, wPicrossDrawingRoutineCounter
	ld e, [hl]
	inc [hl]
	ld d, 0
	ld hl, wPicrossNumbersBuffer
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .done_applying_digit

	swap a
	and $f0
	ld e, a
	ld a, [hl]
	swap a
	and $f
	ld d, a

	ld hl, PicrossNumbersGFX
	add hl, de
	ld a, l
	ld [wPicrossBaseGFXPointer], a
	ld a, h
	ld [wPicrossBaseGFXPointer+1], a
	pop hl

	ld a, [hli]
	ld [wPicrossBase2bppPointer], a
	ld a, [hli]
	ld [wPicrossBase2bppPointer+1], a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.done_applying_digit
	pop hl
	ret

Picross_SetCellGFX_1:
	call Picross_SetTileGFXPointerDE
	ld hl, 0
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_SetCellGFX_2:
	call Picross_SetTileGFXPointerDE
	ld hl, 0
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopRight1

	call Picross_SetTileGFXPointerDE
	ld hl, $10
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopLeft1

	ret

Picross_SetCellGFX_3:
	call Picross_SetTileGFXPointerDE
	ld hl, 0
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopRight2

	call Picross_SetTileGFXPointerDE
	ld hl, $10
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopLeft2

	ret

Picross_SetCellGFX_4:
	call Picross_SetTileGFXPointerDE
	ld hl, 0
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopRightFull
	ret

Picross_SetCellGFX_5:
	call Picross_SetTileGFXPointerDE
	ld hl, 12
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopLeftFull
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_SetCellGFX_6:
	call Picross_SetTileGFXPointerDE
	ld hl, 12
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopRight1
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopRight1
	call Picross_SetTileGFXPointerDE
	ld hl, $1c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopLeft1
	ld hl, $40
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopLeft1
	ret

Picross_SetCellGFX_7:
	call Picross_SetTileGFXPointerDE
	ld hl, $c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopRight2
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopRight2
	call Picross_SetTileGFXPointerDE
	ld hl, $1c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopLeft2
	ld hl, $40
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopLeft2
	ret

Picross_SetCellGFX_8:
	call Picross_SetTileGFXPointerDE
	ld hl, $c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopRightFull
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopRightFull
	ret

Picross_SetCellGFX_9:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopLeftFull
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_SetCellGFX_10:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopRight1
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopRight1
	call Picross_SetTileGFXPointerDE
	ld hl, $18
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopLeft1
	ld hl, $40
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopLeft1
	ret

Picross_SetCellGFX_11:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopRight2
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopRight2
	call Picross_SetTileGFXPointerDE
	ld hl, $18
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopLeft2
	ld hl, $40
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopLeft2
	ret

Picross_SetCellGFX_12:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopRightFull
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopRightFull
	ret

Picross_SetCellGFX_13:
	call Picross_SetTileGFXPointerDE
	ld hl, 4
	call Picross_AddToHL2bppPointer
	ld c, $a
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_SetCellGFX_14:
	call Picross_SetTileGFXPointerDE
	ld hl, 4
	call Picross_AddToHL2bppPointer
	ld c, $a
	call Picross_ApplyTileGFXTopRight1
	call Picross_SetTileGFXPointerDE
	ld hl, $14
	call Picross_AddToHL2bppPointer
	ld c, $a
	call Picross_ApplyTileGFXTopLeft1
	ret

Picross_SetCellGFX_15:
	call Picross_SetTileGFXPointerDE
	ld hl, 4
	call Picross_AddToHL2bppPointer
	ld c, $a
	call Picross_ApplyTileGFXTopRight2
	call Picross_SetTileGFXPointerDE
	ld hl, $14
	call Picross_AddToHL2bppPointer
	ld c, $a
	call Picross_ApplyTileGFXTopLeft2
	ret

Picross_SetCellGFX_16:
	call Picross_SetTileGFXPointerDE
	ld hl, 4
	call Picross_AddToHL2bppPointer
	ld c, 10
	call Picross_ApplyTileGFXTopRightFull
	ret

Picross_ApplyDigit_17:
	call Picross_SetTileGFXPointerDE
	ld hl, $c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopLeftFull
	ld hl, $20
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_ApplyDigit_18:
	call Picross_SetTileGFXPointerDE
	ld hl, $c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopRight1
	ld hl, $20
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopRight1
	call Picross_SetTileGFXPointerDE
	ld hl, $1c
	call Picross_AddToHL2bppPointer
	ld c, 4
	call Picross_ApplyTileGFXTopLeft1
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 6
	call Picross_ApplyTileGFXTopLeft1
	ret

Picross_ApplyDigit_19:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopLeftFull
	ld hl, $20
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopLeftFull
	ret

Picross_ApplyDigit_20:
	call Picross_SetTileGFXPointerDE
	ld hl, 8
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopRight1
	ld hl, $20
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopRight1
	call Picross_SetTileGFXPointerDE
	ld hl, $18
	call Picross_AddToHL2bppPointer
	ld c, 8
	call Picross_ApplyTileGFXTopLeft1
	ld hl, $30
	call Picross_AddToHL2bppPointer
	ld c, 2
	call Picross_ApplyTileGFXTopLeft1
	ret

Picross_AddToHL2bppPointer:
	push de
	ld a, [wPicrossBase2bppPointer]
	ld e, a
	ld a, [wPicrossBase2bppPointer+1]
	ld d, a
	add hl, de
	pop de
	ret

Picross_ApplyTileGFXTopLeftFull:
	ld a, [de]
	inc de
	ld b, $f8
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopLeftFull
	ret

Picross_ApplyTileGFXTopRight1:
	ld a, [de]
	inc de
	rlca
	rlca
	ld b, 3
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopRight1
	ret

Picross_ApplyTileGFXTopLeft1:
	ld a, [de]
	inc de
	sla a
	sla a
	ld b, $e0
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopLeft1
	ret

Picross_ApplyTileGFXTopRight2:
	ld a, [de]
	inc de
	swap a
	ld b, $f
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopRight2
	ret

Picross_ApplyTileGFXTopLeft2:
	ld a, [de]
	inc de
	swap a
	ld b, $80
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopLeft2
	ret

Picross_ApplyTileGFXTopRightFull:
	ld a, [de]
	inc de
	srl a
	srl a
	ld b, 62
	call Picross_ApplyTileGFXCommon
	dec c
	jr nz, Picross_ApplyTileGFXTopRightFull
	ret

Picross_ApplyTileGFXCommon:
	push de
	push af
	ld a, [wPicrossCurrentCellType]
	cp -1
	jr nz, .skip
	pop af
	and b
	ld e, a
	ld a, [hl]
	or e
	ld [hl], a
	jr .finish

.skip
	ld a, b
	xor $ff
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

.asm_e3516 ; unreferenced
	ld a, b
	xor $ff
	ld e, a
	ld a, [hl]
	and e
	ld [hl], a
	pop af

.finish
	pop de
	inc hl
	ret

Picross_SetTileGFXPointerDE:
	ld a, [wPicrossCurrentCellType]
	cp -1
	jr z, .skip
	and 3
	ld e, a
	ld d, 0
	ld hl, .CellGFX
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

.CellGFX:
; A "tileset" of 5x5 dots to place over the grid GFX.
	dw .empty
	dw .colored
	dw .marked
	dw .empty

pusho
opt g.oX# ; . = 0, o = 1, X = 2, # = 3
.empty:
	dw `........
	dw `.oo.o...
	dw `.o..o...
	dw `....o...
	dw `.oooo...

.colored:
	dw `#####...
	dw `#XXXX...
	dw `#XXXX...
	dw `#XXXX...
	dw `#XXXX...

.marked:
	dw `........
	dw `.XoXo...
	dw `.oX.o...
	dw `.X.Xo...
	dw `.oooo...
popo

Picross_LoadLayout:
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, PicrossSprites
	add hl, de
	ld a, [hli]
	and a
	jr z, .normal_pattern

.tileset_pattern
; Pattern originates from a tileset.
; Its bottom half GFX is exactly $100 apart from the top half.
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wPicrossLayoutBuffer - 1
	ld a, b
	ld bc, 2 tiles
	push bc
	push af
	push hl
	call FarCopyData
	pop hl

; apply offset of bottom half GFX
	ld bc, $100
	add hl, bc
	pop af
	pop bc
	call FarCopyData
	ret

.normal_pattern
; Pattern originates from regular 2bpp data.
; Its bottom half GFX directly follows the top half.
	ld b, [hl]
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wPicrossLayoutBuffer - 1
	ld a, b
	ld bc, 4 tiles
	call FarCopyData
	ret

MACRO picross_pattern
if _NARG > 2
	db \1
	dbw \2, \3
else
	db \1
	dba \2
endc
ENDM

PicrossSprites:
	picross_pattern PATTERN_NORMAL, DiglettIcon
	picross_pattern PATTERN_NORMAL, GengarIcon
	picross_pattern PATTERN_NORMAL, AnnonIcon
	picross_pattern PATTERN_NORMAL, SnorlaxIcon
; TODO: Setting fixed bank $C for now before Tileset_0c_GFX is ripped
	picross_pattern PATTERN_TILESET, $c, Tileset_0c_GFX + $200
	picross_pattern PATTERN_NORMAL, PoliwrathSpriteGFX

