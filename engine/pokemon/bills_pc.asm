INCLUDE "constants.asm"

SECTION "engine/pokemon/bills_pc.asm", ROMX

_BillsPC:
	call .CheckCanUsePC
	ret c
	call LoadStandardMenuHeader
	call ClearTileMap
	call LoadFontsBattleExtra
	ld hl, vChars2 tile $78
	ld de, PokeBallsGFX
	lb bc, BANK(PokeBallsGFX), 1
	call Request2bpp
	ld hl, .PCWhatText
	call MenuTextBox
	ld hl, .MenuHeader
	call LoadMenuHeader
.loop
	call SetPalettes
	xor a
	ld [wWhichIndexSet], a
	call OpenMenu
	jr c, .cancel
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop

.cancel
	call CloseWindow
	call CloseWindow
	call LoadTilesetGFX
	call RestoreScreenAndReloadTiles
	call LoadFontExtra
	call CloseWindow
	ret

.PCWhatText:
	text "なんに　するん？" ; (lit. "What are you going to do?")
	done

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 14, 17
	dw .MenuData
	db 1

.MenuData:
	db MENU_BACKUP_TILES_2
	db 0
	dw .items
	dw PlaceMenuStrings
	dw .strings

.strings
	db "#の　ようすをみる@"   ; (lit "look at Pokemon")
	db "#を　つれていく@"    ; "Withdraw (Pokemon)"
	db "#を　あずける@"      ; "Deposit (Pokemon)"
	db "#を　にがす@"       ; "Release (Pokemon)"
	db "ボックスを　かえる@" ; "Change Box"
	db "さようなら@"        ; "Goodbye"

.Jumptable:
	dw BillsPC_ViewPokemon
	dw BillsPC_WithdrawPokemon
	dw BillsPC_DepositMon
	dw BillsPC_ReleaseMon
	dw BillsPC_ChangeBoxMenu
	dw BillsPC_SeeYa

.items
	db 5 ; # items
	db 0 ; VIEW
	db 1 ; WITHDRAW
	db 2 ; DEPOSIT
	db 3 ; RELEASE
	db 4 ; CHANGE BOX
	db 5 ; SEE YA!
	db -1

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .PCGottaHavePokemonText
	call MenuTextBoxBackup
	scf
	ret

.PCGottaHavePokemonText:
	text "#もってへんやつは"
	line "おことわりや！"
	prompt

BillsPC_SeeYa:
	scf
	ret

BillsPC_DepositMon:
	call .CheckPartySize
	jr c, .cant_deposit
	call _DepositPKMN

.cant_deposit
	and a
	ret

.CheckPartySize:
	ld a, [wPartyCount]
	and a
	jr z, .no_mon
	cp 2
	jr c, .only_one_mon
	and a
	ret

.no_mon
	ld hl, .PCNoSingleMonText
	call MenuTextBoxBackup
	scf
	ret

.only_one_mon
	ld hl, .PCCantDepositLastMonText
	call MenuTextBoxBackup
	scf
	ret

.PCNoSingleMonText:
	text "１ぴきも　もってへんやんか！" ; (lit: "I can't even have one!")
	prompt

.PCCantDepositLastMonText:
	text "それ　あずけたら"   ; "You can't deposit"
	line "こまるんとちゃう？" ; "the last #MON!"
	prompt

_DepositPKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_DepositMenu
	call BillsPC_Menu
	call CloseWindow
	ret c

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

BillsPC_WithdrawPokemon:
	call .CheckPartySize
	jr c, .cant_withdraw
	call _WithdrawPKMN
.cant_withdraw
	and a
	ret

.CheckPartySize:
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .party_full
	and a
	ret

.party_full
	ld hl, .PCCantTakeText
	call MenuTextBoxBackup
	scf
	ret

.PCCantTakeText:
	text "それいじょう　よくばったって" ; "You can't take any"
	line "#　もたれへんで！"          ; "more #MON."
	prompt

_WithdrawPKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_WithdrawReleaseMenu
	call BillsPC_Menu
	call CloseWindow
	ret c

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	xor a ; PC_WITHDRAW
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

BillsPC_ReleaseMon:
	call .ReleasePKMN
	and a
	ret

.ReleasePKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_WithdrawReleaseMenu
	call BillsPC_Menu
	call CloseWindow
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ret c

	ld hl, .OnceReleasedText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

.OnceReleasedText:
	text_from_ram wStringBuffer1
	text "　をほんとうに" ; "Are you sure you"
	next "にがしますか？" ; "want to release (MON)?"
	done

BillsPC_ChangeBoxMenu:
	call _ChangeBox
	and a
	ret

_ChangeBox:
	call InitDummyBoxNames
	call LoadStandardMenuHeader
	call ClearPalettes
	call ClearTileMap
.sub_e3d4
	ld hl, _ChangeBox_MenuHeader
	call CopyMenuHeader
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .sub_e3e9
	call BillsPC_ChangeBoxSubmenu
	jr .sub_e3d4
.sub_e3e9
	call CloseWindow
	ret

; Resets all box names to "ダミーボックス#" ("Dummy Box#"), where # is the box index.
InitDummyBoxNames:
	ld hl, wBoxNames
	ld c, 0
.loop
	push hl
	ld de, .DummyBoxText
	call CopyString
	ld a, "０"
	add c
	dec hl
	ld [hli], a
	ld [hl], "@"
	pop hl
	ld de, BOX_NAME_LENGTH
	add hl, de
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .loop
	ret

.DummyBoxText:
	db "ダミーボックス@" ; "Dummy Box"

_ChangeBox_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, SCREEN_WIDTH - 1, 12
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 0
	db SCROLLINGMENU_ITEMS_NORMAL
	dba .Boxes
	dba .PrintBoxNames
	ds 3
	dba BillsPC_PrintBoxCountAndCapacity

.Boxes:
	db NUM_BOXES
for x, NUM_BOXES
	db x + 1
endr
	db -1

.PrintBoxNames:
	push de
	ld a, [wMenuSelection]
	dec a
	ld bc, 6 ; length of "No. 0#" strings
	ld hl, .BoxNumbers
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	push bc
	ld a, [wMenuSelection]
	dec a
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

; TODO: rework this to use a nice macro?
.BoxNumbers:
	db "№．０１　@"
	db "№．０２　@"
	db "№．０３　@"
	db "№．０４　@"
	db "№．０５　@"
	db "№．０６　@"
	db "№．０７　@"
	db "№．０８　@"
	db "№．０９　@"
	db "№．１０　@"

BillsPC_PrintBoxCountAndCapacity:
	ld h, d
	ld l, e
	ld de, .Pokemon
	call PlaceString
	ld hl, 3
	add hl, bc
	push hl
	call .GetBoxCount
	pop hl
	ld de, wStringBuffer1
	ld [de], a
	lb bc, 1, 2
	call PrintNumber
	ld de, .OutOf30
	call PlaceString
	ret

.Pokemon:
	db "あずかっている#" ; "Mon in my care"
	next "　@"

.OutOf30: ; max mon per box
	db "／３０@"

.GetBoxCount:
	ld a, [wMenuSelection]
	dec a
	ld c, a
	ld b, 0
	ld hl, .BoxBankAddresses
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ret

.BoxBankAddresses:
	table_width 3, BillsPC_PrintBoxCountAndCapacity.BoxBankAddresses
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
endr
	assert_table_length NUM_BOXES

BillsPC_ChangeBoxSubmenu:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [wMenuCursorY]
	cp 1
	jr z, .Switch
	cp 2
	jr z, .Name
	and a
	ret

.UnderDev:
	ld hl, .BoxChangeUnderDevText
	call MenuTextBox
	call CloseWindow
	ret

.BoxChangeUnderDevText:
	text "バンクチェンジは" ; "Box change is"
	next "かいはつちゅうです！" ; "under development!"
	prompt

