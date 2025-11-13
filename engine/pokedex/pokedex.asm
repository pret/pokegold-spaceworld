INCLUDE "constants.asm"

; Pokedex_RunJumptable.Jumptable indexes
	const_def
	const DEXSTATE_INIT
	const DEXSTATE_MAIN_SCR
	const DEXSTATE_UPDATE_MAIN_SCR
	const DEXSTATE_A_BUTTON_MENU_SCR
	const DEXSTATE_UPDATE_A_BUTTON_MENU_SCR
	const DEXSTATE_SELECT_BUTTON_MENU_SCR
	const DEXSTATE_UPDATE_SELECT_BUTTON_MENU_SCR
	const DEXSTATE_EXIT

; wPokedexInputFlags
	const_def
	const PRESSED_B_F      ; 0
	const PRESSED_A_F      ; 1
	const PRESSED_UP_F     ; 2
	const PRESSED_DOWN_F   ; 3
	const PRESSED_LEFT_F   ; 4
	const PRESSED_RIGHT_F  ; 5
	const PRESSED_SELECT_F ; 6

; wPokedexInputFlags when in a submenu
	const_def
	shift_const EXIT_POKEDEX           ; 0
	shift_const BREAK_LOOP             ; 1
	shift_const VIEW_DEX_ENTRY         ; 2
	shift_const PLAY_CRY               ; 3
	shift_const VIEW_AREA              ; 4
	shift_const NUMBERED_DEX_ORDER     ; 5
	shift_const ALPHABETICAL_DEX_ORDER ; 6
	shift_const SEARCH_TYPE            ; 7
DEF UNOWN_MODE_F EQU 5
DEF NEXT_MENU_F  EQU 7

; Values of 'a' prior to running ShowPokedexMenu, which determines the buttons drawn
	const_def
	const DEX_SCROLL_BUTTONS
	const A_BUTTON_MENU_NO_UNOWN
	const SELECT_BUTTON_MENU
	const A_BUTTON_MENU_UNOWN

SECTION "engine/pokedex/pokedex.asm", ROMX

Pokedex::
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]

	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a

	ld a, [wStateFlags]
	push af
	xor a
	ld [wStateFlags], a

	ldh a, [hJoypadSum]
	push af

	call InitPokedex
	call DelayFrame
.loop
	call Pokedex_Main
	jr nc, .loop

	pop af
	ldh [hJoypadSum], a	
	pop af
	ld [wStateFlags], a
	pop af
	ldh [hMapAnims], a
	pop af
	ld [wOptions], a
	call ClearJoypad
	ret

InitPokedex:
	call ClearBGPalettes
	callfar LoadPokeDexGraphics
	call DisableLCD
	call ClearSprites
	ld b, SGB_POKEDEX_SELECTION
	call GetSGBLayout
	callfar ClearSpriteAnims
	call Pokedex_InitUIGraphics

	xor a
	ldh [hSCY], a
	ld [wGlobalAnimYOffset], a
	ldh [hSCX], a
	ld [wGlobalAnimXOffset], a
	ld [wJumptableIndex], a
	ld [wDexListingScrollOffset], a
	ld [wCurDexMode], a
	ld [wPokedexInputFlags], a
	ldh [hBGMapMode], a

	ld a, 7
	ldh [hWX], a
	call Pokedex_OrderMonsByMode
	ld a, 12
	call UpdateSoundNTimes

	ld a, LCDC_DEFAULT
	ldh [rLCDC], a

	xor a
	call ShowPokedexMenu
	ld a, (1 << rLCDC_ENABLE) | (1 << rLCDC_WINDOW_TILEMAP) | (1 << rLCDC_WINDOW_ENABLE) | (1 << rLCDC_SPRITE_SIZE)
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a
	ret

Pokedex_InitUIGraphics:
	call Pokedex_CopyButtonsGFX
	ld de, vChars0
	ld hl, PokedexCursorGFX
	ld bc, $30 tiles
	ld a, BANK(PokedexCursorGFX)
	call FarCopyData

	ld a, SPRITE_ANIM_DICT_TEXT_CURSOR
	ld hl, wSpriteAnimDict
	ld [hli], a
	ld [hl], $00
	ret

ShowPokedexMenu:
	push af
	call WaitForAutoBgMapTransfer
	call Pokedex_ClearScreen
	call Pokedex_PrintListing
	pop af
	call Pokedex_PlaceStartOrSelectString
	call Pokedex_PlaceButtons

	ld hl, wPokedexSeen
	ld b, wEndPokedexSeen - wPokedexSeen
	call CountSetBits
	ld de, wNumSetBits	
	hlcoord 16, 13
	lb bc, 1, 3
	call PrintNumber

	ld hl, wPokedexCaught
	ld b, wEndPokedexCaught - wPokedexCaught
	call CountSetBits
	ld de, wNumSetBits
	hlcoord 16, 16
	lb bc, 1, 3
	call PrintNumber

	hlcoord 12, 12
	ld de, String_SEEN
	call PlaceString
	hlcoord 12, 15
	ld de, String_OWN
	call PlaceString

	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ret

