DisplayStartMenu::
	call ReanchorMap
	ld de, SFX_MENU
	call PlaySFX
	ld hl, .StartMenuHeader
	call LoadMenuHeader
.RefreshStartDisplay
	call UpdateTimePals
	call UpdateSprites
	call ClearJoypad
	call GetStartMenuState
	ld a, [wStartmenuCursor]
	ld [wMenuCursorPosition], a
	call OpenMenu
	jr c, .MainReturn
	ld a, [wMenuCursorPosition]
	ld [wStartmenuCursor], a
	call PlaceHollowCursor
	ld a, [wMenuSelection]
	ld hl, StartMenuJumpTable
	call CallJumptable
	ld hl, .StartMenuEntriesReturnTable
	jp CallJumptable

.StartMenuEntriesReturnTable:
	dw .RefreshStartDisplay
	dw .MainReturn
	dw .exit
	dw .UpdateTime
	dw .ExitAndHookFF

.MainReturn
	call .WaitForARelease
	call LoadFontExtra
.exit
	call ExitMenu
.UpdateTime
	call CloseText
	call UpdateTimePals
	ret

.unused
	call .WaitForARelease
	call LoadFontExtra
	call CloseWindow
	jr .UpdateTime

.WaitForARelease
	call GetJoypad
	ldh a, [hJoyDown]
	bit B_PAD_A, a
	jr nz, .WaitForARelease
	ret

.ExitAndHookFF:
	call ExitMenu
	ld a, $FF
	ldh [hStartmenuCloseAndSelectHookEnable], a
	jr .UpdateTime

.StartMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 12, 0, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1 ; default option

.MenuData:
	db STATICMENU_CURSOR | STATICMENU_WRAP | STATICMENU_ENABLE_START ; flags
	db 0 ; items
	dw StartMenuItems
	dw PlaceMenuStrings
	dw .Strings

.Strings:
	db "ずかん@"
	db "ポケモン@"
	db "リュック@"
	db "<PLAYER>@"
	db "レポート@"
	db "せってい@"
	db "とじる@"
	db "わくせん@"
	db "リセット@"

StartMenuJumpTable:
	dw StartMenu_Pokedex
	dw StartMenu_Party
	dw StartMenu_Backpack
	dw StartMenu_Status
	dw StartMenu_Save
	dw StartMenu_Settings
	dw StartMenu_Exit
	dw StartMenu_SetFrame
	dw StartMenu_Reset

StartMenuItems:
	db 4
	db START_SAVE
	db START_OPTIONS
	db START_TRAINERCARD
	db START_EXIT
	db -1

	db 5
	db START_PARTY
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 6
	db START_POKEDEX
	db START_PARTY
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 7
	db START_POKEDEX
	db START_PARTY
	db START_BACKPACK
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 6
	db START_POKEDEX
	db START_PARTY
	db START_BACKPACK
	db START_TRAINERCARD
	db START_OPTIONS
	db START_EXIT
	db -1

GetStartMenuState:
; Stores one of four values to wActiveBackpackPocket
; based on story flags and debug mode.
; 4 = not debug (disables saving for demo)
; 3 = starting, 2 = rival beat in lab
; 1 = pokedex recieved, 0 = chose starter
	ld b, 4
	ld hl, wDebugFlags
	bit DEBUG_FIELD_F, [hl]
	jr z, .store
	ld b, 0
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	jr z, .store
	ld b, 1
	CheckEvent SILENT_HILL_LAB_FRONT_GOT_POKEDEX
	jr z, .store
	ld b, 2
	CheckEvent SILENT_HILL_LAB_FRONT_RIVAL_BATTLED
	jr z, .store
	ld b, 3
.store
	ld a, b
	ld [wActiveBackpackPocket], a
	ret

StartMenu_Exit:
; Exits the menu
	ld a, 1
	ret

StartMenu_SetFrame:
	callfar FrameTypeDialog
	ld a, 0
	ret

StartMenu_Reset:
; This SHOULD be the setup for a FarCall_hl to DisplayResetDialog.
; Instead, it mistakenly calls DisplayResetDialog prior to loading its bank.
; This causes it to read data as code, specifically from the middle of MapGroup_Newtype in vanilla.
	ld hl, DisplayResetDialog
	ld a, BANK(DisplayResetDialog)
	call DisplayResetDialog ; the problematic line
	ld a, 0
	ret

StartMenu_Save:
	predef SaveMenu
	call UpdateSprites
	ld a, 0
	ret

StartMenu_Settings:
	call LoadStandardMenuHeader
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	call UpdateSprites
	callfar MenuCallSettings
	call ClearPalettes
	call Call_ExitMenu
	call LoadTilesetGFX
	call LoadFontExtra
	call UpdateSprites
	call WaitBGMap
	call UpdateTimePals
	ld a, 0
	ret

StartMenu_Status:
	call _TrainerCard
	ld a, 0
	ret

_TrainerCard:
	call LoadStandardMenuHeader
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	callfar TrainerCardLoop
	call ClearPalettes
	call LoadFont
	call ReloadFontAndTileset
	call Call_ExitMenu
	call GetMemSGBLayout
	call WaitBGMap
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	ret

StartMenu_Pokedex:
	call LoadStandardMenuHeader
	predef Pokedex
	call ClearPalettes
	call RestoreScreenAndReloadTiles
	call ReloadFontAndTileset
	call Call_ExitMenu
	call GetMemSGBLayout
	call WaitBGMap
	call UpdateTimePals
	ld a, 0
	ret
