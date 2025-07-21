INCLUDE "constants.asm"

SECTION "engine/events/pokecenter_pc.asm", ROMX

; PokemonCenterPC.Jumptable indices
	const_def
	const PCITEM_PLAYERS_PC
	const PCITEM_BILLS_PC
	const PCITEM_OAKS_PC
	const PCITEM_HALL_OF_FAME
	const PCITEM_TURN_OFF

PokemonCenterPC:
; Also used for player's PC (both in debug and in demo mode)

	ld a, [wDebugFlags]
	bit 1, a
	jp z, PC_Demo
	call PC_PlayBootSound

; Return if there are no mons in party
	ret c

; Open the player's PC menu
	ld hl, .TurnOnText
	call MenuTextBoxBackup
	ld hl, wDebugFlags
	bit 1, [hl]
	jr nz, .DisplayMenu
	ld hl, .NotConnectedText
	call MenuTextBoxBackup
	ret

.NotConnectedText:
	text "<⋯⋯>　が　つながっていなかった"
	line "ようだ　<⋯⋯>"
	prompt

.DisplayMenu:
	ld hl, .TopMenu
	call LoadMenuHeader
.loop
	xor a
	ld [wActiveBackpackPocket], a
	call OpenMenu
	jr c, .shutdown
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop

.shutdown
	call CloseWindow
	ret

.TurnOnText:
	text "コンピューターを　きどう！"
	para "ネットワークにせつぞくした！"
	prompt

.TopMenu:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 14, 12
	dw .MenuData
	db 1 ; default item

.MenuData:
	db STATICMENU_CURSOR
	db 0
	dw .WhichPC
	dw PlaceMenuStrings
	dw .MenuStrings

.MenuStrings:
	db "<PLAYER>の　パソコン@"
	db "？？？の　パソコン@"
	db "オーキドの　パソコン@"
	db "でんどういり@"
	db "せつぞくをきる@"

.Jumptable:
	dw PlayersPC
	dw BillsPC
	dw OaksPC
	dw OaksPC
	dw TurnOffPC

.WhichPC:
	db 4
	db PCITEM_PLAYERS_PC
	db PCITEM_BILLS_PC
	db PCITEM_OAKS_PC
	db PCITEM_TURN_OFF
	db -1

PC_PlayBootSound:
	ld a, [wPartyCount]
	and a

; Don't play the bootup sound if player has at least one mon
	ret nz

	ld de, SFX_CHOOSE_PC_OPTION
	call PlaySFX
	ld hl, .NoPokemonText
	call OpenTextbox

; Return carry when there are no mons in party
	scf
	ret

.NoPokemonText:
	text "ピーッ！"
	line "ポケモンを　もっていない"
	cont "ひとは　つかうことが　できません！"
	text_end
	text_end

PC_Demo:
	ld de, SFX_CHOOSE_PC_OPTION
	call PlaySFX
	ld hl, .SkarmoryText
	call PrintText
	call TextboxWaitPressAorB_BlinkCursor
	ret

.SkarmoryText:
	text "ポケモン　ジャーナル　ホームぺージ"
	line "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	para "しんポケモン　はっけん！！"
	line "めいめい　ヨロイドり"
	cont "はがねの　ように"
	cont "かたい　つばさが　とくちょう"
	para "ひこうタイプ　だけではなく"
	line "あたらしく　メタルタイプ　としても"
	cont "ぶんるい　されることが　けってい"
	cont "これからの　けんきゅうが　またれる"
	cont "<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>　<⋯⋯>"
	done

BillsPC:
	callfar _BillsPC
	and a
	ret

PlayersPC:
	call _PlayersPC
	and a
	ret

OaksPC:
	ld hl, .TooManyConnectionsText
	call MenuTextBoxBackup
	and a
	ret

.TooManyConnectionsText:
	text "かいせん　が　こみあっていて"
	line "せつぞくできません"
	prompt

TurnOffPC:
	ld hl, .ClosedPCText
	call MenuTextBoxBackup
	scf
	ret

.ClosedPCText:
	text "ネットワークへの　せつぞくを"
	line "やめました"
	prompt


_PlayersPC:
	ld hl, .TurnOnText
	call MenuTextBoxBackup
.loop
	call UpdateTimePals
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	push af
	call ExitMenu
	pop af
	jr c, .done
	ld a, [wMenuCursorY]
	dec a
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop
	ld hl, .ShutDownText
	call MenuTextBoxBackup
.done
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 10, 10
	dw .MenuStrings
	db   1 ; default selection

.MenuStrings:
	db STATICMENU_CURSOR
	db 4
	db "ひきだす@"
	db "あずける@"
	db "すてる@"
	db "せつぞくをきる@"

.Jumptable:
	dw PlayerWithdrawItemMenu
	dw PlayerDepositItemMenu
	dw PlayerTossItemMenu
	dw PlayerLogOffMenu

.TurnOnText:
	text "<PLAYER>は　じぶんのパソコンに"
	line "つないだ"
	para "どうぐあずかりシステムを"
	line "よびだした！"
	prompt

.ShutDownText:
	text "<PLAYER>は　じぶんのパソコンとの"
	line "せつぞくをきった"
	para ""
	done

PlayerWithdrawItemMenu:
	call LoadStandardMenuHeader
	call ClearTileMap
	call UpdateSprites
.loop
	call PCItemsJoypad
	jr c, .quit
	call .Submenu
	jr .loop
.quit
	call Call_ExitMenu
	and a
	ret

.Submenu:
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr z, .AskQuantity
	ld a, 1
	ld [wItemQuantity], a
	jr .Withdraw