String_SEEN:
	db "みつけたかず@"

String_OWN:
	db "つかまえたかず@"

Pokedex_PlaceStartOrSelectString:
	hlcoord 11, 9
	and a
	jr z, .Select_SEARCH
	cp $03
	jr z, .Start_TYPE
	ret

.Select_SEARCH:
	ld de, String_SELECT_SEARCH
	call PlaceString
	xor a
	ret

.Start_TYPE:
	ld de, String_START_VARIANTS
	call PlaceString
	ld a, $03
	ret

String_SELECT_SEARCH:
	db "セレクト▶けんさく@"

String_START_VARIANTS:
	db "スタート▶しゅるい@"

Pokedex_ClearScreen:
	ld hl, wTileMap
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
.loop:
	ld [hl], $6B
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop

	hlcoord 0, 0
	lb bc, 18, 11
	call Pokedex_PlaceBorder
	hlcoord 11, 10
	lb bc, 8, 9
	call Pokedex_PlaceBorder
	ret

Pokedex_Main:
	call Pokedex_CopyJoypadSum
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .exit

	call Pokedex_RunJumptable
	farcall PlaySpriteAnimationsAndDelayFrame
	call DelayFrame
	and a
	ret

.exit
	callfar ClearSpriteAnims
	call ClearSprites
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	scf
	ret

Pokedex_CopyJoypadSum:
	ld a, [wVBlankJoyFrameCounter]
	and a
	jr nz, .waiting_for_vblank

	ldh a, [hJoypadSum]
	ldh [hJoyDown], a

	xor a
	ldh [hJoypadSum], a

	ldh a, [hJoypadState]
	ldh [hJoySum], a

	ld a, 8
	ld [wVBlankJoyFrameCounter], a
	ret

.waiting_for_vblank
	xor a
	ldh [hJoySum], a
	ldh [hJoyDown], a
	ret

Pokedex_ClearJoypad:
	xor a
	ldh [hJoypadSum], a
	ldh [hJoyDown], a
	ldh [hJoySum], a
	ret

Pokedex_RunJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable:
	dw .Init
	dw Pokedex_InitList
	dw Pokedex_List
	dw Pokedex_InitAButtonMenu
	dw Pokedex_AButtonMenu
	dw Pokedex_InitSelectButtonMenu
	dw Pokedex_SelectButtonMenu
	dw Pokedex_Exit

.Init:
	depixel 4, 6, 4, 0
	ld a, SPRITE_ANIM_OBJ_POKEDEX_CURSOR
	call InitSpriteAnimStruct

	ld a, c
	ld [wPokedexCursorStructAddress], a
	ld a, b
	ld [wPokedexCursorStructAddress + 1], a
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_InitList:
	xor a
	call ShowPokedexMenu
	call Pokedex_ClearJoypad
	ld a, DEXSTATE_UPDATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_List:
	ld hl, wPokedexInputFlags
	ld a, [hl]
	bit PRESSED_B_F, a
	jr nz, .Close

	bit PRESSED_A_F, a
	jr nz, .PressedA

	bit PRESSED_SELECT_F, a
	jr nz, .Select

	bit PRESSED_UP_F, a
	jr nz, .Up

	bit PRESSED_DOWN_F, a
	jr nz, .Down

	bit PRESSED_LEFT_F, a
	jr nz, .Left

	bit PRESSED_RIGHT_F, a
	jr nz, .Right
	ret

.Close
	ld a, DEXSTATE_EXIT
	ld [wJumptableIndex], a

	ld hl, wPokedexInputFlags
	ld [hl], $00
	ret

.PressedA
	ld hl, wPokedexInputFlags
	ld [hl], $00
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	ret z

	ld a, DEXSTATE_A_BUTTON_MENU_SCR
	ld [wJumptableIndex], a
	ret

.Select
	ld a, DEXSTATE_SELECT_BUTTON_MENU_SCR
	ld [wJumptableIndex], a

	ld hl, wPokedexInputFlags
	ld [hl], $00
	ret

.Up
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, .ClearInputFlags

	dec a
	jr .ReorderDex

.Down
	ld hl, wDexListingScrollOffset
	ld a, [wDexListingEnd]
	cp 9
	jr c, .ClearInputFlags

	sub 8
	ld e, a
	ld a, [hl]
	cp e
	jr nc, .ClearInputFlags
	inc a
	jr .ReorderDex

.Left
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, .ClearInputFlags
	cp 8
	jr nc, .more_than_eight
	ld a, 8
.more_than_eight
	sub 8
	jr .ReorderDex

