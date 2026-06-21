INCLUDE "constants.asm"

SECTION "data/player_names.asm", ROMX

ChoosePlayerName::
	call PanPortraitRight
	ld hl, PlayerNameMenuHeader
	call NamingWindow
	ld a, [wMenuCursorY]
	dec a
	jr z, .loop
	ld de, wPlayerName
	call SaveCustomName
	jr .farjump

.loop
	ld b, NAME_PLAYER
	ld de, wPlayerName
	farcall NamingScreen
	ld a, [wPlayerName]
	cp '@'
	jr z, .loop

	call GBFadeOutToWhite
	call ClearTileMap
	call LoadFontExtra
	call WaitBGMap
	ld de, ProtagonistPic
	lb bc, BANK(ProtagonistPic), 0
	call IntroDisplayPicCenteredOrUpperRight
	call GBFadeInFromWhite
.farjump
	ld hl, ChoosePlayerNameEndText
	call PrintText
	ret

ChoosePlayerNameEndText:
	text "ふむ・・・"
	line "<PLAYER>　と　いうんだな！"
	prompt

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
