INCLUDE "constants.asm"

SECTION "engine/menu/empty_sram.asm", ROMX

Checksum::
	push de
	xor a
	ld d, a
.loop
	ld a, [hli]
	add d
	ld d, a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ld a, d
	cpl
	pop de
	ret

EmptyAllSRAMBanks::
	ld a, 0
	call .EmptyBank
	call InitOptions
	ld a, 1
	call .EmptyBank
	ld a, 2
	call .EmptyBank
	ld a, 3
	call .EmptyBank
	call CloseSRAM
	ret

.EmptyBank:
	call OpenSRAM
	ld hl, SRAM_Begin
	ld bc, SRAM_End - SRAM_Begin
	ld a, $ff
	call ByteFill
	ret

SaveMenu::
	call PrintSaveScreenText
	ld hl, WouldYouLikeToSaveTheGameText
	call SaveTheGame_yesorno
	and a
	jr nz, .done
	call VerifyChecksum
	ld hl, wSaveFileFlags
	bit NEW_FILE_F, [hl]
	res NEW_FILE_F, [hl]
	jr nz, .next

	bit ANOTHER_FILE_EXISTS_F, [hl]
	res ANOTHER_FILE_EXISTS_F, [hl]
	jr nz, .another_save_file

	ld hl, AlreadyASaveFileText
	call SaveTheGame_yesorno
	and a
	jr nz, .done

	jr .next

.another_save_file:
	ld hl, AnotherSaveFileText
	call SaveTheGame_yesorno
	and a
	jr nz, .done

.next
	ld hl, wSaveFileFlags
	set 0, [hl]
	ld hl, wDebugFlags
	set SAVE_FILE_EXISTS_F, [hl]
	call SaveOptionsAndGameData
	call SavePokemonData
	call Dummy_SaveBox
	ld c, 32
	call DelayFrames
	ld hl, SavedTheGameText
	call MenuTextBox
	ld de, SFX_SAVE
	call WaitPlaySFX
	call WaitSFX
	ld c, 30
	call DelayFrames
	call ExitMenu

.done
	call ExitMenu
	ret

SaveTheGame_yesorno:
	call MenuTextBox
	lb bc, 0, 7
	call PlaceYesNoBox
	ld a, [wMenuCursorY]
	dec a
	call CloseWindow
	ret

WouldYouLikeToSaveTheGameText:
	text "ここまでの　かつやくを"
	line "#レポートに　かきこみますか？"
	done

SavedTheGameText:
	text "<PLAYER>は"
	line "レポートに　しっかり　かきのこした！"
	done

AlreadyASaveFileText:
	text "まえに　かかれた　レポートが"
	line "きえて　しまいますが"
	cont "うえから　かいても　いいですか？"
	done

AnotherSaveFileText:
	text "まえに　かかれた　レポート　が"
	line "こんかいと　ちがう　もの　ですが"
	cont "うえから　かいても　いいですか？"
	done

VerifyChecksum::
	ld a, BANK(sChecksum)
	call OpenSRAM
	ld a, [sChecksum + 2]
	ldh [hChecksum], a
	cp $ff
	jr nz, .file_exists
	ld hl, wSaveFileFlags
	set NEW_FILE_F, [hl]
	jr .done

.file_exists
	ld a, BANK(sGameData)
	call OpenSRAM
	ld hl, sGameData
	ld bc, sGameDataEnd - sGameData
	call Checksum
	ld b, a
	ldh a, [hChecksum]
	cp b
	jr z, .done
	ld hl, wSaveFileFlags
	set ANOTHER_FILE_EXISTS_F, [hl]
.done
	call CloseSRAM
	ret

PrintSaveScreenText::
	xor a
	ldh [hBGMapMode], a
	ld hl, .MenuHeader
	call LoadMenuHeader
	call MenuBox
	call PlaceVerticalMenuItems
	farcall PrintSaveScreenNumbers
	call LoadFontExtra
	call UpdateSprites
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 20
	call DelayFrames
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 0, 19, 9
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_PLACE_TITLE
	db 4
	db "しゅじんこう　<PLAYER>@"
	db "もっているバッジ　　　　こ@"
	db "#ずかん　　　　ひき@"
	db "プレイじかん@"
	db 6
	db "テスト@" ; "TEST"

SaveOptionsAndGameData::
	ld a, BANK(sOptions)
	call OpenSRAM
	ld hl, wOptions
	ld de, sOptions
	ld bc, wGameDataEnd - wOptions
	call CopyBytes
	ld hl, wGameData2
	ld de, sGameData2
	ld bc, wGameData2End - wGameData2
	call CopyBytes

	ld a, BANK(sChecksum)
	call OpenSRAM
	ld hl, wGameData
	ld bc, wGameDataEnd - wGameData
	call Checksum
	ld [sChecksum + 2], a
	ld hl, wGameData2
	ld bc, wGameData2End - wGameData2
	call Checksum
	ld [sChecksum + 1], a
	call CloseSRAM
	ret

SavePokemonData::
	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, wPokemonData
	ld de, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes

	ld a, BANK(sChecksum)
	call OpenSRAM
	ld hl, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call Checksum
	ld [sChecksum], a
	call CloseSRAM
	ret

; Dummied out with a ret, but it seemingly works.
Dummy_SaveBox::
	ret

	ld a, [wCurBox]
	ldh [hTempCurBox], a
	call .SaveBox
	ret

