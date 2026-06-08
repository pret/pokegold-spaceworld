INCLUDE "constants.asm"

SECTION "engine/games/fifteen_puzzle_minigame.asm", ROMX

	const_def
	const FIFTEENPUZZLE_DOING_PUZZLE
	const FIFTEENPUZZLE_SOLVED_PUZZLE
	const FIFTEENPUZZLE_SLIDE_FINAL_PANEL
	const FIFTEENPUZZLE_SLIDE_PUZZLE_LEFT
	const FIFTEENPUZZLE_END_SCREEN


DEF FIFTEENPUZZLE_END_LOOP_F EQU 7
DEF FIFTEENPUZZLE_PANEL_COUNT EQU 16
DEF FIFTEENPUZZLE_EMPTY_PANEL_NUM EQU FIFTEENPUZZLE_PANEL_COUNT - 1

FifteenPuzzleMinigame:
	call .LoadGFXAndPals
	call DelayFrame
.loop:
	call .JumptableLoop
	jr nc, .loop
	call TextboxWaitPressAorB_BlinkCursor
	ret

.LoadGFXAndPals
	call DisableLCD
	ld hl, FifteenPuzzleGFX
	ld de, vChars2
	ld bc, $28 tiles

	ld a, BANK(FifteenPuzzleGFX)
	call FarCopyData
	
	call FifteenPuzzleMinigame_Tilemap.PlaceBorderTiles
	call .SetPanels
	
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
	ldh [rOBP0], a
	ret

.SetPanels:
	call Random
	and %00000111
	ld hl, wFifteenPuzzleIconNumber
	cp [hl]
	jr z, .SetPanels
	ld [hl], a
	
	call FifteenPuzzleMinigame_Tilemap.InitShufflePuzzleLayout
	call FifteenPuzzleMinigame_Tilemap
	call FifteenPuzzleMinigame_Tilemap.ShufflePuzzleLayout
	call FifteenPuzzleMinigame_Tilemap.PlaceTiles
	ld a, FIFTEENPUZZLE_EMPTY_PANEL_NUM
	ld [wFifteenPuzzlePosition], a
	
	ld a, 200
.SetPanelsLoop:
	push af
.SetPanels_1:
	call Random
	and %00000011
	ld e, a
	ld d, 0
	ld hl, .InputTable
	add hl, de
	ld a, [hl]
	ld [wFifteenPuzzleJoyStateBuffer], a
	call .ExecutePanelJumptable
	jr c, .SetPanels_1
	pop af
	dec a
	jr nz, .SetPanelsLoop
	ret

.InputTable:
	db D_UP
	db D_DOWN
	db D_LEFT
	db D_RIGHT

.JumptableLoop:
	ld a, [wJumptableIndex]
	bit FIFTEENPUZZLE_END_LOOP_F, a
	jr nz, .quit

	call .ExecuteJumptable

	call .LoadGFXBuffers
	call DelayFrame
	and a
	ret

.quit:
	scf
	ret

.LoadGFXBuffers:
	ld de, wFifteenPuzzlePanelNumberOrder
	hlcoord SCREEN_WIDTH - 4, 2
	call .sub
	ld de, wFifteenPuzzlePanelNumberOrder + 4
	hlcoord SCREEN_WIDTH - 4, 3
	call .sub
	ld de, wFifteenPuzzlePanelNumberOrder + 8
	hlcoord SCREEN_WIDTH - 4, 4
	call .sub
	ld de, wFifteenPuzzlePanelNumberOrder + 12
	hlcoord SCREEN_WIDTH - 4, 5
.sub:
	ld c, 4
.LoadGFXBuffersLoop:
	ld a, [de]
	inc de
	add a, FIFTEENPUZZLE_PANEL_COUNT
	ld [hl+], a
	dec c
	jr nz, .LoadGFXBuffersLoop
	ret

.ExecuteJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw .DoingPuzzle
	dw .FinishedPuzzle
	dw .SlideFinalPanel
	dw .SlidePuzzleLeft
	dw .PuzzleEndScreen

.DoingPuzzle:
	call FifteenPuzzleMinigame_Tilemap.IsPuzzleSolved
	jr c, .InitPuzzle

	ldh a, [hJoypadDown]
	ld [wFifteenPuzzleJoyStateBuffer], a	; The code to exit the minigame was blatantly stubbed out.
;	and B_BUTTON
;	jr nz, .ExitPuzzle
	call .ExecutePanelJumptable
	ret
