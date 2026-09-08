StartMenu_Party:
	ld a, [wPartyCount]
	and a
	jr nz, .partynonzero
	ld a, 0
	ret
.partynonzero
	call LoadStandardMenuHeader
	callfar ClearGraphicsForPartyMenu

HandleSelectedPokemon:
	xor a
	ld [wPartyMenuActionText], a
	ld [wSwitchMon], a
	predef OpenPartyMenu
	jr PartyPrompt.partypromptreturn

PartyPrompt:
	ld a, [wCurPartyMon]
	inc a
	ld [wSwitchMon], a
	callfar UnfreezeMonIcons
	ld a, PARTYMENUACTION_MOVE
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu
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
	ld hl, 0
	call Call_ExitMenu
	call WaitBGMap
	call UpdateTimePals
	pop af
	ret

SelectedPokemonSubmenu:
	hlcoord 1, 13
	lb bc, 4, $12
	call ClearBox
	callfar MonSubmenu
	call GetCurNick
	ld a, [wMenuSelection]
	ld hl, PartyJumpTable
	ld de, $3
	call IsInArray
	jp nc, HandleSelectedPokemon
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wJohtoBadges]
	jp hl

PartyJumpTable:
	dbw MONMENUITEM_UPROOT, PartyTryCut
	dbw MONMENUITEM_WIND_RIDE, PartyTryFly
	dbw MONMENUITEM_WATER_SPORT, PartyTrySurf
	dbw MONMENUITEM_STRONG_ARM, PartyCantUseMove
	dbw MONMENUITEM_BRIGHT_MOSS, PartyCantUseMove 
	dbw MONMENUITEM_WHIRLPOOL, PartyCantUseMove
	dbw MONMENUITEM_BOUNCE, PartyCantUseMove
	dbw MONMENUITEM_DIG, PartyTryDig
	dbw MONMENUITEM_TELEPORT, PartyTryTeleport
	dbw MONMENUITEM_SOFTBOILED, PartyCalculateHealth
	dbw MONMENUITEM_STATS, PartyPokemonSummary
	dbw MONMENUITEM_SWITCH, PartyCheckLessThanTwo
	dbw MONMENUITEM_ITEM, PartyHeldItem
	dbw MONMENUITEM_CANCEL, HandleSelectedPokemon
	dbw MONMENUITEM_MOVE, PartyPokemonSummary2
	dbw MONMENUITEM_MAIL, PartyMailMenu

PartyCheckLessThanTwo:
; might have to do with switch?
	ld a, [wPartyCount]
	cp 2
	jp c, HandleSelectedPokemon
	jp PartyPrompt

PartyHeldItem:
	callfar FreezeMonIcons
	ld hl, GiveTakeItemMenuData
	call LoadMenuHeader
	call VerticalMenu
	jp c, .close
	call GetCurNick
	ld hl, wStringBuffer1
	ld de, wMonOrItemNameBuffer
	ld bc, MON_NAME_LENGTH
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
	ld a, [wItemAttributeValue]
	and a
	jp nz, .CantGive
	call GetPartyItemOffset
	ld a, [hl]
	and a
	jr z, .NoItem
	ld [wTempSpecies], a
	call GetItemName
	ld hl, PokemonAskSwapItemText
	call MenuTextBox
	call YesNoBox
	call ExitMenu
	jp c, .ExitGiveItem
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call TossItem
	ld a, [wTempSpecies]
	ld b, a
	ld a, [wCurItem]
	ld [wTempSpecies], a
	ld a, b
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	jp nc, .GiveItem
	ld a, [wTempSpecies]
	ld [wCurItem], a
	ld hl, PokemonSwapItemText
	call MenuTextBoxBackup
	jr .CheckMail

.NoItem
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call TossItem
	ld hl, PokemonHoldItemText
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
	ld a, [wTempSpecies]
	ld [wCurItem], a
	call ReceiveItemFromPokemon
	ld hl, ItemStorageFullText
	call MenuTextBoxBackup
	jr .ExitGiveItem

.CantGive
	ld hl, ItemCantHeldText
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
	call ReceiveItemFromPokemon
	jr nc, .jump2
	call GetPartyItemOffset
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	ld [hl], ITEM_NONE
	call GetItemName
	ld hl, PokemonTookItemText
	call MenuTextBoxBackup
	jr .escape
.NoItemToRecieve
	ld hl, PokemonNotHoldingText
	call MenuTextBoxBackup
	jr .escape
