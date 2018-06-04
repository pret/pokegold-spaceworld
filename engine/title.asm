INCLUDE "constants.asm"

SECTION "Title screen", ROMX[$5D8C], BANK[$01]

IntroSequence:: ; 5d8c
	ld hl, GameFreakLogo ;E4000
	ld a, $39
	call FarCall_hl
	jr c, TitleSequenceStart ;5dae
	ld a, [wOpeningType] ;cc38
	and a
	jr z, .opening_sequence_start
	
.pikachu_minigame_start
	ld hl, PikachuMiniGame ;E0000
	ld a, $38
	call FarCall_hl
	jr TitleSequenceStart ;5dae

.opening_sequence_start
	ld hl, OpeningSequence ;E432F
	ld a, $39
	call FarCall_hl

TitleSequenceStart::
	call TitleSequenceInit
	ld hl, SetTitleBGDecorationBorder ;91D2
	ld a, $02
	call FarCall_hl
	
.loop
	call TitleScreenMain ;5fb8
	jr nc, .loop
	
	call ClearPalettesAndWait ;361e -clear palettes and wait
	call ClearSprites
	ld a, $01
	ldh [$FFDE], a
	call ClearTileMap
	call ResetPalette ;33a
	
	ld a, [wSequence + 1]	; wSequence + 1 = $CB5F
	ld e, a
	ld d, $00
	ld hl, TitleScreenJumpTable
	add hl, de
	add hl, de
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	
	jp hl

TitleScreenJumpTable::
	dw MainMenu
	dw DebugMenu ;4031
	dw SRAMClearMenu ;61c6
	dw IntroSequence

TitleSequenceInit::
	call ClearPalettes
	
	xor a
	ldh [$FFE8], a
	ldh [$FFDA], a
	ldh [$FFD9], a
	
	ld de, $0000 ;Stop the music.
	call PlayMusic
	
	call ClearTileMap
	call DisableLCD
	call ClearSprites
	
	ld a, $23
	ld hl, InitEffectObject	; 8CCFD - create another object?
	call FarCall_hl
	ld hl, $8000
	ld bc, $1800

.clear_loop
	ld [hl], $00
	inc hl
	dec bc
	ld a, b
	or c
	jr nz, .clear_loop

	ld hl, TitleScreenGFX	; TitleScreenGFX = $47CF
	ld de, $9410
	ld bc, $00D0
	ld a, $04
	call FarCopyData
	
	ld hl, TitleScreenVersionGFX ;1095F
	ld de, $9600
	ld bc, $0180
	ld a, $04
	call FarCopyData
	
	ld hl, TitleScreenHoOhGFX	;10ADF
	ld de, $9000
	ld bc, $0310
	ld a, $04
	call FarCopyData
	
	ld hl, TitleScreenLogoGFX ;10DEF
	ld de, $8800
	ld bc, $03A0
	ld a, $04
	call FarCopyData
	
	ld hl, TitleScreenGoldLogoGFX	;1118F
	ld de, $8BA0
	ld bc, $0140
	ld a, $04
	call FarCopyData
	
	call SetTitleArt ;6288
	ld hl, wTileMapBackup	; wTileMapBackup = $C408
	ld a, $24
	ldi [hl], a
	ld a, $00
	ldi [hl], a
	
	ld hl, $9800
	ld bc, $0800
	ld a, $7F
	call ByteFill
	
	ld b, $06
	call GetSGBLayout
	call EnableLCD
	ld a, $01	
	ldh [$FFDE], a
	call WaitBGMap
	xor a
	ldh [$FFDE], a
	ld hl, wSequence	; wSequence = $CB5E
	ldi [hl], a
	ldi [hl], a
	ldi [hl], a
	ld [hl], a
	
	call .load_position_table
		
	
	ld a, $1A
	ldh [rBGP], a
	ld a, $E4
	ldh [rOBP0], a
	ret
	
.load_position_table:
	ld hl, FirePositionTable
	ld c, $06	;load 6 flying objects on the screen
	
