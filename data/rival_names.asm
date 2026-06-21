INCLUDE "constants.asm"

SECTION "data/rival_names.asm", ROMX

ChooseRivalName::
	call PanPortraitRight
	ld hl, RivalNameMenuHeader
	call NamingWindow
	ld a, [wMenuCursorY]
	dec a
	jr z, .loop
	ld de, wRivalName
	call SaveCustomName
	jr .farjump

.loop
	ld b, NAME_RIVAL
	ld de, wRivalName
	farcall NamingScreen
	ld a, [wRivalName]
	cp '@'
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, OakPic
	lb bc, BANK(OakPic), 0
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
.farjump
	ld hl, ChooseRivalNameEndText
	call PrintText
	ret

ChooseRivalNameEndText:
	text "そうか　そうだったな"
	line "<RIVAL>　という　なまえだ"
	prompt

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