.jump2
	ld hl, ItemStorageFullText
	call MenuTextBoxBackup
.escape
	ret

GiveTakeItemMenuData:
	db STATICMENU_NO_TOP_SPACING | STATICMENU_PLACE_TITLE
	menu_coords 4, 4, 14, 9
	dw .Items
	db 1 ; default option

.Items:
	db STATICMENU_CURSOR ; flags
	db 2 ; # items
	db "そうびを　する@"
	db "そうびを　はずす@"

ItemCantHeldText:
	text_from_ram wStringBuffer1
	text "を　そうびすることは"
	line "できません"
	prompt

PokemonSwapItemText:
	text_from_ram wMonOrItemNameBuffer
	text "は　そうび　していた"
	line "@"
	text_from_ram wStringBuffer1
	text "を　はずして"
	para "@"
	text_from_ram wStringBuffer2
	text "を　そうびした！"
	prompt

PokemonHoldItemText:
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer2
	text "を"
	line "そうびした！"
	prompt

PokemonNotHoldingText:
	text_from_ram wMonOrItemNameBuffer
	text "は　なにも"
	line "そうび　していません！"
	prompt

ItemStorageFullText:
	text "どうぐが　いっぱいで"
	line "そうびを　はずせません！"
	prompt

PokemonTookItemText:
	text_from_ram wMonOrItemNameBuffer
	text "から　@"
	text_from_ram wStringBuffer1
	text "を"
	line "はずしました！"
	prompt

PokemonAskSwapItemText:
	text_from_ram wMonOrItemNameBuffer
	text "は　@"
	text_from_ram wStringBuffer1
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

ReceiveItemFromPokemon:
	ld a, 1
	ld [wItemQuantity], a
	ld hl, wNumBagItems
	call ReceiveItem
	ret

UnusedHandleRecieveItemJumptable:
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, UnusedRecieveItemJumptable
	jp CallJumptable

UnusedRecieveItemJumptable:
	dw PartyGiveItem
	dw PartyGiveMail
	dw PartyBallPocket
	dw ChangeBackpackPocket
	dw PartyGiveItem
	dw PartyGiveItem
	dw PartyGiveItem

PartyGiveItem:
	ret

ChangeBackpackPocket:
	call FlipPocket2Status
	xor a
	ld [wSwitchItem], a
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
	callfar ComposeMailMessage
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra
	call Call_ExitMenu
	call WaitBGMap
	ld a, [wCurPartyMon]
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	ld hl, wMovementBufferCount
	ld bc, MAIL_STRUCT_LENGTH
	ld a, BANK(sPartyMail)
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
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1 + MON_ITEM
	ld bc, PARTYMON_STRUCT_LENGTH
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
	ld a, [wCurPartyMon]
	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	ld bc, MAIL_STRUCT_LENGTH
	ld de, wMovementBufferCount
	ld a, BANK(sPartyMail)
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
	menu_coords 4, 4, 14, 11
	dw .MailMenuStrings
	db 1 ; default option

.MailMenuStrings

	db STATICMENU_CURSOR
	db 3
	db "メールを　よむ@"
	db "メールを　はずす@"
	db "やめる@"

.MessageRemoveMail
	text "メールを　はずすと　メッセージが"
	line "きえてしまいますが　いいですか？"
	done

.DrawNick
	text_from_ram wStringBuffer1
	text "から　@"

.DeleteMailText
	text "メールを"
	line "はずしました！"
	prompt

.MailFullText
	text "どうぐが　いっぱいで"
	line "メールを　はずせません！"
	prompt

PartyPokemonSummary:
	call LoadStandardMenuHeader
	call ClearSprites
	xor a
	ld [wMonType], a
	call LowVolume
	predef StatsScreenMain
	call MaxVolume
	call ReloadFontAndTileset
	call Call_ExitMenu
	jp HandleSelectedPokemon

PartyTryCut:
	callfar CutFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTryFly:
	bit 2, a
	jp z, PrintNeedNewBadgeText
	callfar FlyFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyCantUseMove:
	call PrintCantUseHM
	jp HandleSelectedPokemon

PartyTryTeleport:
	callfar TeleportFunction
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTrySurf:
	bit 4, a
	jp z, PrintNeedNewBadgeText
	callfar SurfFunction
	ld a, [wFieldMoveSucceeded]
	and a
	jp z, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyTryDig:
	callfar DigFunction
	ld a, [wFieldMoveSucceeded]
	cp $F
	jp nz, HandleSelectedPokemon
	ld a, 4
	jp PartyPromptExit

