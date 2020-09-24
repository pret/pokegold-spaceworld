INCLUDE "constants.asm"


SECTION "home/names.asm@Names", ROM0

NamesPointers::
; entries correspond to GetName constants (see constants/text_constants.asm)
	dba PokemonNames       ; MON_NAME (not used; jumps to GetPokemonName)
	dba MoveNames          ; MOVE_NAME
	dbw 0, 0               ; DUMMY_NAME
	dba ItemNames          ; ITEM_NAME
	dbw $00, wPartyMonOT   ; PARTY_OT_NAME
	dbw $00, wOTPartyMonOT ; ENEMY_OT_NAME
	dba TrainerClassNames  ; TRAINER_NAME
	dbw $04, $5677         ; MOVE_DESC_NAME_BROKEN (wrong bank..?)

GetName::
; Return name wCurSpecies from name list wNamedObjectTypeBuffer in wStringBuffer1.

	ldh a, [hROMBank]
	push af
	push hl
	push bc
	push de

	ld a, [wNamedObjectTypeBuffer]
	cp MON_NAME
	jr nz, .not_mon_name

	ld a, [wCurSpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, MON_NAME_LENGTH
	add hl, de
	ld e, l
	ld d, h
	jr .done

.not_mon_name
	ld a, [wNamedObjectTypeBuffer]
	dec a
	ld e, a
	ld d, 0
	ld hl, NamesPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	call Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wCurSpecies]
	dec a
	call GetNthString

	ld de, wStringBuffer1
	ld bc, ITEM_NAME_LENGTH
	call CopyBytes

.done
	ld a, e
	ld [wcd72], a
	ld a, d
	ld [wcd72 + 1], a

	pop de
	pop bc
	pop hl
	pop af
	call Bankswitch
	ret

GetNthString::
; Return the address of the ath string starting from hl.
	and a
	ret z
	push bc
	ld b, a
	ld c, "@"
.readChar:
	ld a, [hli]
	cp c
	jr nz, .readChar
	dec b
	jr nz, .readChar
	pop bc
	ret

GetPokemonName:
; Get Pokemon name wNamedObjectIndexBuffer.

	ldh a, [hROMBank]
	push af
	push hl
	ld a, BANK(PokemonNames)
	call Bankswitch

	; Each name is five characters
	ld a, [wNamedObjectIndexBuffer]
	dec a
	ld hl, PokemonNames
	ld e, a
	ld d, 0
rept 5
	add hl, de
endr

	; Terminator
	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH - 1
	call CopyBytes
	ld hl, wStringBuffer1 + MON_NAME_LENGTH - 1
	ld [hl], "@"
	pop de
	pop hl
	pop af
	call Bankswitch
	ret

GetItemName::
; given an item ID at [wNamedObjectIndexBuffer], store the name of the item into a string
; starting at wStringBuffer1
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	cp ITEM_HM01_RED
	jr nc, .machine

	ld [wCurSpecies], a
	ld a, ITEM_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	jr .finish

.machine
	call GetMachineName
.finish
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

GetMachineName::
; copies the name of the TM/HM in [wNamedObjectIndexBuffer] to wStringBuffer1
	push hl
	push de
	push bc
	ld a, [wNamedObjectIndexBuffer]
	push af
	cp ITEM_TM01_RED
	jr nc, .write_tm
; if HM, then write "HM" and add 5 to the item ID, so we can reuse the
; TM printing code
	add 5
	ld [wNamedObjectIndexBuffer], a

	ld hl, .HMText
	ld bc, .HMTextEnd - .HMText
	jr .write_machine_prefix

.write_tm
	ld hl, .TMText
	ld bc, .TMTextEnd - .TMText

.write_machine_prefix
	ld de, wStringBuffer1
	call CopyBytes
; now get the machine number and convert it to text
	ld a, [wNamedObjectIndexBuffer]
	sub ITEM_TM01_RED - 1
	ld b, "０"
.first_digit
	sub 10
	jr c, .second_digit
	inc b
	jr .first_digit
.second_digit
	add 10
	push af
	ld a, b
	ld [de], a
	inc de
	pop af
	ld b, "０"
	add b
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
	pop af
	ld [wNamedObjectIndexBuffer], a
	pop bc
	pop de
	pop hl
	ret

.TMText:
	db "わざマシン"
.TMTextEnd:
	db "@"

.HMText:
	db "ひでんマシン"
.HMTextEnd:
	db "@"

IsHM::
	cp ITEM_HM01_RED
	jr c, .false
	cp ITEM_TM01_RED
	ret

.false
	and a
	ret

IsHMMove::
	ld hl, .HMMoves
	ld de, 1
	jp FindItemInTable

.HMMoves:
	db MOVE_CUT
	db MOVE_FLY
	db MOVE_SURF
	db MOVE_STRENGTH
	db MOVE_FLASH
	db -1

Unreferenced_GetMoveName::
	push hl
	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	call GetName
	ld de, wStringBuffer1
	pop hl
	ret


SECTION "home/names.asm@GetNick", ROM0

GetCurNick::
	ld a, [wWhichPokemon]
	ld hl, wPartyMonNicknames

GetNick:
; Get nickname a from list hl.
	push hl
	push bc
	call SkipNames
	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop de
	callab CorrectNickErrors
	pop bc
	pop hl
	ret
