INCLUDE "constants.asm"

SECTION "engine/menu/start_menu.asm", ROMX

DisplayStartMenu:
	call RefreshScreen
	ld de, SFX_MENU
	call PlaySFX
	ld hl, .StartMenuHeader
	call LoadMenuHeader
.RefreshStartDisplay
	call UpdateTimePals
	call UpdateSprites
	call ClearJoypad
	call GetStartMenuState
	ld a, [wStartmenuCursor]
	ld [wMenuCursorBuffer], a
	call OpenMenu
	jr c, .MainReturn
	ld a, [wMenuCursorBuffer]
	ld [wStartmenuCursor], a
	call PlaceHollowCursor
	ld a, [wMenuSelection]
	ld hl, StartMenuJumpTable
	call CallJumptable
	ld hl, .StartMenuEntriesReturnTable
	jp CallJumptable

.StartMenuEntriesReturnTable:
	dw .RefreshStartDisplay
	dw .MainReturn
	dw .exit
	dw .UpdateTime
	dw .ExitAndHookFF

.MainReturn
	call .WaitForARelease
	call LoadFontExtra
.exit
	call ExitMenu
.UpdateTime
	call Function1fea
	call UpdateTimePals
	ret

.unused
	call .WaitForARelease
	call LoadFontExtra
	call CloseWindow
	jr .UpdateTime

.WaitForARelease
	call GetJoypad
	ldh a, [hJoyDown]
	bit A_BUTTON_F, a
	jr nz, .WaitForARelease
	ret

.ExitAndHookFF:
	call ExitMenu
	ld a, $FF
	ldh [hStartmenuCloseAndSelectHookEnable], a
	jr .UpdateTime

.StartMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords $0C, 00, $13, $11
	dw .MenuData
	db 1 ; default option

.MenuData:
	db $A8 ; flags
	db 0 ; items
	dw StartMenuItems
	db $8A, $1F
	dw .Strings

.Strings:
	db "ずかん@"
	db "ポケモン@"
	db "りュック@"
	db "<PLAYER>@"
	db "レポート@"
	db "せってい@"
	db "とじる@"
	db "わくせん@"
	db "りセット@"

StartMenuJumpTable:
	dw StartMenu_Pokedex
	dw StartMenu_Party
	dw StartMenu_Backpack
	dw StartMenu_TrainerCard
	dw StartMenu_Save
	dw StartMenu_Settings
	dw StartMenu_Exit
	dw StartMenu_SetFrame
	dw StartMenu_Reset

StartMenuItems:
	db 4
	db START_SAVE
	db START_OPTIONS
	db START_TRAINERCARD
	db START_EXIT
	db -1

	db 5
	db START_PARTY
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 6
	db START_POKEDEX
	db START_PARTY
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 7
	db START_POKEDEX
	db START_PARTY
	db START_BACKPACK
	db START_TRAINERCARD
	db START_SAVE
	db START_OPTIONS
	db START_EXIT
	db -1

	db 6
	db START_POKEDEX
	db START_PARTY
	db START_BACKPACK
	db START_TRAINERCARD
	db START_OPTIONS
	db START_EXIT
	db -1

GetStartMenuState:
; Stores one of four values to wActiveBackpackPocket
; based on story flags and debug mode.
; 4 = debug, 3 = starting, 2 = rival beat in lab
; 1 = pokedex recieved, 0 = chose starter
	ld b, 4
	ld hl, wDebugFlags
	bit DEBUG_FIELD_F, [hl]
	jr z, .store
	ld b, 0
	ld hl, wd41b
	bit 2, [hl]
	jr z, .store
	ld b, 1
	ld hl, wd41c
	bit 4, [hl]
	jr z, .store
	ld b, 2
	ld hl, wd41d
	bit 2, [hl]
	jr z, .store
	ld b, 3
.store
	ld a, b
	ld [wActiveBackpackPocket], a
	ret

StartMenu_Exit:
; Exits the menu
	ld a, 1
	ret

StartMenu_SetFrame:
	callab FrameTypeDialog
	ld a, 0
	ret

StartMenu_Reset:
	ld hl, DisplayResetDialog
	ld a, BANK(DisplayResetDialog)
	call DisplayResetDialog ; should be farcall
	ld a, 0
	ret

StartMenu_Save:
	predef Function143e0
	call UpdateSprites
	ld a, 0
	ret

StartMenu_Settings:
	call LoadStandardMenuHeader
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	call UpdateSprites
	callab MenuCallSettings
	call ClearPalettes
	call Call_ExitMenu
	call LoadTilesetGFX
	call LoadFontExtra
	call UpdateSprites
	call WaitBGMap
	call UpdateTimePals
	ld a, 0
	ret

StartMenu_TrainerCard:
	call _TrainerCard
	ld a, 0
	ret

_TrainerCard:
	call LoadStandardMenuHeader
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	callab TrainerCardLoop
	call ClearPalettes
	call LoadFont
	call ReloadFontAndTileset
	call Call_ExitMenu
	call GetMemSGBLayout
	call WaitBGMap
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	ret

StartMenu_Pokedex:
	call LoadStandardMenuHeader
	predef Function40000
	call ClearPalettes
	call Function360b
	call ReloadFontAndTileset
	call Call_ExitMenu
	call GetMemSGBLayout
	call WaitBGMap
	call UpdateTimePals
	ld a, 0
	ret

UnusedToolPocketData:
	dw ToolsPocketHeader
	dw wRegularItemsCursor
	dw wRegularItemsScrollPosition

ToolsPocketHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 03, 03, $11, $0A
	dw .ToolsPocketData
	db 1

