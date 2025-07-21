FieldDebug_PokemartMenu:
	ld hl, DebugMart_WelcomeText
	call MenuTextBox
	call ExitMenu
	call .DoPokemartMenu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoPokemartMenu:
	call LoadStandardMenuHeader
	callfar PlaceMoneyTopRight
	ld hl, DebugMart_PokemartMenuText
	call PrintText
	ld hl, .MenuHeader
	call CopyMenuHeader
	call VerticalMenu
	push af
	call ExitMenu
	pop af
	jr c, .exit_menu
	ld a, [wMenuCursorY]
	dec a
	ld hl, .MenuJumptable
	call CallJumptable
	jr nc, .DoPokemartMenu
	ret

.exit_menu
	ld hl, DebugMart_GoodbyeText
	call MenuTextBoxBackup
	scf
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 10, 8
	dw .MenuData
	db 1 ; default

.MenuData:
	db STATICMENU_CURSOR
	db 3 ; items
	db "どうぐを　かう@"
	db "どうぐを　うる@"
	db "さようなら@"

.MenuJumptable:
	dw DebugMart_Buy
	dw DebugMart_Sell
	dw .exit_menu

DebugMart_BuyMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 3, 19, 11
	dw .BuyMenuParams
	db 1 ; default

.BuyMenuParams:
	db STATICMENU_WRAP
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wcd60
	dba PlaceMenuItemName
	dba .PrintAmount
	dba UpdateItemDescription

.PrintAmount:
	ld a, [wScrollingMenuCursorPosition]
	ld c, a
	ld b, 0
	ld hl, wcc3a
	add hl, bc
	add hl, bc
	add hl, bc
	push de
	ld d, h
	ld e, l
	pop hl
	ld c, $83
	call PrintBCDNumber
	ld [hl], "円"
	ret

DebugMart_WelcomeText:
	text "フレンドりーショップへ　"
	line "ようこそ！"
	prompt

DebugMart_PokemartMenuText:
	text "なんになさいますか？"
	done

DebugMart_GoodbyeText:
	text "またのごりようを"
	line "おまちしています"
	prompt

DebugMart_Buy:
	ld de, DebugMart_ItemList
	call DebugMart_LoadItems
	call LoadStandardMenuHeader
	call ClearTileMap
.buy_loop
	call .BuyMenu
	jr nc, .buy_loop
	call ExitMenu
	and a
	ret

.BuyMenu:
	call UpdateSprites
	ld hl, DebugMart_BuyMenuHeader
	call CopyMenuHeader
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .cancel_buy
	cp A_BUTTON
	jr z, .buy_item
.buy_item
	ld a, MAX_ITEM_STACK
	ld [wItemQuantityBuffer], a
	ld hl, .HowManyText
	call PrintText
	callfar SelectQuantityToBuy
	call ExitMenu
	jr c, .done
	predef LoadItemData
	ld hl, .ConfirmPurchaseText
	call PrintText
	call YesNoBox
	jr c, .done
	ld hl, .UnderDevelopmentText
	call MenuTextBoxBackup
.done
	and a
	ret

.cancel_buy
	scf
	ret

.BuyPromptText: ; unreferenced?
	text "なにを　おかいあげに"
	line "なりますか"
	done

.HowManyText:
	text "いくつ　おかいあげになりますか"
	done

.ConfirmPurchaseText:
	text_from_ram wStringBuffer2
	text "を　@"
	deciram wItemQuantity, 1, 2
	text "こで"
	line "@"
	deciram hMoneyTemp, 3, 6
	text "円　おかいあげですか？"
	done

.UnderDevelopmentText:
	text "ごめんね"
	line "かいはつちゅうなんだ"
	prompt

INCLUDE "data/debug/field_debug_pokemart_items.inc"

DebugMart_Sell:
	call DebugMart_ShowPlaceholderText
	and a
	ret

; unused
	callfar CheckItemsQuantity
	jp c, .no_items
	call LoadStandardMenuHeader
	xor a
	ld [wActiveBackpackPocket], a
.bag_loop
	callfar DrawBackpack
	callfar DebugBackpackLoop
	jr c, .close_bag
	call .DoBagFunctions
	jr nc, .bag_loop
.close_bag
	call ClearBGPalettes
	call CloseWindow
	call UpdateTimePals
	and a
	ret

.DoBagFunctions:
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .BagJumptable
	call CallJumptable
	ret

.BagJumptable:
	dw .CheckSellableItem
	dw .CannotSellItem
	dw .BallPocket
	dw .FlipPocket
	dw .CheckSellableItem
	dw .CheckSellableItem
	dw .CheckSellableItem

.FlipPocket:
	callfar FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	ret

.CannotSellItem:
	ld hl, .CannotSellText
	call MenuTextBoxBackup
	and a
	ret

.CannotSellText:
	text "つかえないのだ！"
	prompt

.BallPocket:
	callfar BallPocket
	jr nc, .CheckSellableItem
	and a
	ret

.CheckSellableItem:
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .not_sellable
	jp .ItemQuantityPrompt

.not_sellable
	ld hl, .ImportantItemText
	call MenuTextBoxBackup
	and a
	ret

.ImportantItemText:
	text "それは　だいじなものです"
	line "うることは　できません！"
	prompt

.no_items
	ld hl, .NoItemsText
	call MenuTextBoxBackup
	and a
	ret

.NoItemsText:
	text "どうぐを　ひとつも"
	next "もっていません！"
	prompt

.ItemQuantityPrompt:
	ld hl, .HowManyItemsText
	call PrintText
	callfar SelectQuantityToBuy
	jr c, .got_quantity
	jr .CannotSellItem

.got_quantity
	and a
	ret

.HowManyItemsText:
	text "いくつ　うりますか？"
	done

DebugMart_LoadItems:
	ld hl, wcd60
.load_loop
	ld a, [de]
	inc de
	ld [hli], a
	cp -1
	jr nz, .load_loop
	ld hl, wcc3a
	ld de, wcd60 + 1
.load_loop2
	ld a, [de]
	inc de
	cp -1
	jr z, .done_load
	push de
	call .GetPrice
	pop de
	jr .load_loop2

.done_load
	ret

.GetPrice:
	push hl
	ld [wCurItem], a
	callfar GetItemPrice
	ld a, d
	ld [wBuySellItemPrice], a
	ld a, e
	ld [wBuySellItemPrice + 1], a
	ld hl, wStringBuffer1
	ld de, wBuySellItemPrice
	lb bc, PRINTNUM_LEADINGZEROS | 2, 6
	call PrintNumber
	pop hl
	ld de, wStringBuffer1
	ld c, 3
.print_price
	call .PrintPaddedDigits
	swap a
	ld b, a
	call .PrintPaddedDigits
	or b
	ld [hli], a
	dec c
	jr nz, .print_price
	ret

.PrintPaddedDigits:
	ld a, [de]
	inc de
	cp "　"
	jr nz, .to_digit
	ld a, "０"
.to_digit
	sub "０"
	ret

DebugMart_ShowPlaceholderText:
	ld hl, .PlaceholderText
	call MenuTextBox
	call ExitMenu
	ret

.PlaceholderText:
	text "かいはつちゅうです"
	next "<PROMPT>"

