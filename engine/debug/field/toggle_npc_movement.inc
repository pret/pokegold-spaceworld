FieldDebug_ToggleNPCMovement:
	call .ToggleNPCMovement
	jr nc, .close
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.close
	ld a, FIELDDEBUG_RETURN_CLOSE
	ret

.ToggleNPCMovement:
	ld hl, .MenuHeader
	call GetMenu2
	ret c
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .move
; stop NPCs
	ld a, 0
	call Function17f9
	jr .done

.move
	call Function1848
.done
	and a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 7, 6
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "とめる@"
	db "うごかす@"

