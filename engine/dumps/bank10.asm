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

SECTION "engine/dumps/bank10.asm", ROMX

Pokedex:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]

	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a

	ld a, [wVramState]
	push af
	xor a
	ld [wVramState], a

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
	ld [wVramState], a
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
	ld a, "　"
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

NewPokedexEntry:
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

; Takes the DEX_* index stored in wTempSpecies,
; finds its MON_* in the Pokered_MonIndices table,
; and returns its index in wTempSpecies.
ConvertMon_2to1::
	push bc
	push hl
	ld a, [wTempSpecies]
	ld b, a
	ld c, $00
	ld hl, Pokered_MonIndices
.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop
	ld a, c
	ld [wTempSpecies], a
	pop hl
	pop bc
	ret

; Takes the MON_* value stored in wTempSpecies
; and returns the corresponding DEX_* value from Pokered_MonIndices in wTempSpecies.
ConvertMon_1to2::
	push bc
	push hl
	ld a, [wTempSpecies]
	dec a
	ld hl, Pokered_MonIndices
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wTempSpecies], a
	pop hl
	pop bc
	ret

Pokered_MonIndices::
; BUG: Notice anything odd about this list? There are only 250 entries; Riifi is missing!
; Presumably, it was such a recent addition that it hadn't yet been included in this list.
; This causes ConvertMon_2to1 to search out of bounds for byte $FB, eventually finding it and loading Nidorina's cry.

