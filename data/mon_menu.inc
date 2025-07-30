; An unreferenced, nonfunctional menu that resembles the field debug menu.
Unreferenced_FieldMoveMenu:
	ld hl, .MenuData
	call LoadMenuHeader
	call VerticalMenu
	ret

.MenuData:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 6, 10
	dw .MenuText
	db 1

.MenuText:
	db (STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING)
	db 3 ; amount of options
	db "うる@"      ; Switch
	db "かう@"      ; Buy
	db "やめる@"    ; Cancel
	db "くさかり@"   ; "Mower"? (replaced by Uproot)
	db "とんでけ@"   ; "Flight"? (replaced by Wind Ride)
	db "どんぶらこ@" ; "Splash"? (replaced by Water Sport)
	db "フルパワー@" ; "Full Power" (replaced by Strong Arm)
	db "ひかりゴケ@" ; Bright Moss
	db "うずしお@"   ; Whirlpool
	db "とびはねる@" ; Bounce
	db "あなをほる@" ; Dig
	db "テレポート@" ; Teleport
	db "タマゴうみ@" ; Softboiled

; MonMenuOptionStrings indexes
	const_def 1
	const MONMENUVALUE_STATS  ; 1
	const MONMENUVALUE_SWITCH ; 2
	const MONMENUVALUE_ITEM   ; 3
	const MONMENUVALUE_CANCEL ; 4
	const MONMENUVALUE_MOVE   ; 5
	const MONMENUVALUE_MAIL   ; 6
	const MONMENUVALUE_ERROR  ; 7
DEF NUM_MONMENUVALUES EQU const_value - 1

MonMenuOptionStrings:
	db "つよさをみる@" ; Stats
	db "ならびかえ@"   ; Switch
	db "そうび@"      ; Item
	db "キャンセル@"   ; Cancel
	db "もちわざ@"     ; Moves
	db "メール@"      ; Mail
	db "エラー！@"     ; Error!

Unreferenced_FieldMoveList:
	db MOVE_UPROOT, MONMENUITEM_CUT
	db MOVE_WIND_RIDE, MONMENUITEM_FLY
	db MOVE_WATER_SPORT, MONMENUITEM_SURF
	db MOVE_STRONG_ARM, MONMENUITEM_STRENGTH
	db MOVE_BRIGHT_MOSS, MONMENUITEM_FLASH
	db MOVE_WHIRLPOOL, MONMENUITEM_WHIRLPOOL
	db MOVE_BOUNCE, MONMENUITEM_BOUNCE
	db MOVE_DIG, MONMENUITEM_DIG
	db MOVE_TELEPORT, MONMENUITEM_TELEPORT
	db MOVE_SOFTBOILED, MONMENUITEM_SOFTBOILED
	db -1

MonMenuOptions:
	db MONMENU_FIELD_MOVE, MONMENUITEM_CUT,        MOVE_UPROOT
	db MONMENU_FIELD_MOVE, MONMENUITEM_FLY,        MOVE_WIND_RIDE
	db MONMENU_FIELD_MOVE, MONMENUITEM_SURF,       MOVE_WATER_SPORT
	db MONMENU_FIELD_MOVE, MONMENUITEM_STRENGTH,   MOVE_STRONG_ARM
	db MONMENU_FIELD_MOVE, MONMENUITEM_FLASH,      MOVE_BRIGHT_MOSS
	db MONMENU_FIELD_MOVE, MONMENUITEM_WHIRLPOOL,  MOVE_WHIRLPOOL
	db MONMENU_FIELD_MOVE, MONMENUITEM_BOUNCE,     MOVE_BOUNCE
	db MONMENU_FIELD_MOVE, MONMENUITEM_DIG,        MOVE_DIG
	db MONMENU_FIELD_MOVE, MONMENUITEM_TELEPORT,   MOVE_TELEPORT
	db MONMENU_FIELD_MOVE, MONMENUITEM_SOFTBOILED, MOVE_SOFTBOILED
	db MONMENU_MENUOPTION, MONMENUITEM_STATS,      MONMENUVALUE_STATS
	db MONMENU_MENUOPTION, MONMENUITEM_SWITCH,     MONMENUVALUE_SWITCH
	db MONMENU_MENUOPTION, MONMENUITEM_ITEM,       MONMENUVALUE_ITEM
	db MONMENU_MENUOPTION, MONMENUITEM_CANCEL,     MONMENUVALUE_CANCEL
	db MONMENU_MENUOPTION, MONMENUITEM_MOVE,       MONMENUVALUE_MOVE
	db MONMENU_MENUOPTION, MONMENUITEM_MAIL,       MONMENUVALUE_MAIL
	db MONMENU_MENUOPTION, MONMENUITEM_ERROR,      MONMENUVALUE_ERROR
	db -1
	