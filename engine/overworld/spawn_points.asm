INCLUDE "constants.asm"

SECTION "engine/overworld/spawn_points.asm", ROMX

GetFlyPointMapLocation:
	ld a, [wFlyDestination]
	ld l, a
	ld h, $00
	add hl, hl
	add hl, hl
	ld de, SpawnPoints
	add hl, de
	ld b, [hl] ; SpawnPoints + (wFlyDestination * 4)
	inc hl
	ld c, [hl]
	call GetWorldMapLocation
	ld e, a
	ret

LoadSpawnPoint:
; loads the spawn point in wDefaultSpawnPoint
	push hl
	push de
	ld a, [wDefaultSpawnPoint]
	and a
	jr z, .skip
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	ld de, SpawnPoints
	add hl, de
	ld a, [hli]
	ld [wMapGroup], a
	ld a, [hli]
	ld [wMapId], a
	ld a, [hli]
	ld [wXCoord], a
	ld a, [hli]
	ld [wYCoord], a
.skip
	pop de
	pop hl
	ret

IsSpawnPoint:
; Checks if the map loaded in de is a spawn point.
; Returns carry if it's a spawn point.
	ld hl, SpawnPoints
	ld c, 1
.loop
	ld a, [hl]
	cp SPAWN_N_A
	jr z, .fail
	cp d
	jr nz, .next
	inc hl
	ld a, [hld]
	cp e
	jr z, .succeed
.next
	push bc
	ld bc, SPAWN_POINT_SIZE
	add hl, bc
	pop bc
	inc c
	jr .loop
.fail
	and a
	ret
.succeed
	scf
	ret
