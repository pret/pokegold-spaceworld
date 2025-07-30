INCLUDE "constants.asm"

SECTION "engine/menu/menu_2.asm", ROMX

PlacePackItems::
	ld a, [wMenuSelection]
	cp -1
	jr z, .cancel
	push de
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld e, a
	ld d, 0
	ld hl, .attribute_icons
	add hl, de
	ld a, [hl]
	pop de
	ld [de], a
	inc de
	jr PlaceMenuItemName

.attribute_icons:
	db "　"
	db $62  ; TM Holder icon
	db $64  ; Ball Holder icon
	db $63  ; Key Items icon
	db "　"
	db "　"
	db "　"

.cancel
	ld h, d
	ld l, e
	ld de, .CancelString
	call PlaceString
	ret

.CancelString:
	db "　ーーやめるーー@"

PlaceMenuItemName::
	push de
	ld a, [wMenuSelection]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	pop hl
	call PlaceString
	ret

PlaceMenuItemQuantity::
	push de
	ld a, [wMenuSelection]
	ld [wCurItem], a
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	pop hl
	and a
	jr nz, .done
	ld [hl], "×"
	inc hl
	ld de, wMenuSelectionQuantity
	lb bc, 1, 2
	call PrintNumber
.done
	ret

PlacePartyMonNicknames::
	ld hl, wPartyMonNicknames
	jr PlaceMonNicknames

PlaceBoxMonNicknames::
	ld hl, wBoxMonNicknames
PlaceMonNicknames:
	push de
	ld a, [wScrollingMenuCursorPosition]
	call GetNick
	pop hl
	call PlaceString
	ret

PlacePartyMonLevels::
	ld a, PARTYMON
	ld [wMonType], a
	jr PlaceMonLevels

PlaceBoxMonLevels::
	ld a, BOXMON
	ld [wMonType], a
PlaceMonLevels:
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	predef CopyMonToTempMon
	pop hl
	call PrintLevel
	ret

; Unreferenced.
	ret

; Prints the names, nicknames, levels, and genders of Pokémon.
PlaceDetailedBoxMonView::
	push de
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wBoxSpecies
	add hl, bc

	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	call PlaceString
	ld de, MON_NAME_LENGTH
	add hl, de
	push hl

	ld a, [wScrollingMenuCursorPosition]
	ld hl, wBoxMonNicknames
	call GetNick
	pop hl
	call PlaceString
	ld de, MON_NAME_LENGTH
	add hl, de
	push hl

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	predef CopyMonToTempMon
	pop hl
	push hl
	call PrintLevel
	pop hl
	ld de, 3
	add hl, de
	push hl

	callfar GetGender
	ld a, "♂"
	jr c, .male
	ld a, "♀"
.male
	pop hl
	ld [hl], a
	ret

Unreferenced_PlaceMoneyTextbox_Old::
	ld hl, .MenuHeader
	call CopyMenuHeader
	call MenuBox
	call PlaceVerticalMenuItems
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, wMoney
	lb bc, PRINTNUM_RIGHTALIGN | 3, 6
	call PrintNumber
	ret

.MenuHeader:
	db 0
	menu_coords 11, 0, SCREEN_WIDTH - 1, 2
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_NO_TOP_SPACING
	db 1
	db "　　　　　　円@"

PlaceMoneyTopRight::
	ld hl, MoneyTopRightMenuHeader
	call CopyMenuHeader
	jr PlaceMoneyTextbox

; Unreferenced.
PlaceMoneyAtTopLeftOfTextbox::
	ld hl, MoneyTopRightMenuHeader
	ld d, 11
	ld e, 0
	call OffsetMenuHeader

PlaceMoneyTextbox:
	call MenuBox
	call MenuBoxCoord2Tile
	ld de, SCREEN_WIDTH + 1
	add hl, de
	ld de, wMoney
	lb bc, PRINTNUM_RIGHTALIGN | 3, 6
	call PrintNumber
	ld [hl], "円"
	ret

MoneyTopRightMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 11, 0, SCREEN_WIDTH - 1, 2
	dw NULL
	db 1
