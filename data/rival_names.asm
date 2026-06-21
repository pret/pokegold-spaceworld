INCLUDE "constants.asm"

SECTION "data/rival_names.asm", ROMX

RivalNameMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .Names
	db 01 ; initial selection

.Names:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B
	db 04 ; items
	db "じぶんできめる@"
if DEF(_GOLD)
	db "シルバー@"
	db "シゲル@"
	db "ジョン@"
endc
if DEF(_SILVER)
	db "ゴールド@"
	db "サトシ@"
	db "ジャック@"
endc
	db 3
	db "なまえこうほ@"