.Right
	ld hl, wDexListingScrollOffset
	ld a, [wDexListingEnd]
	cp 9
	jr c, .ClearInputFlags

	sub 8
	ld e, a
	cp 8
	jr c, .greater_than_end

	sub 8
	ld d, a
	ld a, [hl]
	cp e
	jr nc, .ClearInputFlags

	cp d
	jr c, .less_than_eight
	ld a, d
.less_than_eight
	add 8
	jr .ReorderDex

.greater_than_end
	ld a, [hl]
	cp e
	jr nc, .ClearInputFlags
	ld a, e
.ReorderDex:
	ld [hl], a
	call Pokedex_PressButtonSprites
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	xor a
	call ShowPokedexMenu
.ClearInputFlags:
	ld hl, wPokedexInputFlags
	ld [hl], $00
	ret

Pokedex_InitAButtonMenu:
	ld a, [wTempSpecies]
	cp DEX_ANNON
	jr nz, .not_annon

	ld a, A_BUTTON_MENU_UNOWN
	jr .DisplayButtons

.not_annon
	ld a, A_BUTTON_MENU_NO_UNOWN
.DisplayButtons
	call ShowPokedexMenu
	depixel 4, 16, 4, 4
	ld a, SPRITE_ANIM_OBJ_POKEDEX_HAND_CURSOR
	call InitSpriteAnimStruct
	ld a, c
	ld [wPokedexHandCursorStructAddress], a
	ld a, b
	ld [wPokedexHandCursorStructAddress + 1], a
	xor a
	ld [wPokedexHandCursorPosIndex], a
	call Pokedex_ClearJoypad
	ld a, DEXSTATE_UPDATE_A_BUTTON_MENU_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_AButtonMenu:
	ld hl, wPokedexInputFlags
	ld a, [hl]
	ld [hl], $00
	bit VIEW_DEX_ENTRY_F, a
	jp nz, .Data

	bit PLAY_CRY_F, a
	jp nz, .Cry

	bit BREAK_LOOP_F, a
	jr nz, .Back

	bit NEXT_MENU_F, a
	jr nz, .NextMenu

	bit UNOWN_MODE_F, a
	jr nz, .UnownMode
	ret

.Back:
	ld hl, wPokedexHandCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld [hl], $00

	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

.NextMenu:
	ld hl, wPokedexHandCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld [hl], $00

	ld a, DEXSTATE_SELECT_BUTTON_MENU_SCR
	ld [wJumptableIndex], a
	ld hl, wPokedexInputFlags
	ld [hl], $00
	ret

.UnownMode:
	call Pokedex_GetSelectedMon
	ld a, [wTempSpecies]
	cp DEX_ANNON
	ret nz

	call Pokedex_UnownMode
	hlcoord 12, 10
	lb bc, 7, 7
	call ClearBox
	call WaitBGMap
	call WaitForAutoBgMapTransfer

	ld b, SGB_POKEDEX_SELECTION
	call GetSGBLayout
	call Pokedex_CopyButtonsGFX
	ld a, A_BUTTON_MENU_UNOWN
	call ShowPokedexMenu
	xor a
	ldh [hJoyDown], a
	ldh [hJoypadSum], a
	ret

.Data:
	call Pokedex_GetSelectedMon
	call Pokedex_DexEntryScreen
	call WaitForAutoBgMapTransfer
	hlcoord 1, 1
	lb bc, 7, 7
	call ClearBox
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld b, SGB_POKEDEX_SELECTION
	call GetSGBLayout
	call Pokedex_CopyButtonsGFX
	call .ReturnButtons
	xor a
	ldh [hJoyDown], a
	ldh [hJoypadSum], a
	ret

.Cry:
	call Pokedex_GetSelectedMon
	ld a, [wApplyStatLevelMultipliersToEnemy]
	call GetCryIndex
	ld e, c
	ld d, b
	call PlayCryHeader
	ret

; Unreferenced, presumably dummied out for the demo
.Area:
	call Pokedex_GetSelectedMon
	predef Pokedex_GetArea

	call ClearBGPalettes
	callfar LoadPokeDexGraphics
	call DisableLCD
	call ClearSprites
	ld b, SGB_POKEDEX_SELECTION
	call GetSGBLayout
	call Pokedex_InitUIGraphics
	ld a, 8
	call UpdateSoundNTimes

	ld a, LCDC_DEFAULT
	ldh [rLCDC], a
	call .ReturnButtons
	ld a, (1 << rLCDC_ENABLE) | (1 << rLCDC_WINDOW_TILEMAP) | (1 << rLCDC_WINDOW_ENABLE) | (1 << rLCDC_SPRITE_SIZE)
	ldh [rBGP], a
	ld a, %11010000
	ldh [rOBP0], a
	xor a
	ldh [hJoyDown], a
	ldh [hJoypadSum], a
	ret

.ReturnButtons:
	ld a, [wTempSpecies]
	cp DEX_ANNON
	jr nz, .unown
	ld a, A_BUTTON_MENU_UNOWN
	jr .show_pokedex_menu