; Note that in the final game, Celebi is also missing from this list, meaning that they never actually fixed this
; before they switched the cry order to match the Pokédex order.
	db DEX_RHYDON			; 01
	db DEX_KANGASKHAN		; 02
	db DEX_NIDORAN_M		; 03
	db DEX_CLEFAIRY			; 04
	db DEX_SPEAROW			; 05
	db DEX_VOLTORB			; 06
	db DEX_NIDOKING			; 07
	db DEX_SLOWBRO			; 08
	db DEX_IVYSAUR			; 09
	db DEX_EXEGGUTOR		; 0a
	db DEX_LICKITUNG		; 0b
	db DEX_EXEGGCUTE		; 0c
	db DEX_GRIMER			; 0d
	db DEX_GENGAR			; 0e
	db DEX_NIDORAN_F		; 0f
	db DEX_NIDOQUEEN		; 10

	db DEX_CUBONE			; 11
	db DEX_RHYHORN			; 12
	db DEX_LAPRAS			; 13
	db DEX_ARCANINE			; 14
	db DEX_MEW				; 15
	db DEX_GYARADOS			; 16
	db DEX_SHELLDER			; 17
	db DEX_TENTACOOL		; 18
	db DEX_GASTLY			; 19
	db DEX_SCYTHER			; 1a
	db DEX_STARYU			; 1b
	db DEX_BLASTOISE		; 1c
	db DEX_PINSIR			; 1d
	db DEX_TANGELA			; 1e
	db DEX_KAPOERER			; 1f
	db DEX_PUDIE			; 20

	db DEX_GROWLITHE		; 21
	db DEX_ONIX				; 22
	db DEX_FEAROW			; 23
	db DEX_PIDGEY			; 24
	db DEX_SLOWPOKE			; 25
	db DEX_KADABRA			; 26
	db DEX_GRAVELER			; 27
	db DEX_CHANSEY			; 28
	db DEX_MACHOKE			; 29
	db DEX_MRMIME			; 2a
	db DEX_HITMONLEE		; 2b
	db DEX_HITMONCHAN		; 2c
	db DEX_ARBOK			; 2d
	db DEX_PARASECT			; 2e
	db DEX_PSYDUCK			; 2f
	db DEX_DROWZEE			; 30

	db DEX_GOLEM			; 31
	db DEX_HANEKO			; 32
	db DEX_MAGMAR			; 33
	db DEX_TAIL				; 34
	db DEX_ELECTABUZZ		; 35
	db DEX_MAGNETON			; 36
	db DEX_KOFFING			; 37
	db DEX_POPONEKO			; 38
	db DEX_MANKEY			; 39
	db DEX_SEEL				; 3a
	db DEX_DIGLETT			; 3b
	db DEX_TAUROS			; 3c
	db DEX_WATANEKO			; 3d
	db DEX_BARIRINA			; 3e
	db DEX_LIP				; 3f
	db DEX_FARFETCHD		; 40

	db DEX_VENONAT			; 41
	db DEX_DRAGONITE		; 42
	db DEX_ELEBABY			; 43
	db DEX_BOOBY			; 44
	db DEX_KIREIHANA		; 45
	db DEX_DODUO			; 46
	db DEX_POLIWAG			; 47
	db DEX_JYNX				; 48
	db DEX_MOLTRES			; 49
	db DEX_ARTICUNO			; 4a
	db DEX_ZAPDOS			; 4b
	db DEX_DITTO			; 4c
	db DEX_MEOWTH			; 4d
	db DEX_KRABBY			; 4e
	db DEX_TSUBOMITTO		; 4f
	db DEX_MILTANK			; 50
	
	db DEX_BOMBSEEKER		; 51
	db DEX_VULPIX			; 52
	db DEX_NINETALES		; 53
	db DEX_PIKACHU			; 54
	db DEX_RAICHU			; 55
	db DEX_GIFT				; 56
	db DEX_KOTORA			; 57
	db DEX_DRATINI			; 58
	db DEX_DRAGONAIR		; 59
	db DEX_KABUTO			; 5a
	db DEX_KABUTOPS			; 5b
	db DEX_HORSEA			; 5c
	db DEX_SEADRA			; 5d
	db DEX_RAITORA			; 5e
	db DEX_MADAME			; 5f
	db DEX_SANDSHREW		; 60

	db DEX_SANDSLASH		; 61
	db DEX_OMANYTE			; 62
	db DEX_OMASTAR			; 63
	db DEX_JIGGLYPUFF		; 64
	db DEX_WIGGLYTUFF		; 65
	db DEX_EEVEE			; 66
	db DEX_FLAREON			; 67
	db DEX_JOLTEON			; 68
	db DEX_VAPOREON			; 69
	db DEX_MACHOP			; 6a
	db DEX_ZUBAT			; 6b
	db DEX_EKANS			; 6c
	db DEX_PARAS			; 6d
	db DEX_POLIWHIRL		; 6e
	db DEX_POLIWRATH		; 6f
	db DEX_WEEDLE			; 70

	db DEX_KAKUNA			; 71
	db DEX_BEEDRILL			; 72
	db DEX_NOROWARA			; 73
	db DEX_DODRIO			; 74
	db DEX_PRIMEAPE			; 75
	db DEX_DUGTRIO			; 76
	db DEX_VENOMOTH			; 77
	db DEX_DEWGONG			; 78
	db DEX_KYONPAN			; 79
	db DEX_YAMIKARASU		; 7a
	db DEX_CATERPIE			; 7b
	db DEX_METAPOD			; 7c
	db DEX_BUTTERFREE		; 7d
	db DEX_MACHAMP			; 7e
	db DEX_HAPPI			; 7f
	db DEX_GOLDUCK			; 80

	db DEX_HYPNO			; 81
	db DEX_GOLBAT			; 82
	db DEX_MEWTWO			; 83
	db DEX_SNORLAX			; 84
	db DEX_MAGIKARP			; 85
	db DEX_SCISSORS			; 86
	db DEX_PURAKKUSU		; 87
	db DEX_MUK				; 88
	db DEX_DEVIL			; 89
	db DEX_KINGLER			; 8a
	db DEX_CLOYSTER			; 8b
	db DEX_HELGAA			; 8c
	db DEX_ELECTRODE		; 8d
	db DEX_CLEFABLE			; 8e
	db DEX_WEEZING			; 8f
	db DEX_PERSIAN			; 90
	
	db DEX_MAROWAK			; 91
	db DEX_WOLFMAN			; 92
	db DEX_HAUNTER			; 93
	db DEX_ABRA				; 94
	db DEX_ALAKAZAM			; 95
	db DEX_PIDGEOTTO		; 96
	db DEX_PIDGEOT			; 97
	db DEX_STARMIE			; 98
	db DEX_BULBASAUR		; 99
	db DEX_VENUSAUR			; 9a
	db DEX_TENTACRUEL		; 9b
	db DEX_WARWOLF			; 9c
	db DEX_GOLDEEN			; 9d
	db DEX_SEAKING			; 9e
	db DEX_PORYGON2			; 9f
	db DEX_NAMEIL			; a0

	db DEX_HAGANEIL			; a1
	db DEX_KINGDRA			; a2
	db DEX_PONYTA			; a3
	db DEX_RAPIDASH			; a4
	db DEX_RATTATA			; a5
	db DEX_RATICATE			; a6
	db DEX_NIDORINO			; a7
	db DEX_NIDORINA			; a8
	db DEX_GEODUDE			; a9
	db DEX_PORYGON			; aa
	db DEX_AERODACTYL		; ab
	db DEX_RAI				; ac
	db DEX_MAGNEMITE		; ad
	db DEX_EN				; ae
	db DEX_SUI				; af
	db DEX_CHARMANDER		; b0

	db DEX_SQUIRTLE			; b1
	db DEX_CHARMELEON		; b2
	db DEX_WARTORTLE		; b3
	db DEX_CHARIZARD		; b4
	db DEX_NYULA			; b5
	db DEX_HOUOU			; b6
	db DEX_TOGEPY			; b7
	db DEX_BULU				; b8
	db DEX_ODDISH			; b9
	db DEX_GLOOM			; ba
	db DEX_VILEPLUME		; bb
	db DEX_BELLSPROUT		; bc
	db DEX_WEEPINBELL		; bd
	db DEX_VICTREEBEL		; be
	db DEX_HAPPA			; bf
	db DEX_HANAMOGURA		; c0

	db DEX_HANARYU			; c1
	db DEX_HONOGUMA			; c2
	db DEX_VOLBEAR			; c3
	db DEX_DYNABEAR			; c4
	db DEX_KURUSU			; c5
	db DEX_AQUA				; c6
	db DEX_AQUARIA			; c7
	db DEX_HOHO				; c8
	db DEX_BOBO				; c9
	db DEX_PACHIMEE			; ca
	db DEX_MOKOKO			; cb
	db DEX_DENRYU			; cc
	db DEX_MIKON			; cd
	db DEX_MONJA			; ce
	db DEX_JARANRA			; cf
	db DEX_HANEEI			; d0

	db DEX_PUKU				; d1
	db DEX_SHIBIREFUGU		; d2
	db DEX_PICHU			; d3
	db DEX_PY				; d4
	db DEX_PUPURIN			; d5
	db DEX_MIZUUO			; d6
	db DEX_NATY				; d7
	db DEX_NATIO			; d8
	db DEX_GYOPIN			; d9
	db DEX_MARIL			; da
	db DEX_MANBO1			; db
	db DEX_IKARI			; dc
	db DEX_GROTESS			; dd
	db DEX_EKSING			; de
	db DEX_PARA				; df
	db DEX_KOKUMO			; e0

	db DEX_TWOHEAD			; e1
	db DEX_YOROIDORI		; e2
	db DEX_ANIMON			; e3
	db DEX_HINAZU			; e4
	db DEX_SUNNY			; e5
	db DEX_PAON				; e6
	db DEX_DONPHAN			; e7
	db DEX_TWINZ			; e8
	db DEX_KIRINRIKI		; e9
	db DEX_PAINTER			; ea
	db DEX_KOUNYA			; eb
	db DEX_RINRIN			; ec
	db DEX_BERURUN			; ed
	db DEX_NYOROTONO		; ee
	db DEX_YADOKING			; ef
	db DEX_ANNON			; f0

	db DEX_REDIBA			; f1
	db DEX_MITSUBOSHI		; f2
	db DEX_PUCHICORN		; f3
	db DEX_EIFIE			; f4
	db DEX_BLACKY			; f5
	db DEX_TURBAN			; f6
	db DEX_BETBABY			; f7
	db DEX_TEPPOUO			; f8
	db DEX_OKUTANK			; f9
	db DEX_GONGU			; fa
	db DEX_REDIBA			; fb
	db DEX_REDIBA			; fc
	
