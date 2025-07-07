INCLUDE "constants.asm"

SECTION "engine/movie/title.asm@Title screen", ROMX

IntroSequence::
	callfar GameFreakIntro
	jr c, TitleSequenceStart
	ld a, [wTitleSequenceOpeningType]
	and a
	jr z, .opening_sequence

.pikachu_minigame
	callfar PikachuMiniGame
	jr TitleSequenceStart

.opening_sequence
	callfar OpeningCutscene

TitleSequenceStart::
	call TitleSequenceInit
	callfar SetTitleBGDecorationBorder

.loop
	call TitleScreenMain
	jr nc, .loop

	call ClearBGPalettes
	call ClearSprites
	ld a, $01
	ldh [hBGMapMode], a
	call ClearTileMap
	call UpdateTimePals

	ld a, [wJumptableIndex + 1]
	ld e, a
	ld d, 0
	ld hl, TitleScreenJumpTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	jp hl

TitleScreenJumpTable::
	dw MainMenu
	dw DebugMenu
	dw SRAMClearMenu
	dw IntroSequence

TitleSequenceInit::
	call ClearPalettes

	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ldh [hSCX], a

	ld de, MUSIC_NONE
	call PlayMusic

	call ClearTileMap
	call DisableLCD
	call ClearSprites

	farcall ClearSpriteAnims
	ld hl, vChars0
	ld bc, vBGMap0 - vChars0

.clear_loop
	ld [hl], $00
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop

	ld hl, TitleScreenGFX
	ld de, vChars2 tile $41
	ld bc, 13 tiles
	ld a, BANK(TitleScreenGFX)
	call FarCopyData

	ld hl, TitleScreenVersionGFX
	ld de, vChars2 tile $60
	ld bc, 24 tiles
	ld a, BANK(TitleScreenVersionGFX)
	call FarCopyData

	ld hl, TitleScreenHoOhGFX
	ld de, vChars2
	ld bc, 49 tiles
	ld a, BANK(TitleScreenHoOhGFX)
	call FarCopyData

	ld hl, TitleScreenLogoGFX
	ld de, vChars1
	ld bc, 58 tiles
	ld a, BANK(TitleScreenLogoGFX)
	call FarCopyData

	ld hl, TitleScreenGoldLogoGFX
	ld de, vChars1 tile $3a
	ld bc, 20 tiles
	ld a, BANK(TitleScreenGoldLogoGFX)
	call FarCopyData

	call SetTitleGfx
	ld hl, wTileMapBackup
	ld a, $24
	ld [hli], a
	ld a, $00
	ld [hli], a

	ld hl, vBGMap0
	ld bc, 128 tiles
	ld a, "　"
	call ByteFill

	ld b, SGB_TITLE_SCREEN
	call GetSGBLayout
	call EnableLCD
	ld a, $01
	ldh [hBGMapMode], a
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex
	ld [hli], a ; (Possibly wJumptableIndex from Crystal)
	ld [hli], a ; (Possibly wIntroSceneFrameCounter from Crystal)
	ld [hli], a ; (Possibly wTitleScreenTimer from Crystal)
	ld [hl], a  ; (Possibly wTitleScreenTimer + 1 from Crystal)

	call .load_position_table


	ld a, %00011010
	ldh [rBGP], a
	ld a, %11100100
	ldh [rOBP0], a
	ret

.load_position_table:
	ld hl, FirePositionTable
	ld c, 6 ; Load 6 flying objects on the screen.

.set_fire_note_loop
	push bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld a, SPRITE_ANIM_OBJ_GS_TITLE_FLAME_NOTE
	call InitSpriteAnimStruct
	pop hl
	pop bc
	dec c
	jr nz, .set_fire_note_loop
	ret

FirePositionTable::
	dbpixel 28,  9,  0,  4
	dbpixel 20, 11,  0,  0
	dbpixel 18, 12,  0,  4
	dbpixel 26, 14,  0,  0
	dbpixel 22, 15,  0,  4
	dbpixel  0, 17,  0,  0

TitleFireGFX:: INCBIN "gfx/title/fire.2bpp"
TitleNotesGFX:: INCBIN "gfx/title/notes.2bpp"

TitleScreenMain::
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .exit
	call TitleScreenSequence
	farcall PlaySpriteAnimations
	call DelayFrame
	and a
	ret

.exit
	scf
	ret

TitleScreenSequence::
	ld e, a
	ld d, 0
	ld hl, TitleScreenSequenceTable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

