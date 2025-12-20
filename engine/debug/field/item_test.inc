ItemTest_BagMenu:
	dw .MenuHeader
	dw wRegularItemsCursor
	dw wRegularItemsScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 4, 1, 19, 10
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY
	dbw 0, wItems
; Incorrectly configured, will cause the game to crash
	db BANK(PlaceMenuItemName), $cd
	dw PlaceMenuItemName
	db BANK(PlaceMenuItemQuantity), $cd
	dw PlaceMenuItemQuantity
	db BANK(UpdateItemDescription)
	dw UpdateItemDescription

ItemTest_KeyItemMenu:
	dw .MenuHeader
	dw wBackpackAndKeyItemsCursor
	dw wBackpackAndKeyItemsScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 4, 1, 19, 10
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY
	dbw 0, wNumKeyItems
; Incorrectly configured, will cause the game to crash
	db BANK(PlaceMenuItemName), $cd
	dw PlaceMenuItemName
	db BANK(PlaceMenuItemQuantity), $cd
	dw PlaceMenuItemQuantity
	db BANK(UpdateItemDescription)
	dw UpdateItemDescription

FieldDebug_ItemTest:
	call ClearSprites
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call LoadStandardMenuHeader
	call ClearTileMap
	call UpdateSprites
	call .DoItemTest
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call CloseWindow
	ret
; unused
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.ClearTilemap:
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $f1
	call ByteFill
	ret

.DoItemTest:
	call .ClearTilemap
.bag_menu
	ld hl, ItemTest_BagMenu
	call ScrollingMenu_FromTable
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit_menu
	cp D_LEFT
	jr z, .key_item_menu
	cp D_RIGHT
	jr z, .key_item_menu
	jr .DecideAction

.key_item_menu
	ld hl, ItemTest_KeyItemMenu
	call ScrollingMenu_FromTable
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit_menu
	cp D_LEFT
	jr z, .bag_menu
	cp D_RIGHT
	jr z, .bag_menu
	ld hl, .CannotUsePCToolsText
	call MenuTextBox
	call CloseWindow
	jr .key_item_menu

.CannotUsePCToolsText:
	text "パソコンの　どうぐ　は"
	next "つかえません"
	prompt

.restart
	jp .DoItemTest

.exit_menu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret
; unused
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DecideAction:
	ld a, [wScrollingMenuCursorPosition]
	ld [wItemIndex], a
	call .ClearMenu
	call PlaceHollowCursor
	ld hl, .UseOrTossMenuHeader
	call GetMenu2
	jp c, .restart
	ld a, [wMenuCursorY]
	cp 2
	jr z, .toss_item
	jp .continue
; unused
	ld hl, .ItemPickedText
	call FieldDebug_ShowTextboxAndExit
	jp .restart

.ItemPickedText:
	text "アイテムを　えらんだ！"
	done

.ClearMenu:
	call MenuBoxCoord2Tile
	ld de, $14
	add hl, de
	ld de, $28
	ld a, [wMenuDataItems]
.clear_menu_loop
	ld [hl], '　'
	add hl, de
	dec a
	jr nz, .clear_menu_loop
	ret

.UseOrTossMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 14, 10, 19, 14
	dw .UseOrTossMenuData
	db 1

.UseOrTossMenuData:
	db $c0
	db 2
	db "つかう@"
	db "すてる@"

.toss_item
	ld hl, wItems
	call .DetermineItemTossable
	jp .DoItemTest

.DetermineItemTossable:
	push hl
	callfar _CheckTossableItem
	pop hl
	ld a, [wItemAttributeValue]
	and a
	jr nz, .not_tossable
	call .tossable
	jr .done

.not_tossable
	ld hl, .CannotTossText
	call MenuTextBox
	call CloseWindow
.done
	ret

.tossable
	push hl
	callfar SelectQuantityToToss
	jr c, .cancel_toss
	call .load_item
	ld hl, .TossConfirmText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .cancel_toss
	ld a, [wItemIndex]
	pop hl
	call TossItem
	call .load_item

; Crashes here; .ItemTossedText should be loaded to hl instead
	call .ItemTossedText
	call MenuTextBox

	call ExitMenu
	call CloseWindow
	and a
	ret

.cancel_toss
; Missing pop after push
	call CloseWindow
	scf
	ret

.load_item
	predef LoadItemData
	ret

.TossConfirmText:
	text_from_ram wStringBuffer2
	text "を　すてます"
	line "ほんとに　よろしいですか？"
	prompt

.ItemTossedText:
	text_from_ram wStringBuffer1
	text "を"
	line "すてました！"
	prompt

.CannotTossText:
	text "それは　とても　たいせつなモノです"
	line "すてることは　できません！"
	prompt

.continue
	predef LoadItemData
	ld a, [wCurItem]
	cp ITEM_TM01
	jr nc, .use_item2
	ld a, [wCurItem]
	call ItemTest_FindUsableItem2
	jr c, .use_item
	ld a, [wCurItem]
	call ItemTest_FindUsableItem
	jr c, .use_item2
	call DoItemEffect
	jp .restart

.use_item
	call DoItemEffect
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, .restart
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret

.use_item2
	call DoItemEffect
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	jp .restart

ItemTest_FindUsableItem:
	ld hl, ItemTest_UsableItems
	ld de, 1
	call FindItemInTable
	ret

INCLUDE "data/debug/field_debug_usable_items_1.inc"

ItemTest_FindUsableItem2:
	ld hl, ItemTest_UsableItems2
	ld de, 1
	call FindItemInTable
	ret

INCLUDE "data/debug/field_debug_usable_items_2.inc"
