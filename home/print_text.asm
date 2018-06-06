include "constants.asm"

if DEBUG
SECTION "Print Letter Delay", ROM0[$33a3]
else
SECTION "Print Letter Delay", ROM0[$3367]
endc

PrintLetterDelay:: ; 33a3 (0:33a3)
	ld a, [wce5f]
	bit 4, a
	ret nz
	ld a, [wTextBoxFlags]
	bit 1, a
	ret z
	push hl
	push de
	push bc
	ld a, [wTextBoxFlags]
	bit 0, a
	jr z, .waitOneFrame
	ld a, [wce5f]
	and $07
	jr .initFrameCnt
.waitOneFrame
	ld a, $01
.initFrameCnt
	ld [wVBlankJoyFrameCounter], a
.checkButtons
	call GetJoypad
	ldh a, [hJoyState]
.checkAButton
	bit 0, a ; is the A button pressed?
	jr z, .checkBButton
	jr .endWait
.checkBButton
	bit 1, a ; is the B button pressed?
	jr z, .buttonsNotPressed
.endWait
	call DelayFrame
	jr .done
.buttonsNotPressed ; if neither A nor B is pressed
	ld a, [wVBlankJoyFrameCounter]
	and a
	jr nz, .checkButtons
.done
	pop bc
	pop de
	pop hl
	ret
; 0x33e3

CopyDataUntil:: ; 33e3
; Copy [hl .. bc) to de.

; In other words, the source data is
; from hl up to but not including bc,
; and the destination is de.

.asm_33e3: ; 00:33e3
	ld a, [hli]
	ld [de], a
	inc de
	ld a, h
	cp b
	jr nz, .asm_33e3
	ld a, l
	cp c
	jr nz, .asm_33e3
	ret
