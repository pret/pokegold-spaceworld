; MenuHeader flags
	const_def
	shift_const MENU_RESTORE_TILES ; Will be set if MENU_BACKUP_TILES(_2) is set.
	const_skip 2
	shift_const MENU_NO_CLICK_SFX
	shift_const MENU_SPRITE_ANIMS
	shift_const MENU_UNUSED
	shift_const MENU_BACKUP_TILES
	shift_const MENU_BACKUP_TILES_2

; VerticalMenu/DoNthMenu/SetUpMenu/_2DMenu MenuData flags
; Per flag the comment specifies which menus actually implement it
	const_def
	shift_const STATICMENU_DISABLE_B ; VerticalMenu/_2DMenu
	shift_const STATICMENU_ENABLE_SELECT ; VerticalMenu/_2DMenu
	shift_const STATICMENU_ENABLE_LEFT_RIGHT ; DoNthMenu/SetUpMenu
	shift_const STATICMENU_ENABLE_START ; DoNthMenu/SetUpMenu
	shift_const STATICMENU_PLACE_TITLE ; VerticalMenu
	shift_const STATICMENU_WRAP ; All
	shift_const STATICMENU_NO_TOP_SPACING ; VerticalMenu/_2DMenu
	shift_const STATICMENU_CURSOR ; VerticalMenu/_2DMenu

; ScrollingMenu MenuData flags
	const_def
	shift_const SCROLLINGMENU_CALL_FUNCTION1_CANCEL
	shift_const SCROLLINGMENU_CALL_FUNCTION3_NO_SWITCH
	shift_const SCROLLINGMENU_ENABLE_LEFT
	shift_const SCROLLINGMENU_ENABLE_RIGHT
	shift_const SCROLLINGMENU_DISPLAY_ARROWS
	shift_const SCROLLINGMENU_ENABLE_FUNCTION3
	shift_const SCROLLINGMENU_ENABLE_START
	shift_const SCROLLINGMENU_ENABLE_SELECT

; _2DMenu more flags
	const_def
	shift_const _2DMENU_EXIT_RIGHT            ; 0
	shift_const _2DMENU_EXIT_LEFT             ; 1
	shift_const _2DMENU_EXIT_UP               ; 2
	shift_const _2DMENU_EXIT_DOWN             ; 3
	shift_const _2DMENU_WRAP_LEFT_RIGHT       ; 4
	shift_const _2DMENU_WRAP_UP_DOWN          ; 5
	shift_const _2DMENU_ENABLE_SPRITE_ANIMS   ; 6
	shift_const _2DMENU_DISABLE_JOYPAD_FILTER ; 7

; _2DMenu more flags 2
	const_def
	const_skip 7
	shift_const _2DMENU_EXITING ; 7


; MonMenuOptions indexes (see data/mon_menu.asm)
; used by PokemonActionSubmenu (see engine/menus/start_menu.asm)
	const_def 1
	; moves
	const MONMENUITEM_CUT			; 1
	const MONMENUITEM_FLY			; 2
	const MONMENUITEM_SURF			; 3
	const MONMENUITEM_STRENGTH		; 4
	const MONMENUITEM_FLASH			; 5
	const MONMENUITEM_WHIRLPOOL		; 6
	const MONMENUITEM_BOUNCE		; 7
	const MONMENUITEM_DIG			; 8
	const MONMENUITEM_TELEPORT		; 9
	const MONMENUITEM_SOFTBOILED	; 10
	; options
	const MONMENUITEM_STATS      ; 11
	const MONMENUITEM_SWITCH     ; 12
	const MONMENUITEM_ITEM       ; 13
	const MONMENUITEM_CANCEL     ; 14
	const MONMENUITEM_MOVE       ; 15
	const MONMENUITEM_MAIL       ; 16
	const MONMENUITEM_ERROR      ; 17

; MonMenuOptions categories
DEF MONMENU_MENUOPTION EQU 0
DEF MONMENU_FIELD_MOVE EQU 1

DEF NUM_MONMENU_ITEMS EQU 8

; start/select menu return values
DEF HMENURETURN_SCRIPT EQU %10000000
DEF HMENURETURN_ASM    EQU %11111111


; PartyMenuQualityPointers indexes (see data/party_menu_qualities.asm)
	const_def
	const PARTYMENUACTION_CHOOSE_POKEMON
	const PARTYMENUACTION_HEALING_ITEM
	const PARTYMENUACTION_SWITCH
	const PARTYMENUACTION_TEACH_TMHM
	const PARTYMENUACTION_MOVE
	const PARTYMENUACTION_EVO_STONE
	const PARTYMENUACTION_GIVE_MON
	const PARTYMENUACTION_GIVE_MON_FEMALE ; unused
	const PARTYMENUACTION_GIVE_ITEM
	const PARTYMENUACTION_MOBILE ; mobile
; PrintPartyMenuActionText arguments (see engine/pokemon/party_menu.asm)
	const_def $f0
	const PARTYMENUTEXT_HEAL_PSN
	const PARTYMENUTEXT_HEAL_BRN
	const PARTYMENUTEXT_HEAL_FRZ
	const PARTYMENUTEXT_HEAL_SLP
	const PARTYMENUTEXT_HEAL_PAR
	const PARTYMENUTEXT_HEAL_HP
	const PARTYMENUTEXT_HEAL_ALL
	const PARTYMENUTEXT_REVIVE
	const PARTYMENUTEXT_LEVEL_UP
	const PARTYMENUTEXT_HEAL_CONFUSION

; ScrollingMenu items structure format
	const_def 1
	const SCROLLINGMENU_ITEMS_NORMAL
	const SCROLLINGMENU_ITEMS_QUANTITY
