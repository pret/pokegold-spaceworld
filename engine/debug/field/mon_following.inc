FieldDebug_PokemonFollowing:
	call .DoPokemonFollowing
	jr c, .exit
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
.exit
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

.DoPokemonFollowing:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	jr c, .done
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .remove
	ld a, [wPlayerStructEnd]
	and a
	jr nz, .ShowUnableText
	callab Function8031
	ld de, SFX_24
	call PlaySFX
	call CloseWindow
	call UpdateSprites
	scf
	ret

.remove
	callab Function806c
	ld de, SFX_25
	call PlaySFX
	jr .done

.ShowUnableText:
	ld hl, .UnableText
	call FieldDebug_ShowTextboxAndExit

.done
	call CloseWindow
	call UpdateSprites
	xor a
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 3, 3, 9, 9
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "つける@"
	db "はずす@"

.UnableText:
	text "だめです！！"
	done