.Switch:
	ld hl, .ChangeBoxSaveText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	jr .UnderDev

.Unreferenced_e54d:
	ld a, [wMenuSelection]
	ret

.ChangeBoxSaveText:
	text "#　ボックスを　かえると" ; "When you change a box"
	line "どうじに　レポートが　かかれます" ; "data will be saved."
	para "<⋯⋯>　それでも　いいですか？" ; "Is that okay?"
	done

.Name:
	ld b, NAME_BOX
	ld de, wTempBoxName
	farcall NamingScreen
	ld a, [wTempBoxName]
	cp "@"
	ret z
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	ld a, [wMenuSelection]
	dec a
	call AddNTimes
	ld de, wTempBoxName
	call CopyString
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 6, 14, 14
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "ボックスきりかえ@" ; "Change Box"
	db "なまえを　かえる@" ; " Change Name"
	db "やめる@" ; (lit "stop")

BillsPC_ViewPokemon:
	call LoadStandardMenuHeader
	call _ViewPKMN
	call ClearPalettes
	call CloseWindow
	and a
	ret

_ViewPKMN:
.loop
	call ClearBGPalettes
	call .InitViewPokemonDisplay
	call SetPalettes
	ld hl, BillsPC_ViewMenuHeader
	call CopyMenuHeader
	ld a, [wBillsPCCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBillsPCScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBillsPCScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBillsPCCursor], a
	call ClearPalettes
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit
	call .ViewStats
	jr .loop

.exit
	ret
.ViewStats
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	call LoadStandardMenuHeader
	call LowVolume
	predef StatsScreenMain
	call MaxVolume
	call ExitMenu
	ret

.InitViewPokemonDisplay
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]
	call ClearTileMap

; Note that the name of the box doesn't actually gets printed yet: register 'de' is immediately overwritten,
; so the game displays the placeholder "いまの　ボックス" ("Current Box"). The setup is here, though.
	ld a, [wCurBox]
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l

	hlcoord 1, 1
	ld de, .CurrentBox
	call PlaceString
	hlcoord 0, 3
	ld a, "┌"
	ld [hli], a
	ld a, "─"
	ld c, SCREEN_WIDTH - 1

.top_border_loop
	ld [hli], a
	dec c
	jr nz, .top_border_loop
	ld de, SCREEN_WIDTH
	ld a, "│"
	ld c, 8
.left_border_loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .left_border_loop

	hlcoord 2, 3
	ld de, .SpeciesNameLevel
	call PlaceString
	ld hl, .PCString_ChooseaPKMN
	call PrintText
	pop af
	ld [wOptions], a
	ret

.CurrentBox:
	db "ボックス／いまの　ボックス@" ; "Box/Current Box"

.SpeciesNameLevel:
	db "しゅるい　　なまえ　　　レべル@" ; "Species Name Level"

.PCString_ChooseaPKMN:
	text "どの#が　みたいねん？" ; "Which would you like to see?"
	done

BillsPC_Menu::
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	hlcoord 4, 2
	ld b, 9
	ld c, 14
	call DrawTextBox
	ld hl, wListPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ScrollingMenu_FromTable
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit
	ld hl, .PokemonSelected
	call MenuTextBoxBackup
	and a
	ret
	
.exit
	scf
	ret

.PokemonSelected:
	text "#を　えらんだ！" ; "POKéMON selected!"
	prompt

BillsPC_DepositMenu:
	dw .MenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wPartyCount
	dba PlacePartyMonNicknames
	dba PlacePartyMonLevels
	ds 3

BillsPC_WithdrawReleaseMenu:
	dw .MenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wBoxCount
	dba PlaceBoxMonNicknames
	dba PlaceBoxMonLevels
	ds 3

BillsPC_ViewMenu:
	dw BillsPC_ViewMenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

BillsPC_ViewMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 4, SCREEN_WIDTH - 1, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 0
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wBoxCount
	dba PlaceDetailedBoxMonView
	ds 3
	ds 3