.ToolsPocketData
	db $AD
	db 4, 9, 2, 0
	dw wNumBagItems

	dba Function2473b
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

	dw KeyItemsPocketHeader
	dw wBackpackAndKeyItemsCursor
	dw wBackpackAndKeyItemsScrollPosition

KeyItemsPocketHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 03, 03, $11, $0A
	dw .KeyPocketData
	db 1

.KeyPocketData
	db $AD
	db 4, 9, 1, 0
	dw wNumKeyItems

	dba Function2473b
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription

BackpackMenuHeader:
	db MENU_BACKUP_TILES ; flags
	menu_coords 03, 03, $11, $0A
	dw .BackpackData
	db 01

.BackpackData
	db $A1
	db 4, 9, 2, 0
	dw wNumBagItems

	dba Function2473b
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
	ld hl, wVramState
	res 0, [hl]
	call ClearSprites
	call ClearTileMap
	callab LoadBackpackGraphics
	hlcoord 2, 2
	ld b, 08
	ld c, $0F
	call DrawTextBox
	ret

	ld hl, wVramState
	set 0, [hl]
	call ExitMenu
	ret

StartMenu_Backpack:
	call CheckItemsQuantity
	jr c, .NoItems
	call LoadStandardMenuHeader
	ld hl, wVramState
	res 0, [hl]
	call DrawBackpack
	xor a
	ld [wSelectedSwapPosition], a
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
	ld hl, wVramState
	set 0, [hl]
	xor a
	ld [wSelectedSwapPosition], a
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
; if wactivebackpackpocket is 1 (doesn't have key items) then jumps below
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
	ld [wMenuCursorBuffer], a
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
	ld [wMenuCursorBuffer], a
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
	ld [wMenuCursorBuffer], a
	ld a, [wBackpackAndKeyItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu

	ld a, [wMenuScrollPosition]
	ld [wBackpackAndKeyItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBackpackAndKeyItemsCursor], a
	jr HandleBackpackInput

BackpackHeaderText:
	db "　　　　　　りュックの　なか　　　　　@"

HandleBackpackInput:
	ld a, [wMenuJoypad]
	cp A_BUTTON
	jp z, .BackpackA
	cp B_BUTTON
	jp z, .BackpackBack
	cp D_LEFT
	jp z, .BackpackSwapPocket
	cp D_RIGHT
	jp z, .BackpackSwapPocket
	cp SELECT
	jp z, .BackpackSelect
	jp .exit

.BackpackSwapPocket
	call FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	jp .exit

.BackpackSelect
	callab SwitchItemsInBag
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
	callab ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	call LoadItemData
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .BagSelectJumptable
	jp CallJumptable

.BagSelectJumptable:
	dw SelectItem
	dw .UnknownSelection
	dw BallPocketLoop
	dw .SwapPocket
	dw SelectItem
	dw SelectItem
	dw SelectItem

.SwapPocket
	call FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	and a
	ret

.UnknownSelection
	call LoadStandardMenuHeader
	callab Function2d2fc
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
	menu_coords $0D, $0A, $13, $10
	dw .DebugSelectedItemMenuText
	db 01

.DebugSelectedItemMenuText
	db $C0
	db 3
	db "つかう@" ; use
	db "すてる@" ; toss
	db "とうろく@" ; register

SelectedItemMenu:
	db MENU_BACKUP_TILES
	menu_coords $0E, $0A, $13, $0E
	dw .SelectedItemMenuText
	db 01

.SelectedItemMenuText
	db $C0
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
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
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
	call UseItem
	and a
	ret

.SpriteItem:
; might be a better name for this once
; bank 5 gets sorted out
	call UseItem
	call ClearBGPalettes
	call StartMenuLoadSprites
	call DrawBackpack
	and a
	ret

.FieldMove:
	call UseItem
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
	callab _CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jr nz, .TossFail
	ld hl, .TossedText
	call MenuTextBox
	callab SelectQuantityToToss
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

.TossFail ;25
	call CantDropItem
.TossReturn
	pop hl
	scf
	ret

.TossedText:
	db 1
	dw wStringBuffer2
	text "を　"
	line "いくつ　すてますか？"
	done

.TossVerifyText:
	db 1
	dw wStringBuffer2
	text "を　@"
	db 9
	dw wItemQuantity
	db $12
	text "こ"
	line "すててもよろしいですか？"
	done

.TossedTextCopy:
	db 1
	dw wStringBuffer1
	text "を"
	line "すてました！<PROMPT>"

CantDropItem:
	ld hl, .CantDropItemText
	call MenuTextBoxBackup
	ret

.CantDropItemText:
	text "それは　とても　たいせつなモノです"
	line "すてることは　できません！<PROMPT>"

PrintCantUseHM:
	ld hl, .CantUseHMText
	call MenuTextBoxBackup
	ret

.CantUseHMText:
	text "かいはつちゅう　です"
	line "いまは　つかえません<PROMPT>"

PrintCantUseText:
	ld hl, .CantUseHereText
	call MenuTextBoxBackup
	ret

.CantUseHereText:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！<PROMPT>"

DrawNoItemsText:
	ld hl, .NoItemsText
	call MenuTextBoxBackup
	ret

.NoItemsText:
	text "どうぐ　をひとつも<NEXT>もっていません！<PROMPT>"

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
	menu_coords 03, 03, $11, $0A
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_FUNCTION3 ; flags
	db 4, 8 ; rows, columns
	db $80 ; horizontal spacing?
	db 0 ; ???
	dw wNumBallItems

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
	ld [wce37], a
	call GetItemName
	call CopyStringToStringBuffer2
	ret

StartMenuLoadSprites:
	call DisableLCD
	ld a, 6
	call UpdateSoundNTimes
	callab Function140d9
	call LoadTilesetGFX
	call LoadFontExtra
	call ClearSprites
	ld hl, wVramState
	set 0, [hl]
	call UpdateSprites
	call EnableLCD
	call GetMemSGBLayout
	ret

TryRegisterItem:
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
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
	db 1
	dw wStringBuffer2
	text "を　"
	line "べんりボタンに　とうろくした！<PROMPT>"

PrintCantRegisterToolText:
	ld hl, .CantRegisterToolText
	call MenuTextBoxBackup
	ret

.CantRegisterToolText:
	text "そのどうぐは　"
	line "とうろくできません！<PROMPT>"

StartMenu_Party:
	ld a, [wPartyCount]
	and a
	jr nz, .partynonzero
	ld a, 0
	ret
.partynonzero
	call LoadStandardMenuHeader
	callab Function50756

HandleSelectedPokemon:
	xor a
	ld [wcdb9], a
	ld [wSelectedSwapPosition], a
	predef Function50774
	jr PartyPrompt.partypromptreturn

PartyPrompt:
	ld a, [wWhichPokemon]
	inc a
	ld [wSelectedSwapPosition], a
	callab Function8f1f2
	ld a, 4
	ld [wcdb9], a
	predef Function50774
.partypromptreturn
	jr c, .return
	jp SelectedPokemonSubmenu
.return
	ld a, 0
PartyPromptExit:
	push af
	call ClearBGPalettes
	call StartMenuLoadSprites
	nop
	nop
	nop
	ld hl, 0000
	call Call_ExitMenu
	call WaitBGMap
	call UpdateTimePals
	pop af
	ret

SelectedPokemonSubmenu:
	hlcoord 1, 13
	lb bc, 4, $12
	call ClearBox
	callab Function24955
	call GetCurNick
	ld a, [wMenuSelection]
	ld hl, PartyJumpTable
	ld de, $3
	call FindItemInTable
	jp nc, HandleSelectedPokemon
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wd163]
	jp hl

PartyJumpTable:
	dbw 1, PartyTryCut
	dbw 2, PartyTryFly
	dbw 3, PartyTrySurf
	dbw 4, PartyCantUseMove
	dbw 5, PartyCantUseMove
	dbw 6, PartyCantUseMove
	dbw 7, PartyCantUseMove
	dbw 8, PartyTryDig
	dbw 9, PartyTryTeleport
	dbw 10, PartyCalculateHealth
	dbw 11, PartyPokemonSummary
	dbw 12, PartyCheckLessThanTwo
	dbw 13, PartyHeldItem
	dbw 14, HandleSelectedPokemon
	dbw 15, PartyPokemonSummary2
	dbw 16, PartyMailMenu

PartyCheckLessThanTwo:
; might have to do with switch?
	ld a, [wPartyCount]
	cp 2
	jp c, HandleSelectedPokemon
	jp PartyPrompt

PartyHeldItem:
	callab Function_8f1cb
	ld hl, .HoldItemMenu
	call LoadMenuHeader
	call VerticalMenu
	jp c, .close
	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wcd11
	ld bc, $0006
	call CopyBytes
	ld a, [wMenuCursorY]
	cp 1
	jr nz, .skip
	call CloseWindow
	call .PartyGiveHeldItem
	jr .jump
.skip
	call .PartyTryRecieveItem
	call CloseWindow
	jr .jump
.close
	call CloseWindow
.jump
	jp HandleSelectedPokemon

.PartyGiveHeldItem
	call LoadStandardMenuHeader
	call ClearPalettes
	call GetPocket2Status
	call DrawBackpack
	call DebugBackpackLoop
	ld a, [wMenuJoypad]
	cp 2
	jp z, .ExitGiveItem
	call SpeechTextBox
	call LoadItemData
	call CheckTossableItem
	ld a, [wItemAttributeParamBuffer]
	and a
	jp nz, .CantGive
	call GetPartyItemOffset
	ld a, [hl]
	and a
	jr z, .NoItem
	ld [wce37], a
	call GetItemName
	ld hl, ItemPrompt6753
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jp c, .ExitGiveItem
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call TossItem
	ld a, [wce37]
	ld b, a
	ld a, [wCurItem]
	ld [wce37], a
	ld a, b
	ld [wCurItem], a
	call PartyRecieveItem
	jp nc, .GiveItem
	ld a, [wce37]
	ld [wCurItem], a
	ld hl, ItemWasEquippedText
	call MenuTextBoxBackup
	jr .CheckMail

.NoItem
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call TossItem
	ld hl, ItemPrompt66FA
	call MenuTextBoxBackup
.CheckMail
	call GetPartyItemOffset
	ld a, [wCurItem]
	ld [hl], a
	ld a, [wCurItem]
	cp ITEM_MAIL
	call z, PartyGiveMail
	jr .ExitGiveItem

.GiveItem
	ld a, [wce37]
	ld [wCurItem], a
	call PartyRecieveItem
	ld hl, PartyItemRecieveBagFullText
	call MenuTextBoxBackup
	jr .ExitGiveItem

.CantGive
	ld hl, .CantBeEquippedText
	call MenuTextBoxBackup
.ExitGiveItem
	call ClearPalettes
	call LoadFontsBattleExtra
	call ExitMenu
	ret

.PartyTryRecieveItem
	call SpeechTextBox
	call GetPartyItemOffset
	ld a, [hl]
	and a
	jr z, .NoItemToRecieve
	ld [wCurItem], a
	call PartyRecieveItem
	jr nc, .jump2
	call GetPartyItemOffset
	ld a, [hl]
	ld [wce37], a
	ld [hl], 0
	call GetItemName
	ld hl, ItemPrompt673D
	call MenuTextBoxBackup
	jr .escape
.NoItemToRecieve
	ld hl, PartyNoItemToRecieveText
	call MenuTextBoxBackup
	jr .escape
.jump2
	ld hl, PartyItemRecieveBagFullText
	call MenuTextBoxBackup
.escape
	ret

.HoldItemMenu ; verticalmenu
	db STATICMENU_NO_TOP_SPACING | STATICMENU_PLACE_TITLE
	menu_coords 4, 4, $e, 9
	dw .HoldItemMenuText
	db 1

.HoldItemMenuText
	db $80

	db 2
	db "そうびを　する@"
	db "そうびを　はずす@"

.CantBeEquippedText
	db 1
	dw wStringBuffer1
	text "を　そうびすることは"
	line "できません<PROMPT>"

ItemWasEquippedText:
	db 1
	dw wcd11
	text "は　そうび　していた"
	line "@"

.UnusedText1
	db 1
	dw wStringBuffer1
	text "を　はずして"
	para "@"

.UnusedText2
	db 1
	dw wStringBuffer2
	text "を　そうびした！<PROMPT>"

ItemPrompt66FA:
	db 1
	dw wcd11
	text "は　@"

.UnusedText3
	db 1
	dw wStringBuffer2
	text "を"
	line "そうびした！<PROMPT>"

PartyNoItemToRecieveText:
	db 1
	dw wcd11
	text "は　なにも"
	line "そうび　していません！<PROMPT>"

PartyItemRecieveBagFullText:
	text "どうぐが　いっぱいで"
	line "そうびを　はずせません！<PROMPT>"

ItemPrompt673D:
	db 1
	dw wcd11
	text "から　@"

.UnusedText4
	db 1
	dw wStringBuffer1
	text "を"
	line "はずしました！<PROMPT>"

ItemPrompt6753:
	db 1
	dw wcd11
	text "は　@"

.UnusedText5:
	db 1
	dw wStringBuffer1
	text "を"
	line "すでに　そうび　しています"
	para "そうびしている　どうぐを"
	line "とりかえますか？"
	done

GetPartyItemOffset:
	push af
	ld a, 1
	call GetPartyParamLocation
	pop af
	ret

PartyRecieveItem:
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call ReceiveItem
	ret

UnusedHandleItemJumptable:
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, UnusedItemJumptable
	jp CallJumptable

UnusedItemJumptable:
	dw EmptyFunction127b7
	dw PartyGiveMail
	dw PartyBallPocket
	dw ChangeBackpackPocket
	dw EmptyFunction127b7
	dw EmptyFunction127b7
	dw EmptyFunction127b7

EmptyFunction127b7:
	ret

ChangeBackpackPocket:
	call FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	ret

PartyBallPocket:
	call BallPocket
	jr c, .exit
	call SelectItem
	ret c
	jr PartyBallPocket
.exit
	ret

PartyGiveMail:
	call LoadStandardMenuHeader
	ld de, wMovementBufferCount
	callab ComposeMailMessage
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra
	call Call_ExitMenu
	call WaitBGMap
	ld a, [wWhichPokemon]
	ld hl, $BA68
	ld bc, $0028
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wMovementBufferCount
	ld bc, $0028
	ld a, 2
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	ret

PartyMailMenu:
	ld hl, .MailMenu
	call LoadMenuHeader
	call VerticalMenu
	call PlaceHollowCursor
	jp c, .exit
	ld a, [wMenuCursorY]
	cp 3
	jp z, .exit
	cp 1
	jr z, .GiveMail
	ld hl, .MessageRemoveMail
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jp c, .exit
	ld a, [wWhichPokemon]
	ld hl, wPartyMon1 + MON_ITEM
	ld bc, $0030
	call AddNTimes
	ld a, [hl]
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantity], a
	push hl
	ld hl, wNumBagItems
	call ReceiveItem
	pop hl
	jr nc, .MailFull
	xor a
	ld [hl], a
	call GetCurNick
	ld hl, .DrawNick
	call MenuTextBoxBackup
	jr .exit
