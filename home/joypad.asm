INCLUDE "constants.asm"


SECTION "home/joypad.asm", ROM0

ClearJoypad::
	xor a
; Pressed this frame (delta)
	ldh [hJoyDown], a
; Currently pressed
	ldh [hJoyState], a
	ret


Joypad::
; Read the joypad register and translate it to something more
; workable for use in-game. There are 8 buttons, so we can use
; one byte to contain all player input.

; Updates:

; hJoypadUp: released this frame (delta)
; hJoypadDown: pressed this frame (delta)
; hJoypadState: currently pressed
; hJoypadSum: pressed so far
	ld a, [$d4ab]
	and $d0
	ret nz
	ld a, 1 << 5 ; select direction keys
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	cpl
	and $0f
	swap a
	ld b, a
	ld a, 1 << 4 ; select button keys
	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	cpl
	and $0f
	or b
	ld b, a
	ld a, (1 << 5 | 1 << 4) ; port reset
	ldh [rJOYP], a
	ldh a, [hJoypadState]
	ld e, a
	xor b
	ld d, a
	and e
	ldh [hJoypadUp], a
	ld a, d
	and b
	ldh [hJoypadDown], a
	ld c, a
	ldh a, [hJoypadSum]
	or c
	ldh [hJoypadSum], a
	ld a, b
	ldh [hJoypadState], a
	ldh [hJoypadState2], a
	; Soft-Reset by holding A+B+SELECT+START
	and (A_BUTTON | B_BUTTON | SELECT | START)
	cp (A_BUTTON | B_BUTTON | SELECT | START)
	jp z, Reset
	ret

GetJoypad::
; Update mirror joypad input from hJoypadState (real input)

; hJoyReleased, hJoyDown and hJoyState are synchronized
; copies of their hJoypad* counterparts.

; bit 0 A
;     1 B
;     2 SELECT
;     3 START
;     4 RIGHT
;     5 LEFT
;     6 UP
;     7 DOWN
	push af
	push hl
	push de
	ld hl, wJoypadFlags
	set 6, [hl]           ; mutex
	ld hl, hJoypadDown
	ld de, hJoyDown
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	ld hl, wJoypadFlags
	res 6, [hl]
	pop de
	pop hl
	pop af
	ret

JoyTitleScreenInput::
; Check if any of the following conditions
; is met for c frames
; - B, Select and Up keys are pressed in same frame
; - A is pressed
; - START is pressed
;
; Inputs: c - number of frames to check for
; Return: carry set if condition met, else reset
.loop
	call DelayFrame
	push bc
	call GetJoypadDebounced
	pop bc
	ldh a, [hJoyState]
	cp (D_UP | SELECT | B_BUTTON)
	jr z, .done
	ldh a, [hJoySum]
	and (START | A_BUTTON)
	jr nz, .done
	dec c
	jr nz, .loop
	and a
	ret
.done
	scf
	ret

GetJoypadDebounced::
; Update hJoySum joypad input from either hJoyDown or
; hJoyState depending on hJoyDebounceSrc.
; hJoyState is only updated every 5 frames and
; the update is delayed by 15 frames after any button
; press.
	call GetJoypad
	ldh a, [hJoyDebounceSrc]
	and a
	ldh a, [hJoyDown]
	jr z, .joyDownSrc
.joyStateSrc
	ldh a, [hJoyState]
.joyDownSrc
	ldh [hJoySum], a
	ldh a, [hJoyDown]
	and a
	jr z, .sampleAfterPress
	ld a, $0f
	ld [wVBlankJoyFrameCounter], a
	ret
.sampleAfterPress
	ld a, [wVBlankJoyFrameCounter]
	and a
	jr z, .sampleRegular
	xor a
	ldh [hJoySum], a
	ret
.sampleRegular
	ld a, $05
	ld [wVBlankJoyFrameCounter], a
	ret