; Pokedex_UpdateSearchScreen.Jumptable indexes
	const_def
	const SEARCHSTATE_INIT_FIRST_MON_TYPE
	const SEARCHSTATE_UPDATE_FIRST_MON_TYPE
	const SEARCHSTATE_INIT_FIRST_TYPE_SELECTED_MENU
	const SEARCHSTATE_UPDATE_FIRST_TYPE_SELECTED_MENU
	const SEARCHSTATE_INIT_SECOND_MON_TYPE
	const SEARCHSTATE_UPDATE_SECOND_MON_TYPE
	const SEARCHSTATE_INIT_SECOND_TYPE_SELECTED_MENU
	const SEARCHSTATE_UPDATE_SECOND_TYPE_SELECTED_MENU
	const SEARCHSTATE_EXIT_NO_SLOWPOKE_ANIM
	const SEARCHSTATE_EXIT_PLAY_SLOWPOKE_ANIM

Pokedex_SearchByTypeScreen::
	ld hl, wJumptableIndex
	ld a, [hl]
	push af
	xor a
	ld [hl], a

	ld hl, hInMenu
	ld a, [hl]
	push af
	ld a, 1
	ld [hl], a
	call ClearSprites
	call .Init

.loop
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .return
	call Pokedex_UpdateSearchScreen
	call DelayFrame
	jr .loop

