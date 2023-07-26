INCLUDE "constants.asm"

SECTION "home/text.asm", ROM0

ClearBox::
; Fill a c*b box at hl with blank tiles.
	ld a, "　"
	; fallthrough

FillBoxWithByte::
	ld de, SCREEN_WIDTH
.asm_0e1d:
	push hl
	push bc
.asm_0e1f:
	ld [hli], a
	dec c
	jr nz, .asm_0e1f
	pop bc
	pop hl
	add hl, de
	dec b
	jr nz, .asm_0e1d
	ret

ClearTileMap::
; Fill wTileMap with blank tiles.

	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
	ld a, "　"
	call ByteFill
	ldh a, [rLCDC]
	bit 7, a
	ret z
	jp WaitBGMap

DrawTextBox::

	; Top
	push hl
	ld a, "┌"
	ld [hli], a
	inc a ; "─"
	call .PlaceChars
	inc a ; "┐"
	ld [hl], a
	pop hl

	; Middle
	ld de, SCREEN_WIDTH
	add hl, de
.row
	push hl
	ld a, "│"
	ld [hli], a
	ld a, "　"
	call .PlaceChars
	ld [hl], "│"
	pop hl

	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .row

	; Bottom
	ld a, "└"
	ld [hli], a
	ld a, "─"
	call .PlaceChars
	ld [hl], "┘"

	ret

.PlaceChars:
; Place char a c times.
	ld d, c
.loop
	ld [hli], a
	dec d
	jr nz, .loop
	ret

PrintText::
	push hl
	hlcoord TEXTBOX_X, TEXTBOX_Y
	ld b, TEXTBOX_INNERH
	ld c, TEXTBOX_INNERW
	call DrawTextBox
	call UpdateSprites
	call WaitBGMap
	pop hl
PrintTextBoxText::
	bccoord TEXTBOX_INNERX, TEXTBOX_INNERY
	call TextCommandProcessor
	ret

SpeechTextBox::
; Standard textbox.
	hlcoord TEXTBOX_X, TEXTBOX_Y
	ld b, TEXTBOX_INNERH
	ld c, TEXTBOX_INNERW
	jp DrawTextBox

PlaceString::
	push hl
PlaceNextChar::
	ld a, [de]
	cp "@"
	jr nz, CheckDict
	ld b, h
	ld c, l
	pop hl
	ret

CheckDict::
MACRO dict
if \1 == 0
	and a
else
	cp \1
endc
	jp z, \2
ENDM

	cp "<NEXT>"
	jr nz, .asm_0eaa
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	push hl
	jp NextChar

.asm_0eaa:
	cp "<LINE>"
	jr nz, .asm_0eb6
	pop hl
	hlcoord 1, 16
	push hl
	jp NextChar

.asm_0eb6:
	dict "<NULL>", NullChar
	dict "<SCROLL>", _ContTextNoPause
	dict "<_CONT>", _ContText
	dict "<PARA>", Paragraph
	dict "<MOM>", PrintMomsName
	dict "<PLAYER>", PrintPlayerName
	dict "<RIVAL>", PrintRivalName
	dict "#", PlacePOKe
	dict "<PC>", PCChar
	dict "<ROCKET>", RocketChar
	dict "<TM>", TMChar
	dict "<TRAINER>", TrainerChar
	dict "<CONT>", ContText
	dict "<⋯⋯>", SixDotsChar
	dict "<DONE>", DoneText
	dict "<PROMPT>", PromptText
	dict "<GA>", GaCharacter
	dict "<DEXEND>", PlaceDexEnd
	dict "<TARGET>", PlaceMoveTargetsName
	dict "<USER>", PlaceMoveUsersName

	cp "ﾟ"
	jr z, .diacritic
	cp "ﾞ"
	jr nz, .not_diacritic
.diacritic:
	push hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	pop hl
	jr NextChar