.GiveMail
	ld a, [wWhichPokemon]
	ld hl, $BA68
	ld bc, $0028
	call AddNTimes
	ld bc, $0028
	ld de, wMovementBufferCount
	ld a, 2
	call OpenSRAM
	call CopyBytes
	call CloseSRAM
	hlcoord 0, 12
	ld b, 4
	ld c, $12
	call DrawTextBox
	ld de, wMovementBufferCount
	hlcoord 1, 14
	call PlaceString
	ld c, 5
	call DelayFrames
	xor a
	ldh [hJoyState], a
	call TextboxWaitPressAorB_BlinkCursor
.exit
	call CloseWindow
	jp HandleSelectedPokemon

.MailFull
	ld hl, .MailFullText
	call MenuTextBoxBackup
	jr .exit

.MailMenu
	db MENU_BACKUP_TILES
	menu_coords 04, 04, $0E, $0B
	dw .MailMenuStrings
	db 01

.MailMenuStrings

	db $80
	db 3
	db "メールを　よむ@"
	db "メールを　はずす@"
	db "やめる@"

.MessageRemoveMail
	text "メールを　はずすと　メッセージが"
	line "きえてしまいますが　いいですか？"
	done

.DrawNick
	db 1
	dw wStringBuffer1
	text "から　@"

