FieldDebug_Minigames:
	call .DoMinigameSelection
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoMinigameSelection:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	push af
	ld a, [wMenuCursorY]
	dec a
	call CopyNameFromMenu
	ld a, [wMenuCursorY]
	dec a
	ld e, a
	ld d, 0
	ld hl, .MinigamePointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wQueuedScriptBank], a
	ld a, [hli]
	ld [wQueuedScriptAddr], a
	ld a, [hl]
	ld [wQueuedScriptAddr + 1], a
	pop af
	call CloseWindow
	ret c

	ld hl, .MinigameConfirmationText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c

	call LoadStandardMenuHeader
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearSprites
	call ClearTileMap
	call WaitBGMap
	ld hl, wQueuedScriptBank
	call CallPointerAt
	call ClearPalettes
	call ReloadSpritesAndFont
	call LoadTilesetGFX
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call CloseWindow
	pop af
	ldh [hMapAnims], a
	call GetMemSGBLayout
	call WaitBGMap
	call UpdateTimePals
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 10, 10
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "スロットマシン@"
	db "ポーカーゲーム@"
	db "ペアゲーム@"

.MinigamePointers:
	dba SlotMachineGame
	dba PokerMinigame
	dba MemoryMinigame

.MinigameConfirmationText:
	text_from_ram wStringBuffer2
	text "で　"
	line "あそびますか？"
	done