.return
	pop af
	ldh [hInMenu], a
	pop af
	ld [wJumptableIndex], a
	ret

.Init
	ld hl, wDexListingCursor
	ld c, wDexPlaySlowpokeAnimation - wDexListingCursor
	xor a
.init_loop:
	ld [hli], a
	dec c
	jr nz, .init_loop
	ret

Pokedex_UpdateSearchScreen:
	jumptable .SearchScreenJumptable, wJumptableIndex

.SearchScreenJumptable:
	dw Pokedex_InitSearchMonType,              Pokedex_UpdateSearchMonType
	dw Pokedex_InitFirstTypeSelectedMenu,      Pokedex_UpdateFirstTypeSelectedMenu
	dw Pokedex_InitNextSearchMonType,          Pokedex_UpdateNextSearchMonType
	dw Pokedex_InitSecondTypeSelectedMenu,     Pokedex_UpdateSecondTypeSelectedMenu
	dw Pokedex_ExitSearch_NoSlowpokeAnimation, Pokedex_ExitSearch_PlaySlowpokeAnimation
	
Pokedex_InitSearchMonType:
	xor a
	ld hl, wDexSearchMonType1
	ld [hli], a
	ld [hli], a
	ld [hli], a
	call Pokedex_DisplayTypeSearch
	ld hl, wJumptableIndex ; SEARCHSTATE_UPDATE_FIRST_MON_TYPE
	inc [hl]
	ret

Pokedex_UpdateSearchMonType:
	call GetJoypadDebounced
	ld de, wDexSearchMonType1
	call Pokedex_GetSearchMenuJoyDown
	ret nc
	ld a, SEARCHSTATE_EXIT_NO_SLOWPOKE_ANIM
	ld [wJumptableIndex], a
	ret

Pokedex_InitFirstTypeSelectedMenu:
	ld de, FirstTypeSelectedMenu
	call Pokedex_DisplaySearchOptions
	ret

Pokedex_UpdateFirstTypeSelectedMenu:
	call GetJoypadDebounced
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed

	call Pokedex_MoveTypeSelectedMenuCursor
	ret

.b_pressed
	ld a, SEARCHSTATE_INIT_FIRST_MON_TYPE
	ld [wJumptableIndex], a
	ret

.a_pressed
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .search

	cp 1
	jr z, .select_next_type

	ld a, SEARCHSTATE_EXIT_NO_SLOWPOKE_ANIM
	ld [wJumptableIndex], a
	ret

.search
	call Pokedex_SearchForMons
	ld a, SEARCHSTATE_EXIT_PLAY_SLOWPOKE_ANIM
	ld [wJumptableIndex], a
	ret

.select_next_type
	ld a, SEARCHSTATE_INIT_SECOND_MON_TYPE
	ld [wJumptableIndex], a
	ret

Pokedex_InitNextSearchMonType:
	xor a
	ld [wDexSearchMonType2], a
	ld [wDexArrowCursorPosIndex], a
	call Pokedex_DisplayTypeSearch
	ld hl, wJumptableIndex ; SEARCHSTATE_UPDATE_SECOND_MON_TYPE
	inc [hl]
	ret

