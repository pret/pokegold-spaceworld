UnreferencedToolPocketData:
	dw ToolsPocketHeader
	dw wRegularItemsCursor
	dw wRegularItemsScrollPosition

ToolsPocketHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 3, 17, 10
	dw .ToolsPocketData
	db 1

.ToolsPocketData
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_SELECT
	db 4, 9, 2, 0
	dw wNumBagItems

	dba PlacePackItems
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

	dw KeyItemsPocketHeader
	dw wBackpackAndKeyItemsCursor
	dw wBackpackAndKeyItemsScrollPosition

KeyItemsPocketHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 3, 17, 10
	dw .KeyPocketData
	db 1

.KeyPocketData
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_SELECT
	db 4, 9, 1, 0
	dw wNumKeyItems

	dba PlacePackItems
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

BackpackMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 3, 3, 17, 10
	dw .BackpackData
	db 1 ; default option

.BackpackData
	db SCROLLINGMENU_CALL_FUNCTION1_CANCEL | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_SELECT
	db 4, 9, 2, 0
	dw wNumBagItems

	dba PlacePackItems
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

GetPocket2Status:
; puts 2 in wActiveBackpackPocket if pocket 2 has items
; otherwise puts 1 in
	ld a, 2
	ld [wActiveBackpackPocket], a
	ld a, [wNumBagItems]
	and a
	ret nz
	ld a, 1
	ld [wActiveBackpackPocket], a
	ret

FlipPocket2Status:
; stores 1 in wactivebackpocket if it's currently 2
; and vice versa
	ld a, [wActiveBackpackPocket]
	cp 2
	ld a, 1
	jr z, .skip
	ld a, 2
.skip
	ld [wActiveBackpackPocket], a
	ret

CheckItemsQuantity:
; sets clear flag if you have no items
	ld a, [wNumBagItems]
	and a
	ret nz
	ld a, [wNumKeyItems]
	and a
	ret nz
	scf
	ret

DrawBackpack:
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearSprites
	call ClearTileMap
	callfar LoadBackpackGraphics
	hlcoord 2, 2
	ld b, 8
	ld c, $0F
	call DrawTextBox
	ret

	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call ExitMenu
	ret

StartMenu_Backpack:
	call CheckItemsQuantity
	jr c, .NoItems
	call LoadStandardMenuHeader
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call DrawBackpack
	xor a
	ld [wSwitchItem], a
	call GetPocket2Status
.loop
	call DebugBackpackLoop
	jr c, .jump
	call BackpackSelected
	jr nc, .loop
	jr .skip
.jump
	ld a, 0
.skip
	push af
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	xor a
	ld [wSwitchItem], a
	call ClearPalettes
	call CloseWindow
	call LoadFontExtra
	pop af
	ret

.NoItems
	call DrawNoItemsText
	scf
	ld a, 0
	ret