.SaveBox:
	ldh a, [hTempCurBox]
	dec a
	push af
	cp NUM_BOXES / 2
	ld a, BANK("Boxes 6-10")
	jr nc, .next
	ld a, BANK("Boxes 1-5")
.next
	call OpenSRAM
	pop af
	add a
	ld d, 0
	ld e, a
	ld hl, .BoxAddresses
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wBox
	ld bc, wBoxEnd - wBox
	call CopyBytes
	call CloseSRAM
	ret

.BoxAddresses:
for n, 1, NUM_BOXES + 1
	dw sBox{d:n}
endr

; Note that unlike the release versions of Red & Green or Gold & Silver, there's nothing to stop you from loading
; a corrupted file. The message will be displayed, but otherwise the game continues as normal.
TryLoadSaveFile::
	call ClearTileMap
	call LoadFont
	call LoadFontExtra
	call TryLoadSaveData
	jr c, .corrupt
	call TryLoadPokemonData
	jr c, .corrupt
	ret

.corrupt
	ld hl, wOptions
	push hl
	set NO_TEXT_SCROLL_F, [hl]
	ld hl, .SaveFileCorruptedText
	call PrintText
	ld c, 100
	call DelayFrames
	pop hl
	res NO_TEXT_SCROLL_F, [hl]
	ret

.SaveFileCorruptedText:
	text "レポートの　ないようが"
	line "こわれています！！"
	prompt

TryLoadSaveData:
	call CheckSaveFileChecksum
	jr nz, .corrupt

	ld a, BANK(sGameData)
	call OpenSRAM
	ld hl, sGameData
	ld de, wGameData
	ld bc, wGameDataEnd - wGameData
	call CopyBytes

	ld hl, sGameData2
	ld de, wGameData2
	ld bc, wGameData2End - wGameData2
	call CopyBytes
	jr .done

.corrupt
	scf
.done
	call CloseSRAM
	ret

CheckSaveFileChecksum:
	ld a, BANK(sChecksum)
	call OpenSRAM
	ld a, [sChecksum + 2]
	ldh [hChecksum], a
	ld a, [sChecksum + 1]
	ldh [hChecksum + 1], a
	ld a, [sChecksum + 0]
	ldh [hChecksum + 2], a

	ld a, BANK(sGameData)
	call OpenSRAM
	ld hl, sGameData
	ld bc, wGameDataEnd - wGameData
	call Checksum
	ld b, a
	ldh a, [hChecksum]
	cp b
	jr nz, .corrupt

	ld hl, sGameData2
	ld bc, wGameData2End - wGameData2
	call Checksum
	ld b, a
	ldh a, [hChecksum + 1]
	cp b
	jr nz, .corrupt

	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call Checksum
	ld b, a
	ldh a, [hChecksum + 2]
	cp b

.corrupt
	push af
	call CloseSRAM
	pop af
	ret

TryLoadPokemonData:
	ld a, BANK(sChecksum)
	call OpenSRAM
	ld a, [sChecksum]
	ldh [hChecksum + 2], a

	ld a, BANK(sPokemonData)
	call OpenSRAM
	ld hl, sPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call Checksum
	ld b, a
	ldh a, [hChecksum + 2]
	cp b
	jr nz, .corrupt

	ld hl, sPokemonData
	ld de, wPokemonData
	ld bc, wPokemonDataEnd - wPokemonData
	call CopyBytes
	jr .done

.corrupt
	scf
.done
	call CloseSRAM
	ret
; Unreferenced
	ret


MACRO map_buffer_pointers
	db GROUP_\1, MAP_\1
	dw \2, \3, \4

ENDM

; TODO: Rename to something more fitting, and actually label the flag ram addresses.
UnknownMapBufferPointers:
	map_buffer_pointers PLAYER_HOUSE_2F, wPlayerHouse2FCurScript, PlayerHouse2FScriptPointers, wd39a
	;db $01, $09, $9A, $D2, $95, $41, $9A, $D3
	db $01, $08, $9B, $D2, $A6, $40, $9B, $D3 ; PLAYER_HOUSE_1F
	db $01, $04, $9C, $D2, $7E, $76, $9C, $D3 ; SILENT_HILL
	db $01, $0C, $9D, $D2, $C6, $4B, $9D, $D3 ; SILENT_HILL_LAB_FRONT
	db $01, $0D, $9E, $D2, $73, $5C, $9E, $D3 ; SILENT_HILL_LAB_BACK
	db $01, $0A, $9F, $D2, $8C, $46, $9F, $D3 ; SILENT_HILL_POKECENTER
	db $01, $0B, $A0, $D2, $43, $48, $A0, $D3 ; SILENT_HILL_HOUSE
	db $01, $01, $A1, $D2, $A2, $7B, $A1, $D3 ; ROUTE1P1
	db $01, $02, $A2, $D2, $72, $7C, $A2, $D3 ; ROUTE1P2
	db $01, $05, $A3, $D2, $6B, $40, $A3, $D3 ; ROUTE1_GATE_1F
	db $01, $06, $A4, $D2, $29, $41, $A4, $D3 ; ROUTE1_GATE_2F
	db $01, $0F, $A5, $D2, $55, $56, $A5, $D3 ; SHIZUKANA_OKA
	db $02, $11, $A6, $D2, $8F, $47, $A6, $D3 ; OLD_CITY_POKECENTER_2F
	db -1

OverworldLoop_ReturnFromBattle:
	ld a, MAPSTATUS_MAIN
	call SetMapStatus
	ret
