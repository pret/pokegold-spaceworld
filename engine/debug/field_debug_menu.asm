; FieldDebugMenu.ReturnJumptable constants
	const_def
	const FIELDDEBUG_RETURN_REOPEN     ; 0
	const FIELDDEBUG_RETURN_WAIT_INPUT ; 1
	const FIELDDEBUG_RETURN_CLOSE      ; 2
	const FIELDDEBUG_RETURN_CLEANUP    ; 3
	const FIELDDEBUG_RETURN_EXIT       ; 4

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

INCLUDE "data/debug/field_debug_entries.asm"

FieldDebugMenu::
	call ReanchorMap
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
	call CloseText
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

INCLUDE "engine/debug/field/change_transportation.asm"
