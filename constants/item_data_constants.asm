; item_attributes struct members (see data/items/attributes.asm)
	const_def
	const ITEMATTR_PRICE
	const ITEMATTR_PRICE_HI
	const ITEMATTR_EFFECT
	const ITEMATTR_PARAM
	const ITEMATTR_PERMISSIONS
	const ITEMATTR_POCKET
	const ITEMATTR_HELP
ITEMATTR_STRUCT_LENGTH EQU const_value

; item types
	const_def 1
	const ITEM     ; 1
	const KEY_ITEM ; 2
	const BALL     ; 3
	const TM_HM    ; 4

; item menu types
; UseItem.dw indexes (see engine/items/pack.asm)
; UseRegisteredItem.SwitchTo indexes (see engine/overworld/select_menu.asm)
ITEMMENU_NOUSE   EQU 0
ITEMMENU_CURRENT EQU 4
ITEMMENU_PARTY   EQU 5
ITEMMENU_CLOSE   EQU 6

; item actions
CANT_SELECT_F EQU 6
CANT_TOSS_F   EQU 7

NO_LIMITS   EQU 0
CANT_SELECT EQU 1 << CANT_SELECT_F
CANT_TOSS   EQU 1 << CANT_TOSS_F

; pack pockets
	const_def
	const ITEM_POCKET     ; 0
	const BALL_POCKET     ; 1
	const KEY_ITEM_POCKET ; 2
	const TM_HM_POCKET    ; 3
NUM_POCKETS EQU const_value

MAX_ITEMS     EQU 20
MAX_KEY_ITEMS EQU 20
MAX_PC_ITEMS  EQU 50