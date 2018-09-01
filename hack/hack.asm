INCLUDE "constants.asm"

; To call hacks, use the "hack" macro (patch_constants.asm).

; Move elsewhere if $DA00 turns out to be used.
SECTION "Patch WRAM", WRAM0[$DA00]
wPatchWRAM:

; RAM values here...

wPatchWRAMEnd:

SECTION "Hack interrupt vector", ROM0[HackInterrupt]
	; Save A for RunHack.
	ld [wPredefID], a

	di
	; Save bank to be able to switch back.
	ldh a, [hROMBank]
	push af

	ld a, BANK(RunHack)
	call Bankswitch
	ei

	call RunHack

	di
	; Juggly way to both pop the previous bank off the stack and preserve AF.
	push af
	add sp, 1 * 2
	pop af
	add sp, -2 * 2
	call Bankswitch
	pop af
	inc sp
	inc sp

	reti

SECTION "Patch ROM", ROMX[$4000], BANK[$28]
; [wPredefID]: Index of hack function to run.
RunHack:
	; Save HL for later.
	ld a, h
	ld [wPredefHL], a
	ld a, l
	ld [wPredefHL + 1], a

	; Calculate offset in jump table.
	push bc
	ld hl, HackTable
	ld b, 0
	ld a, [wPredefID] ; Get back old A.
	ld c, a
	add hl, bc
	add hl, bc

	; Put hack address in HL.
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	ld h, b
	ld l, c
	pop bc

	push hl
	ld a, [wPredefHL]
	ld h, a
	ld a, [wPredefHL + 1]
	ld l, a
	ret ; Jump to HL.

hack_entry: MACRO
Hack\1Entry:
	dw Hack\1
ENDM

HackTable:
	hack_entry InitializeNewGameWRAM

HackInitializeNewGameWRAM:
	; Avoid clearing hack WRAM.

	xor a

	ld hl, wPlayerName
	ld bc, wPatchWRAM - wPlayerName
	call ByteFill

	ld hl, wPatchWRAMEnd
	ld bc, (wPlayerName + $1164) - wPatchWRAMEnd
	call ByteFill

	ret