.ExitPuzzle:
;	ld hl, wJumptableIndex
;	set FIFTEENPUZZLE_END_LOOP_F, [hl]
;	ret
.InitPuzzle:
	ld hl, wJumptableIndex
	inc [hl]
	ld a, FIFTEENPUZZLE_PANEL_COUNT * 4
	ld [wJumptableIndex + 1], a
.FinishedPuzzle:
	ld hl, wJumptableIndex + 1
	ld a, [hl]
	and a
	jr z, .FinishedPuzzle_Next
	dec [hl]
	ret
.FinishedPuzzle_Next:
	ld hl, wJumptableIndex
	inc [hl]								; FIFTEENPUZZLE_SLIDE_FINAL_PANEL
	ld a, 4
	ld [wJumptableIndex + 1], a
.SlideFinalPanel:
	ld hl, wJumptableIndex + 1
	ld a, [hl]
	and a
	jr z, .SlideFinalPanelScroll
	dec [hl]
	call FifteenPuzzleMinigame_Tilemap.SlideFinalPanelLeft
	ld c, 3
	call DelayFrames
	ret
.SlideFinalPanelScroll:
	call FifteenPuzzleMinigame_Tilemap
	ld hl, wJumptableIndex
	inc [hl]								; FIFTEENPUZZLE_SLIDE_PUZZLE_LEFT
	ld a, SCREEN_WIDTH - 4
	ld [wJumptableIndex + 1], a
	ld a, $02
	ld [wJumptableIndex + 2], a
.SlidePuzzleLeft:
	ld hl, wJumptableIndex + 1
	ld a, [hl]
	and a
	jr z, .SlidePuzzleLeft_End
	dec [hl]
	ld hl, wJumptableIndex + 2
	ld a, [hl]
	xor %11111111
	inc a
	ld [hl], a
	ldh [hSCY], a
	ld c, 3
	call DelayFrames
	ret
.SlidePuzzleLeft_End:
	ld hl, wJumptableIndex
	inc [hl]								; FIFTEENPUZZLE_END_SCREEN
	ld a, SCREEN_WIDTH - 4
	ld [wJumptableIndex + 1], a
.PuzzleEndScreen:
	ld hl, wJumptableIndex + 1
	ld a, [hl]
	and a
	jr z, .PuzzleEndScreen_End
	dec [hl]
	
	call FifteenPuzzleMinigame_Tilemap.SlidePuzzleLeft
	
	ld hl, wJumptableIndex + 2
	ld a, [hl]
	xor %11111111
	inc a
	ld [hl], a
	ldh [hSCY], a
	ld c, 3
	call DelayFrames
	ret

.PuzzleEndScreen_End:
	ld hl, wJumptableIndex
	set FIFTEENPUZZLE_END_LOOP_F, [hl]
	xor a
	ldh [hSCY], a
	ret

.ExecutePanelJumptable:
	ld a, [wFifteenPuzzlePosition]
	and %00001111
	ld e, a
	ld d, 0
	ld hl, .PositionJumptable
	add hl, de
	add hl, de
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	jp hl
	
.PositionJumptable:
	dw .PanelCanMoveUpLeft					; 1		(Row 1 Right)
	dw .PanelCanMoveUpLeftRight				; 2		(Row 1 Middle Right)
	dw .PanelCanMoveUpLeftRight 			; 3		(Row 1 Middle Left)
	dw .PanelCanMoveUpRight					; 4		(Row 1 Left)
	dw .PanelCanMoveUpDownLeft				; 5		(Row 2 Right)
	dw .PanelCanMoveAllDirections			; 6		(Row 2 Middle Right)
	dw .PanelCanMoveAllDirections			; 7		(Row 2 Middle Left)
	dw .PanelCanMoveUpDownRight				; 8		(Row 2 Left)
	dw .PanelCanMoveUpDownLeft				; 9		(Row 3 Right)
	dw .PanelCanMoveAllDirections			; 10	(Row 3 Middle Right)
	dw .PanelCanMoveAllDirections			; 11	(Row 3 Middle Left)
	dw .PanelCanMoveUpDownRight				; 12	(Row 3 Left)
	dw .PanelCanMoveDownLeft				; 13	(Row 4 Right)
	dw .PanelCanMoveDownLeftRight			; 14	(Row 4 Middle Right)
	dw .PanelCanMoveDownLeftRight			; 15	(Row 4 Middle Left)
	dw .PanelCanMoveDownRight				; 16	(Row 4 Left)
	
.PanelCanMoveUpLeft:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveLeftCheck
	ret
.PanelCanMoveUpLeftRight:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveLeftCheck
	ret nc
	call .PanelMoveRightCheck
	ret
.PanelCanMoveUpRight:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveRightCheck
	ret
.PanelCanMoveUpDownLeft:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveLeftCheck
	ret