PartyCalculateHealth:
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ldh a, [hQuotient + 3]
	sub [hl]
	dec hl
	ldh a, [hQuotient + 2]
	sbc [hl]
	jp nc, PrintNotHealthyEnoughText
	callfar SoftboiledFunction
	jp HandleSelectedPokemon

PrintNotHealthyEnoughText:
	ld hl, NotHealthyEnoughText
	call PrintText
	jp HandleSelectedPokemon

NotHealthyEnoughText:
	text "たいりょくが　たりません！"
	prompt

PrintNeedNewBadgeText:
	ld hl, NeedNewBadgeText
	call PrintText
	jp HandleSelectedPokemon

NeedNewBadgeText:
	text "あたらしい　バッジを　てにするまで"
	line "まだ　つかえません！"
	prompt

PartyPokemonSummary2:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]
	call PokeSummary
	pop af
	ld [wOptions], a
	call ClearBGPalettes
	jp HandleSelectedPokemon

PokeSummary:
	call ClearBGPalettes
	call ClearTileMap
	call ClearSprites
	xor a
	ldh [hBGMapMode], a
	callfar LoadOnlyPokemonStatsGraphics
	callfar LoadOverworldMonIcon
	ld a, [wCurPartyMon]
	ld e, a
	ld d, 0
	ld hl, wPartySpecies
	add hl, de
	ld a, [hl]
	ld [wTempIconSpecies], a
	ld hl, LoadMenuMonIcon
	ld a, BANK(LoadMenuMonIcon)
	ld e, MONICON_MOVES
	call FarCall_hl
	hlcoord 0, 1
	ld b, 8
	ld c, $12
	call DrawTextBox
	hlcoord 1, 1
	lb bc, 2, $12
	call ClearBox
	hlcoord 3, 1
	predef PlacePartyMember
	ld hl, wPlayerHPPal
	call SetHPPal
	ld b, SGB_MOVE_LIST
	call GetSGBLayout
	hlcoord 11, 0
	lb bc, 1, 9
	call ClearBox
	hlcoord 16, 0
	ld a, [wCurPartyMon]
	and a
	jr z, .FirstPokeChosen
	ld [hl], '」'
.FirstPokeChosen
	inc a
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr z, .LastPokeChosen
	inc hl
	inc hl
	ld [hl], '▶' ; right filled arrow
.LastPokeChosen
	ld de, PartyMenuAttributes
	call SetMenuAttributes
SummaryDrawPoke:
	xor a
	ldh [hBGMapMode], a
	ld [wSwitchMon], a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld hl, wTempMonMoves
	ld de, wListMoves_MoveIndicesBuffer
	ld bc, NUM_MOVES
	call CopyBytes
	ld a, $28
	ld [wHPBarMaxHP], a
	hlcoord 2, 3
	predef ListMoves
	hlcoord 11, 3
	predef ListMovePP
	call WaitBGMap
	call SetDefaultBGPAndOBP
	ld a, [wNumMoves]
	inc a
	ld [w2DMenuNumRows], a
	hlcoord 0, 10
	ld b, 6
	ld c, 18
	call DrawTextBox
	ld hl, w2DMenuFlags1
	set _2DMENU_ENABLE_SPRITE_ANIMS_F, [hl]
	jr PartySelectionInputs.PartySelectSkipInputs
PartySelectionInputs:
	call StaticMenuJoypad + 3
	bit B_PAD_B, a
	jp nz, PartySelectionBackOut
	bit B_PAD_A, a
	jp nz, .PartyPokeSelect
	bit B_PAD_RIGHT, a
	jp nz, .PartyPokeDetailsAdvancePage
	bit B_PAD_LEFT, a
	jp nz, .PartyPokeDetailsBackPage
.PartySelectSkipInputs
	ld hl, wPartyMon1 + MON_MOVES
	lb bc, 0, $30
	ld a, [wCurPartyMon]
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
	ld a, [wSwitchMon]
	and a
	jr nz, .DrawMovePokeText
	ld de, PartyTypeText
	call PlaceString
	ld a, [wCurSpecies]
	ld b, a
	hlcoord 5, 12
	predef PrintMoveType
	ld a, [wCurSpecies]
	dec a
	ld hl, Moves + MOVE_POWER
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	hlcoord 15, 12
	cp 2
	jr c, .NotAMove
	ld [wTempSpecies], a
	ld de, wTempSpecies
	lb bc, 1, 3
	call PrintNumber
	jr .step
