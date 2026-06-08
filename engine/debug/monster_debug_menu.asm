INCLUDE "constants.asm"

SECTION "engine/debug/monster_debug_menu.asm", ROMX

DEF NUM_MONSTERTEST_ITEMS EQU 9

MonsterTest:
	call ClearPalettes

	xor a
	ld [wOptionsMenuCursorX], a
	ld [wOptionsMenuCursorY], a
	ld [wWhichPicTest], a
	inc a
	ld [wTempSpecies], a
	ldh [hInMenu], a

	callfar LoadPokeDexGraphics
	; fallthrough
.Loop:
	call MonsterTest_List
	ret nc

.Menu_Loop:
	call .Menu
	jr .Loop

.Menu:
	ld a, [wOptionsMenuCursorX]
	ld b, a
	ld a, [wOptionsMenuCursorY]
	add a, b
	inc a
	ld [wTempSpecies], a
	ld a, [wTempSpecies]
	push af
	ld a, [wOptionsTextSpeedCursorX]
	push af

	call MonsterTest_SelectedMenu

	pop af
	ld [wOptionsTextSpeedCursorX], a
	ld a, [wTempSpecies]
	ld c, a
	pop af
	cp c
	jr nz, .Different

	ld [wTempSpecies], a
	ret
	
.Different:
	ld a, [wTempSpecies]
	dec a
	ld [wTempSpecies], a
	ld c, a
	ld a, [wOptionsTextSpeedCursorX]	; page size
	cp NUM_MONSTERTEST_ITEMS + 1
	jr c, .ScrollPosition
	
	sub c
	cp NUM_MONSTERTEST_ITEMS
	jr c, .AllowChange

	ld a, c
	ld [wOptionsMenuCursorY], a
	xor a
	ld [wOptionsMenuCursorX], a
	ret
.ScrollPosition:
	xor a
	ld [wOptionsMenuCursorY], a
	ld a, c
	ld [wOptionsMenuCursorX], a
	ret
.AllowChange:
	ld a, [wOptionsTextSpeedCursorX]	; page size
	sub a, NUM_MONSTERTEST_ITEMS
	ld [wOptionsMenuCursorY], a
	ld d, a
	ld a, c
	sub d
	ld [wOptionsMenuCursorX], a
	ret

MonsterTest_List:
	call MonsterTest_ListGetNumEntries
.Loop
	xor a
	ldh [hBGMapMode], a
	call MonsterTest_ClearScreen

	hlcoord 1, 1
	ld a, [wOptionsMenuCursorY]
	ld [wTempSpecies], a
	ld d, NUM_MONSTERTEST_ITEMS
	; fallthrough
.TextInput_Loop:						; put mons number & mons name
	ld a, [wTempSpecies]
	inc a
	ld [wTempSpecies], a
	push af

	push de								; counter save
	push hl								; vram address save

	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber

	push hl
	call MonsterTest_ListGetString
	pop hl
	inc hl
	call PlaceString

	pop hl								; vram address load
	ld bc, $28
	add hl, bc
	pop de								; counter load

	pop af
	ld [wTempSpecies], a

	dec d
	jr nz, .TextInput_Loop
	call WaitBGMap
	call SetPalettes

	call MonsterTest_Cursor

	bit B_BUTTON_F, a					; cancel by "B" button
	jp nz, .close_menu

	bit SELECT_F, a						; trainer or monster change
	jr z, .move_up
	ld hl, wWhichPicTest
	ld a, [hl]
	xor 1
	ld [hl], a
	xor a
	ld [wOptionsMenuCursorY], a
	jr MonsterTest_List
.move_up:
	bit D_UP_F, a						; up key
	jr z, .move_down

	ld a, [wOptionsMenuCursorY]
	and a
	jp z, .Loop

	dec a								; scroll up by 1 if possible
	ld [wOptionsMenuCursorY], a
	jp .Loop
.move_down:
	bit D_DOWN_F, a						; down key
	jr z, .next_page

	ld a, [wOptionsTextSpeedCursorX]	; page size
	cp NUM_MONSTERTEST_ITEMS
	jp c, .Loop

	sub NUM_MONSTERTEST_ITEMS
	ld b, a
	ld a, [wOptionsMenuCursorY]
	cp b
	jp z, .Loop

	inc a								; scroll down by 1 if possible
	ld [wOptionsMenuCursorY], a
	jp .Loop
.next_page:
	bit D_RIGHT_F, a					; right key
	jr z, .previous_page

	ld a, [wOptionsTextSpeedCursorX]	; page size
	cp NUM_MONSTERTEST_ITEMS
	jp c, .Loop

	sub NUM_MONSTERTEST_ITEMS - 1
	ld b, a
	ld a, [wOptionsMenuCursorY]
	add a, NUM_MONSTERTEST_ITEMS
	ld [wOptionsMenuCursorY], a
	cp b
	jp c, .Loop

	dec b								; scroll up by 9 if possible
	ld a, b
	ld [wOptionsMenuCursorY], a
	jp .Loop
.previous_page:
	bit D_LEFT_F, a						; left key
	jr z, .no_input

	ld a, [wOptionsMenuCursorY]
	sub NUM_MONSTERTEST_ITEMS
	ld [wOptionsMenuCursorY], a	
	jp nc, .Loop

	xor a								; scroll down by 9 if possible
	ld [wOptionsMenuCursorY], a
	jp .Loop
.no_input:
	scf
	ret