.DeleteMailText
	text "メールを"
	line "はずしました！<PROMPT>"

.MailFullText
	text "どうぐが　いっぱいで"
	line "メールを　はずせません！<PROMPT>"

PartyPokemonSummary:
	call LoadStandardMenuHeader
	call ClearSprites
	xor a
	ld [wMonType], a
	call LowVolume
	predef Function502b5
	call MaxVolume
	call ReloadFontAndTileset
	call Call_ExitMenu
	jp HandleSelectedPokemon

PartyTryCut:
	callab CutFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTryFly:
	bit 2, a
	jp z, PrintNeedNewBadgeText
	callab FlyFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyCantUseMove:
	call PrintCantUseHM
	jp HandleSelectedPokemon

PartyTryTeleport:
	callab TeleportFunction
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTrySurf:
	bit 4, a
	jp z, PrintNeedNewBadgeText
	callab SurfFunction
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTryDig:
	callab DigFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyCalculateHealth:
	ld a, MON_MAXHP ; might be wrong, was $24
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hQuotient], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ld a, MON_HP + 1 ; might be wrong, was $23
	call GetPartyParamLocation
	ldh a, [hQuotient + 2]
	sub [hl]
	dec hl
	ldh a, [hQuotient + 1]
	sbc a, [hl]
	jp nc, PrintNotHealthyEnoughText
	callab Functionf218
	jp HandleSelectedPokemon