.PanelCanMoveUpDownRight:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveRightCheck
	ret
.PanelCanMoveAllDirections:
	call .PanelMoveUpCheck
	ret nc
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveLeftCheck
	ret nc
	call .PanelMoveRightCheck
	ret
.PanelCanMoveDownLeft:
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveLeftCheck
	ret
.PanelCanMoveDownLeftRight:
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveLeftCheck
	ret nc
	call .PanelMoveRightCheck
	ret
.PanelCanMoveDownRight:
	call .PanelMoveDownCheck
	ret nc
	call .PanelMoveRightCheck
	ret

.PanelMoveDownCheck:
	ld a, [wFifteenPuzzleJoyStateBuffer]
	and D_DOWN
	jr nz, .PanelMoveDown
	scf
	ret
.PanelMoveDown:
	ld a, [wFifteenPuzzlePosition]
	and %00001111
	ld e, a
	ld d, 0
	sub 4
	ld c, a
	ld b, 0
	call .PanelMove

	ld a, [wFifteenPuzzlePosition]
	sub 4
	ld [wFifteenPuzzlePosition], a
	and a
	ret

.PanelMoveUpCheck:
	ld a, [wFifteenPuzzleJoyStateBuffer]
	and D_UP
	jr nz, .PanelMoveUp
	scf
	ret
.PanelMoveUp:
	ld a, [wFifteenPuzzlePosition]
	and %00001111
	ld e, a
	ld d, 0
	add 4
	ld c, a
	ld b, 0
	call .PanelMove

	ld a, [wFifteenPuzzlePosition]
	add 4
	ld [wFifteenPuzzlePosition], a
	and a
	ret

.PanelMoveRightCheck:
	ld a, [wFifteenPuzzleJoyStateBuffer]
	and D_RIGHT
	jr nz, .PanelMoveRight
	scf
	ret
.PanelMoveRight:
	ld a, [wFifteenPuzzlePosition]
	and %00001111
	ld e, a
	ld d, 0
	dec a
	ld c, a
	ld b, 0
	call .PanelMove

	ld a, [wFifteenPuzzlePosition]
	dec a
	ld [wFifteenPuzzlePosition], a
	and a
	ret
	
.PanelMoveLeftCheck:
	ld a, [wFifteenPuzzleJoyStateBuffer]
	and D_LEFT
	jr nz, .PanelMoveLeft
	scf
	ret
.PanelMoveLeft:
	ld a, [wFifteenPuzzlePosition]
	and %00001111
	ld e, a
	ld d, 0
	inc a
	ld c, a
	ld b, 0
	call .PanelMove

	ld a, [wFifteenPuzzlePosition]
	inc a
	ld [wFifteenPuzzlePosition], a
	and a
	ret

.PanelMove:
	ld hl, wFifteenPuzzlePanelNumberOrder
	add hl, bc
	ld b, [hl]
	ld a, [wFifteenPuzzleEmptyPanelNumber]
	ld [hl], a
	ld hl, wFifteenPuzzlePanelNumberOrder
	add hl, de
	ld [hl], b

	call FifteenPuzzleMinigame_Tilemap.PlaceTiles
	ret

FifteenPuzzleMinigame_Tilemap:
	xor a
	ldh [hBGMapMode], a
	ld a, [wFifteenPuzzleIconNumber]
	ld e, a
	ld d, $00
	ld hl, FifteenPuzzleIconTable
	add hl, de
	add hl, de
	add hl, de
	ld b, [hl]
	inc hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld de, wFifteenPuzzleGFXPointer
	ld a, b
	ld bc, FIFTEENPUZZLE_PANEL_COUNT * 4
	call FarCopyData
	
	ld hl, wFifteenPuzzleGFXPointer
	call .TilemapPositions
	call .LoadTilemap
	ld a, 1
	ldh [hBGMapMode], a
	ret
.TilemapPositions:
	decoord 0, 1
	call .GetPosition
	
	decoord 8, 1
	call .GetPosition
	
	decoord 0, 9
	call .GetPosition
	
	decoord 8, 9
	call .GetPosition
	ret
.GetPosition:
	ld a, 8
.GetPosition_Loop:
	push af
	push hl
	push de
	ld c, [hl]
	inc hl
	ld b, [hl]
	
	ld a, 8
.GetPosition_Loop_1:
	push af
	xor a
	
	sla c
	jr nc, .GetPosition_Pass
	inc a
.GetPosition_Pass:
	sla b
	jr nc, .GetPosition_Pass_1
	inc a
	inc a