.unown
	ld a, A_BUTTON_MENU_NO_UNOWN
.show_pokedex_menu
	call ShowPokedexMenu
	ret

Pokedex_InitSelectButtonMenu:
	xor a
	ld [wDexListingScrollOffset], a
	ld hl, wPokedexCursorStructAddress
	call Pokedex_GetSpriteAnimYOffset
	ld [hl], $00
	call Pokedex_OrderMonsByMode
	ld a, SELECT_BUTTON_MENU
	call ShowPokedexMenu

	depixel 4, 16, 4, 4
	ld a, SPRITE_ANIM_OBJ_POKEDEX_HAND_CURSOR
	call InitSpriteAnimStruct

	ld a, c
	ld [wPokedexHandCursorStructAddress], a
	ld a, b
	ld [wPokedexHandCursorStructAddress + 1], a
	xor a
	ld [wPokedexHandCursorPosIndex], a
	call Pokedex_ClearJoypad

	ld a, DEXSTATE_UPDATE_SELECT_BUTTON_MENU_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_SelectButtonMenu:
	ld hl, wPokedexInputFlags
	ld a, [hl]
	ld [hl], $00
	bit BREAK_LOOP_F, a ; BACK
	jr nz, .Back

	bit NUMBERED_DEX_ORDER_F, a
	jr nz, .Number

	bit ALPHABETICAL_DEX_ORDER_F, a ; 
	jr nz, .ABC

	bit SEARCH_TYPE_F, a
	jr nz, .SearchType
	ret

.Number:
	ld a, DEXMODE_NUMBERED
	ld [wCurDexMode], a
	call Pokedex_OrderMonsByMode
	jr .ReorderDex

.ABC:
	ld a, DEXMODE_ABC
	ld [wCurDexMode], a
	call Pokedex_OrderMonsByMode
	jr .ReorderDex

.SearchType:
	call Pokedex_SearchByTypeScreen
	xor a
	ldh [hJoyDown], a
	ldh [hJoypadSum], a
	ld a, [wDexPlaySlowpokeAnimation]
	and a
	jr z, .no_slowpoke

	call Pokedex_SlowpokeAnimation
	ld a, [wDexListingEnd]
	and a
	jr nz, .Back
.no_slowpoke
	ld a, DEXSTATE_UPDATE_SELECT_BUTTON_MENU_SCR
	ld [wJumptableIndex], a

	xor a
	ld [wDexListingScrollOffset], a
	ld hl, wPokedexCursorStructAddress

	call Pokedex_GetSpriteAnimYOffset
	ld [hl], 0
	call Pokedex_OrderMonsByMode
.ReorderDex:
	ld a, SELECT_BUTTON_MENU
	call ShowPokedexMenu
	ret

.Back:
	ld hl, wPokedexHandCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld [hl], $00
	ld a, DEXSTATE_MAIN_SCR
	ld [wJumptableIndex], a
	ret

Pokedex_Exit:
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Pokedex_PrintListing:
	ld a, [wDexListingScrollOffset]
	ld e, a
	ld d, $00
	ld hl, wPokedexOrder
	add hl, de
	ld e, l
	ld d, h
	hlcoord 1, 2
	ld a, 8
.loop
	push af
	ld a, [de]
	ld [wTempByteValue], a
	push de
	push hl
	and a
	jr z, .unidentified

	ld de, wTempByteValue
	lb bc, (%10000000 | 1), 3
	call PrintNumber

; Here, only seen Pokémon are listed in the first place, so this effectively does nothing.
	call Pokedex_PlaceDefaultStringIfNotSeen
	jr c, .unidentified

	call Pokedex_PlaceCaughtSymbolIfCaught
	push hl
	call GetPokemonName
	pop hl
	call PlaceString

.unidentified
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de

	pop de
	inc de
	pop af
	dec a
	jr nz, .loop
	ret

Pokedex_PlaceCaughtSymbolIfCaught:
	call Pokedex_CheckCaught
	jr nz, .place_caught_symbol
	xor a
	ld [hli], a
	ret

.place_caught_symbol
	ld a, $6c
	ld [hli], a
	ret

Pokedex_PlaceDefaultStringIfNotSeen:
	ld a, [wCurDexMode]
	and a
	ret nz
	
	call Pokedex_CheckSeen
	ret nz
	inc hl
	
	ld de, .NameNotSeen
	call PlaceString
	scf
	ret

.NameNotSeen:
db "ーーーーー@"

; Gets the species of the currently selected Pokémon. This corresponds to the
; position of the cursor in the main listing.
Pokedex_GetSelectedMon:
	ld hl, wPokedexCursorStructAddress
	call Pokedex_GetSpriteAnimYOffset
	ld a, [hl]
	swap a
	and $f
	ld hl, wDexListingScrollOffset
	add [hl]
	ld e, a
	ld d, 0
	ld hl, wPokedexOrder
	add hl, de
	ld a, [hl]
	ld [wTempSpecies], a
	ret

