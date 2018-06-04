INCLUDE "constants.asm"
INCLUDE "vram.asm"

SECTION "Title screen", ROMX[$5D8C], BANK[$01]

IntroSequence:: 					; 5D8C 
	callfar GameFreakIntro, $39
	jr c, TitleSequenceStart			; 5DAE 
	ld a, [wTitleSequenceOpeningType] 	; CC38 
	and a
	jr z, .opening_sequence
	
.pikachu_minigame
	callfar PikachuMiniGame, $38
	jr TitleSequenceStart 			; 5DAE 

.opening_sequence
	callfar OpeningCutscene, $39

TitleSequenceStart::
	call TitleSequenceInit
	callfar SetTitleBGDecorationBorder, $02
	
.loop
	call TitleScreenMain 			; 5FB8 
	jr nc, .loop
	
	call ClearPalettesAndWait 		; 361E 
	call ClearSprites
	ld a, $01
	ldh [hBGMapMode], a
	call ClearTileMap
	call ResetPalette ;33a
	
	ld a, [wJumptableIndex + 1]	; CB5F 
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
	dw DebugMenu 					; 4031 
	dw SRAMClearMenu 				; 61C6 
	dw IntroSequence

TitleSequenceInit::
	call ClearPalettes
	
	xor a
	ldh [hMapAnims], a
	ldh [hSCY], a
	ldh [hSCX], a
	
	ld de, MUSIC_NONE 					; Stop the music. 
	call PlayMusic
	
	call ClearTileMap
	call DisableLCD
	call ClearSprites
	
	ld a, $23
	ld hl, InitEffectObject			; 8CCFD - create another object? 
	call FarCall_hl
	ld hl, vChars0
	ld bc, vBGMap0 - vChars0

.clear_loop
	ld [hl], $00
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop

	ld hl, TitleScreenGFX			; 107CF 
	ld de, $9410
	ld bc, 13 tiles
	ld a, BANK(TitleScreenGFX)
	call FarCopyData
	
	ld hl, TitleScreenVersionGFX	; 1095F 
	ld de, $9600
	ld bc, 24 tiles
	ld a, BANK(TitleScreenVersionGFX)
	call FarCopyData
	
	ld hl, TitleScreenHoOhGFX		; 10ADF 
	ld de, $9000
	ld bc, 49 tiles
	ld a, BANK(TitleScreenHoOhGFX)
	call FarCopyData
	
	ld hl, TitleScreenLogoGFX		; 10DEF 
	ld de, $8800
	ld bc, 58 tiles
	ld a, BANK(TitleScreenLogoGFX)
	call FarCopyData
	
	ld hl, TitleScreenGoldLogoGFX	; 1118F 
	ld de, $8BA0
	ld bc, 20 tiles
	ld a, BANK(TitleScreenGoldLogoGFX)
	call FarCopyData
	
	call SetTitleGfx 				; 6288 
	ld hl, wTileMapBackup			; C408 
	ld a, $24
	ld [hli], a
	ld a, $00
	ld [hli], a
	
	ld hl, vBGMap0
	ld bc, $0800
	ld a, "　"
	call ByteFill
	
	ld b, $06
	call GetSGBLayout
	call EnableLCD
	ld a, $01	
	ldh [hBGMapMode], a
	call WaitBGMap
	xor a
	ldh [hBGMapMode], a
	ld hl, wJumptableIndex		; CB5E 
	ld [hli], a 					; (Possibly wJumptableIndex from Crystal) 
	ld [hli], a 					; (Possibly wIntroSceneFrameCounter from Crystal) 
	ld [hli], a 					; (Possibly wTitleScreenTimer from Crystal) 
	ld [hl], a  					; (Possibly wTitleScreenTimer + 1 from Crystal) 
	
	call .load_position_table
		
	
	ld a, %00011010
	ldh [rBGP], a
	ld a, %11100100
	ldh [rOBP0], a
	ret
	
.load_position_table:
	ld hl, FirePositionTable
	ld c, 6							; Load 6 flying objects on the screen. 
	
