CallSubGameMenu:
	call ClearTileMap
	call LoadFont
	call LoadFontsBattleExtra
	call ClearSprites
	call GetMemSGBLayout
	ld hl, .MenuHeader
	call CopyMenuHeader
	call VerticalMenu
	ret c

	ld a, [wMenuCursorY]
	dec a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl

.return
	jr CallSubGameMenu

.Jumptable:
	dw SubGameMenu_PokerGame
	dw SubGameMenu_PuzzleGame
	dw SubGameMenu_CardFlipGame
	dw SubGameMenu_PicrossGame
	dw SubGameMenu_SlotMachineGame

.MenuHeader:
	db 0 ; flags
	menu_coords 5, 4, SCREEN_WIDTH - 7, SCREEN_HEIGHT - 3
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP
	db 5 ; items
	db "ポーカー@"
	db "１５パズル@"
	db "しんけい@"
	db "ピクロス@"
	db "スロット@"

SubGameMenu_PokerGame:
	callfar PokerMinigame
	ret

SubGameMenu_PuzzleGame:
	callfar FifteenPuzzleMinigame
	ret

SubGameMenu_CardFlipGame:
	callfar MemoryMinigame
	ret

SubGameMenu_PicrossGame:
	callfar PicrossMinigame
	ret

SubGameMenu_SlotMachineGame:
	callfar SlotMachineGame
	ret