Pokedex_UpdateNextSearchMonType:
	call GetJoypadDebounced
	ld de, wDexSearchMonType2
	call Pokedex_GetSearchMenuJoyDown
	ret nc

	ld a, SEARCHSTATE_INIT_FIRST_TYPE_SELECTED_MENU
	ld [wJumptableIndex], a
	ret

Pokedex_InitSecondTypeSelectedMenu:
	ld de, SecondTypeSelectedMenu
	call Pokedex_DisplaySearchOptions
	ret

Pokedex_UpdateSecondTypeSelectedMenu:
	call GetJoypadDebounced
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed
	call Pokedex_MoveTypeSelectedMenuCursor
	ret

.b_pressed
	ld a, SEARCHSTATE_INIT_SECOND_MON_TYPE
	ld [wJumptableIndex], a
	ret

.a_pressed
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .search

	cp 1
	jr z, .back_to_first_type

	ld a, SEARCHSTATE_EXIT_NO_SLOWPOKE_ANIM
	ld [wJumptableIndex], a
	ret

.search
	call Pokedex_SearchForMons
	ld a, SEARCHSTATE_EXIT_PLAY_SLOWPOKE_ANIM
	ld [wJumptableIndex], a
	ret

; Unreferenced
.reorder_dex
	call Pokedex_OrderMonsByMode

.back_to_first_type
	ld a, SEARCHSTATE_INIT_FIRST_MON_TYPE
	ld [wJumptableIndex], a
	ret

Pokedex_ExitSearch_NoSlowpokeAnimation:
	xor a
	ld [wDexPlaySlowpokeAnimation], a
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Pokedex_ExitSearch_PlaySlowpokeAnimation:
	ld a, SEARCHSTATE_UPDATE_FIRST_MON_TYPE
	ld [wDexPlaySlowpokeAnimation], a
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

Pokedex_GetSearchMenuJoyDown:
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .a_pressed

	ld a, [hl]
	and B_BUTTON
	jr nz, .b_pressed

	call Pokedex_MoveSearchMenuCursor
	and a
	ret

.b_pressed
	scf
	ret

.a_pressed
	ld hl, wDexListingCursor
	ld a, [wDexArrowCursorPosIndex]
	add [hl]
	inc a
	ld [de], a
	call Pokedex_PlaceSearchScreenTypeStrings
	call Pokedex_WaitBGMap

	ld hl, wJumptableIndex
	inc [hl]
	and a
	ret

Pokedex_DisplaySearchOptions:
	; Erase old cursor
	push de
	ld a, [wDexArrowCursorPosIndex]
	call Pokedex_GetSearchScreenCursorPos
	ld [hl], "　"

	; Place new cursor
	hlcoord 13, 12
	ld [hl], "▶"
	xor a
	ld [wDexArrowCursorPosIndex], a
	pop de

	; Place the options loaded at de
	hlcoord 14, 12
	call PlaceString
	call Pokedex_WaitBGMap

	; Move to update code for next Jumptable loop
	ld hl, wJumptableIndex
	inc [hl]
	ret

Pokedex_DisplayTypeSearch:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
.fill_screen
	ld [hl], $6b
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .fill_screen

	hlcoord 1, 0
	lb bc, 2, 10
	call ClearBox

	hlcoord 13, 0
	lb bc, 2, 6
	call ClearBox

	hlcoord 0, 2
	lb bc, 16, 12
	call Pokedex_PlaceBorder

	hlcoord 12, 2
	lb bc, 6, 8
	call Pokedex_PlaceBorder

	hlcoord 12, 10
	lb bc, 8, 8
	call Pokedex_PlaceBorder

	hlcoord 1, 1
	ld de, .SearchByTypeString
	call PlaceString

	hlcoord 13, 1
	ld de, .SelectedString
	call PlaceString

	call Pokedex_PlaceSearchScreenTypeList
	call Pokedex_PlaceSearchScreenTypeStrings
	hlcoord 2, 4
	ld [hl], "▶"
	call Pokedex_WaitBGMap
	ret

.SearchByTypeString:
	db "ぞくせい　で　さがす@"

.SelectedString:
	db "えらんだもの@"