.close_menu:
	and a
	ret

MonsterTest_ListGetNumEntries:
	ld a, [wWhichPicTest]
	and a
	jr z, .is_a_pokemon
	ld a, NUM_TRAINER_CLASSES - 1
	jr .return
.is_a_pokemon:
	ld a, NUM_POKEMON
.return:
	ld [wOptionsTextSpeedCursorX], a
	ret

MonsterTest_ListGetString:
	ld a, [wWhichPicTest]
	and a
	jr z, .is_a_pokemon
	ld a, [wTempSpecies]
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	ld de, wStringBuffer1
	ret
.is_a_pokemon:
	call GetPokemonName
	ret
	
MonsterTest_ClearScreen:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, '　'
	call ByteFill
	ret
	

MonsterTest_SelectedMenu:
	xor a
	ldh [hBGMapMode], a

	call MonsterTest_ClearScreen

	xor a
	ldh [hMapAnims], a
	call MonsterTest_PlaceBorder
	call WaitBGMap
	call SetPalettes

	call MonsterTest_GetPic
.wait_for_input:
	call GetJoypadDebounced

	ld hl, hJoySum
	ld a, [hl]
	and (A_BUTTON | B_BUTTON)
	ret nz

.Input_Loop:
	ld a, [hl]
	and D_PAD
	jr z, .wait_for_input

	ld a, [wTempSpecies]
	ld c, a

	ld a, [hl]
	and (D_DOWN | D_RIGHT)
	jr nz, .next_entry

	dec c
	jr z, .wait_for_input
	jr .return
.next_entry:
	inc c
	ld a, [wOptionsTextSpeedCursorX]
	cp c
	jr c, .wait_for_input
.return:
	ld a, c
	ld [wTempSpecies], a
	jp MonsterTest_SelectedMenu

MonsterTest_PlaceBorder:
	ld de, 20
	hlcoord 0, 0
	; Top-left corner
	ld [hl], $63
	hlcoord 19, 0
	; Top-right corner
	ld [hl], $65
	hlcoord 0, 17
	; Bottom-left corner
	ld [hl], $68
	hlcoord 19, 17
	; Bottom-right corner
	ld [hl], $6a

	hlcoord 1, 0
	ld bc, SCREEN_HEIGHT
	; Top border
	ld a, $64
	call ByteFill

	hlcoord 1, 17
	ld bc, SCREEN_HEIGHT
	; Bottom border
	ld a, $69
	call ByteFill

	hlcoord 0, 1
	ld de, SCREEN_WIDTH - 1
	; Fill 6-by-6 tile area with gray/orange space.
	ld a, $10
.Loop:
	; Left border
	ld [hl], $66
	add hl, de
	; Right border
	ld [hl], $67
	inc hl
	dec a
	jr nz, .Loop
	ret

MonsterTest_GetPic:
	ld a, [wWhichPicTest]
	and a
	jr z, .is_a_pokemon
	ld a, [wTempSpecies]
	ld [wTrainerClass], a
	callfar GetTrainerAttributes
	ld de, wStringBuffer1
	hlcoord 1, 10
	call PlaceString

	callfar GetTrainerPic

	xor a
	ld [wTempEnemyMonSpecies], a
	ldh [hGraphicStartTile], a
	dec a
	ld [wEnemyItemState], a
	hlcoord 1, 1
	lb bc, 7, 7
	predef PlaceGraphic
	ret
.is_a_pokemon
	ld a, [wUnownDex]				; BUG: wUnownDex isn't set beforehand so an invalid Unown ($00) is displayed instead.
	ld [wAnnonID], a

	ld a, [wTempSpecies]
	ld [wCurPartySpecies], a
									; No code is present to load the palettes yet, but SGB_POKEDEX works on the front sprites.
;	ld b, SGB_POKEDEX
;	call GetSGBLayout
;	call SetPalettes

	call GetPokemonName
	hlcoord 9, 2
	call PlaceString

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData

	hlcoord 1, 1
	call PrepMonFrontpic
	ld hl, wMonHBackSprite - wMonHeader
	call UncompressMonSprite
	
	ld hl, vChars2 tile $31
	predef GetMonBackpic

	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 1, 10
	lb bc, 6, 6
	predef PlaceGraphic
	ld a, [wCurPartySpecies]
	call PlayCry
	ret

MonsterTest_Cursor:
	call .get_position
	ld [hl], '▶'
	call WaitBGMap
.Loop:
	call GetJoypadDebounced
	ld hl, hJoySum
	ld a, [hl]
	and a
	jr z, .Loop

	and D_UP
	jr nz, .move_up
	ld a, [hl]
	and D_DOWN
	jr nz, .move_down
.return:
	ldh a, [hJoySum]
	ret
.move_up:
	ld a, [wOptionsMenuCursorX]
	and a
	jr z, .return
	
	call .get_position
	ld [hl], '　'
	ld hl, wOptionsMenuCursorX
	dec [hl]
	jr MonsterTest_Cursor
.move_down:
	ld a, [wOptionsMenuCursorX]
	cp NUM_MONSTERTEST_ITEMS-1
	jr nc, .return
	
	call .get_position
	ld [hl], '　'
	ld hl, wOptionsMenuCursorX
	inc [hl]
	jr MonsterTest_Cursor
.get_position:
	ld a, [wOptionsMenuCursorX]
	sla a
	inc a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH
	call AddNTimes
	ret