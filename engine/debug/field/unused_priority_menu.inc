FieldDebug_UnusedSetPriority:
	ld hl, .MenuHeader
	call GetMenu2
	jr c, .done
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .skip
	ld a, 0
	call SetObjFlags2_7_IfVisible
	jr .done

.skip
	ld a, 0
	call ResetObjFlags2_7_IfVisible
.done
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 8, 6
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "ゆうせん@"
	db "ひゆうせん@"