.NotAMove
	ld de, PartyPokeDivider
	call PlaceString
.step
	hlcoord 1, 14
	predef PrintMoveDescription
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
	ld hl, wCurPartyMon
	inc [hl]
	ld a, [wPartyCount]
	cp [hl]
	jp nz, PokeSummary
	dec [hl]
	jp PartySelectionInputs

.PartyPokeDetailsBackPage
	ld hl, wCurPartyMon
	ld a, [hl]
	and a
	jp z, PartySelectionInputs
	dec [hl]
	jp PokeSummary

.PartyPokeSelect
	ld a, [wSwitchMon]
	and a
	jr nz, .swap
	ld a, [wMenuCursorY]
	ld [wSwitchMon], a
	call PlaceHollowCursor
	jr .DrawMovePokeText
.swap
	ld hl, wPartyMon1 + MON_MOVES
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call SwapEntries
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	call SwapEntries
	ld a, [wBattleMode]
	jr z, .NotInBattle
	ld hl, wBattleMonMoves
	ld bc, NUM_MOVES * MOVE_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	push hl
	call SwapEntries
	pop hl
	ld bc, PARTY_LENGTH
	add hl, bc
	call SwapEntries
.NotInBattle
	hlcoord 1, 2
	lb bc, 8, $12
	call ClearBox
	jp SummaryDrawPoke

SwapEntries:
; values at (hl + [cursor place]-1)
; and (hl + [wSwitchMon] -1) get swapped
	push hl ; saves hl
	ld a, [wMenuCursorY]
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	ld d, h
	ld e, l
	pop hl ; hl is same as start
	ld a, [wSwitchMon]
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
	ld [wSwitchMon], a
	ld hl, w2DMenuFlags1
	res _2DMENU_ENABLE_SPRITE_ANIMS_F, [hl]
	call ClearSprites
	call ClearTileMap
	ret

PartyMenuAttributes:
	db 3, 1 ; cursor y, x
	db 3, 1 ; rows, cols
	db _2DMENU_ENABLE_SPRITE_ANIMS ; flags 1
	db 0 ; flags 2
	dn 2, 0 ; cursor offset y, x
	db PAD_CTRL_PAD | PAD_B | PAD_A ; joypad filter

PartyTypeText:
	db "タイプ／　　　　　いりょく／@"

PartyPokeDivider:
	db "ーーー@"

PartyMoveText:
	db "どこに　いどうしますか？@"

CheckRegisteredItem::
	call .RegisteredItem
	ret

.RegisteredItem
	call GetRegisteredItemID
	jr c, .NotRegistered
	call UseRegisteredItem
	ret

.NotRegistered
	call ReanchorMap
	ld hl, .NothingRegisteredText
	call MenuTextBoxBackup
	call CloseText
	ret

.NothingRegisteredText:
	text "べんりボタンを　おした！"
	line "⋯しかしなにもおきない！"
	prompt

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
	and %01111111
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
	callfar CheckItemMenu
	ld a, [wItemAttributeValue]
	ld hl, .RegisteredItemJumptable
	jp CallJumptable

.RegisteredItemJumptable
; BUG: This table only has 6 entries instead of the needed 7.
; .RegularItem appears to have been commented out, adding it back as the fifth entry restores proper behavior.
	dw .CantUse2
	dw .CantUse
	dw .CantUse
	dw .CantUse
;	dw .RegularItem
	dw .KeyItem
	dw .FieldMove

.CantUse
	call ReanchorMap
	call PrintCantUseText
	call CloseText
	and a
	ret

.RegularItem ; unreferenced
	call ReanchorMap
	call DoItemEffect
	call CloseText
	and a
	ret

.KeyItem
	call ReanchorMap
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call DoItemEffect
	call ClearPalettes
	call StartMenuLoadSprites
	call UpdateTimePals
	call CloseText
	and a
	ret

.FieldMove
	call DoItemEffect
	ld a, [wFieldMoveSucceeded]
	and a
	jr z, .CantUse2
	scf
	ld a, -1
	ldh [hStartmenuCloseAndSelectHookEnable], a
	ld a, 4
	ret

.CantUse2
	call ReanchorMap
	call PrintCantUseText
	call CloseText
	and a
	ret
