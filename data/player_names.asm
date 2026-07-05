PlayerNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 11
	dw .Names
	db 1 ; initial selection

.Names:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db NUM_PLAYER_NAMES + 1 ; items
	db "じぶんできめる@"

	list_start PLAYER_NAME_LENGTH - 1
FOR n, 1, NUM_PLAYER_NAMES + 1
	li #PLAYERNAME{d:n}
ENDR
	assert_list_length NUM_PLAYER_NAMES
	db 3 ; x offset for the title string
	db "なまえこうほ@"