PrintNotHealthyEnoughText:
	ld hl, NotHealthyEnoughText
	call PrintText
	jp HandleSelectedPokemon

NotHealthyEnoughText:
	text "たいりょくが　たりません！<PROMPT>"

PrintNeedNewBadgeText:
	ld hl, NeedNewBadgeText
	call PrintText
	jp HandleSelectedPokemon

NeedNewBadgeText:
	text "あたらしい　バッジを　てにするまで"
	line "まだ　つかえません！<PROMPT>"

PartyPokemonSummary2:
	ld hl, wce5f
	ld a, [hl]
	push af
	set 4, [hl]
	call PokeSummary
	pop af
	ld [wce5f], a
	call ClearBGPalettes
	jp HandleSelectedPokemon

PokeSummary:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	callab LoadOnlyPokemonStatsGraphics
	callab Function8f0cc
	ld a, [wWhichPokemon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wce37], a
	ld hl, Function8f0e3
	ld a, BANK(Function8f0e3)
	ld e, 2
	call FarCall_hl
	hlcoord 0, 1
	ld b, 8
	ld c, $12
	call DrawTextBox
	hlcoord 1, 1
	lb bc, 2, $12
	call ClearBox
	hlcoord 3, 1
	predef Function508c4
	ld hl, wccd1
	call SetHPPal
	ld b, $0E
	call GetSGBLayout
	hlcoord 11, 0
	lb bc, 1, 9
	call ClearBox
	hlcoord 16, 0
	ld a, [wWhichPokemon]
	and a
	jr z, .FirstPokeChosen
	ld [hl], "」"
.FirstPokeChosen
	inc a
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr z, .LastPokeChosen
	inc hl
	inc hl
	ld [hl], "▶" ; right filled arrow
.LastPokeChosen
	ld de, PartyMenuAttributes
	call SetMenuAttributes
SummaryDrawPoke:
	xor a
	ldh [hBGMapMode], a
	ld [wSelectedSwapPosition], a
	ld [wMonType], a
	predef Function50000
	ld hl, wcd81
	ld de, wce2e
	ld bc, $0004
	call CopyBytes
	ld a, $28
	ld [wHPBarMaxHP], a
	hlcoord 2, 3
	predef Function50bfe
	hlcoord 11, 3
	predef Function506d4
	call WaitBGMap
	call SetPalettes
	ld a, [wcd57]
	inc a
	ld [w2DMenuNumRows], a
	hlcoord 0, 10
	ld b, 6
	ld c, $12
	call DrawTextBox
	ld hl, w2DMenuFlags
	set 6, [hl]
	jr PartySelectionInputs.PartySelectSkipInputs
PartySelectionInputs:
	call Get2DMenuJoypad + 3
	bit B_BUTTON_F, a
	jp nz, PartySelectionBackOut
	bit A_BUTTON_F, a
	jp nz, .PartyPokeSelect
	bit D_RIGHT_F, a
	jp nz, .PartyPokeDetailsAdvancePage
	bit D_LEFT_F, a
	jp nz, .PartyPokeDetailsBackPage
.PartySelectSkipInputs
	ld hl, wPartyMon1 + MON_MOVES
	lb bc, 0, $30
	ld a, [wWhichPokemon]
	call AddNTimes
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	hlcoord 1, 11
	lb bc, $06, $12
	call ClearBox
	hlcoord 1, 12
	ld a, [wSelectedSwapPosition]
	and a
	jr nz, .DrawMovePokeText
	ld de, PartyTypeText
	call PlaceString
	ld a, [wCurSpecies]
	ld b, a
	hlcoord 5, 12
	predef Function500a0
	ld a, [wCurSpecies]
	dec a
	ld hl, Data4a8b8
	ld bc, $0007
	call AddNTimes
	ld a, BANK(Data4a8b8)
	call GetFarByte
	hlcoord 15, 12
	cp 2
	jr c, .NotAMove
	ld [wce37], a
	ld de, wce37
	lb bc, 1, 3
	call PrintNumber
	jr .step
.NotAMove
	ld de, PartyPokeDivider
	call PlaceString