Pokedex_CheckCaught:
	push de
	push hl
	ld hl, wPokedexCaught
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, CHECK_FLAG
	ld d, 0
	predef SmallFarFlagAction

	pop hl
	pop de
	ld a, c
	and a
	ret

Pokedex_CheckSeen:
	push de
	push hl
	ld hl, wPokedexSeen
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, CHECK_FLAG
	ld d, 0
	predef SmallFarFlagAction

	pop hl
	pop de
	ld a, c
	and a
	ret

Pokedex_PlaceBorder:
	dec c
	dec c
	dec b
	dec b
	ld de, SCREEN_WIDTH
	push bc
	push hl

	; Top-left corner
	ld a, $63
	ld [hli], a
	; Top border
	ld a, $64
.fill_top
	ld [hli], a
	dec c
	jr nz, .fill_top

	; Top-right corner
	ld a, $65
	ld [hl], a

	pop hl
	pop bc
	add hl, de

.middle_loop
	push bc
	push hl

	; Left border
	ld a, $66
	ld [hli], a
	ld a, '　'
.fill_middle
	ld [hli], a
	dec c
	jr nz, .fill_middle

	; Right border
	ld a, $67
	ld [hli], a
	pop hl
	add hl, de
	pop bc
	dec b
	jr nz, .middle_loop

	; Bottom-left corner
	ld a, $68
	ld [hli], a
	; Bottom border
	ld a, $69
.fill_bottom
	ld [hli], a
	dec c
	jr nz, .fill_bottom

	; Bottom-right corner
	ld a, $6a
	ld [hli], a
	ret

Pokedex_PlaceButtons:
; Fill 6-by-6 tile area with gray/orange space.
	push af
	hlcoord 12, 2
	ld a, $10
	ld de, SCREEN_WIDTH - 6
	ld b, 6
.next_row
	ld c, 6
.next_tile
	ld [hli], a
	dec c
	jr nz, .next_tile

	add hl, de
	dec b
	jr nz, .next_row

; Decide what buttons to draw next.
	pop af
	and a ; DEX_SCROLL_BUTTONS
	jr z, PlaceArrowButtons
	cp A_BUTTON_MENU_NO_UNOWN
	jr z, PlaceOptionButtons_A
	cp SELECT_BUTTON_MENU
	jr z, PlaceOptionButtons_Select
	cp A_BUTTON_MENU_UNOWN
	jr z, PlaceOptionButtons_A
	ret

PlaceArrowButtons:
; Up
	hlcoord 14, 6
	ld a, $40
	call .PutButton
	
; Down
	hlcoord 14, 2
	ld a, $42
	call .PutButton

; Previous page
	hlcoord 16, 4
	ld a, $44
	call .PutButton

; Next page
	hlcoord 12, 4
	ld a, $46
	call .PutButton
	ret

.PutButton:
	ld [hli], a
	inc a
	ld [hl], a
	ld de, SCREEN_WIDTH - 1

	add hl, de
	add $f
	ld [hli], a
	inc a
	ld [hl], a
	ret

PlaceOptionButtons_A:
; DATA
	hlcoord 12, 2
	ld a, $5
	call PutOptionButton
; CRY
	hlcoord 15, 2
	ld a, $8
	call PutOptionButton
; AREA
	hlcoord 12, 4
	ld a, $b
	call PutOptionButton
; Notably uses the Select Button menu's BACK button, instead of とじる ("CLOSE"),
; likely due to how it's split in the graphics data.
	hlcoord 15, 4
	ld a, $2a
	call PutOptionButton
	ret

PlaceOptionButtons_Select:
; NUMBER
	hlcoord 12, 2
	ld a, $24
	call PutOptionButton
; ABCDE
	hlcoord 15, 2
	ld a, $27
	call PutOptionButton
; SEARCH
	hlcoord 12, 4
	ld a, $21
	call PutOptionButton
; BACK
	hlcoord 15, 4
	ld a, $2a
	call PutOptionButton
	ret

PutOptionButton:
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ld de, SCREEN_WIDTH - 2

	add hl, de
	add $e
	ld [hli], a
	inc a
	ld [hli], a
	inc a
	ld [hl], a
	ret

Pokedex_HandCursorControls:
	ld hl, wPokedexInputFlags
	ld de, hJoyDown
	ld a, [de]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [de]
	and B_BUTTON
	jp nz, .b_pressed

	ld a, [de]
	and D_UP
	jr nz, .up

	ld a, [de]
	and D_DOWN
	jr nz, .down

	ld a, [de]
	and D_LEFT
	jr nz, .left

	ld a, [de]
	and D_RIGHT
	jr nz, .right

	ld a, [de]
	and SELECT
	jr nz, .select
	
	ld a, [de]
	and START
	jr nz, .start
	ret