.set_fire_note_loop
	push bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld a, $2E						; Title fire/note object effect type? 
	call InitSpriteAnimStruct 		; 3CA8
	pop hl
	pop bc
	dec c
	jr nz, .set_fire_note_loop
	ret

FirePositionTable::					; 5EAC-5EB7 
	dw $4CE0
	dw $58A0
	dw $6490
	dw $70D0
	dw $7CB0
	dw $8800

TitleFireGFX::	INCBIN "gfx/title/fire.2bpp"	; 5EB8-5F37 
TitleNotesGFX::	INCBIN "gfx/title/notes.2bpp"	; 5F38=5FB7 

TitleScreenMain:: 					; 5FB8
	ld a, [wJumptableIndex]		; CB5E
	bit 7, a
	jr nz, .exit
	call TitleScreenSequence
	ld a, $23
	ld hl, EffectObjectJumpNoDelay	; 8CD13
	call FarCall_hl
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

TitleSeq_IncreaseJumpTableIndex:: 		; 6025 
	ld hl, wJumptableIndex	; CB5E 
	inc [hl]
	ret

TitleSeq_WaitForNextSequence:: 			; 602A 
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

TitleSeq_LoadPokemonLogo:: 				; 603a 
	call PrintPokemonLogo		; 6196 
	call TitleSeq_IncreaseJumpTableIndex ; 6025 
	ld a, $01
	ldh [hBGMapMode], a
	ret	
	
TitleSeq_Start:: 						; 6045 
	call TitleSeq_IncreaseJumpTableIndex
	push de
	ld de, $002D
	call PlaySFX				; Play "Swish" sound 
	pop de
	ld a, $80
	ld [wJumptableIndex + 2], a
	call SetLYOverrides
	ld a, $43
	ldh [hLCDCPointer], a
	ret

TitleSeq_MoveTitle:: 					; 605d 
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
	
TitleSeq_MoveTitleEnd:: 					; 607A 
	xor a
	ldh [hLCDCPointer], a
	call TitleSeq_IncreaseJumpTableIndex
	ld de, MUSIC_TITLE
	call PlayMusic				; Play "Title Theme" 
	ret

TitleSeq_InitFlashTitle:: 				; 6087 
	call TitleSeq_IncreaseJumpTableIndex
	ld a, %00011010
	ld [wJumptableIndex + 2], a
	ld a, 6
	ld [wJumptableIndex + 3], a
	ret

TitleSeq_FlashTitle:: 					; 6095 
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

TitleSeq_PMJapaneseChara:: 				; 60B6 
	call PrintPMJapaneseChara
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_PMSubtitle:: 					; 60C6
	call PrintPMSubtitle
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_Version:: 						; 60D6
	call PrintVersion
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_CopyRight:: 					; 60e6 
	call PrintCopyRight
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_HoOh:: 							; 60f6 
	call Set_HoOh
	ld a, $10
	ld [wJumptableIndex + 2], a
	call TitleSeq_IncreaseJumpTableIndex
	ld a, $01
	ldh [hBGMapMode], a
	ret

TitleSeq_PressButtonInit:: 				; 6106 
	ld hl, wJumptableIndex
	inc [hl]
	ld hl, wJumptableIndex + 2
	ld de, DecodeNybble0Table - 3	; DecodeNybble0Table - 3 = $0C00 
	ld [hl], e
	inc hl
	ld [hl], d
	ret	
	
TitleSeq_TitleScreenInputAndTimeout:: 	; 6114 
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
	ld hl, hJoyState			; hJoyState = $FFA3 
	ld a, [hl]
	and D_UP | B_BUTTON | SELECT						; UP + B + SELECT brings you to the SRAM clear screen. 
	cp D_UP | B_BUTTON | SELECT
	jr z, .psbtn_sramclear
	ld a, [hl]
	and SELECT						; SELECT will bring you to the debug menu. 
	jr nz, .psbtn_gotodebug
	ld a, [hl]
	and $09
	ret z
	
.psbtn_play
	ld a, $00					; MainMenu 
	jr .psbtn_nextseq

.psbtn_gotodebug
if DEBUG 
	ld a, $01					; DebugMenu 
	jr .psbtn_nextseq
else
	ret
endc

.psbtn_sramclear
	ld a, $02					; SRAMClearMenu 
	