FirstTypeSelectedMenu:
	db   "さがす"
	next "もうひとつ"
	next "やめる@"

SecondTypeSelectedMenu:
	db   "さがす"
	next "やりなおし"
	next "やめる@"

Pokedex_PlaceSearchScreenTypeList:
	ld a, [wDexListingCursor]
	call Pokedex_GetTypeString
	hlcoord 3, 4
	ld c, 7
.loop
	push bc
	push de
	push hl
	call PlaceString
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop de
rept POKEDEX_TYPE_STRING_LENGTH
	inc de
endr
	pop bc
	dec c
	jr nz, .loop
	ret

Pokedex_PlaceSearchScreenTypeStrings:
	ld a, [wDexSearchMonType1]
	call .check_type
	hlcoord 14, 4
	call PlaceString

	ld a, [wDexSearchMonType2]
	call .check_type
	hlcoord 14, 6
	call PlaceString
	ret

.check_type
	and a
	jr z, .no_type_selected
	dec a
	call Pokedex_GetTypeString
	ret

.no_type_selected
	ld de, .NoTypeString
	ret

.NoTypeString
db "ーーーー@"

Pokedex_GetTypeString:
	ld e, a
	ld d, $00
	ld hl, PokedexTypeSearchStrings
rept POKEDEX_TYPE_STRING_LENGTH
	add hl, de
endr
	ld e, l
	ld d, h
	ret

INCLUDE "data/types/search_strings.inc"

Pokedex_MoveSearchMenuCursor:
	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	call .MoveUp
	ret nc

	ld hl, wDexListingCursor
	ld a, [hl]
	and a
	ret z

	dec [hl]
	hlcoord 3, 3
	lb bc, 14, 8
	call ClearBox
	call Pokedex_PlaceSearchScreenTypeList
	call Pokedex_WaitBGMap
	ret

.down
	call .MoveDown
	ret nc

	ld hl, wDexListingCursor
	ld a, [hl]
	cp $8
	ret nc

	inc [hl]
	hlcoord 3, 3
	lb bc, 14, 8
	call ClearBox
	call Pokedex_PlaceSearchScreenTypeList
	call Pokedex_WaitBGMap
	ret

.MoveUp:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .set_carry_flag_up

	call Pokedex_GetSearchScreenCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .PutArrow

.set_carry_flag_up
	scf
	ret

.MoveDown:
	ld a, [wDexArrowCursorPosIndex]
	cp 6
	jr nc, .set_carry_flag_down

	call Pokedex_GetSearchScreenCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	inc [hl]
	jr .PutArrow

.set_carry_flag_down
	scf
	ret

.PutArrow:
	ld a, [hl]
	call Pokedex_GetSearchScreenCursorPos
	ld [hl], "▶"
	call Pokedex_WaitBGMap
	and a
	ret

Pokedex_GetSearchScreenCursorPos:
	ld e, a
	ld d, $00
	ld hl, .CursorPosTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.CursorPosTable:
	dwcoord 2, 4
	dwcoord 2, 6
	dwcoord 2, 8
	dwcoord 2, 10
	dwcoord 2, 12
	dwcoord 2, 14
	dwcoord 2, 16

Pokedex_MoveTypeSelectedMenuCursor:
	ld hl, hJoyDown
	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	ld a, [wDexArrowCursorPosIndex]
	and a
	ret z

	call Pokedex_GetTypeSelectedMenuCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .PutArrow

.down
	ld a, [wDexArrowCursorPosIndex]
	cp $2
	ret nc

	call Pokedex_GetTypeSelectedMenuCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	inc [hl]

.PutArrow:
	ld a, [hl]
	call Pokedex_GetTypeSelectedMenuCursorPos
	ld [hl], "▶"
	call Pokedex_WaitBGMap
	and a
	ret

Pokedex_GetTypeSelectedMenuCursorPos:
	ld e, a
	ld d, 0
	ld hl, .CursorPosTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.CursorPosTable:
	dwcoord 13, 12
	dwcoord 13, 14
	dwcoord 13, 16

Pokedex_SearchForMons:
	ld a, [wDexSearchMonType2]
	and a
	jr z, .next_type
	call .Search
.next_type
	ld a, [wDexSearchMonType1]
	and a
	ret z
	call .Search
	ret