.set_fire_note_loop
	push bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	push hl
	ld a, $2E	;title fire/note object effect type?
	call AddEffectObject ;3CA8 add additional object?
	pop hl
	pop bc
	dec c
	jr nz, .set_fire_note_loop
	ret

FirePositionTable:: ;5EAC-5EB7
dw $4CE0
dw $58A0
dw $6490
dw $70D0
dw $7CB0
dw $8800

TitleFireGFX::
INCBIN "gfx/title/fire.2bpp" ;5EB8-5F37
TitleNotesGFX::
INCBIN "gfx/title/notes.2bpp" ;5F38=5FB7

TitleScreenMain:: ;5fb8
	ld a, [wSequence]	; wSequence = $CB5E
	bit 7, a
	jr nz, .exit
	call TitleScreenSequence
	ld a, $23
	ld hl, EffectObjectJumpNoDelay	; obj jump no wait? 8CD13
	call FarCall_hl
	call DelayFrame
	and a
	ret

.exit
	scf
	ret

TitleScreenSequence::
	ld e, a
	ld d, $00
	ld hl, TitleScreenSequenceTable
	add hl, de
	add hl, de
	ldi a, [hl]
	ld h, [hl]
	ld l, a
	jp hl
	
TitleScreenSequenceTable::
dw Start 
dw LoadPokemonLogo 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw MoveTitle 
dw MoveTitleEnd 
dw InitFlashTitle 
dw FlashTitle

dw PMJapaneseChara 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw WaitForNextSequence 
dw PMSubtitle 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber

dw IncreaseSequenceNumber 
dw WaitForNextSequence 
dw Version 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw WaitForNextSequence 
dw CopyRight

dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw WaitForNextSequence 
dw HoOh 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber 
dw IncreaseSequenceNumber

dw WaitForNextSequence 
dw PressButtonInit 
dw TitleScreenInputAndTimeout 
dw FadeMusicOut

IncreaseSequenceNumber:: ;6025
	ld hl, wSequence	; wSequence = $CB5E
	inc [hl]
	ret

WaitForNextSequence:: ;602A
	xor a
	ldh [$FFDE], a
	ld hl, wSequence+2
	ld a, [hl]
	and a
	jr z, .next_seq
	dec [hl]
	ret

.next_seq
	call IncreaseSequenceNumber
	ret

LoadPokemonLogo:: ;603a
	call PrintPokemonLogo ;6196
	call IncreaseSequenceNumber ;6025
	ld a, $01
	ldh [$FFDE], a
	ret	
	
Start:: ;6045
	call IncreaseSequenceNumber
	push de
	ld de, $002D
	call PlaySFX	; Play "Swish" sound
	pop de
	ld a, $80
	ld [wSequence+2], a
	call SetLYOverrides
	ld a, $43
	ldh [$FFD0], a
	ret

MoveTitle:: ;605d
	xor a
	ldh [$FFDE], a
	ld hl, wSequence+2
	ld a, [hl]
	and a
	jr z, .movetitle_nextseq
	add $04
	ld [hl], a
	ld e, a
.movetitle_wait
	ldh a, [rLY]
	cp $40
	jr c, .movetitle_wait
	ld a, e
	call SetLYOverrides
	ret

.movetitle_nextseq
	call IncreaseSequenceNumber
	ret	
	
MoveTitleEnd:: ;607a
	xor a
	ldh [$FFD0], a
	call IncreaseSequenceNumber
	ld de, $0001
	call PlayMusic		; Play Title Theme
	ret

InitFlashTitle:: ;6087
	call IncreaseSequenceNumber
	ld a, $1A
	ld [wSequence+2], a
	ld a, $06
	ld [wSequence+3], a
	ret

FlashTitle:: ;6095
	ld hl, wSequence+3
	ld a, [hl]
	and a
	jr z, .exit
	dec [hl]
	ld a, [wSequence+2]
	xor $1A
	ld [wSequence+2], a
	ldh [rBGP], a
	call DelayFrame
	call DelayFrame
	ret