.psbtn_nextseq
	ld [wJumptableIndex + 1], a
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

.psbtn_reset
	ld hl, wJumptableIndex
	inc [hl]
	xor a
	ld [wMusicFadeID], a 			; C1A7
	ld [wMusicFadeID + 1], a
	ld hl, wMusicFade 			; C1A5 
	ld [hl], 8
	ret	
	
TitleSeq_FadeMusicOut:: 					; 615C 
	ld a, [wMusicFade]
	and a
	ret nz
	ld a, 3
	ld [wJumptableIndex + 1], a
	ld hl, wJumptableIndex
	set 7, [hl]
	ret	

SetLYOverrides:: 				; 616C 
	ld hl, wLYOverrides
	ld c, $30
.setly_loop
	ld [hli], a
	dec c
	jr nz, .setly_loop
	ret

PrintPMSubtitle:: 				; 6176 
	coord hl, 2, 6
	ld b, 15
	ld a, $69
	jr LoadPrintArea 			; 6186 

PrintVersion:: 					; 617f 
	coord hl, 4, 1
	ld b, $09
	ld a, $60
	
LoadPrintArea:: 				; 6186 
	ld [hli], a
	inc a
	dec b
	jr nz, LoadPrintArea
	ret

PrintPMJapaneseChara:: 			; 618C 
	coord hl, 15, 2
	ld a, "こ"
	lb bc, 4, 4
	jr PrintBoxArea

PrintPokemonLogo:: 				; 6196 
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
	
SRAMClearMenu:: 				; 61C6 
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFont
	call LoadFontExtra
	ld hl, SRAMClear_TextMsg1
	call PrintText 	; E70 
	ld hl, SRAMClear_WinPOS
	call CopyMenuHeader 		; 1D50
	call VerticalMenu 			; 1D87
	jp c, Init
	ld a, [wMenuCursorY]				; CC2A
	cp $01
	jp z, Init

	callfar InitAllSRAMBanks, $05
	jp Init

SRAMClear_TextMsg1::
db "<NULL>すべての　セーブデータエりアを"
db "<LINE>クりア　しますか？<DONE>"

SRAMClear_WinPOS::
db	0
db	7,14,11,19
dw SRAMClear_TextChoice ; menu data
db	1 ; default option 

SRAMClear_TextChoice::
db	%11000000
db	2
db "いいえ@"
db "はい@"

IntroCopyRightInfo:: 					; 6223
	call ClearTileMap
	call LoadFontExtra
	ld de, TitleScreenGFX
	ld hl, $9600
	lb bc, BANK(TitleScreenGFX), $19
	call CopyVideoData

	coord hl, 5, 7
	ld de, IntroCopyRightInfo_Text
	jp PlaceString

IntroCopyRightInfo_Text:: 				; 623E
db $60, $61, $62, $63, $6D, $6E, $6F, $70, $71, $72, $4E 				; "(C)1997 Nintendo\n" 
db $60, $61, $62, $63, $73, $74, $75, $76, $77, $78, $6B, $6C, $4E 		; "(C)1997 Creatures Inc.\n" 
db $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $50 ; "(C)1997 GAME FREAK Inc.{EOL}" 	

Set_HoOh:: 								; 6264
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
SetTitleFont::							; 627A 
	ld de, $8800
	ld hl, TitleScreenLogoGFX
	ld bc, 130 tiles
	ld a, $04
	jp FarCopyDataDouble 				; 0D3E 

; Sets the type of art that will be displayed on the title screen 
; depending on wTitleSequenceOpeningType. 
SetTitleGfx:: ;6288
	ld hl, wTitleSequenceOpeningType 	; CC38 
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
	ld de, $8000
	ld c, $80
.loop
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

if DEBUG
SECTION "Title screen TEMPORARY", ROMX[$62A5],BANK[1] ; TODO: merge this with the main section above
else
SECTION "Title screen TEMPORARY", ROMX[$62A2],BANK[1] ; TODO: merge this with the main section above
endc
	

GameInit:: 								; 62A5
	call ClearWindowData
	ld a, $23
	ld [wce5f], a
	jp IntroSequence