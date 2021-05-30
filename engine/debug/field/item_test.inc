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
	db SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3
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
	db SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_FUNCTION3
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
	ld hl, wVramState
	res 0, [hl]
	call LoadStandardMenuHeader
	call ClearTileMap
	call UpdateSprites
	call .DoItemTest
	ld hl, wVramState
	set 0, [hl]
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
	call Function3810
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
	call Function3810
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
	ld [hl], "　"
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
	callab _CheckTossableItem
	pop hl
	ld a, [wItemAttributeParamBuffer]
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
	callab SelectQuantityToToss
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
	predef_id LoadItemData
	call Predef
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
	predef_id LoadItemData
	call Predef
	ld a, [wCurItem]
	cp ITEM_TM01
	jr nc, .use_item2
	ld a, [wCurItem]
	call .FindUsableItem2
	jr c, .use_item
	ld a, [wCurItem]
	call .FindUsableItem
	jr c, .use_item2
	call UseItem
	jp .restart

.use_item
	call UseItem
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, .restart
	ld a, FIELDDEBUG_RETURN_WAIT_INPUT
	ret

.use_item2
	call UseItem
	call ClearBGPalettes
	call Function360b
	jp .restart

.FindUsableItem:
	ld hl, .UsableItems
	ld de, 1
	call FindItemInTable
	ret

.UsableItems:
	db ITEM_BURN_HEAL
	db ITEM_ICE_HEAL
	db ITEM_AWAKENING
	db ITEM_PARLYZ_HEAL
	db ITEM_FULL_RESTORE
	db ITEM_MAX_POTION
	db ITEM_HYPER_POTION
	db ITEM_SUPER_POTION
	db ITEM_POTION
	db ITEM_ESCAPE_ROPE
	db ITEM_REPEL
	db ITEM_RARE_CANDY
	db ITEM_X_ACCURACY
	db ITEM_LEAF_STONE
	db ITEM_23
	db ITEM_NUGGET
	db ITEM_POKE_DOLL
	db ITEM_FULL_HEAL
	db ITEM_REVIVE
	db ITEM_MAX_REVIVE
	db ITEM_SODA_POP
	db ITEM_X_SPEED
	db ITEM_X_SPECIAL
	db ITEM_COIN_CASE
	db ITEM_3C
	db ITEM_SUPER_ROD
	db ITEM_PP_UP
	db ITEM_ELIXER
	db ITEM_MYSTIC_PETAL
	db ITEM_WHITE_FEATHER
	db ITEM_CONFUSE_CLAW
	db ITEM_SNAKESKIN
	db ITEM_ELECTRIC_POUCH
	db ITEM_TOXIC_NEEDLE
	db ITEM_KINGS_ROCK
	db ITEM_STRANGE_POWER
	db -1

.FindUsableItem2:
	ld hl, .UsableItems2
	ld de, 1
	call FindItemInTable
	ret

.UsableItems2:
	db ITEM_BICYCLE
	db ITEM_CARBOS
	db ITEM_UP_GRADE
	db ITEM_BIG_LEAF
	db ITEM_SHARP_STONE
	db ITEM_BLACK_FEATHER
	db ITEM_SHARP_FANG
	db -1

