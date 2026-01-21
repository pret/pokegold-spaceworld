INCLUDE "constants.asm"

SECTION "engine/overworld/wildmons.asm", ROMX

_LoadWildMonData::
	xor a
	ld hl, wWildMonData
	ld bc, GRASS_WILDDATA_LENGTH
	call ByteFill
	ld a, [wMapGroup]
	ld d, a
	ld a, [wMapId]
	ld e, a
	ld bc, GRASS_WILDDATA_LENGTH
	ld hl, GrassWildMons
.find
	ld a, [hl]
	cp -1
	ret z
	cp d
	jr nz, .got_map_group
	inc hl
	ld a, [hl]
	dec hl
	cp e
	jr z, .got_map
.got_map_group
	add hl, bc
	jr .find
.got_map
	inc hl
	inc hl
	ld de, wWildMonData
	ld bc, GRASS_WILDDATA_LENGTH - 2
	jp CopyBytes

; Load nest landmarks into wTilemap[0,0]
FindNest:
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	xor a
	call ByteFill
	ld hl, GrassWildMons
	decoord 0, 0

.FindGrass:
	ld a, [hl]
	cp -1
	jr z, .done

	push hl
	ld b, a
	inc hl
	ld c, [hl]
	call .SearchMapForMon
	jr nc, .next_grass

	push de
	call GetWorldMapLocation
	call .AppendNest
	pop de
	jr c, .next_grass
	ld [de], a
	inc de

.next_grass
	pop hl
	ld bc, GRASS_WILDDATA_LENGTH
	add hl, bc
	jr .FindGrass

.done:
	ret

.SearchMapForMon:
rept 5
	inc hl
endr
	ld a, NUM_GRASSMON

.ScanMapLoop:
	push af
	ld a, [wNamedObjectIndexBuffer]
	cp [hl]
	jr z, .found
	inc hl
	inc hl
	pop af
	dec a
	jr nz, .ScanMapLoop
	and a
	ret

.found
	pop af
	scf
	ret

.AppendNest:
	ld c, a
	ld hl, wTileMap
	ld de, SCREEN_WIDTH * SCREEN_HEIGHT
.AppendNestLoop:
	ld a, [hli]
	cp c
	jr z, .found_nest

	dec de
	ld a, e
	or d
	jr nz, .AppendNestLoop

	ld a, c
	and a
	ret

.found_nest
	scf
	ret

INCLUDE "data/wild/grassmons.inc"

TryWildBattle::
; If there is no active Repel, there's no need to be here.
	ld a, [wRepelEffect]
	and a
	jr z, .encounter

	dec a
	jp z, .repel_wore_off
	ld [wRepelEffect], a

.encounter
	call .CheckGrassCollision
	jr nc, .no_battle

; Get encounter rate for the time of day.
	call WildMon_GetTimeOfDay
	ld c, a
	ld b, 0
	ld hl, wWildMonData
	add hl, bc
	ld a, [hl]
	ld b, a

	call Random
	ldh a, [hRandomAdd]
	cp b
	jr nc, .no_battle

	call Random
	ld b, a
	ld hl, GrassMonProbTable

	call WildMon_GetTimeOfDay
	cp NITE_F
	ld bc, 0
	jr c, .got_time
	ld bc, GRASS_WILDDATA_DAYBLOCK_START * 2
	jr z, .got_time
	ld bc, GRASS_WILDDATA_NITEBLOCK_START * 2

.got_time
	add hl, bc

.random_loop
	call Random
	cp 100
	jr nc, .random_loop
	ld b, a
	ld c, 0

.prob_bracket_loop
	ld a, [hli]
	add c
	ld c, a
	cp b
	jr nc, .got_it
	inc hl
	jr .prob_bracket_loop

.got_it
	ld c, [hl]
	ld b, 0
	ld hl, wWildMons
	add hl, bc
	ld a, [hli]
	ld [wCurPartyLevel], a
	ld a, [hl]
	call ValidateTempWildMonSpecies
	jr c, .no_battle

	ld [wCurPartySpecies], a
	ld [wTempEnemyMonSpecies], a
	ld a, [wRepelEffect]
	and a
	jr z, .ok

	ld a, [wPartyMon1Level]
	ld b, a
	ld a, [wCurPartyLevel]
	cp b
	jr c, .no_battle

	jr .ok

.repel_wore_off
	ld [wRepelEffect], a

.no_battle
	ld a, 1
	and a
	ret

.ok
	ld a, WILD_BATTLE
	ld [wBattleMode], a
	xor a
	ret

.CheckGrassCollision:
	ld a, [wPlayerTile]
	ld hl, .blocks
	ld de, 1
	call FindItemInTable
	ret

.blocks
	db COLLISION_08
	db COLLISION_GRASS
	db COLLISION_WATER_28
	db COLLISION_WATER
	db COLLISION_48
	db COLLISION_49
	db COLLISION_4A
	db COLLISION_4B
	db COLLISION_4C
	db -1

INCLUDE "data/wild/probabilities.inc"

; This actually works as intended in the proto!
; In the final game, due to a development oversight,
; this function is called with the wild Pokemon's level, not its species, in a.
ValidateTempWildMonSpecies:
	and a
	jr z, .nowildmon ; = 0
	cp NUM_POKEMON + 1 ; 252
	jr nc, .nowildmon ; >= 252
	and a ; 1 <= Species <= 251
	ret

.nowildmon
	scf
	ret

WildMon_GetTimeOfDay:
	ld a, [wTimeOfDay]
	inc a
	maskbits NUM_DAYTIMES
	cp MORN_F
	ret nz
	dec a
	ret