.step
	hlcoord 1, 14
	predef Function2d663
	jp PartySelectionInputs

.DrawMovePokeText
	hlcoord 1, 11
	lb bc, 6, $12
	call ClearBox
	hlcoord 1, 12
	ld de, PartyMoveText
	call PlaceString
	jp PartySelectionInputs

.PartyPokeDetailsAdvancePage
	ld hl, wWhichPokemon
	inc [hl]
	ld a, [wPartyCount]
	cp [hl]
	jp nz, PokeSummary
	dec [hl]
	jp PartySelectionInputs

.PartyPokeDetailsBackPage
	ld hl, wWhichPokemon
	ld a, [hl]
	and a
	jp z, PartySelectionInputs
	dec [hl]
	jp PokeSummary

.PartyPokeSelect
	ld a, [wSelectedSwapPosition]
	and a
	jr nz, .swap
	ld a, [wMenuCursorY]
	ld [wSelectedSwapPosition], a
	call PlaceHollowCursor
	jr .DrawMovePokeText
.swap
	ld hl, wPartyMon1 + MON_MOVES
	ld bc, $0030
	ld a, [wWhichPokemon]
	call AddNTimes
	push hl
	call SwapEntries
	pop hl
	ld bc, $0015
	add hl, bc
	call SwapEntries
	ld a, [wBattleMode]
	jr z, .NotInBattle
	ld hl, wca04
	ld bc, $0020
	ld a, [wWhichPokemon]
	call AddNTimes
	push hl
	call SwapEntries
	pop hl
	ld bc, $0006
	add hl, bc
	call SwapEntries
.NotInBattle
	hlcoord 1, 2
	lb bc, 8, $12
	call ClearBox
	jp SummaryDrawPoke

SwapEntries:
; values at (hl + [cursor place]-1)
; and (hl + [wSelectedSwapPosition] -1) get swapped
	push hl ; saves hl
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl ; hl is same as start
	ld a, [wSelectedSwapPosition]
	dec a
	ld c, a
	ld b, 0
	add hl, bc ; hl is now hl + bc
	ld a, [de]
	ld b, [hl]
	ld [hl], a
	ld a, b
	ld [de], a
	ret

PartySelectionBackOut:
	xor a
	ld [wSelectedSwapPosition], a
	ld hl, w2DMenuFlags
	res 6, [hl]
	call ClearSprites
	call ClearTileMap
	ret

PartyMenuAttributes:
; cursor y
; cursor y
; num rows
; num cols
; bit 6: animate sprites  bit 5: wrap around
; ?
; distance between items (hi: y, lo: x)
; allowed buttons (mask)
	db 3, 1
	db 3, 1
	db $40, $00
	dn 2, 0
	db $F3

PartyTypeText:
	db "タイプ／　　　　　いりょく／@"

PartyPokeDivider:
	db "ーーー@"

PartyMoveText:
	db "どこに　いどうしますか？@"

CheckRegisteredItem:
	call .RegisteredItem
	ret

.RegisteredItem
	call GetRegisteredItemID
	jr c, .NotRegistered
	call UseRegisteredItem
	ret

.NotRegistered
	call RefreshScreen
	ld hl, .NothingRegisteredText
	call MenuTextBoxBackup
	call Function1fea
	ret

.NothingRegisteredText:
	text "べんりボタンを　おした！"
	line "⋯しかしなにもおきない！<PROMPT>"

GetRegisteredItemID:
; if you can use the registered item, sets the ID to a
; otherwise sets 0 to a and sets the carry flag
	ld a, [wRegisteredItem]
	and a
	jr z, .CantUse
	bit 7, a
	jr nz, .IsKey
	dec a
	ld hl, wNumBagItems
	cp [hl]
	jr nc, .CantUse
	inc hl
	ld [wItemIndex], a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [wRegisteredItemQuantity]
	cp [hl]
	jr nz, .CantUse
	ld a, [hl]
	ld [wCurItem], a
	and a
	ret
.IsKey
	and $7F
	dec a
	ld hl, wNumKeyItems
	cp [hl]
	jr nc, .CantUse
	ld [wItemIndex], a
	ld e, a
	ld d, 0
	inc hl
	add hl, de
	ld a, [wRegisteredItemQuantity]
	cp [hl]
	jr nz, .CantUse
	ld a, [hl]
	ld [wCurItem], a
	and a
	ret
.CantUse
	xor a
	ld [wRegisteredItem], a
	ld [wRegisteredItemQuantity], a
	scf
	ret

UseRegisteredItem:
	callab CheckItemMenu
	ld a, [wItemAttributeParamBuffer]
	ld hl, .RegisteredItemJumptable
	jp CallJumptable

.RegisteredItemJumptable
	dw .CantUse2
	dw .CantUse
	dw .CantUse
	dw .CantUse
	dw .overworld
	dw .FieldMove

.CantUse
	call RefreshScreen
	call PrintCantUseText
	call Function1fea
	and a
	ret

.UnusedSimpleUse
	call RefreshScreen
	call UseItem
	call Function1fea
	and a
	ret

.overworld
	call RefreshScreen
	ld hl, wVramState
	res 0, [hl]
	call UseItem
	call ClearPalettes
	call StartMenuLoadSprites
	call UpdateTimePals
	call Function1fea
	and a
	ret

.FieldMove
	call UseItem
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .CantUse2
	scf
	ld a, -1
	ldh [hStartmenuCloseAndSelectHookEnable], a
	ld a, 4
	ret

.CantUse2
	call RefreshScreen
	call PrintCantUseText
	call Function1fea
	and a
	ret