.GetPosition_Pass_1:
	ld [de], a
	inc de
	
	pop af
	dec a
	jr nz, .GetPosition_Loop_1
	
	pop de
	ld hl, SCREEN_WIDTH
	add hl, de
	ld e, l
	ld d, h
	pop hl
	inc hl
	inc hl
	pop af
	
	dec a
	jr nz, .GetPosition_Loop
	ret
.LoadTilemap:
	ld de, wFifteenPuzzleBitmap
	ld hl, .Tilemap_Table
	ld c, FIFTEENPUZZLE_PANEL_COUNT
.LoadTilemap_Loop:
	push bc
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	
	ld a, 4
.LoadTilemap_Loop_1:
	push af
	push hl
	
	ld a, 4
.LoadTilemap_Loop_2:
	push af
	ld a, [hl+]
	ld [de], a
	inc de
	pop af
	dec a
	jr nz, .LoadTilemap_Loop_2
	
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop af
	dec a
	jr nz, .LoadTilemap_Loop_1
	
	pop hl
	inc hl
	inc hl
	pop bc
	dec c
	jr nz, .LoadTilemap_Loop
	ret

.PlaceTiles:
	xor a
	ldh [hBGMapMode], a
	ld hl, .Tilemap_Table
	ld de, wFifteenPuzzlePanelNumberOrder
	ld a, FIFTEENPUZZLE_PANEL_COUNT
.PlaceTiles_Loop:
	push af
	push de
	push hl
	
	ld a, [de]
	ld de, wFifteenPuzzleBitmap
	and %00001111
	swap a
	add a, e
	jr nc, .PlaceTiles_Pass
	inc d
.PlaceTiles_Pass:
	ld e, a

	ld a, [hl+]
	ld h, [hl]
	ld l, a

	call .PlaceTiles_Set

	pop hl
	inc hl
	inc hl
	pop de
	inc de
	pop af
	dec a
	jr nz, .PlaceTiles_Loop
	ld a, 1
	ldh [hBGMapMode], a
	ret
	
.PlaceTiles_Set:
	ld a, 4
.PlaceTiles_Loop_1:
	push af
	push hl
	ld a, 4
.PlaceTiles_Loop_2:
	push af
	ld a, [de]
	inc de
	ld [hl+], a
	pop af
	dec a
	jr nz, .PlaceTiles_Loop_2
	
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop af
	dec a
	jr nz, .PlaceTiles_Loop_1
	ret

.Tilemap_Table:
	dwcoord 0, 1
	dwcoord 4, 1
	dwcoord 8, 1
	dwcoord 12, 1
	dwcoord 0, 5
	dwcoord 4, 5
	dwcoord 8, 5
	dwcoord 12, 5
	dwcoord 0, 9
	dwcoord 4, 9
	dwcoord 8, 9
	dwcoord 12, 9
	dwcoord 0, 13
	dwcoord 4, 13
	dwcoord 8, 13
	dwcoord 12, 13
	
.InitShufflePuzzleLayout:
	ld hl, wFifteenPuzzlePanelNumberOrder
	ld c, FIFTEENPUZZLE_PANEL_COUNT
	xor a
.InitShufflePuzzleLayout_Loop:
	ld [hl+], a
	inc a
	dec c
	jr nz, .InitShufflePuzzleLayout_Loop
	ret
.ShufflePuzzleLayout:
	xor a
	ldh [hBGMapMode], a
	ld de, wFifteenPuzzleEmptyPanelBitmap
	hlcoord SCREEN_WIDTH - 4, SCREEN_HEIGHT - 5
	call .ShufflePuzzleLayout_SubRow
	call .ShufflePuzzleLayout_SubRow
	call .ShufflePuzzleLayout_SubRow
	call .ShufflePuzzleLayout_SubRow
	ld a, 1
	ldh [hBGMapMode], a

	ld a, FIFTEENPUZZLE_EMPTY_PANEL_NUM
	ld [wFifteenPuzzleEmptyPanelNumber], a
	ld hl, wFifteenPuzzleEmptyPanelBitmap
	ld bc, FIFTEENPUZZLE_PANEL_COUNT
	ld a, $1f								; Blank Tile
	call ByteFill
	ret
.ShufflePuzzleLayout_SubRow:
	ld c, 4
.ShufflePuzzleLayout_Loop:
	ld a, [de]
	inc de
	ld [hl+], a
	dec c
	jr nz, .ShufflePuzzleLayout_Loop
	ld bc, FIFTEENPUZZLE_PANEL_COUNT
	add hl, bc
	ret

.IsPuzzleSolved:
	ld hl, wFifteenPuzzlePanelNumberOrder
	ld c, FIFTEENPUZZLE_PANEL_COUNT
	xor a
