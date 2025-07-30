INCLUDE "constants.asm"

SECTION "engine/pokedex/pokedex_2.asm", ROMX

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
