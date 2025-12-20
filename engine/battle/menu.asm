INCLUDE "constants.asm"

SECTION "engine/battle/menu.asm", ROMX

LoadBattleMenu::
	ld hl, BattleMenuHeader
	jr CommonBattleMenu

; Unreferenced.
SafariBattleMenu::
	ld hl, SafariBattleMenuHeader
	; fallthrough
CommonBattleMenu:
	call LoadMenuHeader
	ld a, [wBattleMenuCursorPosition]
	ld [wMenuCursorPosition], a
	call Battle_2DMenu
	ld a, [wMenuCursorPosition]
	ld [wBattleMenuCursorPosition], a
	call ExitMenu
	ret

BattleMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 9, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	dn 2, 2
	db 5
	db "たたかう@" ; "FIGHT"
	db "どうぐ@"   ; "ITEM"
	db "#@"       ; "<PK><MN>"
	db "にげる@"   ; "RUN"

SafariBattleMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 12, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 1
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	dn 2, 2
	db 11
	db "サファリボール×　　　@" ; "SAFARI BALL×   @"
	db "エサをなげる@"         ; "THROW BAIT"
	db "いしをなげる@"         ; "THROW ROCK"
	db "にげる@"              ; "RUN"

Battle_2DMenu:
	call CopyMenuData
	call MenuBox
	ld a, [wMenuData_2DMenuDimensions]
	ld b, a
	and $0f
	ld [wBattleMenuRows], a ; rows

	ld a, b
	and $f0
	swap a
	ld [wBattleMenuColumns], a ; columns

	call .PlaceStrings
	call .InitAndHandleCursor
	call StaticMenuJoypad
	ldh a, [hJoySum]
	bit SELECT_F, a
	jr nz, .quit

	ld a, [w2DMenuNumRows]
	ld c, a
	ld a, [wMenuCursorY]
	dec a
	call .GetNewCursorPos
	ld c, a
	ld a, [wMenuCursorX]
	add c
	ld [wMenuCursorPosition], a
	and a
	ret

.quit
	scf
	ret

.GetNewCursorPos:
	and a
	ret z
	push bc
	ld b, a
	xor a
.loop
	add c
	dec b
	jr nz, .loop
	pop bc
	ret

.unreferenced_24baf:
	ld b, 0
.loop2
	inc b
	sub c
	jr nc, .loop2
	dec b
	add c
	ret

.PlaceStrings:
	ld hl, wMenuDataPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, 3
	add hl, de
	ld d, h
	ld e, l
	call GetMenuTextStartCoord
	call Coord2Tile
	ld a, [wBattleMenuRows]
	ld b, a
.column_loop
	push bc
	push hl
	ld a, [wBattleMenuColumns]
	ld c, a
.row_loop
	push bc
	call PlaceString
	inc de
	ld a, [wMenuData_2DMenuSpacing]
	ld c, a
	ld b, 0
	add hl, bc
	pop bc
	dec c
	jr nz, .row_loop
	
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .column_loop
	ret

.InitAndHandleCursor:
	call GetMenuTextStartCoord
	ld a, b
	ld [w2DMenuCursorInitY], a
	dec c
	ld a, c
	ld [w2DMenuCursorInitX], a
	ld a, [wBattleMenuRows]
	ld [w2DMenuNumRows], a
	ld a, [wBattleMenuColumns]
	ld [w2DMenuNumCols], a

	ld a, [wMenuDataFlags]
	ld d, a
	bit STATICMENU_WRAP_F, d
	ld a, 0
	jr z, .no_wrap
	ld a, _2DMENU_WRAP_LEFT_RIGHT | _2DMENU_WRAP_UP_DOWN

.no_wrap
	ld [w2DMenuFlags1], a
	ld a, [wMenuData_2DMenuSpacing]
	or $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | SELECT
	ld [wMenuJoypadFilter], a
	ld a, [w2DMenuNumCols]
	ld e, a
	ld a, [wMenuCursorPosition]
	ld b, a
	xor a
	ld d, 0

.loop3
	inc d
	add e
	cp b
	jr c, .loop3

	sub e
	ld c, a
	ld a, b
	sub c
	and a
	jr z, .left_wrap
	cp e
	jr z, .right_wrap
	jr c, .right_wrap

.left_wrap
	ld a, 1
.right_wrap
	ld [wMenuCursorX], a
	ld a, [w2DMenuNumRows]
	ld e, a
	ld a, d
	and a
	jr z, .up_wrap
	cp e
	jr z, .down_wrap
	jr c, .down_wrap

.up_wrap
	ld a, 1
.down_wrap
	ld [wMenuCursorY], a
	xor a
	ld [wCursorOffCharacter], a
	ld [wCursorCurrentTile], a
	ld [wCursorCurrentTile + 1], a
	ret