.AskQuantity:
	ld hl, .HowManyToWithdrawText
	call MenuTextBox
	callfar SelectQuantityToToss
	call ExitMenu
	call ExitMenu
	jr c, .done

.Withdraw:
	ld hl, wUnknownListLengthd1ea
	ld a, [wItemIndex]
	call TossItem
	ld hl, wNumBagItems
	call ReceiveItem
	jr nc, .PackFull
	predef LoadItemData
	ld hl, .WithdrewItemsText
	call MenuTextBoxBackup
	ret

.PackFull:
	ld hl, .NoRoomWithdrawText
	call MenuTextBoxBackup
	ld hl, wUnknownListLengthd1ea
	call ReceiveItem
	ret

.done
	ret

.HowManyToWithdrawText:
	text "いくつひきだしますか？"
	done

.WithdrewItemsText:
	text_from_ram wStringBuffer2
	text "を　@"
	deciram wItemQuantity, 1, 2
	text "こ　"
	line "ひきだしました"
	prompt

.NoRoomWithdrawText:
	text "もちものが　いっぱいなので"
	line "ひきだせません！"
	prompt

PlayerTossItemMenu:
	call LoadStandardMenuHeader
	call ClearTileMap
	call ClearSprites
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call UpdateSprites
.loop
	call PCItemsJoypad
	jr c, .quit
	ld de, wUnknownListLengthd1ea
	callfar TryTossItem
	jr .loop
.quit
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call Call_ExitMenu
	and a
	ret

PlayerLogOffMenu:
	scf
	ret

PlayerDepositItemMenu:
	call .CheckItemsInBag
	ret c
	call LoadStandardMenuHeader
	callfar GetPocket2Status
	callfar DrawBackpack
.loop
	callfar DebugBackpackLoop
	jr c, .quit
	call .TryDepositItem
	jr .loop
.quit
	call ClearPalettes
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call Call_ExitMenu
	and a
	ret

.CheckItemsInBag:
	callfar CheckItemsQuantity
	ret nc

; no item to deposit
	ld hl, .NoItemsText
	call MenuTextBoxBackup
	scf
	ret

.NoItemsText:
	text "どうぐを　ひとつも"
	line "もっていない！"
	prompt

.TryDepositItem:
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .Jumptable
	jp CallJumptable

.Jumptable:
	dw .Depositable
	dw .NotDepositable
	dw .BallNotDepositable
	dw .SwapPockets
	dw .Depositable
	dw .Depositable
	dw .Depositable

.NotDepositable:
	ld hl, .CantDepositText
	call MenuTextBoxBackup
	ret

.CantDepositText:
	text "わざマシンは　"
	line "あずけられない！"
	prompt

.BallNotDepositable:
	ld hl, .CantDepositBallText
	call MenuTextBoxBackup
	ret

.CantDepositBallText:
	text "ボールホルダは"
	line "あずけられない！"
	prompt

.SwapPockets:
	callfar FlipPocket2Status
	xor a
	ld [wSelectedSwapPosition], a
	ret

.Depositable:
	call .DepositItem
	ret

.DepositItem:
	callfar _CheckTossableItem
	ld a, [wItemAttributeValue]
	and a
	jr z, .AskQuantity
	ld a, 1
	ld [wItemQuantity], a
	jr .ContinueDeposit

.AskQuantity:
	ld hl, .HowManyDepositText
	call MenuTextBox
	callfar SelectQuantityToToss
	push af
	call ExitMenu
	call ExitMenu
	pop af
	jr c, .DeclinedToDeposit

.ContinueDeposit:
	ld hl, wNumBagItems
	ld a, [wItemIndex]
	call TossItem
	ld hl, wUnknownListLengthd1ea
	call ReceiveItem
	jr nc, .NoRoomInPC
	predef LoadItemData
	ld hl, .DepositItemsText
	call MenuTextBoxBackup
	ret

.NoRoomInPC:
	ld hl, .NoRoomDepositText
	call MenuTextBoxBackup
	ld hl, wNumBagItems
	call ReceiveItem
	ret

.DeclinedToDeposit:
	and a
	ret

.HowManyDepositText:
	text "いくつあずけますか？"
	done

.DepositItemsText:
	text_from_ram wStringBuffer2
	text "を　@"
	deciram wItemQuantity, 1, 2
	text "こ　"
	line "あずけました"
	prompt

.NoRoomDepositText:
	text "どうぐが　いっぱいです"
	line "もう　あずけられません！"
	prompt

PCItemsJoypad:
	ld hl, .MenuHeader
	call CopyMenuHeader
	ld a, [wBackpackAndKeyItemsCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBackpackAndKeyItemsScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBackpackAndKeyItemsScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBackpackAndKeyItemsCursor], a
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .b_button
	cp A_BUTTON
	jr z, .a_button
	cp SELECT
	jr z, .select
	jr .next
.select
	callfar SwitchItemsInBag
	jp .next
.next
	jp PCItemsJoypad
.a_button
	callfar ScrollingMenu_ClearLeftColumn
	call PlaceHollowCursor
	and a
	ret
.b_button
	scf
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 4, 1, 19, 10
	dw .MenuData
	db  1 ; default selection

.MenuData:
	db SCROLLINGMENU_ENABLE_SELECT | SCROLLINGMENU_ENABLE_FUNCTION3 | SCROLLINGMENU_ENABLE_RIGHT | SCROLLINGMENU_ENABLE_LEFT
	db 4, 8 ; rows, columns
	db SCROLLINGMENU_ITEMS_QUANTITY ; type
	dbw 0, wUnknownListLengthd1ea
	dba PlaceMenuItemName
	dba PlaceMenuItemQuantity
	dba UpdateItemDescription