.not_diacritic:
	cp FIRST_REGULAR_TEXT_CHAR
	jr nc, .place
	cp "パ"
	jr nc, .handakuten
	cp FIRST_HIRAGANA_DAKUTEN_CHAR
	jr nc, .hiragana_dakuten
	add "カ" - "ガ"
	jr .katakana_dakuten

.hiragana_dakuten:
	add "か" - "が"
.katakana_dakuten:
	push af
	ld a, "ﾞ"
	push hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	pop hl
	pop af
	jr .place

.handakuten:
	cp "ぱ"
	jr nc, .hiragana_handakuten
	add "ハ" - "パ"
	jr .katakana_handakuten

.hiragana_handakuten:
	add "は" - "ぱ"
.katakana_handakuten:
	push af
	ld a, "ﾟ"
	push hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	pop hl
	pop af
.place:
	ld [hli], a
	call PrintLetterDelay
NextChar::
	inc de
	jp PlaceNextChar

NullChar:: ; unused
	ld b, h
	ld c, l
	pop hl
	; A "<NULL>" character in a printed string
	; displays an error message with the current
	; value of hEventID in decimal format.
	; This is a debugging leftover.
	ld de, .Text
	dec de
	ret

.Text:
	deciram hEventID, 1, 2
	text "エラー"
	done

MACRO print_name
	push de
	ld de, \1
	jr PlaceCommandCharacter
ENDM

PrintMomsName::   print_name wMomsName
PrintPlayerName:: print_name wPlayerName
PrintRivalName::  print_name wRivalName

TrainerChar:: print_name TrainerCharText
TMChar::      print_name TMCharText
PCChar::      print_name PCCharText
RocketChar::  print_name RocketCharText
PlacePOKe::   print_name POKeCharText
SixDotsChar:: print_name SixDotsCharText
GaCharacter:: print_name GaCharacterTExt

PlaceMoveTargetsName::
	ldh a, [hBattleTurn]
	xor $1
	jr asm_0fbb

PlaceMoveUsersName::
	ldh a, [hBattleTurn]
asm_0fbb:
	push de
	and a
	jr nz, .asm_0fc4
	ld de, wEnemyMonNickname
	jr PlaceCommandCharacter

.asm_0fc4:
	ld de, EnemyText
	call PlaceString
	ld h, b
	ld l, c
	ld de, wBattleMonNickname
PlaceCommandCharacter:
	call PlaceString
	ld h, b
	ld l, c
	pop de
	inc de
	jp PlaceNextChar

TMCharText::      db "わざマシン@"
TrainerCharText:: db "トレーナー@"
PCCharText::      db "パソコン@"
RocketCharText::  db "ロケットだん@"
POKeCharText::    db "ポケモン@"
SixDotsCharText:: db "⋯⋯@"
EnemyText::       db "てきの　@"
GaCharacterTExt:: db "が　@"

ContText::
	push de
	ld b, h
	ld c, l
	ld hl, .Text
	call TextCommandProcessor
	ld h, b
	ld l, c
	pop de
	inc de
	jp PlaceNextChar

.Text:
	text "<_CONT>@"
	db "@"

PlaceDexEnd::
	ld [hl], "。"
	pop hl
	ret

PromptText::
	ld a, [wLinkMode]
	cp $3
	jp z, Function1026
	ld a, "▼"
	ldcoord_a 18, 17
Function1026::
	call ProtectedWaitBGMap
	call ButtonSound
	ld a, "─"
	ldcoord_a 18, 17
DoneText::
	pop hl
	ld de, .Text
	dec de
	ret

.Text::
	db "@"

Paragraph::
	push de
	ld a, "▼"
	ldcoord_a 18, 17
	call ProtectedWaitBGMap
	call ButtonSound
	hlcoord 1, 13
	lb bc, 4, 18
	call ClearBox
	ld a, "─"
	ldcoord_a 18, 17
	ld c, 20
	call DelayFrames
	pop de
	hlcoord 1, 14
	jp NextChar