TitleScreenSequenceTable::
	dw TitleSeq_Start
	dw TitleSeq_LoadPokemonLogo
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_MoveTitle
	dw TitleSeq_MoveTitleEnd
	dw TitleSeq_InitFlashTitle
	dw TitleSeq_FlashTitle

	dw TitleSeq_PMJapaneseChara
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_WaitForNextSequence
	dw TitleSeq_PMSubtitle
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex

	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_WaitForNextSequence
	dw TitleSeq_Version
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_WaitForNextSequence
	dw TitleSeq_CopyRight

	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_WaitForNextSequence
	dw TitleSeq_HoOh
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex
	dw TitleSeq_IncreaseJumpTableIndex

	dw TitleSeq_WaitForNextSequence
	dw TitleSeq_PressButtonInit
	dw TitleSeq_TitleScreenInputAndTimeout
	dw TitleSeq_FadeMusicOut

TitleSeq_IncreaseJumpTableIndex::
	ld hl, wJumptableIndex
	inc [hl]
	ret

TitleSeq_WaitForNextSequence::
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex + 2
	ld a, [hl]
	and a
	jr z, .next_seq
	dec [hl]
	ret

.next_seq
	call TitleSeq_IncreaseJumpTableIndex
	ret

TitleSeq_LoadPokemonLogo::
	call PrintPokemonLogo
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_Start::
	call TitleSeq_IncreaseJumpTableIndex
	push de
	ld de, SFX_TITLE_ENTRANCE
	call PlaySFX
	pop de
	ld a, $80
	ld [wJumptableIndex + 2], a
	call SetLYOverrides
	ld a, LOW(rSCX)
	ldh [hLCDCPointer], a
	ret

TitleSeq_MoveTitle::
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex + 2
	ld a, [hl]
	and a
	jr z, .nextseq
	add $04
	ld [hl], a
	ld e, a
.wait
	ldh a, [rLY]
	cp $40
	jr c, .wait
	ld a, e
	call SetLYOverrides
	ret

.nextseq
	call TitleSeq_IncreaseJumpTableIndex
	ret

TitleSeq_MoveTitleEnd::
	xor a
	ldh [hLCDCPointer], a
	call TitleSeq_IncreaseJumpTableIndex
	ld de, MUSIC_TITLE
	call PlayMusic
	ret

TitleSeq_InitFlashTitle::
	call TitleSeq_IncreaseJumpTableIndex
	ld a, %00011010
	ld [wJumptableIndex + 2], a
	ld a, 6
	ld [wJumptableIndex + 3], a
	ret

TitleSeq_FlashTitle::
	ld hl, wJumptableIndex + 3
	ld a, [hl]
	and a
	jr z, .exit
	dec [hl]
	ld a, [wJumptableIndex + 2]
	xor %00011010
	ld [wJumptableIndex +2 ], a
	ldh [rBGP], a
	call DelayFrame
	call DelayFrame
	ret

.exit
	call TitleSeq_IncreaseJumpTableIndex
	ld a, %11100100
	ldh [rBGP], a
	ret

TitleSeq_PMJapaneseChara::
	call PrintPMJapaneseChara
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_PMSubtitle::
	call PrintPMSubtitle
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_Version::
	call PrintVersion
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_CopyRight::
	call PrintCopyRight
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_HoOh::
	call Set_HoOh
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_PressButtonInit::
	ld hl, wJumptableIndex
	inc [hl]
	ld hl, wJumptableIndex + 2
	ld de, DecodeNybble0Table - 3
	ld [hl], e
	inc hl
	ld [hl], d
	ret

TitleSeq_TitleScreenInputAndTimeout::
	ld hl, wJumptableIndex + 2
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, e
	or d
	jr z, .psbtn_reset
	dec de
	ld [hl], d
	dec hl
	ld [hl], e
	call GetJoypad
	ld hl, hJoyState
; UP + B + SELECT opens the SRAM clear screen
	ld a, [hl]
	and D_UP | B_BUTTON | SELECT
	cp D_UP | B_BUTTON | SELECT
	jr z, .psbtn_sramclear
; SELECT opens the debug menu
	ld a, [hl]
	and SELECT
	jr nz, .psbtn_gotodebug
	ld a, [hl]
	and $09
	ret z

.psbtn_play
	ld a, $00 ; MainMenu
	jr .psbtn_nextseq

.psbtn_gotodebug
	ld a, $01 ; DebugMenu
	jr .psbtn_nextseq

.psbtn_sramclear
	ld a, $02

