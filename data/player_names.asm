INCLUDE "constants.asm"

SECTION "data/player_names.asm", ROMX

PlayerNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .Names
	db 01 ; initial selection

.Names:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db 04 ; items
	db "じぶんできめる@"
if DEF(_GOLD)
	db "ゴールド@"
	db "サトシ@"
	db "ジャック@"
endc
if DEF(_SILVER)
	db "シルバー@"
	db "シゲル@"
	db "ジョン@"
endc
	db 3 ; x offset for the title string
	db "なまえこうほ@"