.IsPuzzleSolved_Loop:
	cp [hl]
	jr nz, .IsPuzzleSolved_End
	inc a
	inc hl
	dec c
	jr nz, .IsPuzzleSolved_Loop
	scf
	ret
.IsPuzzleSolved_End:
	and a
	ret

.SlideFinalPanelLeft:
	call WaitForAutoBgMapTransfer
	hlcoord SCREEN_WIDTH - 8, SCREEN_HEIGHT - 5
	call .SlideFinalPanelLeft_Move
	hlcoord SCREEN_WIDTH - 8, SCREEN_HEIGHT - 4
	call .SlideFinalPanelLeft_Move
	hlcoord SCREEN_WIDTH - 8, SCREEN_HEIGHT - 3
	call .SlideFinalPanelLeft_Move
	hlcoord SCREEN_WIDTH - 8, SCREEN_HEIGHT - 2
	call .SlideFinalPanelLeft_Move
	ld a, 1
	ldh [hBGMapMode], a
	ret
.SlideFinalPanelLeft_Move:
	ld e, l
	ld d, h
	inc hl
	ld c, 7
.SlideFinalPanelLeft_Loop:
	ld a, [hl+]
	ld [de], a
	inc de
	dec c
	jr nz, .SlideFinalPanelLeft_Loop
	ld a, $1f
	ld [de], a
	ret

.SlidePuzzleLeft:
	call WaitForAutoBgMapTransfer
	hlcoord 0, 1
	ld a, SCREEN_HEIGHT - 2
.SlidePuzzleLeft_Loop:
	push af
	push hl
	call .SlidePuzzleLeft_Move
	pop hl
	ld bc, 20
	add hl, bc
	pop af
	dec a
	jr nz, .SlidePuzzleLeft_Loop

	ld a, 1
	ldh [hBGMapMode], a
	ret
.SlidePuzzleLeft_Move:
	ld e, l
	ld d, h
	inc hl
	ld c, SCREEN_WIDTH - 5					; Scroll Start Offset
.SlidePuzzleLeft_Move_Loop:
	ld a, [hl+]
	ld [de], a
	inc de
	dec c
	jr nz, .SlidePuzzleLeft_Move_Loop
	ld a, $1f								; Blank Tile
	ld [de],a
	ret
	
.PlaceBorderTiles:
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, $04
	call ByteFill
	
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT - 2
	ld a, $05
	call ByteFill

	hlcoord 0, SCREEN_HEIGHT - 1
	ld bc, SCREEN_HEIGHT - 2
	ld a, $08
	call ByteFill

	hlcoord SCREEN_WIDTH - 4, 0
	ld [hl], $06

	hlcoord SCREEN_WIDTH - 4, 1
	ld de, SCREEN_WIDTH
	ld c, SCREEN_WIDTH - 4
.PlaceBorderTilesRightColumn:
	ld [hl], $07
	add hl, de
	dec c
	jr nz, .PlaceBorderTilesRightColumn

	hlcoord SCREEN_WIDTH - 4, SCREEN_HEIGHT - 1
	ld [hl], $09

	hlcoord SCREEN_WIDTH - 4, 1
	call .PlaceBorderTilesRightColumn_Top
	hlcoord SCREEN_WIDTH - 4, 6
	ld [hl], $0a
	inc hl
	call .PlaceBorderTilesRightColumn_Bottom
	hlcoord SCREEN_WIDTH - 4, 12
	call .PlaceBorderTilesRightColumn_Top
	hlcoord SCREEN_WIDTH - 4, SCREEN_HEIGHT - 1
	ld [hl], $08
	inc hl
	call .PlaceBorderTilesRightColumn_Bottom
	ret
.PlaceBorderTilesRightColumn_Top:
	ld [hl], $0b
	inc hl
	ld [hl], $05
	inc hl
	ld [hl], $05
	inc hl
	ld [hl], $05
	ret
.PlaceBorderTilesRightColumn_Bottom:
	ld [hl], $08
	inc hl
	ld [hl], $08
	inc hl
	ld [hl], $08
	ret

SECTION "engine/games/fifteen_puzzle_minigame.asm@FifteenPuzzleIconTable", ROMX
	FifteenPuzzleIconTable:				; Icons used in the minigame are pulled from this table.
	table_width 3
	dba RhydonSpriteGFX
	dba ClefairySpriteGFX
	dba PidgeySpriteGFX
	dba CharizardSpriteGFX
	dba SnorlaxSpriteGFX
	dba SeelSpriteGFX
	dba PoliwrathSpriteGFX
	dba LaprasSpriteGFX
	assert_table_length 8