.a_pressed
	call HandCursor_PressButton
	ret

.select
	ld a, [wJumptableIndex]
	cp DEXSTATE_UPDATE_SELECT_BUTTON_MENU_SCR
	jr z, .b_pressed

	set NEXT_MENU_F, [hl]
	ret

.b_pressed
	set BREAK_LOOP_F, [hl]
	ret

.start
	set UNOWN_MODE_F, [hl]
	ret

.up
	ld hl, wPokedexHandCursorPosIndex
	ld a, [hl]
	and $1
	ret z

	dec [hl]
	jr .GetPositionOffsets

.down
	ld hl, wPokedexHandCursorPosIndex
	ld a, [hl]
	and $1
	ret nz
	inc [hl]
	jr .GetPositionOffsets

.left
	ld hl, wPokedexHandCursorPosIndex
	ld a, [hl]
	bit 1, a ; and %10
	ret z

	sub 2
	ld [hl], a
	jr .GetPositionOffsets

.right
	ld hl, wPokedexHandCursorPosIndex
	ld a, [hl]
	bit 1, a ; and %10
	ret nz

	add 2
	ld [hl], a
.GetPositionOffsets:
	ld a, [wPokedexHandCursorPosIndex]
	ld e, a
	ld d, $00
	ld hl, .PositionOffsetTable
	add hl, de
	add hl, de
	ld e, l
	ld d, h

	ld hl, SPRITEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [de]
	ld [hl], a
	inc de

	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [de]
	ld [hl], a
	ret

.PositionOffsetTable:
	; x offset, y offset
	db 0,     0
	db 0,     8 * 2
	db 8 * 3, 0
	db 8 * 3, 8 * 2

HandCursor_PressButton:
	push hl
	ld a, [wJumptableIndex]
	cp DEXSTATE_UPDATE_SELECT_BUTTON_MENU_SCR
	jr z, .pressed_select

	ld hl, .MenuJumptable
	jr .pressed_a

.pressed_select
	ld hl, .SelectJumptable
.pressed_a
	ld a, [wPokedexHandCursorPosIndex]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.MenuJumptable
dw .Data, .Area, .Cry, .Back

.SelectJumptable
dw .Number, .Search, .ABC, .Back

; Unreferenced
.Close:
	pop hl
	set EXIT_POKEDEX_F, [hl]
	ret

.Back:
	pop hl
	set BREAK_LOOP_F, [hl]
	ret

.Data:
	pop hl
	set VIEW_DEX_ENTRY_F, [hl]
	ret

.Cry:
	pop hl
	set PLAY_CRY_F, [hl]
	ret

.Area:
	pop hl
	set VIEW_AREA_F, [hl]
	ret

.Number:
	pop hl
	set NUMBERED_DEX_ORDER_F, [hl]
	ret

.ABC:
	pop hl
	set ALPHABETICAL_DEX_ORDER_F, [hl]
	ret

.Search:
	pop hl
	set SEARCH_TYPE_F, [hl]
	ret

Pokedex_CursorControls:
	ld a, [wJumptableIndex]
	cp DEXSTATE_UPDATE_MAIN_SCR
	jr z, .CheckInput

	ld hl, SPRITEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], 1
	ld hl, SPRITEANIMSTRUCT_FRAME

	add hl, bc
	ld [hl], 0
	ret

.CheckInput:
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [hl]
	and SELECT
	jr nz, .select_pressed

	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed

	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down

	ld a, [hl]
	and D_LEFT
	jr nz, .left

	ld a, [hl]
	and D_RIGHT
	jr nz, .right

	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down

	ld a, [hl]
	and D_LEFT
	jr nz, .left

	ld a, [hl]
	and D_RIGHT
	jr nz, .right
	ret

.a_pressed
	ld hl, wPokedexInputFlags
	set PRESSED_A_F, [hl]
	ret

.select_pressed
	ld hl, wPokedexInputFlags
	set PRESSED_SELECT_F, [hl]
	ret

.b_pressed
	ld hl, wPokedexInputFlags
	set PRESSED_B_F, [hl]
	ret

.up
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .cursor_at_top
	sub 8 * 2
	ld [hl], a
	ret

.cursor_at_top
	ld hl, wPokedexInputFlags
	set PRESSED_UP_F, [hl]
	ret

.down
	ld a, [wDexListingEnd]
	cp 8
	jr nc, .at_dex_listing_end
	cp 2
	ret c

	dec a
	and $f
	swap a
	ld d, a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp d
	ret nc

	add 8 * 2
	ld [hl], a
	ret

.at_dex_listing_end
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp 8 * 14
	jr nc, .cursor_at_bottom

	add 8 * 2
	ld [hl], a
	ret

.cursor_at_bottom
	ld hl, wPokedexInputFlags
	set PRESSED_DOWN_F, [hl]
	ret