TrainerCardLoop:
	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a
	call ClearTrainerCardJumptable
.loop
	call UpdateTime
	call HandleTrainerCardJumptable
	jr c, .escape
	call DelayFrame
	jr .loop
.escape
	pop af
	ld [wVramState], a
	ret

ClearTrainerCardJumptable:
; sets four bytes at wJumpTableIndex to 0
	call ClearPalettes
	ld hl, wJumptableIndex
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call ClearTileMap
	call ClearSprites
	ld b, $0D
	call GetSGBLayout
	ret

HandleTrainerCardJumptable:
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, .TrainerCardJumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.TrainerCardJumptable:
	dw TrainerCardMainPage
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw .SetPalAndIncJumpTable
	dw TrainerCardMainInputs
	dw TrainerCardScroll
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw TrainerCardClearTileMap
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw TrainerCardSetWindowY
	dw TrainerCardBadgePage
	dw .IncreaseJumpTableIndex
	dw .IncreaseJumpTableIndex
	dw .SetPalAndIncJumpTable
	dw TrainerCardBadgeInput
	dw TrainerCardSetClearFlag

.SetPalAndIncJumpTable:
	call SetPalettes
.IncreaseJumpTableIndex:
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	ret

TrainerCardMainPage:
	call ClearPalettes
	call ClearTileMap
	call TrainerCardDrawProtag
	call DisableLCD
	call PlaceMiscTilesTrainerCard
	ld hl, TrainerCardBorderGFX
	ld de, vTileset
	ld bc, $0240
	ld a, BANK(TrainerCardBorderGFX)
	call FarCopyData
	call DrawTrainerCardMainPage
	call EnableLCD
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	xor a
	ld [wFlyDestination], a
	and a
	ret

TrainerCardMainInputs:
	call EmptyFunction12e37
	call GetJoypad
	ld hl, hJoyDown
	ld a, [hl]
	and D_LEFT
	jr nz, .left
	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ld a, [hl]
	and A_BUTTON
	jr nz, .a
	ld a, [hl]
	and B_BUTTON
	jr nz, .exit
	and a
	ret
.a
	ld a, [wFlyDestination]
	and a
	jr z, .exit
	ld a, 5
	ld [wJumptableIndex], a
	and a
	ret
.exit
	ld a, $11
	ld [wJumptableIndex], a
	and a
	ret
.left
	hlcoord 4, 16
	ld [hl], "▶"
	hlcoord 11, 16
	ld [hl], "　"
	xor a
	ld [wFlyDestination], a
	and a
	ret
.right
	hlcoord 4, 16
	ld [hl], "　"
	hlcoord 11, 16
	ld [hl], "▶"
	ld a, 1
	ld [wFlyDestination], a
	and a
	ret

EmptyFunction12e37:
	ret

TrainerCardScroll:
	ld a, $90
	ldh [hWY], a
	ld a, $9C
	ldh [hBGMapAddress +1], a
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardClearTileMap:
	xor a
	ldh [hWY], a
	ld a, $98
	ldh [hBGMapAddress +1], a
	call ClearTileMap
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardSetWindowY:
	ldh a, [hWY]
	cp $90
	jr nc, TrainerCardClearPals
	add a, 4
	ldh [hWY], a
	and a
	ret

TrainerCardClearPals:
	call ClearPalettes
	ld a, $90
	ldh [hWY], a
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardBadgePage:
	call ClearPalettes
	call DisableLCD
	ld hl, TrainerCardLeadersGFX
	ld de, vTileset
	ld bc, $07F0
	ld a, BANK(TrainerCardLeadersGFX)
	call FarCopyData
	call ClearTileMap
	call DrawTrainerCaseBadgePage
	call EnableLCD
	ld a, [wJumptableIndex]
	inc a
	ld [wJumptableIndex], a
	and a
	ret

TrainerCardBadgeInput:
	call GetJoypad
	ld hl, hJoyDown
	ld a, [hl]
	and 3
	jr z, .skip
	ld a, $11
	ld [wJumptableIndex], a
.skip
	and a
	ret

TrainerCardSetClearFlag:
	scf
	ret

TrainerCardDrawProtag:
	ld de, ProtagonistPic
	ld a, BANK(ProtagonistPic)
	call UncompressSpriteFromDE
	ld a, 0
	call OpenSRAM
	ld hl, sSpriteBuffer1
	ld de, sSpriteBuffer0
	ld bc, $0310
	call CopyBytes
	call CloseSRAM
	ld de, vChars2 tile $30
	call InterlaceMergeSpriteBuffers
	ret

PlaceMiscTilesTrainerCard:
	ld a, $30
	ldh [hGraphicStartTile], a
	hlcoord 13, 1
	lb bc, 7, 7
	predef PlaceGraphic
	ret

