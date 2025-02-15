FieldDebug_DoVRAMViewer:
	call LoadStandardMenuHeader
	call ClearTileMap
	call ClearSprites
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld a, 1
	ld [wcdc3], a
	call .GenerateTilemap
	call WaitBGMap
	call .DoViewer
	pop af
	ldh [hMapAnims], a
	ld a, $e3
	ldh [rLCDC], a
	call .ReloadDefaultGFX
	call CloseWindow
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.DoViewer:
	ld a, [wcdc3]
	dec a
	ld hl, .Jumptable
	call CallJumptable
	call .GenerateTilemap
	call .ScreenControl
	jr nc, .DoViewer
	ret

.ScreenControl:
	call WaitBGMap
.wait_input
	call GetJoypad
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON | START | D_RIGHT | D_LEFT
	jr z, .wait_input
	bit D_LEFT_F, a
	jr nz, .next_page
	bit D_RIGHT_F, a
	jr nz, .previous_page
	bit START_F, a
	jr nz, .switch_tileset
	bit A_BUTTON_F, a
	ret nz
	scf
	ret

.switch_tileset
	ldh a, [rLCDC]
	xor (1 << rLCDC_TILE_DATA)
	ldh [rLCDC], a
	and a
	ret

.next_page
	ld hl, wcdc3
	inc [hl]
	ld a, [hl]
	cp 8
	jr c, .not_at_end
	ld [hl], 1

.not_at_end
	and a
	ret

.previous_page
	ld hl, wcdc3
	dec [hl]
	jr z, .not_at_start
	and a
	ret

.not_at_start
	ld [hl], 7
	and a
	ret

.Jumptable:
	dw .LoadTilesets1
	dw .LoadBagGFX
	dw .LoadTilesetsCommon
	dw .LoadToolgearGFX
	dw .ReloadDefaultGFX
	dw .LoadStatsGFX
	dw .LoadTilesets6

.GenerateTilemap:
	hlcoord 1, 1
	ld de, 4
	ld b, $10
	xor a
.generate_loop1
	ld c, $10
.generate_loop2
	ld [hli], a
	inc a
	dec c
	jr nz, .generate_loop2
	add hl, de
	dec b
	jr nz, .generate_loop1
	ret

.ReloadDefaultGFX:
	call .LoadTilesetsCommon
	call LoadFont
	ret

.LoadBagGFX:
	call .LoadTilesetsCommon
	call DisableLCD
	call LoadFont
	callfar LoadBackpackGraphics
	call EnableLCD
	ret

.LoadToolgearGFX:
	call .LoadTilesetsCommon
	call LoadToolgearGraphics
	ret

.LoadTilesets1:
	call .LoadTilesetsCommon
	call DisableLCD
	call LoadFontsBattleExtra
	call LoadFont
	call EnableLCD
	ret

.LoadStatsGFX:
	call .LoadTilesetsCommon
	call DisableLCD
	call LoadFontsBattleExtra
	call LoadFont
	callfar LoadPokemonStatsGraphics
	xor a
	ldh [hMapAnims], a
	call EnableLCD
	ld de, vTileset
	call .LoadPokemon
	ret

.LoadTilesets6:
	call DisableLCD
	xor a
	ld hl, vSprites
	ld bc, $180 tiles
	call ByteFill
	call LoadFont
	callfar Call_LoadBattleFontsHPBar
	xor a
	ldh [hMapAnims], a
	call EnableLCD
	ld de, vTileset
	call .LoadPokemon
	ld de, vBackPic
	ld a, 3
	ld [wTempBattleMonSpecies], a
	predef LoadMonBackPic
	ret

.LoadPokemon:
	ld a, 3
	ld [wce37], a
	ld [wCurPartySpecies], a
	call GetBaseData
	call LoadMonFrontSprite
	ret

.LoadTilesetsCommon:
	call DisableLCD
	xor a
	ld hl, vSprites
	ld bc, $180 tiles
	call ByteFill
	call LoadTilesetGFX
	ld a, 1
	ldh [hMapAnims], a
	callfar LoadUsedSpritesGfx
	call LoadFontExtra
	call EnableLCD
	ret

FieldDebug_DoClearEventFlags:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	call .CheckMapFlags
	jr nc, .no_flags
	ld a, [wMenuCursorY]
	cp 1
	ld a, 0
	jr z, .done
	ld a, $ff
.done
	ld [de], a
	ret

.no_flags
	ld hl, .NoMapFlagsText
	call MenuTextBoxBackup
	ret

.NoMapFlagsText:
	text "このマップは　シーケンスの"
	line "とうろくが　ありません"
	prompt

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 12, 6
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 2
	db "フラグを　クりア@"
	db "フラグを　うめる@"

.CheckMapFlags:
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	ld hl, UnknownMapBufferPointers
.determine_loop
	push hl
	ld a, BANK(UnknownMapBufferPointers)
	call GetFarByte
	cp -1
	jr z, .none_found
	cp b
	jr nz, .determine_loop2
	inc hl
	ld a, BANK(UnknownMapBufferPointers)
	call GetFarByte
	cp c
	jr nz, .determine_loop2
	jr .has_flags

.determine_loop2
	pop hl
	ld de, 8
	add hl, de
	jr .determine_loop

.has_flags
	pop hl
	ld de, 6
	add hl, de
	ld a, BANK(UnknownMapBufferPointers)
	call GetFarByte
	ld e, a
	inc hl
	ld a, BANK(UnknownMapBufferPointers)
	call GetFarByte
	ld d, a
	scf
	ret

.none_found
	pop hl
	and a
	ret