.exit
	call IncreaseSequenceNumber
	ld a, $E4
	ldh [rBGP], a
	ret

PMJapaneseChara:: ;60b6
	call PrintPMJapaneseChara
	ld a, $10
	ld [wSequence+2], a
	call IncreaseSequenceNumber
	ld a, $01
	ldh [$FFDE], a
	ret

PMSubtitle:: ;60c6
	call PrintPMSubtitle
	ld a, $10
	ld [wSequence+2], a
	call IncreaseSequenceNumber
	ld a, $01
	ldh [$FFDE], a
	ret

Version:: ;60d6
	call PrintVersion
	ld a, $10
	ld [wSequence+2], a
	call IncreaseSequenceNumber
	ld a, $01
	ldh [$FFDE], a
	ret

CopyRight:: ;60e6
	call PrintCopyRight
	ld a, $10
	ld [wSequence+2], a
	call IncreaseSequenceNumber
	ld a, $01
	ldh [$FFDE], a
	ret

HoOh:: ;60f6
	call SetHoOh
	ld a, $10
	ld [wSequence+2], a
	call IncreaseSequenceNumber
	ld a, $01
	ldh [$FFDE], a
	ret

PressButtonInit:: ;6106
	ld hl, wSequence
	inc [hl]
	ld hl, wSequence+2
	ld de, DecodeNybble0Table - 3	; DecodeNybble0Table - 3 = $0C00
	ld [hl], e
	inc hl
	ld [hl], d
	ret	
	
TitleScreenInputAndTimeout:: ;6114
	ld hl, wSequence+2
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
	ld hl, hJoyState	; hJoyState = $FFA3
	ld a, [hl]
	and $46				; UP + B + SELECT brings you to the SRAM clear screen.
	cp $46
	jr z, .psbtn_sramclear
	ld a, [hl]
	and $04				; SELECT will bring you to the debug menu.
	jr nz, .psbtn_gotodebug
	ld a, [hl]
	and $09
	ret z
	
.psbtn_play
	ld a, $00			;MainMenu
	jr .psbtn_nextseq

.psbtn_gotodebug
if DEBUG 
	ld a, $01			;DebugMenu
	jr .psbtn_nextseq
else
	ret
endc

.psbtn_sramclear
	ld a, $02			;SRAMClearMenu
	
.psbtn_nextseq
	ld [wSequence + 1], a	; wSequence + 1 = $CB5F
	ld hl, wSequence	; wSequence = $CB5E
	set 7, [hl]
	ret

.psbtn_reset
	ld hl, wSequence	; wSequence = $CB5E
	inc [hl]
	xor a
	ld [wNextBGM], a ;c1a7
	ld [wNextBGM + 1], a ;c1a8
	ld hl, wSoundFade ;c1a5
	ld [hl], $08
	ret	
	
FadeMusicOut:: ;615c
	ld a, [wSoundFade] ;c1a5
	and a
	ret nz
	ld a, $03
	ld [wSequence + 1], a
	ld hl, wSequence
	set 7, [hl]
	ret	

SetLYOverrides:: ;616c
	ld hl, wLYOverrides
	ld c, $30
.setly_loop
	ldi [hl], a
	dec c
	jr nz, .setly_loop
	ret

PrintPMSubtitle:: ;6176
	;ld hl, _RAM_C31A_ ;c31a
	coord hl, 2, 6
	ld b, $0F
	ld a, $69
	jr LoadPrintArea ;6186

PrintVersion:: ;617f
	;ld hl, _RAM_C2B8_ ;c2b8
	coord hl, 4, 1
	ld b, $09
	ld a, $60
	
LoadPrintArea:: ;6186
	ldi [hl], a
	inc a
	dec b
	jr nz, LoadPrintArea
	ret

PrintPMJapaneseChara:: ;618C
	;ld hl, _RAM_C2D7_
	coord hl, 15, 2
	ld a, $BA
	ld bc, $0404
	jr PrintBoxArea