DrawTrainerCardMainPage:
	hlcoord 0, 0
	ld d, 5
	call PlaceTrainerCardBGTile
	hlcoord 0, 8
	ld d, 6
	call PlaceTrainerCardBGTile
	hlcoord 2, 2
	ld de, TrainerCardText
	call PlaceString
	hlcoord 16, 10
	ld de, TrainerCardDexEntriesText
	call PlaceString
	hlcoord 6, 2
	ld de, wPlayerName
	call PlaceString
	hlcoord 5, 4
	ld de, wce73
	lb bc, 2, 5
	call PrintNumber
	hlcoord 7, 6
	ld de, wd15d
	lb bc, 3, 6
	call PrintNumber
	ld [hl], $F0
	ld hl, wPokedexOwned
	ld b, $1C
	call CountSetBits
	ld de, wce37
	hlcoord 13, 10
	lb bc, 1, 3
	call PrintNumber
	hlcoord 1, 0
	ld de, TrainerCardNameTiles
	call PlaceTrainerCardTiles
	hlcoord 2, 4
	ld de, TrainerCardIDNoTiles
	call PlaceTrainerCardTiles
	hlcoord 1, 3
	ld de, TrainerCardNameUnderlineTiles
	call PlaceTrainerCardTiles
	hlcoord 1, 8
	ld de, TrainerCardStatusTiles
	call PlaceTrainerCardTiles
	hlcoord 0, 13
	ld de, TrainerCardBadgesOutlineTiles
	call PlaceTrainerCardTiles
	hlcoord 5, 16
	ld de, TrainerCardBadgesTextTiles
	call PlaceTrainerCardTiles
	hlcoord 4, 16
	ld [hl], "▶"
	ret

TrainerCardText:
	db "なまえ／<NEXT><NEXT>おこづかい<NEXT><NEXT>#ずかん@"

TrainerCardDexEntriesText:
	db "ひき@"

TrainerCardNameTiles:
	db $0A, $0C, $0D, $0E, $0F, $FF

TrainerCardIDNoTiles:
	db $22, $23, $FF

TrainerCardNameUnderlineTiles:
	db $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $0B, $FF

TrainerCardStatusTiles:
	db $0A, $10, $11, $12, $13, $FF

TrainerCardBadgesOutlineTiles:
	db $03, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $7F, $14, $15, $16, $17, $18, $19, $1A, $1B, $1C, $1D, $7F, $7F, $7F, $FE, $BA, $7F, $7F, $7F, $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $FF

TrainerCardBadgesTextTiles:
	db $1E, $1F, $20, $7F, $7F, $7F, $7F, $1B, $1C, $1D, $FF

DrawTrainerCaseBadgePage:
	hlcoord 0, 0
	ld d, $0E
	call PlaceTrainerCardBGTile
	hlcoord 5, 2
	ld de, TrainerCardLeagueBadgesTextTiles
	call PlaceString
	hlcoord 1, 0
	ld de, TrainerCardBadgesTiles
	call PlaceTrainerCardTiles
	hlcoord 0, 3
	ld de, TrainerCardBadgeSilhouettesTiles
	call PlaceTrainerCardTiles
	ret

TrainerCardLeagueBadgesTextTiles:
	db "#りーグバッジ@"

TrainerCardBadgesTiles:
	db $0A, $0B, $0C, $0D, $0E, $FF

TrainerCardBadgeSilhouettesTiles:
	db $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $07, $07, $02, $18, $58, $59, $5A, $19, $5B, $5C, $5D, $1A, $6B, $6C, $6D, $1B, $78, $79, $7A, $7F, $07, $07, $02, $7F, $20, $21, $22, $7F, $23, $24, $25, $7F, $26, $27, $28, $7F, $29, $2A, $2B, $7F, $07, $07, $02, $7F, $30, $31, $32, $7F, $33, $34, $35, $7F, $36, $37, $38, $7F, $39, $3A, $3B, $7F, $07, $07, $02, $7F, $40, $41, $42, $7F, $43, $44, $45, $7F, $46, $47, $48, $7F, $49, $4A, $4B, $7F, $07, $07, $05, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $04, $07, $07, $7F, $1C, $68, $69, $6A, $1D, $7E, $6F, $6F, $1E, $5E, $5F, $6E, $1F, $7B, $7C, $7D, $02, $07, $07, $7F, $7F, $2C, $2D, $2E, $7F, $2F, $50, $51, $7F, $52, $53, $54, $7F, $55, $56, $57, $02, $07, $07, $7F, $7F, $3C, $3D, $3E, $7F, $3F, $60, $61, $7F, $62, $63, $64, $7F, $65, $66, $67, $02, $07, $07, $7F, $7F, $4C, $4D, $4E, $7F, $4F, $70, $71, $7F, $72, $73, $74, $7F, $75, $76, $77, $02, $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $02, $07, $7F, $7F, $10, $7F, $11, $7F, $12, $7F, $13, $7F, $14, $7F, $15, $7F, $16, $7F, $17, $7F, $02, $07, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $01, $06, $07, $FF

PlaceTrainerCardTiles:
; takes the tiles from de and places them at hl until FF is found.
	ld a, [de]
	cp $FF
	ret z
	ld [hli], a
	inc de
	jr PlaceTrainerCardTiles

PlaceTrainerCardBGTile:
; puts tile $07 (chequered background) at coord hl.
; d controls how many times biggerloop loops.
	ld e, $14
.loop
	ld a, $07
	ld [hli], a
	dec e
	jr nz, .loop

	ld a, $07
	ld [hli], a
	ld e, $11
.ScanLoop
	inc hl
	dec e
	jr nz, .ScanLoop

	ld a, 9
	ld [hli], a
	ld a, 7
	ld [hli], a
.OuterLoop
	ld a, 7
	ld [hli], a
	ld e, $12
.InnerLoop
	inc hl
	dec e
	jr nz, .InnerLoop

	ld a, 7
	ld [hli], a
	dec d
	jr nz, .OuterLoop

	ld a, 7
	ld [hli], a
	ld a, 8
	ld [hli], a
	ld e, $11
.ScanLoop2
	inc hl
	dec e
	jr nz, .ScanLoop2

	ld a, 7
	ld [hli], a
	ld e, $14
.LastLoop
	ld a, 7
	ld [hli], a
	dec e
	jr nz, .LastLoop
	ret

; end of section
