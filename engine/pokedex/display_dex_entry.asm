INCLUDE "constants.asm"

SECTION "engine/pokedex/display_dex_entry.asm", ROMX

; Meters
DEF POKEDEX_m EQU $60
; Kilograms
DEF POKEDEX_k EQU $61
DEF POKEDEX_g EQU $62

_DisplayDexEntry:
	hlcoord 9, 6
	ld de, PokedexText_HeightWeight
	call PlaceString
	call GetPokemonName
	hlcoord 9, 2
	call PlaceString
	ld hl, PokedexEntryPointers1
	ld a, [wTempSpecies]
	cp DEX_VOLTORB
	jr c, .got_dex_entries
	sub DEX_VOLTORB - 1
	ld hl, PokedexEntryPointers2

.got_dex_entries
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	hlcoord 9, 4
	call PlaceString
	ld h, b
	ld l, c
	push de
	ld de, PokedexText_Pokemon
	call PlaceString
	hlcoord 2, 8
	ld a, '№'
	ld [hli], a
	ld a, '．'
	ld [hli], a
	ld de, wTempSpecies
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
; Return if species isn't caught
	callfar Pokedex_CheckCaught
	push af
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	pop af
	pop de
	ret z

	inc de
	ld a, [de]
	and a
	jr z, .skip_height

	hlcoord 13, 6
	lb bc, 1, 3
	call PrintNumber

	hlcoord 14, 6
	ld a, [de]
	cp 10
	jr nc, .less_than_1_meter
	ld [hl], '０'

.less_than_1_meter
; Shift last digit to the right and put decimal point in its place.
	inc hl
	ld a, [hli]
	ld [hld], a
	ld [hl], '．'

.skip_height
	inc de
	ld a, [de]
	ld b, a
	inc de
	ld a, [de]
	or b
	push de
	jr z, .skip_weight

	ld hl, hPokedexTempWeight
	ld a, [hl]
	push af
	ld a, [de]
	ld [hli], a
	ld a, [hl]
	push af
	dec de
	ld a, [de]
	ld [hl], a
	ld de, hPokedexTempWeight
	hlcoord 12, 8
	lb bc, 2, 4
	call PrintNumber

	hlcoord 14, 8
	ldh a, [hPokedexTempWeight + 1]
	sub 10
	ldh a, [hPokedexTempWeight]
	sbc 0
	jr nc, .less_than_1_kilogram
	ld [hl], '０'

.less_than_1_kilogram
; Shift last digit to the right and put decimal point in its place.
	inc hl
	ld a, [hli]
	ld [hld], a
	ld [hl], '．'

	pop af
	ldh [hPokedexTempWeight + 1], a
	pop af
	ldh [hPokedexTempWeight], a
.skip_weight
	pop de
	inc de
	hlcoord 1, 11
	call PlaceString
	ret

PokedexText_HeightWeight:
	db   "たかさ　　？？？", POKEDEX_m
	next "おもさ　　？？？", POKEDEX_k, POKEDEX_g
	text_end

PokedexText_Pokemon:
	db "#" ; "Pokémon" (ポケモン)
	text_end