.Search:
	dec a
	ld e, a
	ld d, $00
	ld hl, PokedexTypeSearchConversionTable
	add hl, de
	ld a, [hl]
	ld [wDexConvertedMonType], a
	ld hl, wPokedexOrder
	ld de, wPokedexOrder
	ld c, NUM_POKEMON
	xor a
	ld [wDexSearchResultCount], a
.loop
	push bc
	ld a, [hl]
	and a
	jr z, .next_mon
	ld [wTempSpecies], a
	ld [wCurSpecies], a

	call Pokedex_CheckCaught
	jr z, .next_mon
	push hl
	push de
	call GetBaseData
	pop de
	pop hl

	ld a, [wDexConvertedMonType]
	ld b, a
	ld a, [wMonHType1]
	cp b
	jr z, .match_found
	
	ld a, [wMonHType2]
	cp b
	jr nz, .next_mon

.match_found
	ld a, [wTempSpecies]
	ld [de], a
	inc de
	ld a, [wDexSearchResultCount]
	inc a
	ld [wDexSearchResultCount], a
.next_mon
	inc hl
	pop bc
	dec c
	jr nz, .loop

	ld l, e
	ld h, d
	ld a, [wDexSearchResultCount]
	ld [wDexListingEnd], a
	ld c, $00

.zero_remaining_mons
	cp NUM_POKEMON
	jr z, .done
	ld [hl], c
	inc hl
	inc a
	jr .zero_remaining_mons

.done
	ret

INCLUDE "data/types/search_types.inc"

Pokedex_WaitBGMap:
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ret

Pokedex_UnownMode:
	ld hl, wJumptableIndex
	ld a, [hl]
	push af
	xor a
	ld [hl], a

	ld hl, hInMenu
	ld a, [hl]
	push af
	ld a, $01
	ld [hl], a

	call ClearSprites
	call GetDexUnownCount

.Loop
	ld a, [wJumptableIndex]
	bit JUMPTABLE_EXIT_F, a
	jr nz, .done

	call Pokedex_RunUnownModeJumptable
	call DelayFrame
	jr .Loop

.done:
	pop af
	ldh [hInMenu], a
	pop af
	ld [wJumptableIndex], a
	ret

GetDexUnownCount:
	ld hl, wDexListingCursor
	ld bc, wDexPlaySlowpokeAnimation - wDexListingCursor
	xor a
	call ByteFill
	ld hl, wUnownDex
	ld bc, NUM_UNOWN
.annon_loop:
	ld a, [hli]
	and a
	jr z, .no_annon
	inc b
.no_annon
	dec c
	jr nz, .annon_loop

	ld a, b
	ld [wDexUnownCount], a
	ret

Pokedex_RunUnownModeJumptable:
	jumptable .Jumptable, wJumptableIndex

.Jumptable
dw .Init, .Update, .ShowUnownLetter

.Init:
	ld hl, wJumptableIndex
	inc [hl]
	call Pokedex_InitUnownMode
	ret

.Update:
	call GetJoypadDebounced
	ld hl, hJoyDown
	ld a, [hl]
	and A_BUTTON
	jr nz, .selected_unown
	ld a, [hl]
	and B_BUTTON
	jr nz, .exit
	call Pokedex_UnownModeHandleDPadInput
	ret

.exit
	ld hl, wJumptableIndex
	set JUMPTABLE_EXIT_F, [hl]
	ret

.selected_unown
	ld hl, wJumptableIndex
	inc [hl]
	ret

.ShowUnownLetter:
	ld hl, wDexListingCursor
	ld a, [wDexArrowCursorPosIndex]
	add [hl]
	ld e, a
	inc a
	ld [wDexCurUnownIndex], a
	ld d, $00
	ld hl, wUnownDex
	add hl, de
	ld a, [hl]
	ld [wAnnonID], a
	ld a, DEX_ANNON
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	call GetBaseData

	xor a
	ld [wSpriteFlipped], a
	hlcoord 12, 10
	call _PrepMonFrontpic

	hlcoord 12, 8
	call PrintUnownListEntry

	call Pokedex_WaitBGMap
	ld hl, wJumptableIndex
	dec [hl]
	ret