.psbtn_nextseq
	ld [wJumptableIndex + 1], a
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.psbtn_reset
	ld hl, wJumptableIndex
	inc [hl]
	xor a
	ld [wMusicFadeID], a
	ld [wMusicFadeID + 1], a
	ld hl, wMusicFade
	ld [hl], 8
	ret

TitleSeq_FadeMusicOut::
	ld a, [wMusicFade]
	and a
	ret nz
	ld a, 3
	ld [wJumptableIndex + 1], a
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

SetLYOverrides::
	ld hl, wLYOverrides
	ld c, $30
.setly_loop
	ld [hli], a
	dec c
	jr nz, .setly_loop
	ret

PrintPMSubtitle::
	coord hl, 2, 6
	ld b, 15
	ld a, $69
	jr LoadPrintArea

PrintVersion::
	coord hl, 4, 1
	ld b, $09
	ld a, $60

LoadPrintArea::
	ld [hli], a
	inc a
	dec b
	jr nz, LoadPrintArea
	ret

PrintPMJapaneseChara::
	coord hl, 15, 2
	ld a, "こ"
	lb bc, 4, 4
	jr PrintBoxArea

PrintPokemonLogo::
	coord hl, 15, 3
	ld [hl], $B8
	coord hl, 15, 4
	ld [hl], $B9
	coord hl, 1, 2
	ld a, $80
	ld bc, $0E04

PrintBoxArea::
	ld de, SCREEN_WIDTH
	push bc
	push hl

.xloop
	ld [hli], a
	inc a
	dec b
	jr nz, .xloop
	pop hl
	add hl, de
	pop bc
	dec c
	jr nz, PrintBoxArea
	ret

PrintCopyRight::
	coord hl, 3, 17
	ld a, $41
	ld b, $0D

.loop
	ld [hli], a
	inc a
	dec b
	jr nz, .loop
	ret

SRAMClearMenu::
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFont
	call LoadFontExtra
	ld hl, SRAMClear_Message
	call PrintText
	ld hl, SRAMClear_WinPOS
	call CopyMenuHeader
	call VerticalMenu
	jp c, Init
	ld a, [wMenuCursorY]
	cp $01
	jp z, Init

	callfar InitAllSRAMBanks
	jp Init

SRAMClear_Message::
	db "<NULL>すべての　セーブデータエりアを"
	db "<LINE>クりア　しますか？<DONE>"

SRAMClear_WinPOS::
	db 0
	db 7,14,11,19
	dw SRAMClear_TextChoice ; menu data
	db 1 ; default option

SRAMClear_TextChoice::
	db %11000000
	db 2
	db "いいえ@"
	db "はい@"

IntroCopyRightInfo::
	call ClearTileMap
	call LoadFontExtra
	ld de, TitleScreenGFX
	ld hl, vChars2 tile $60
	lb bc, BANK(TitleScreenGFX), $19
	call Request2bpp

	coord hl, 5, 7
	ld de, IntroCopyRightInfo_Text
	jp PlaceString

IntroCopyRightInfo_Text::
	db $60, $61, $62, $63, $6D, $6E, $6F, $70, $71, $72, $4E                ; "ⓒ1997 Nintendo\n"
	db $60, $61, $62, $63, $73, $74, $75, $76, $77, $78, $6B, $6C, $4E      ; "ⓒ1997 Creatures Inc.\n"
	db $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $50 ; "ⓒ1997 GAME FREAK Inc.\0"

Set_HoOh::
	coord hl, 7, 9
	ld de, $000D
	ld a, $00
	ld b, $07
.loop
	ld c, $07
.loop2
	ld [hli], a
	inc a
	dec c
	jr nz, .loop2
	add hl, de
	dec b
	jr nz, .loop
	ret

; Unused code, looks like it sets the font type for the logo?
SetTitleFont::
	ld de, vChars1
	ld hl, TitleScreenLogoGFX
	ld bc, 130 tiles
	ld a, $04
	jp FarCopyDataDouble

; Sets the type of art that will be displayed on the title screen
; depending on wTitleSequenceOpeningType.
SetTitleGfx::
	ld hl, wTitleSequenceOpeningType
	ld a, [hl]
	xor $01
	ld [hl], a
	jr nz, .flame

.note
	ld hl, TitleNotesGFX
	jr SetTitleGfxNext

.flame
	ld hl, TitleFireGFX
SetTitleGfxNext::
	ld de, vChars0
	ld c, $80
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

GameInit::
	call ClearWindowData
	ld a, STEREO | TEXT_DELAY_MED
	ld [wOptions], a
	jp IntroSequence