PrintPokemonLogo:: ;6196
	;ld hl, _RAM_C2EB_
	coord hl, 15, 3
	ld [hl], $B8
	;ld hl, _RAM_C2FF_
	coord hl, 15, 4
	ld [hl], $B9
	;ld hl, _RAM_C2C9_
	coord hl, 1, 2
	ld a, $80
	ld bc, $0E04
	
PrintBoxArea::
	ld de, $0014
	push bc
	push hl
.xloop
	ldi [hl], a
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
	;ld hl, _RAM_C3F7_
	coord hl, 3, 17
	ld a, $41
	ld b, $0D
.copyright_loop
	ldi [hl], a
	inc a
	dec b
	jr nz, .copyright_loop
	ret
	
SRAMClearMenu:: ;61c6
	call ClearTileMap
	call GetMemSGBLayout
	call LoadFont
	call LoadFontExtra
	ld hl, Window_SRAMClearPOS
	call PrintStringIntoMessageWindow ;e70
	ld hl, Text_SRAMClearChoice
	call SetNormalSelectMenuText ;1d50
	call DrawNormalSelectMenu ;1d87
	jp c, Init
	ld a, [wMenuCursorY]	; wMenuCursorY = $CC2A
	cp $01
	jp z, Init
	ld hl, InitAllSRAMBanks	; 143B6
	ld a, $05
	call FarCall_hl
	jp Init

Window_SRAMClearPOS:: ;617f
db $00, $BD, $3D, $C3, $C9, $7F, $8D, $E3, $1B, $12, $E3, $8F, $83, $D8, $80, $DD
db $4F, $87, $D8, $80, $7F, $BC, $CF, $BD, $B6, $E6, $57

Text_SRAMClearChoice:: ;6212
db $00, $07, $0E, $0B, $13, $1A, $62, $01, $C0, $02, $B2, $B2, $B4, $50, $CA, $B2
db $50	

IntroCopyrightInfo:: ;6223
	call ClearTileMap
	call LoadFontExtra
	ld de, $47CF
	ld hl, $9600
	ld bc, $0419	;bank 4 * 0x100 + 0x19?
	call CopyVideoData
	;ld hl, _RAM_C331_
	coord hl, 5, 7
	ld de, IntroCopyrightInfo_Text
	jp PlaceString

IntroCopyrightInfo_Text:: ;623e
db $60, $61, $62, $63, $6D, $6E, $6F, $70, $71, $72, $4E 			; "(C)1997 Nintendo\n"
db $60, $61, $62, $63, $73, $74, $75, $76, $77, $78, $6B, $6C, $4E 	; "(C)1997 Creatures Inc.\n"
db $60, $61, $62, $63, $64, $65, $66, $67, $68, $69, $6A, $6B, $6C, $50 ; "(C)1997 GAME FREAK Inc.{EOL}"	

SetHoOh:: ;6264
	;ld hl, _RAM_C35B_
	coord hl, 7, 9
	ld de, $000D
	ld a, $00
	ld b, $07
.hoohloop
	ld c, $07
.hoohloop2
	ldi [hl], a
	inc a
	dec c
	jr nz, .hoohloop2
	add hl, de
	dec b
	jr nz, .hoohloop
	ret

; unused code, looks like it sets the font type for the logo?
SetTitleFont::	;627a
	ld de, $8800
	ld hl, TitleScreenLogoGFX
	ld bc, $0820
	ld a, $04
	jp FarCopyDataDouble ;0d3e

; Sets the type of art that will be displayed on the title screen
; depending on wOpeningType.
SetTitleArt:: ;6288
	ld hl, wOpeningType ;cc38
	ld a, [hl]
	xor $01
	ld [hl], a
	jr nz, .flame
	
.note
	ld hl, TitleNotesGFX
	jr SetTitleArtNext

.flame
	ld hl, TitleFireGFX
SetTitleArtNext::
	ld de, $8000
	ld c, $80
.loop
	ldi a, [hl]
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
	

GameInit:: ; 62a5
	call ClearWindowData
	ld a, $23
	ld [wce5f], a
	jp IntroSequence