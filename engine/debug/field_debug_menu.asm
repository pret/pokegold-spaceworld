INCLUDE "constants.asm"

; FieldDebugMenu.ReturnJumptable constants
	const_def
	const FIELDDEBUG_RETURN_REOPEN     ; 0
	const FIELDDEBUG_RETURN_WAIT_INPUT ; 1
	const FIELDDEBUG_RETURN_CLOSE      ; 2
	const FIELDDEBUG_RETURN_CLEANUP    ; 3
	const FIELDDEBUG_RETURN_EXIT       ; 4


SECTION "engine/menu/field_debug_menu.asm@FieldDebugMenuHeader", ROMX

FieldDebugMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 17
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_ENABLE_LEFT_RIGHT | STATICMENU_ENABLE_START | STATICMENU_WRAP | STATICMENU_CURSOR
	db 0
	dw FieldDebug_Pages
	dw PlaceMenuStrings
	dw FieldDebug_MenuStrings

INCLUDE "data/debug/field_debug_entries.inc"

FieldDebugMenu::
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, FieldDebugMenuHeader
	call LoadMenuHeader

; load first page
	ld a, 0
	ld [wFieldDebugPage], a

.Reopen:
	call UpdateTimePals
	call UpdateSprites
	ld a, [wFieldDebugMenuCursorBuffer]
	ld [wMenuCursorPosition], a
	call OpenMenu
	jr c, .WaitInput
	ld a, [wMenuCursorPosition]
	ld [wFieldDebugMenuCursorBuffer], a
	call PlaceHollowCursor

	ld a, [wMenuJoypad]
	cp A_BUTTON
	jr z, .DoJumptable

	call FieldDebug_ChangePage
	jr .DoReturn

.DoJumptable:
	ld a, [wMenuSelection]
	ld hl, FieldDebug_Jumptable
	call CallJumptable

.DoReturn:
	ld hl, .ReturnJumptable
	jp CallJumptable

.ReturnJumptable:
	dw .Reopen
	dw .WaitInput
	dw .Close
	dw .Cleanup
	dw .Exit

.WaitInput:
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .WaitInput
	call LoadFontExtra

.Close:
	call CloseWindow

.Cleanup:
	push af
	call ScreenCleanup
	pop af
	ret

.Exit:
	call ExitMenu
	ld a, -1
	ldh [hStartmenuCloseAndSelectHookEnable], a
	jr .Cleanup

FieldDebug_CloseMenu:
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

FieldDebug_ChangePage:
	ld a, [wMenuJoypad]
	cp D_LEFT
	jr z, .previous
	ld a, [wFieldDebugPage]
	inc a
	cp FIELDDEBUG_NUM_PAGES
	jr nz, .next
	xor a
.next
	ld [wFieldDebugPage], a
	jr FieldDebug_PlayMenuSound

.previous
	ld a, [wFieldDebugPage]
	dec a
	cp -1
	jr nz, .load_previous
	ld a, FIELDDEBUG_NUM_PAGES - 1
.load_previous
	ld [wFieldDebugPage], a
	jr FieldDebug_PlayMenuSound

FieldDebug_GoToNextPage:
; This will only scroll between the first two pages
; instead of the available three.

	ld a, [wFieldDebugPage]
	and a
	jr z, .page_1
	xor a
	jr .load_page
.page_1
	ld a, 1
.load_page
	ld [wFieldDebugPage], a

FieldDebug_PlayMenuSound:
	ld de, SFX_MENU
	call PlaySFX
.loop
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .loop
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_WaitJoypadInput:
	push bc
	ld b, a
.loop
	call GetJoypad
	ldh a, [hJoyDown]
	and b
	jr z, .loop
	pop bc
	ret

FieldDebug_ShowTextboxAndExit:
	call MenuTextBox
	ld a, A_BUTTON | B_BUTTON
	call FieldDebug_WaitJoypadInput
	call CloseWindow
	ret

FieldDebug_FrameType:
	call FrameTypeDialog
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_Reset:
	call DisplayResetDialog
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_ShowTrainerCard: ; unreferenced?
	callfar _TrainerCard
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/change_transportation.inc"

INCLUDE "engine/debug/field/change_tileset.inc"

FieldDebug_TownMap:
	call LoadStandardMenuHeader
	call ClearSprites
	callfar FlyMap
	call ClearPalettes
	call ReloadSpritesAndFont
	call LoadFontExtra
	call CloseWindow
	call GetMemSGBLayout
	call SetPalettes
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/sprite_viewer.inc"

FieldDebug_NamePlayer:
	call LoadStandardMenuHeader
	ld de, wPlayerName
	ld b, 1
	callfar NamingScreen
	call ClearBGPalettes
	call ClearTileMap
	call CloseWindow
	call ClearSprites
	call GetMemSGBLayout
	call SetPalettes
	ld hl, wOptions
	res NO_TEXT_SCROLL_F, [hl]
	call LoadFontExtra
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/toolgear.inc"

FieldDebug_HealPokemon:
	predef HealParty
	ld hl, .HealedText
	call MenuTextBoxBackup
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.HealedText:
	text "#の　たいりょくを"
	line "かいふくしました"
	prompt

FieldDebug_CableClub:
	callfar Function29abf
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/npc_movement_test.inc"

INCLUDE "engine/debug/field/mon_following.inc"

INCLUDE "engine/debug/field/follow_npc_test.inc"

INCLUDE "engine/debug/field/warp.inc"

INCLUDE "engine/debug/field/toggle_npc_movement.inc"

INCLUDE "engine/debug/field/field_cut.inc"

INCLUDE "engine/debug/field/check_tile.inc"

INCLUDE "engine/debug/field/move_to_entrance.inc"

FieldDebug_TrainerGear:
	call .OpenTrainerGear
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.OpenTrainerGear:
	call LoadStandardMenuHeader
	callfar OpenTrainerGear
	call ClearPalettes
	callfar StartMenuLoadSprites
	call CloseWindow
	ret

INCLUDE "engine/debug/field/map_viewer.inc"

INCLUDE "engine/debug/field/item_test.inc"

FieldDebug_PCMenu:
	callfar PokemonCenterPC
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/pokemart_menu.inc"

INCLUDE "engine/debug/field/teleport.inc"

INCLUDE "engine/debug/field/minigames.inc"

FieldDebug_VRAMViewer:
	call FieldDebug_DoVRAMViewer
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

FieldDebug_ClearEventFlags:
	call FieldDebug_DoClearEventFlags
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

INCLUDE "engine/debug/field/unused_flag_menu.inc"

INCLUDE "engine/debug/field/unused_priority_menu.inc"

INCLUDE "engine/debug/field/vram_viewer.inc"