.left
	ld hl, wPokedexInputFlags
	set PRESSED_LEFT_F, [hl]
	ret

.right
	ld hl, wPokedexInputFlags
	set PRESSED_RIGHT_F, [hl]
	ret

Pokedex_PressButtonSprites:
	ld a, [wPokedexInputFlags]

	hlcoord 14, 6
	bit PRESSED_DOWN_F, a
	jr nz, .PressButton

	hlcoord 14, 2
	bit PRESSED_UP_F, a
	jr nz, .PressButton

	hlcoord 16, 4
	bit PRESSED_RIGHT_F, a
	jr nz, .PressButton

	hlcoord 12, 4
	bit PRESSED_LEFT_F, a
	jr nz, .PressButton
	ret

.PressButton:
	call .ChangeTile
	call .ChangeTile
	ld de, SCREEN_WIDTH - 2
	add hl, de
	call .ChangeTile
	call .ChangeTile
	ret

; The pressed button graphics are exactly eight tiles to the right of the unpressed graphics
.ChangeTile:
	ld a, [hl]
	add $08
	ld [hli], a
	ret

Pokedex_DexEntryScreen:
	call LowVolume
	call ClearSprites
.loop
	call WaitForAutoBgMapTransfer
	ld a, [wUnownDex]
	ld [wAnnonID], a
	ld hl, wTileMap
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	call Pokedex_PlaceBorder

	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a

	push af
	ld b, SGB_POKEDEX
	call GetSGBLayout
	pop af
	
	ld [wTempSpecies], a
	call Pokedex_DisplayDexEntry

	call WaitBGMap
	call GetBaseData
	hlcoord 1, 1
	call PrepMonFrontpic

	ld a, [wCurPartySpecies]
	call PlayCry
	call Pokedex_DexEntryInput
	jr c, .loop

	call MaxVolume
	ret

Pokedex_DexEntryInput:
	ld hl, wPokedexCursorStructAddress
	call Pokedex_GetSpriteAnimYOffset

	ld a, [hl]
	ld [wDexTempCursorY], a
	ld a, [wDexListingScrollOffset]
	ld [wDexTempListingScrollOffset], a
.CheckInput:
	call Pokedex_CopyJoypadSum
	ld hl, hJoyDown
	ld a, [hl]
	and B_BUTTON | A_BUTTON
	jr z, .GotInput
	and a
	ret

.GotInput:
	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down
	jp .no_more_entries

.up
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .top_of_list

	sub 2 * TILE_WIDTH
	ld [hl], a
	call .NextMonIsSeen
	jr z, .up

	jr .Scrolled

.top_of_list:
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	and a
	jr z, .no_more_entries
	
	dec a
	ld [hl], a
	call .NextMonIsSeen
	jr z, .top_of_list

	jr .Scrolled

.down
	ld a, [wDexListingEnd]
	cp 8
	jr nc, .more_than_eight

	cp 2
	jr c, .no_more_entries

	dec a
	and $f
	swap a
	ld d, a
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp d
	jr nc, .no_more_entries
	
	add 2 * TILE_WIDTH
	ld [hl], a
	call .NextMonIsSeen
	jr z, .down

	jr .Scrolled

.more_than_eight
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp 14 * TILE_WIDTH
	jr nc, .bottom_of_list

	add 2 * TILE_WIDTH
	ld [hl], a
	call .NextMonIsSeen
	jr z, .more_than_eight
	jr .Scrolled

.bottom_of_list
	ld a, [wDexListingEnd]
	sub 8
	ld e, a
	ld hl, wDexListingScrollOffset
	ld a, [hl]
	cp e
	jr nc, .no_more_entries

	inc a
	ld [hl], a
	call .NextMonIsSeen
	jr z, .bottom_of_list

.Scrolled:
	scf
	ret

.no_more_entries
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [wDexTempCursorY]
	ld [hl], a
	ld a, [wDexTempListingScrollOffset]
	ld [wDexListingScrollOffset], a
	jp .CheckInput

.NextMonIsSeen:
	push bc
	call Pokedex_GetSelectedMon
	call Pokedex_CheckSeen
	pop bc
	ret

Pokedex_DisplayDexEntry:
	callfar _DisplayDexEntry
	ret

Pokedex_OrderMonsByMode:
	ld hl, wPokedexOrder
	ld c, 0
	xor a
.loop
	ld [hli], a
	dec c
	jr nz, .loop

	ld a, [wCurDexMode]
	and $1
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
dw .Numbered, Pokedex_ABCMode

.Numbered:
	xor a
	ld [wDexListingEnd], a
	ld hl, wPokedexOrder
	ld a, 1
	ld [wTempSpecies], a
	ld c, NUM_POKEMON

.loop_numbered
	push bc
	call Pokedex_CheckSeen
	jr z, .not_seen

	ld a, [wTempSpecies]
	ld [hli], a
	ld a, [wDexListingEnd]
	inc a
	ld [wDexListingEnd], a

