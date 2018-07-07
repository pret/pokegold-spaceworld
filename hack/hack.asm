INCLUDE "constants.asm"

; To call hacks, use the "hack" macro (patch_constants.asm).

; Move elsewhere if $DA00 turns out to be used.
SECTION "Patch WRAM", WRAM0[$DA00]
wPatchWRAM:
wHackOldBank: db
wTempA: db
wTempL: db
wTempH: db
wWorked: db
wPatchWRAMEnd:

SECTION "Hack interrupt vector", ROM0[HackInterrupt]
    push af
    ldh a, [hROMBank]
    ld [wHackOldBank], a

    ld a, BANK(RunHack)
	call Bankswitch

    pop af
    call RunHack

    push af
    ld a, [wHackOldBank]
    call Bankswitch
    pop af

    ret

SECTION "Patch ROM", ROMX[$4000], BANK[$28]
; A: Index of hack function to run.
RunHack:
	; Save A and HL for later.
	ld [wTempA], a
	ld a, h
	ld [wTempH], a
	ld a, l
	ld [wTempL], a

	; Calculate offset in jump table.
	push bc
	ld hl, HackTable
	ld b, 0
	ld a, [wTempA] ; Get back old A.
	ld c, a
	add hl, bc
	add hl, bc

	; Put hack address in HL.
	ld a, [hli]
	ld c, a
	ld a, [hl]
	ld b, a
	push bc
	pop hl
	pop bc

	push hl
	ld a, [wTempH]
	ld h, a
	ld a, [wTempL]
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