_ContText::
	ld a, "▼"
	ldcoord_a 18, 17
	call ProtectedWaitBGMap
	push de
	call ButtonSound
	pop de
	ld a, "─"
	ldcoord_a 18, 17
_ContTextNoPause::
	push de
	call ScrollTextUpOneLine
	call ScrollTextUpOneLine
	hlcoord 1, 16
	pop de
	jp NextChar

ScrollTextUpOneLine::
; move both rows of text in the normal text box up one row
; always called twice in a row
; first time, copy the two rows of text to the "in between" rows that are usually emtpy
; second time, copy the bottom row of text into the top row of text
	coord hl, TEXTBOX_X, TEXTBOX_INNERY     ; top row of text
	coord de, TEXTBOX_X, TEXTBOX_INNERY - 1 ; empty line above text
	ld b, TEXTBOX_WIDTH * 3
.copyText
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copyText
	coord hl, TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	ld a, "　"
	ld b, TEXTBOX_INNERW
.clearText
	ld [hli], a
	dec b
	jr nz, .clearText
	ld b, $05           ; wait five frames
.waitFrame
	call DelayFrame
	dec b
	jr nz, .waitFrame
	ret

ProtectedWaitBGMap::
	push bc
	call WaitBGMap
	pop bc
	ret

TextCommandProcessor::
; Process a string of text commands
; at hl and write text to bc
	ld a, [wTextBoxFlags]
	push af
	set 1, a
	ld [wTextBoxFlags], a
	ld a, c
	ld [wTextDest], a
	ld a, b
	ld [wTextDest + 1], a
	; fall through

NextTextCommand::
	ld a, [hli]
	cp "@" ; terminator
	jr nz, .doTextCommand
	pop af
	ld [wTextBoxFlags], a
	ret
.doTextCommand
	push hl
	ld hl, TextCommands
	push bc
	add a
	ld b, $00
	ld c, a
	add hl, bc
	pop bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Text_TX_BOX::
; TX_BOX
; draw a box
; little endian
; [$04][addr][height][width]
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	push hl
	ld h, d
	ld l, e
	call DrawTextBox
	pop hl
	jr NextTextCommand

Text_TX::
; TX
; write text until "@"
; [$00]["...@"]
	pop hl
	ld d, h
	ld e, l
	ld h, b
	ld l, c
	call PlaceString
	ld h, d
	ld l, e
	inc hl
	jr NextTextCommand

Text_TX_RAM::
; text_from_ram
; write text from a ram address
; little endian
; [$01][addr]
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
	call PlaceString
	pop hl
	jr NextTextCommand

Text_TX_BCD::
; TX_BCD
; write bcd from address, typically ram
; [$02][addr][flags]
; flags: see PrintBCDNumber
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld c, a
	call PrintBCDNumber
	ld b, h
	ld c, l
	pop hl
	jr NextTextCommand

Text_TX_MOVE::
; TX_MOVE
; move to a new tile
; [$03][addr]
	pop hl
	ld a, [hli]
	ld [wTextDest], a
	ld c, a
	ld a, [hli]
	ld [wTextDest + 1], a
	ld b, a
	jp NextTextCommand

Text_TX_LOW::
; TX_LOW
; write text at (1,16)
; [$05]
	pop hl
	coord bc, TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	jp NextTextCommand

Text_WAIT_BUTTON::
; TX_WAITBUTTON
; wait for button press
; show arrow
; [06]
	ld a, [wLinkMode]
	cp $03
	jp z, Text_TX_LINK_WAIT_BUTTON
	ld a, "▼"
	ldcoord_a TEXTBOX_WIDTH - 2, TEXTBOX_Y + TEXTBOX_HEIGHT - 1
	push bc
	call ButtonSound
	pop bc
	ld a, "─"
	ldcoord_a TEXTBOX_WIDTH - 2, TEXTBOX_Y + TEXTBOX_HEIGHT - 1
	pop hl
	jp NextTextCommand