Pokedex_InitUnownMode:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, $6b
	call ByteFill

	hlcoord 0, 2
	lb bc, 16, 11
	call Pokedex_PlaceBorder

	hlcoord 11, 2
	lb bc, 6, 9
	call Pokedex_PlaceBorder

	hlcoord 11, 9
	lb bc, 9, 9
	call Pokedex_PlaceBorder

	hlcoord 4, 1
	ld de, .UnownVariantsString
	call PlaceString
	
	hlcoord 13, 4
	ld de, .VariantsDiscoveredString
	call PlaceString

	hlcoord 13, 4
	ld de, wDexUnownCount
	lb bc, 1, 2
	call PrintNumber

	hlcoord 12, 8
	call PrintUnownListEntry
	hlcoord 17, 8
	ld a, "？"
	ld [hli], a
	ld [hl], a
	call PrintUnownList
	hlcoord 2, 4
	ld [hl], "▶"
	call Pokedex_WaitBGMap
	ret

.UnownVariantsString:
	db "アンノーン　の　しゅるい@"

.VariantsDiscoveredString:
	db "　　しゅるい<NEXT>　はっけん！@"


PrintUnownList:
	ld a, [wDexUnownCount]
	cp 7
	jr c, .max_length
	ld a, 7

.max_length
	ld [wDexUnownModeListLength], a
	ld a, [wDexListingCursor]
	inc a
	ld [wDexCurUnownIndex], a
	hlcoord 3, 4
	ld a, [wDexUnownModeListLength]

.loop
	push af
	push hl
	call PrintUnownListEntry
	ld hl, wDexCurUnownIndex
	inc [hl]
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop af
	dec a
	jr nz, .loop
	ret

PrintUnownListEntry:
	ld de, .UnownString
	call PlaceString
	ld l, c
	ld h, b
	ld de, wDexCurUnownIndex
	lb bc, 1 | %10000000, 2
	call PrintNumber
	ret

.UnownString:
	db "アンノーン@"

Pokedex_UnownModeHandleDPadInput:
	ld hl, hJoySum
	ld a, [hl]
	and D_UP
	jr nz, .up

	ld a, [hl]
	and D_DOWN
	jr nz, .down
	ret

.up
	call .ScrollListUp
	ret nc
	ld hl, wDexListingCursor
	ld a, [hl]
	and a
	ret z
	
	dec [hl]
	hlcoord 3, 3
	lb bc, 14, 7
	call ClearBox
	call PrintUnownList
	call Pokedex_WaitBGMap
	ret

.down
	call .ScrollListDown
	ret nc
	ld a, [wDexUnownCount]
	cp 7
	ret c

	ld a, [wDexUnownCount]
	sub 7
	ld e, a
	ld hl, wDexListingCursor
	ld a, [hl]
	cp e
	ret nc

	inc [hl]
	hlcoord 3, 3
	lb bc, 14, 7
	call ClearBox
	call PrintUnownList
	call Pokedex_WaitBGMap
	ret

.ScrollListUp:
	ld a, [wDexArrowCursorPosIndex]
	and a
	jr z, .top_of_list

	call .GetCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	dec [hl]
	jr .PlaceArrow

.top_of_list
	scf
	ret

.ScrollListDown:
	ld a, [wDexUnownCount]
	cp 7
	jr c, .longer_than_7_entries
	ld a, 7

.longer_than_7_entries
	dec a
	ld e, a
	ld a, [wDexArrowCursorPosIndex]
	cp e
	jr nc, .bottom_of_list

	call .GetCursorPos
	ld [hl], "　"
	ld hl, wDexArrowCursorPosIndex
	inc [hl]
	jr .PlaceArrow

.bottom_of_list
	scf
	ret

.PlaceArrow:
	ld a, [hl]
	call Pokedex_GetSearchScreenCursorPos
	ld [hl], "▶"
	call Pokedex_WaitBGMap
	and a
	ret

.GetCursorPos:
	ld e, a
	ld d, $00
	ld hl, .CursorPosTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.CursorPosTable:
	dwcoord 2, 4
	dwcoord 2, 6
	dwcoord 2, 8
	dwcoord 2, 10
	dwcoord 2, 12
	dwcoord 2, 14
	dwcoord 2, 16