.not_seen
	ld a, [wTempSpecies]
	inc a
	ld [wTempSpecies], a
	pop bc
	dec c
	jr nz, .loop_numbered

	ld a, [wDexListingEnd]
	ld c, 0

.FindLastSeen:
	cp NUM_POKEMON
	jr z, .done
	ld [hl], c
	inc hl
	inc a
	jr .FindLastSeen
.done
	ret

Pokedex_ABCMode:
	xor a
	ld [wDexListingEnd], a
	ld hl, wPokedexOrder
	ld de, AlphabeticalPokedexOrder
	ld c, NUM_POKEMON

.loop_abc
	push bc
	ld a, [de]
	ld [wTempSpecies], a
	call Pokedex_CheckSeen
	jr z, .not_seen

	ld a, [wTempSpecies]
	ld [hli], a
	ld a, [wDexListingEnd]
	inc a
	ld [wDexListingEnd], a

.not_seen
	inc de
	pop bc
	dec c
	jr nz, .loop_abc

	ld a, [wDexListingEnd]
	ld c, 0

.FindLastSeen:
	cp NUM_POKEMON
	jr z, .done
	ld [hl], c
	inc hl
	inc a
	jr .FindLastSeen
.done
	ret

INCLUDE "data/pokemon/dex_order_alpha.inc"

Pokedex_SlowpokeAnimation:
	call Pokedex_PlaceSlowpoke

	ld hl, wPokedexCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld a, [hl]
	ld [hl], 0
	push af

	ld hl, wPokedexHandCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld a, [hl]
	ld [hl], 0
	push af
	
	ld a, %11100100
	ldh [rOBP0], a
	call Pokedex_AnimateDexSearchSlowpoke

; Restore cursor positions after animation
	ld hl, wPokedexHandCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	pop af
	ld [hl], a

	ld hl, wPokedexCursorStructAddress
	call Pokedex_GetSpriteAnimStruct
	pop af
	ld [hl], a

	ld a, %11010000
	ldh [rOBP0], a
	ret

Pokedex_PlaceSlowpoke:
	call WaitForAutoBgMapTransfer
	call Pokedex_ClearScreen
	call WaitBGMap
	call WaitForAutoBgMapTransfer
	ld a, [wDexListingEnd]
	ld [wPokedexSlowpokeNumSearchEntries], a
	depixel 9, 6, 4, 0
	ld a, SPRITE_ANIM_OBJ_POKEDEX_SLOWPOKE
	call InitSpriteAnimStruct
	ld a, c
	ld [wPokedexSlowpokeAnimStructAddress], a
	ld a, b
	ld [wPokedexSlowpokeAnimStructAddress + 1], a
	ret

; Loop Slowpoke reading animation until it deletes itself
Pokedex_AnimateDexSearchSlowpoke:
	ld hl, wPokedexSlowpokeAnimStructAddress
	call Pokedex_GetSpriteAnimStruct
	ld a, [hl]
	and a
	ret z
	farcall PlaySpriteAnimationsAndDelayFrame
	call DelayFrame
	jr Pokedex_AnimateDexSearchSlowpoke

; Get index of sprite animation struct at 'hl'
Pokedex_GetSpriteAnimStruct:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_INDEX
	add hl, bc
	ret

; Get Y Offset from sprite animation struct at 'hl'
Pokedex_GetSpriteAnimYOffset:
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, SPRITEANIMSTRUCT_YOFFSET
	add hl, bc
	ret

Pokedex_CopyButtonsGFX:
	ld de, PokedexButtonsGFX
	ld hl, vChars2
	lb bc, BANK(PokedexButtonsGFX), 96
	call Get2bpp
	ret

NewPokedexEntry::
	call LowVolume
	call ClearBGPalettes
	call ClearTileMap
	call UpdateSprites
	callfar LoadPokeDexGraphics
	call ClearSprites
	ld hl, wd4a7
	set 1, [hl]
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	call _NewPokedexEntry

	pop af
	ldh [hMapAnims], a
	call ClearPalettes
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFontExtra
	call SetPalettes
	ld hl, wd4a7
	res 1, [hl]
	call MaxVolume
	ret

_NewPokedexEntry:
	call WaitForAutoBgMapTransfer
	ld hl, wTileMap
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
	call Pokedex_PlaceBorder
	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
	push af
	ld b, SGB_POKEDEX
	call GetSGBLayout
	pop af
	ld [wTempSpecies], a
	call Pokedex_DisplayDexEntry
	call SetPalettes
	call WaitBGMap
	call GetBaseData
	hlcoord 1, 1
	call PrepMonFrontpic
	ld a, [wCurPartySpecies]
	call PlayCry
.wait_for_input
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and A_BUTTON | B_BUTTON
	jr z, .wait_for_input
	ret

