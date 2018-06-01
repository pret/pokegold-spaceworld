INCLUDE "constants.asm"

SECTION "Text Commands", ROM0[$107e]

ScrollTextUpOneLine:: ; 107e (0:107e)
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

ProtectedWaitBGMap:: ; 10a0 (0:10a0)
	push bc
	call WaitBGMap
	pop bc
	ret

TextCommandProcessor:: ; 10a6 (0:10a6)
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
    
NextTextCommand:: ; 10b7 (0:10b7)
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

Text_TX_BOX:: ; 10d0 (0:10d0)
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
    
Text_TX:: ; 10e2 (0:10e2)
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

Text_TX_RAM:: ; 10ef (0:10ef)
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

Text_TX_BCD:: ; 10fd (0:10fd)
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

Text_TX_MOVE:: ; 110f (0:110f)
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

Text_TX_LOW:: ; 111d (0:111d)
; TX_LOW
; write text at (1,16)
; [$05]
	pop hl
	coord bc, TEXTBOX_INNERX, TEXTBOX_INNERY + 2
	jp NextTextCommand
; 0x1124

Text_WAIT_BUTTON:: ; 1124 (0:1124)
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

Text_TX_SCROLL:: ; 113f (0:113f)
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

Text_START_ASM:: ; 1151 (0:1151)
; TX_ASM
; Executes code following this command.
; Text processing is resumed upon returning.
; [08][asm...ret]
	pop hl
	ld de, NextTextCommand
	push de
	jp hl

Text_TX_NUM:: ; 1157 (0:1157)
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
; 0x1175

Text_TX_EXIT: ; 1175 (0:1175)
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
; 0x1189

Text_PlaySound:: ; 1189 (0:1189)
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
	dbw TX_SOUND_0B, $0063
	dbw TX_SOUND_12, $006B
	dbw TX_SOUND_0E, $0066
	dbw TX_SOUND_0F, $0067
	dbw TX_SOUND_10, $0068
	dbw TX_SOUND_11, $0069
	dbw TX_SOUND_13, $0027
	dbw TX_CRY_14,   MON_NIDORINA ; or MON_LEAFY?
	dbw TX_CRY_15,   MON_PIGEOT
	dbw TX_CRY_16,   MON_JUGON

Text_TX_DOTS: ; 11e1 (0:11e1)
	pop hl
	ld a, [hli]
	ld d, a
	push hl
	ld h, b
	ld l, c
.loop
	ld a, "…"
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
	
Text_TX_LINK_WAIT_BUTTON:: ; 1203 (0:1203)
	push bc
	call ButtonSound
	pop bc
	pop hl
	jp NextTextCommand
; 0x120c

TextCommands:: ; 120c
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