DebugBackpackLoop:
; checks the field debug flag, if set this runs
; otherwise NondebugBackpackLoop runs
; if wActiveBackpackPocket is 1 (doesn't have key items) then jumps below
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jp z, NondebugBackpackLoop
	ld a, [wActiveBackpackPocket]
	cp 2
	jr nz, .NoTools
	ld hl, ToolsPocketHeader
	call CopyMenuHeader
	ld de, .ToolsPocketText
	call DrawBackpackTitleRow
	ld a, [wRegularItemsCursor]
	ld [wMenuCursorPosition], a
	ld a, [wRegularItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu

	ld a, [wMenuScrollPosition]
	ld [wRegularItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wRegularItemsCursor], a
	jp HandleBackpackInput

.ToolsPocketText
	db "　　　　　　ふつうの　どうぐ　　　　　　@"

.NoTools
	ld hl, KeyItemsPocketHeader
	call CopyMenuHeader
	ld de, KeyItemsPocketText
	call DrawBackpackTitleRow
	ld a, [wBackpackAndKeyItemsCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBackpackAndKeyItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu

	ld a, [wMenuScrollPosition]
	ld [wBackpackAndKeyItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBackpackAndKeyItemsCursor], a
	jr HandleBackpackInput

KeyItemsPocketText:
	db "　　　　　　だいじな　もの　　　　　　　@"

NondebugBackpackLoop:
	ld hl, BackpackMenuHeader
	call CopyMenuHeader
	ld de, BackpackHeaderText
	call DrawBackpackTitleRow
	ld a, [wBackpackAndKeyItemsCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBackpackAndKeyItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu

	ld a, [wMenuScrollPosition]
	ld [wBackpackAndKeyItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBackpackAndKeyItemsCursor], a
	jr HandleBackpackInput

BackpackHeaderText:
	db "　　　　　　リュックの　なか　　　　　@"

HandleBackpackInput:
	ld a, [wMenuJoypad]
	cp PAD_A
	jp z, .BackpackA
	cp PAD_B
	jp z, .BackpackBack
	cp PAD_LEFT
	jp z, .BackpackSwapPocket
	cp PAD_RIGHT
	jp z, .BackpackSwapPocket
	cp PAD_SELECT
	jp z, .BackpackSelect
	jp .exit

.BackpackSwapPocket
	call FlipPocket2Status
	xor a
	ld [wSwitchItem], a
	jp .exit

.BackpackSelect
	callfar SwitchItemsInBag
	jp .exit

.exit
	jp DebugBackpackLoop

.UnusedNoItems
	call DrawNoItemsText
	scf
	ret

.BackpackBack
	scf
	ret

.BackpackA
	and a
	ret

BackpackSelected:
	callfar ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	call LoadItemData
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .BagSelectJumptable
	jp CallJumptable

.BagSelectJumptable:
	dw SelectItem
	dw .TMHolder
	dw BallPocketLoop
	dw .SwapPocket
	dw SelectItem
	dw SelectItem
	dw SelectItem

.SwapPocket
	call FlipPocket2Status
	xor a
	ld [wSwitchItem], a
	and a
	ret

.TMHolder
	call LoadStandardMenuHeader
	callfar _TMHolder
	call ExitMenu
	call DrawBackpack
	and a
	ret

BallPocketLoop:
	call BallPocket
	jr c, .exit
	call SelectItem
	ret c
	jr BallPocketLoop
.exit
	and a
	ret

SelectItem:
	call ItemUseMenu
	jr c, .skip1
	ld a, [wMenuCursorY]
	cp 1
	jp z, UseItemSelection
	cp 2
	jp z, TossItemSelection
	cp 3
	jp z, RegisterItemSelection
.skip1
	and a
	ret

ItemUseMenu:
; loads SelectedItemMenu if not debug,
; DebugSelectedItemMenu if debug
	ld a, [wDebugFlags]
	bit DEBUG_FIELD_F, a
	jr nz, .jump
	ld hl, SelectedItemMenu
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret
.jump
	ld hl, DebugSelectedItemMenu
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret

DebugSelectedItemMenu:
	db MENU_BACKUP_TILES
	menu_coords 13, 10, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 2
	dw .DebugSelectedItemMenuText
	db 1 ; default option

.DebugSelectedItemMenuText
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING
	db 3
	db "つかう@" ; use
	db "すてる@" ; toss
	db "とうろく@" ; register

SelectedItemMenu:
	db MENU_BACKUP_TILES
	menu_coords 14, 10, SCREEN_WIDTH - 1, SCREEN_HEIGHT - 4
	dw .SelectedItemMenuText
	db 1 ; default option

.SelectedItemMenuText
	db STATICMENU_CURSOR | STATICMENU_NO_TOP_SPACING
	db 2
	db "つかう@" ; use
	db "すてる@" ; toss

TossItemSelection:
	ld de, wNumBagItems
	call TryTossItem
	and a
	ret

RegisterItemSelection:
	call TryRegisterItem
	and a
	ret

UseItemSelection:
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .UseItemJumptable
	jp CallJumptable

.UseItemJumptable: ; jumptable
	dw .FailedMove
	dw .unusable
	dw .unusable
	dw .unusable
	dw .SimpleItem
	dw .SpriteItem
	dw .FieldMove

.unusable
	call PrintCantUseText
	and a
	ret

.SimpleItem:
	call DoItemEffect
	and a
	ret

.SpriteItem:
; might be a better name for this once
; bank 5 gets sorted out
	call DoItemEffect
	call ClearBGPalettes
	call StartMenuLoadSprites
	call DrawBackpack
	and a
	ret

.FieldMove:
	call DoItemEffect
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .FailedMove
	scf
	ld a, 4
	ret

.FailedMove
	call PrintCantUseText
	and a
	ret

TryTossItem:
	push de
	call LoadItemData
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr nz, .TossFail
	ld hl, .TossedText
	call MenuTextBox
	callfar SelectQuantityToToss
	push af
	call CloseWindow
	call ExitMenu
	pop af
	jr c, .TossReturn
	ld hl, .TossVerifyText
	call MenuTextBox
	call YesNoBox
	push af
	call ExitMenu
	pop af
	jr c, .TossReturn
	pop hl
	ld a, [wItemIndex]
	call TossItem
	call LoadItemData
	ld hl, .TossedTextCopy
	call MenuTextBox
	call ExitMenu
	and a
	ret

.TossFail
	call CantDropItem
.TossReturn
	pop hl
	scf
	ret

.TossedText:
	text_from_ram wStringBuffer2
	text "を　"
	line "いくつ　すてますか？"
	done

.TossVerifyText:
	text_from_ram wStringBuffer2
	text "を　@"
	deciram wItemQuantity, 1, 2
	text "こ"
	line "すててもよろしいですか？"
	done

.TossedTextCopy:
	text_from_ram wStringBuffer1
	text "を"
	line "すてました！"
	prompt

CantDropItem:
	ld hl, .CantDropItemText
	call MenuTextBoxBackup
	ret

.CantDropItemText:
	text "それは　とても　たいせつなモノです"
	line "すてることは　できません！"
	prompt

PrintCantUseHM:
	ld hl, .CantUseHMText
	call MenuTextBoxBackup
	ret

.CantUseHMText:
	text "かいはつちゅう　です"
	line "いまは　つかえません"
	prompt

PrintCantUseText:
	ld hl, .CantUseHereText
	call MenuTextBoxBackup
	ret

.CantUseHereText:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！"
	prompt

DrawNoItemsText:
	ld hl, .NoItemsText
	call MenuTextBoxBackup
	ret

.NoItemsText:
	text "どうぐ　をひとつも"
	next "もっていません！"
	prompt

BallPocket:
	xor a
	ldh [hBGMapMode], a
	ld hl, .BallPocketHeader
	call CopyMenuHeader
	ld de, .BallHolderText
	call DrawBackpackTitleRow
	hlcoord 2, 2
	ld b, 8
	ld c, $F
	call DrawTextBox
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp 1
	jr z, .jmp1
	cp 2
	jr z, .jmp2
	jr BallPocket
.jmp1
	and a
	ret
.jmp2
	scf
	ret

.BallHolderText:
	db "　　　　　ボール　ホルダ　　　　　　@"

.BallPocketHeader:
	db MENU_BACKUP_TILES
	menu_coords 3, 3, 17, 10
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_BALL_POCKET
	dbw 0, wNumBallItems
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

DrawBackpackTitleRow:
	push de
	hlcoord 0, 0
	ld de, .BlankLine
	call PlaceString
	pop de
	hlcoord 0, 1
	call PlaceString
	ret

.BlankLine:
	db "　　　　　　　　　　　　　　　　　　　　@"

LoadItemData:
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ret

StartMenuLoadSprites:
	call DisableLCD
	ld a, 6
	call UpdateSoundNTimes
	callfar LoadStandingSpritesGFX
	call LoadTilesetGFX
	call LoadFontExtra
	call ClearSprites
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call UpdateSprites
	call EnableLCD
	call GetMemSGBLayout
	ret

TryRegisterItem:
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .RegisterItemJumptable
	jp CallJumptable

.RegisterItemJumptable
	dw PrintCantRegisterToolText
	dw PrintCantRegisterToolText
	dw PrintCantRegisterToolText
	dw PrintCantRegisterToolText
	dw RegisterItem
	dw RegisterItem
	dw RegisterItem

RegisterItem:
	ld a, [wItemIndex]
	inc a
	ld b, a
	ld a, [wActiveBackpackPocket]
	cp 2
	jr z, .skip
	set 7, b
.skip
	ld a, b
	ld [wRegisteredItem], a
	ld a, [wCurItem]
	ld [wRegisteredItemQuantity], a
	call LoadItemData
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, .RegisteredItemText
	call MenuTextBoxBackup
	ret

.RegisteredItemText:
	text_from_ram wStringBuffer2
	text "を　"
	line "べんりボタンに　とうろくした！"
	prompt

PrintCantRegisterToolText:
	ld hl, .CantRegisterToolText
	call MenuTextBoxBackup
	ret

.CantRegisterToolText:
	text "そのどうぐは　"
	line "とうろくできません！"
	prompt