Text_TX_SCROLL::
; TX_SCROLL
; pushes text up two lines and sets the BC cursor to the border tile
; below the first character column of the text box.
; [07]
	ld a, "─"
	ldcoord_a TEXTBOX_WIDTH - 2, TEXTBOX_Y + TEXTBOX_HEIGHT - 1
	call ScrollTextUpOneLine
	call ScrollTextUpOneLine
	pop hl
	coord bc, TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	jp NextTextCommand

Text_START_ASM::
; TX_ASM
; Executes code following this command.
; Text processing is resumed upon returning.
; [08][asm...ret]
	pop hl
	ld de, NextTextCommand
	push de
	jp hl

Text_TX_NUM::
; TX_NUM
; [$09][addr][hi:bytes lo:digits]
	pop hl
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	push hl
	ld h, b
	ld l, c
	ld b, a
	and $0f
	ld c, a
	ld a, b
	and $f0
	swap a
	set 6, a
	ld b, a
	call PrintNumber
	ld b, h
	ld c, l
	pop hl
	jp NextTextCommand

Text_TX_EXIT:
; TX_EXIT
; [$0A]
	push bc
	call GetJoypad
	ldh a, [hJoyState]
	and (A_BUTTON | B_BUTTON)
	jr nz, .done
	ld c, 30
	call DelayFrames
.done
	pop bc
	pop hl
	jp NextTextCommand

Text_PlaySound::
; Text_PlaySound
; [0B|0E..13] Play Sound Effects
; [14..16]    Play Pokémon Cries
	pop hl
	push bc
	dec hl
	ld a, [hli]
	ld b, a
	push hl
	ld hl, .soundTable
.loop
	ld a, [hli]
	cp b
	jr z, .found
	inc hl
	inc hl
	jr .loop
.found
	cp $14
	jr z, .playCry
	cp $15
	jr z, .playCry
	cp $16
	jr z, .playCry
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call PlaySFX
	call WaitSFX
	pop de
	pop hl
	pop bc
	jp NextTextCommand
.playCry
	push de
	ld e, [hl]
	inc hl
	ld d, [hl]
	call PlayCry
	pop de
	pop hl
	pop bc
	jp NextTextCommand

.soundTable:
	dbw TX_SOUND_0B, SFX_GET_ITEM_RG
	dbw TX_SOUND_12, SFX_UNUSED_FANFARE_3
	dbw TX_SOUND_0E, SFX_LEVEL_UP_RG
	dbw TX_SOUND_0F, SFX_EVOLUTION_COMPLETE_RG
	dbw TX_SOUND_10, SFX_GET_KEY_ITEM_RG
	dbw TX_SOUND_11, SFX_UNUSED_FANFARE_2
	dbw TX_SOUND_13, SFX_POKEDEX_REGISTRATION
	dbw TX_CRY_14,   MON_NIDORINA
	dbw TX_CRY_15,   MON_PIDGEOT
	dbw TX_CRY_16,   MON_DEWGONG

Text_TX_DOTS:
	pop hl
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
.loop
	ld a, "⋯"
	ld [hli], a
	push de
	call GetJoypad
	pop de
	ldh a, [hJoyState]
	and (A_BUTTON | B_BUTTON)
	jr nz, .next
	ld c, 10
	call DelayFrames
.next
	dec d
	jr nz, .loop
	ld b, h
	ld c, l
	pop hl
	jp NextTextCommand

Text_TX_LINK_WAIT_BUTTON::
	push bc
	call ButtonSound
	pop bc
	pop hl
	jp NextTextCommand

TextCommands::
	dw Text_TX
	dw Text_TX_RAM
	dw Text_TX_BCD
	dw Text_TX_MOVE
	dw Text_TX_BOX
	dw Text_TX_LOW
	dw Text_WAIT_BUTTON
	dw Text_TX_SCROLL
	dw Text_START_ASM
	dw Text_TX_NUM
	dw Text_TX_EXIT
	dw Text_PlaySound
	dw Text_TX_DOTS
	dw Text_TX_LINK_WAIT_BUTTON
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
	dw Text_PlaySound