TextboxWaitPressAorB_BlinkCursor:
; Show a blinking cursor in the lower right-hand
; corner of a textbox and wait until A or B is
; pressed.
;
; CAUTION: The cursor has to be shown when calling
; this function or no cursor will be shown at all.
; Waiting on button presses is unaffected by this.
	ldh a, [hSpriteWidth]  ; hTextBoxCursorBlinkInterval is shared with
	push af                ; hSpriteWidth and hSpriteHeight, so we need
	ldh a, [hSpriteHeight] ; to back them up
	push af
	xor a
	ldh [hTextBoxCursorBlinkInterval], a
	ld a, $06
	ldh [hTextBoxCursorBlinkInterval + 1], a ; initially, $600 iterations
.loop
	push hl
	coord hl, (TEXTBOX_WIDTH - 2), (TEXTBOX_Y + TEXTBOX_HEIGHT - 1)
	call TextboxBlinkCursor
	pop hl
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and (A_BUTTON | B_BUTTON)
	jr z, .loop
	pop af
	ldh [hSpriteHeight], a
	pop af
	ldh [hSpriteWidth], a
	ret

ButtonSound::
	ld a, [wLinkMode]
	cp $03
	jr z, .link
	call WaitAorB_BlinkCursor
	push de
	ld de, $5
	call PlaySFX
	pop de
	ret
.link
	ld c, $41
	jp DelayFrames

WaitAorB_BlinkCursor::
.loop
	call BlinkCursor
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and (A_BUTTON | B_BUTTON)
	ret nz
	call UpdateTime
	call UpdateTimeOfDayPalettes
	ld a, $01
	ldh [hBGMapMode], a
	call DelayFrame
	jr .loop

BlinkCursor:
; Show a blinking cursor in the lower right-hand
; corner of the screen
; Will toggle between cursor and blank every
; 16 frames.
	ldh a, [hVBlankCounter]
	and $10
	jr z, .cursor_off
	ld a, "▼"
	jr .save_cursor_state
.cursor_off
	ld a, "　"
.save_cursor_state
	ldcoord_a (SCREEN_WIDTH - 2), (SCREEN_HEIGHT - 1)
	ret

TextboxBlinkCursor::
; Show a blinking cursor at the specified position
; that toggles between down arrow and horizontal textbox
; frame tile.
; hl - address of cursor
; hTextBoxCursorBlinkInterval - initial delay between toggling
;                               subsequent delays will be $6FF
;                               calls of this function
; CAUTION: if the cursor is not shown initially, even initial
; hTextBoxCursorBlinkInterval values will cause no cursor
; to be shown at all.
	ld a, [hl]
	ld b, a
	ld a, "▼"
	cp b
	jr nz, .showCursorCountdown
.showTextboxFrameCountdown
	ldh a, [hTextBoxCursorBlinkInterval]
	dec a
	ldh [hTextBoxCursorBlinkInterval], a
	ret nz
	ldh a, [hTextBoxCursorBlinkInterval + 1]
	dec a
	ldh [hTextBoxCursorBlinkInterval + 1], a
	ret nz
	ld a, "─"
	ld [hl], a
	ld a, $ff
	ldh [hTextBoxCursorBlinkInterval], a
	ld a, $06
	ldh [hTextBoxCursorBlinkInterval + 1], a ; reset to $6FF iterations
	ret
.showCursorCountdown
	ldh a, [hTextBoxCursorBlinkInterval]
	and a
	ret z
	dec a
	ldh [hTextBoxCursorBlinkInterval], a
	ret nz
	dec a
	ldh [hTextBoxCursorBlinkInterval], a
	ldh a, [hTextBoxCursorBlinkInterval + 1]
	dec a
	ldh [hTextBoxCursorBlinkInterval + 1], a
	ret nz
	ld a, $06
	ldh [hTextBoxCursorBlinkInterval + 1], a ; reset to $6FF iterations
	ld a, "▼"
	ld [hl], a
	ret
