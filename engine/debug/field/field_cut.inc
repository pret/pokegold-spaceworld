FieldDebug_FieldCut:
	call .DetermineEnvironment
	jr c, .close_menu
	ld a, FIELDDEBUG_RETURN_REOPEN
	ret

.close_menu
	ld a, FIELDDEBUG_RETURN_CLEANUP
	ret

.DetermineEnvironment:
	call GetMapEnvironment
	cp ROUTE
	jr z, .outdoors
; Exit if indoors
	cp TOWN
	jr nz, .exit

.outdoors
	call .CheckGrassMetatile
	jr z, .in_grass
	call .IsCollision
	jr nz, .exit
	call .IsCuttableTile
	jr nc, .exit
	ld [hl], a
	jr .do_cut
.in_grass
	ld [hl], METATILE_LAWN
.do_cut
	call CloseWindow
	ld de, SFX_SHINE
	call PlaySFX
	call LoadMapPart
	call UpdateSprites
	call WaitBGMap
	scf
	ret

.exit
	and a
	ret

.CheckGrassMetatile:
	ld a, [wPlayerMapX]
	ld d, a
	ld a, [wPlayerMapY]
	ld e, a
	call GetBlockLocation
	ld a, [hl]
	cp METATILE_GRASS
	ret

.IsCollision: ; broken
	call GetFacingTileCoord
	cp OLD_COLLISION_CUT_TREE
	ret

.IsCuttableTile:
	call GetBlockLocation
	ld a, [hl]
	ld b, a
	ld de, .CuttableMetatiles
.find_cuttables
	ld a, [de]
	inc de
	cp b
	jr z, .got_cuttable
	cp -1
	jr z, .not_cuttable
	inc de
	jr .find_cuttables

.got_cuttable
	ld a, [de]
	scf
	ret

.not_cuttable
	and a
	ret

.CuttableMetatiles:
	db METATILE_CUT_SE_TREES_N
	db METATILE_SMALL_TREES_N
	db METATILE_CUT_NW_TREES_E
	db METATILE_SMALL_TREES_E
	db METATILE_CUT_NE_TREE_NW
	db METATILE_SMALL_TREE_NW
	db METATILE_CUT_NE_TREE_SE
	db METATILE_SMALL_TREE_SE
	db -1

