INCLUDE "constants.asm"

SECTION "engine/dumps/bank03.asm@GetFlyPointMapLocation", ROMX

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

SECTION "engine/dumps/bank03.asm@Functionc9c1", ROMX

_Functionc9c1:
	xor a
	ld bc, $0020 ; presumably size of wCurrMapInlineTrainers
	ld hl, wCurrMapInlineTrainers
	call ByteFill
	ld de, wMap2Object
	ld a, 2 ; skip the player
.loop
	push af
	push de
	ld hl, MAPOBJECT_PALETTE
	add hl, de
	ld a, [hl]
	cp 0
	jr nz, .skip

	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .skip
	call .check_inline_trainer

.skip
	pop de
	ld hl, MAPOBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

.check_inline_trainer
	jp CheckInlineTrainer

; Leftover from Generation I. Equivalent to pokered's AddItemToInventory_.
Unreferenced_ReceiveItem_Old:
	ld a, [wItemQuantity]
	push af
	push bc
	push de
	push hl
	push hl
	ld d, 50 ; PC_ITEM_CAPACITY
	push hl
	ld bc, $2e62 ; TODO: ???
	add hl, bc
	ld a, h
	or l
	pop hl
	jr nz, .check_if_inventory_full

	ld d, 20 ; BAG_ITEM_CAPACITY
.check_if_inventory_full
	ld a, [hl]
	sub d
	ld d, a
	ld a, [hli]
	and a
	jr z, .add_new_item

.not_at_end_of_inventory
	ld a, [hli]
	ld b, a
	ld a, [wCurItem]
	cp b
	jp z, .increase_item_quantity
	inc hl
	ld a, [hl]
	cp -1
	jr nz, .not_at_end_of_inventory

.add_new_item
	pop hl
	ld a, d
	and a
	jr z, .done

	inc [hl]
	ld a, [hl]
	add a
	dec a
	ld c, a
	ld b, 0
	add hl, bc ; address to store item
	ld a, [wCurItem]
	ld [hli], a
	ld a, [wItemQuantity]
	ld [hli], a
	ld [hl], -1
	jp .success

.increase_item_quantity
	ld a, [wItemQuantity]
	ld b, a
	ld a, [hl]
	add b
	cp MAX_ITEM_STACK + 1
	jp c, .store_new_quantity
	sub MAX_ITEM_STACK
	ld [wItemQuantity], a
	ld a, d
	and a
	jr z, .increase_item_quantity_failed
	ld a, MAX_ITEM_STACK
	ld [hli], a
	jp .not_at_end_of_inventory

.increase_item_quantity_failed
	pop hl
	and a
	jr .done

.store_new_quantity
	ld [hl], a
	pop hl
.success
	scf
.done
	pop hl
	pop de
	pop bc
	pop bc
	ld a, b
	ld [wItemQuantity], a
	ret

Unreferenced_RemoveItemFromInventory_Old:
	push hl
	inc hl
	ld a, [wItemIndex]
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	inc hl
	ld a, [wItemQuantity]
	ld e, a
	ld a, [hl]
	sub e
	ld [hld], a
	ld [wItemQuantityBuffer], a
	and a
	jr nz, .skip_moving_up_slots
	ld e, l
	ld d, h
	inc de
	inc de
.loop
	ld a, [de]
	inc de
	ld [hli], a
	cp -1
	jr nz, .loop
	xor a
	ld [wMenuScrollPosition], a
	ld [wRegularItemsCursor], a
	pop hl
	ld a, [hl]
	dec a
	ld [hl], a
	ld [wScrollingMenuListSize], a
	cp 2
	jr c, .done
	jr .done
.skip_moving_up_slots
	pop hl
.done
	ret


SECTION "engine/dumps/bank03.asm@Unreferenced_TossItem_Old", ROMX

Unreferenced_TossItem_Old:
	push hl
	call Unused_IsKeyItem_Old
	ld a, [wItemAttributeValue]
	and a
	jr nz, .cant_toss

	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, .ItemsThrowAwayText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	jr c, .cancel

	ld a, [wItemIndex]
	pop hl
	call TossItem
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld hl, .ItemsDiscardedText
	call MenuTextBox
	call CloseWindow

	and a
	ret

.cant_toss
	ld hl, .ItemsTooImportantText
	call MenuTextBox
	call CloseWindow
.cancel
	pop hl
	scf
	ret

.ItemsDiscardedText:
	text_from_ram wStringBuffer1
	text "を" ; "Threw away"
	line "すてました！" ; "(item?)!"
	prompt

.ItemsThrowAwayText:
	text_from_ram wStringBuffer2
	text "を　すてます" ; "Are you sure you want"
	line "ほんとに　よろしいですか？" ; "to throw (item?) away?"
	prompt

.ItemsTooImportantText:
	text "それは　とても　たいせつなモノです" ; "You can't throw away"
	line "すてることは　できません！" ; "something that special!"
	prompt

Unused_IsKeyItem_Old:
	push hl
	push bc
	ld a, 1
	ld [wItemAttributeValue], a
	ld a, [wCurItem]
	cp ITEM_HM01_RED
	jr nc, .check_if_hm
	ld hl, ItemAttributes + ITEMATTR_PERMISSIONS
	dec a
	ld c, a
	ld b, 0
rept 5
	add hl, bc
endr
	ld a, BANK(ItemAttributes)
	call GetFarByte
	bit 0, a
	jr nz, .cant_toss
	jr .can_toss

.check_if_hm
	ld a, [wCurItem]
	call IsHM
	jr c, .cant_toss

.can_toss
	xor a
	ld [wItemAttributeValue], a
.cant_toss
	pop bc
	pop hl
	ret

_HandlePlayerStep_Old:
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .start
	bit PLAYERSTEP_STOP_F, a
	jr nz, .update_player_coords
	bit PLAYERSTEP_CONTINUE_F, a
	jr nz, HandlePlayerStep_Finish
	ret

.start
	jr ._start

.unreferenced_d4fa
	call UpdatePlayerCoords
	callfar EmptyFunction8261

._start
	ld a, 4
	ld [wHandlePlayerStep], a
	ldh a, [hOverworldFlashlightEffect]
	and a
	jr nz, .update_overworld_map
	call UpdateOverworldMap_Old
	jr HandlePlayerStep_Finish

.update_overworld_map
	call UpdateOverworldMap
	jr HandlePlayerStep_Finish

.update_player_coords
	call UpdatePlayerCoords
	jr HandlePlayerStep_Finish

UpdatePlayerCoords:
	ld a, [wPlayerStepDirection]
	and a
	jr nz, .check_step_down
	ld hl, wYCoord
	inc [hl]
	ret

.check_step_down
	cp UP
	jr nz, .check_step_left
	ld hl, wYCoord
	dec [hl]
	ret

.check_step_left
	cp LEFT
	jr nz, .check_step_right
	ld hl, wXCoord
	dec [hl]
	ret

.check_step_right
	cp RIGHT
	ret nz
	ld hl, wXCoord
	inc [hl]
	ret

HandlePlayerStep_Finish:
	call HandlePlayerStep
	ld a, [wPlayerStepVectorX]
	ld d, a
	ld a, [wPlayerStepVectorY]
	ld e, a
	call ScrollNPCs
	call ScrollMinorObjects
	ldh a, [hSCX]
	add d
	ldh [hSCX], a
	ldh a, [hSCY]
	add e
	ldh [hSCY], a
	ret

ScrollNPCs:
	ld bc, wObjectStructs
	xor a
.loop
	ldh [hMapObjectIndex], a
	ld hl, OBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip
	ld hl, OBJECT_FLAGS1
	add hl, bc
	bit CENTERED_OBJECT_F, [hl]
	jr nz, .skip

	ld hl, OBJECT_SPRITE_X
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, OBJECT_SPRITE_Y
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
.skip
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_OBJECT_STRUCTS
	jr nz, .loop
	ret

ScrollMinorObjects:
	ld bc, wMinorObjects
	ld a, 1
.loop
	ldh [hMapObjectIndex], a
	ld hl, MINOR_OBJECT_PARENT_OBJECT
	add hl, bc
	ld a, [wCenteredObject]
	inc a
	cp [hl]
	jr z, .skip
	ld hl, MINOR_OBJECT_X_POS
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ld hl, MINOR_OBJECT_Y_POS
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a

.skip
	ld hl, MINOR_OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	ldh a, [hMapObjectIndex]
	inc a
	cp NUM_MINOR_OBJECTS + 1
	jr nz, .loop
	ret

HandlePlayerStep::
	ld hl, wHandlePlayerStep
	ld a, [hl]
	and a
	ret z
	dec [hl]
	ld a, [hl]
	add a
	ld e, a
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.Jumptable:
	dw RefreshTiles
	dw Functionc9c1
	dw BufferScreen
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail
	dw .fail

.fail
	ret

Functionc9c1:
	callfar _Functionc9c1
	ret

UpdateOverworldMap_Old:
	ld a, [wPlayerStepDirection]
	and a ; DOWN
	jr z, .step_down
	cp UP
	jr z, .step_up
	cp LEFT
	jr z, .step_left
	cp RIGHT
	jr z, .step_right
	ret

.step_down
	call ScrollOverworldMapDown
	call LoadMapPart
	call ScheduleSouthRowRedraw
	ret

.step_up
	call ScrollOverworldMapUp
	call LoadMapPart
	call ScheduleNorthRowRedraw
	ret

.step_left
	call ScrollOverworldMapLeft
	call LoadMapPart
	call ScheduleWestColumnRedraw
	ret
	
.step_right
	call ScrollOverworldMapRight
	call LoadMapPart
	call ScheduleEastColumnRedraw
	ret

ScrollOverworldMapDown:
	ld a, [wBGMapAnchor]
	add BG_MAP_WIDTH * 2
	ld [wBGMapAnchor], a
	jr nc, .no_overflow
	ld a, [wBGMapAnchor + 1]
	inc a
	and %11
	or HIGH(vBGMap0)
	ld [wBGMapAnchor + 1], a
.no_overflow
	ld hl, wMetatileNextY
	inc [hl]
	ld a, [hl]
	cp 2
	jr nz, .done
	ld [hl], 0
	call .ScrollMapDataDown
.done
	ret

.ScrollMapDataDown:
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 3 * 2 ; surrounding tiles
	add [hl]
	ld [hli], a
	ret nc
	inc [hl]
	ret

ScrollOverworldMapUp:
	ld a, [wBGMapAnchor]
	sub BG_MAP_WIDTH * 2
	ld [wBGMapAnchor], a
	jr nc, .not_underflowed
	ld a, [wBGMapAnchor+1]
	dec a
	and %11
	or HIGH(vBGMap0)
	ld [wBGMapAnchor+1], a
.not_underflowed
	ld hl, wMetatileNextY
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done_up
	ld [hl], 1
	call .ScrollMapDataUp
.done_up
	ret

.ScrollMapDataUp:
	ld hl, wOverworldMapAnchor
	ld a, [wMapWidth]
	add 3 * 2
	ld b, a
	ld a, [hl]
	sub b
	ld [hli], a
	ret nc
	dec [hl]
	ret

ScrollOverworldMapLeft:
	ld a, [wBGMapAnchor]
	ld e, a
	and ~(BG_MAP_WIDTH - 1)
	ld d, a
	ld a, e
	sub 2
	maskbits BG_MAP_WIDTH - 1
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	dec [hl]
	ld a, [hl]
	cp -1
	jr nz, .done_left
	ld [hl], 1
	call .ScrollMapDataLeft
.done_left
	ret

.ScrollMapDataLeft:
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	sub 1
	ld [hli], a
	ret nc
	dec [hl]
	ret

ScrollOverworldMapRight:
	ld a, [wBGMapAnchor]
	ld e, a
	and ~(BG_MAP_WIDTH - 1)
	ld d, a
	ld a, e
	add 2
	maskbits BG_MAP_WIDTH - 1
	or d
	ld [wBGMapAnchor], a
	ld hl, wMetatileNextX
	inc [hl]
	ld a, [hl]
	cp 2
	jr nz, .done_right
	ld [hl], $00
	call .ScrollMapDataRight
.done_right
	ret

.ScrollMapDataRight:
	ld hl, wOverworldMapAnchor
	ld a, [hl]
	add 1
	ld [hli], a
	ret nc
	inc [hl]
	ret

_HandlePlayerStep:
	ld a, [wPlayerStepFlags]
	and a
	ret z
	bit PLAYERSTEP_START_F, a
	jr nz, .update_overworld_map
	bit PLAYERSTEP_STOP_F, a
	jr nz, .update_player_coords
	bit PLAYERSTEP_CONTINUE_F, a
	jp nz, HandlePlayerStep_Finish
	ret

.update_overworld_map
	ld a, 4
	ld [wHandlePlayerStep], a
	call UpdateOverworldMap
	jp HandlePlayerStep_Finish

.update_player_coords
	call UpdatePlayerCoords
	jp HandlePlayerStep_Finish

UpdateOverworldMap:
	ld a, [wPlayerStepDirection]
	and a
	jr z, .step_down
	cp UP
	jr z, .step_up
	cp LEFT
	jr z, .step_left
	cp RIGHT
	jr z, .step_right
	ret

.step_down
	call ScrollOverworldMapDown
	call LoadMapPart
	ld a, 2
	call ScrollOverworldFlashlight
	ret
.step_up
	call ScrollOverworldMapUp
	call LoadMapPart
	ld a, 1
	call ScrollOverworldFlashlight
	ret
.step_left
	call ScrollOverworldMapLeft
	call LoadMapPart
	ld a, 3
	call ScrollOverworldFlashlight
	ret
.step_right
	call ScrollOverworldMapRight
	call LoadMapPart
	ld a, 4
	call ScrollOverworldFlashlight
	ret

ScrollOverworldFlashlight::
	push af
	call .GetFlashlightVariables
	call .GetFlashlightSize
	pop af
	add 2
	ldh [hRedrawRowOrColumnMode], a
	ret

.GetFlashlightVariables:
	dec a
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, hl
	ldh a, [hOverworldFlashlightEffect]
	dec a
	swap a  ; * 16
	sla a   ; *  2
	ld e, a
	ld d, 0
	add hl, de
	ld de, .FlashlightColumns
	add hl, de
	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightDst0], a
	ld a, d
	ld [wRedrawFlashlightDst0 + 1], a

	call .GetFlashlightSrc
	ld a, e
	ld [wRedrawFlashlightSrc0], a
	ld a, d
	ld [wRedrawFlashlightSrc0 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightBlackDst0], a
	ld a, d
	ld [wRedrawFlashlightBlackDst0 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightDst1], a
	ld a, d
	ld [wRedrawFlashlightDst1 + 1], a

	call .GetFlashlightSrc
	ld a, e
	ld [wRedrawFlashlightSrc1], a
	ld a, d
	ld [wRedrawFlashlightSrc1 + 1], a

	call .ReadFlashlightDst
	ld a, e
	ld [wRedrawFlashlightBlackDst1], a
	ld a, d
	ld [wRedrawFlashlightBlackDst1 + 1], a
	ret

; The positions of the columns drawn.
; TODO: Wrap these in neat macros.
.FlashlightColumns:
	db $02, $03, $02, $11, $02, $02, $02, $10 ; up
	db $02, $0e, $02, $00, $02, $0f, $02, $01 ; down
	db $03, $02, $11, $02, $02, $02, $10, $02 ; left
	db $0e, $02, $00, $02, $0f, $02, $01, $02 ; right

	db $04, $05, $04, $0f, $04, $04, $04, $0e
	db $04, $0c, $04, $02, $04, $0d, $04, $03
	db $05, $04, $0f, $04, $04, $04, $0e, $04
	db $0c, $04, $02, $04, $0d, $04, $03, $04

	db $06, $07, $06, $0d, $06, $06, $06, $0c
	db $06, $0a, $06, $04, $06, $0b, $06, $05
	db $07, $06, $0d, $06, $06, $06, $0c, $06
	db $0a, $06, $04, $06, $0b, $06, $05, $06

	db $08, $09, $08, $0b, $08, $08, $08, $0a
	db $08, $08, $08, $06, $08, $09, $08, $07
	db $09, $08, $0b, $08, $08, $08, $0a, $08
	db $08, $08, $06, $08, $09, $08, $07, $08

.ReadFlashlightDst:
	ld c, [hl]
	inc hl
	ld b, [hl]
	inc hl
	push hl
	push bc
	ld a, [wBGMapAnchor]
	ld e, a
	ld a, [wBGMapAnchor + 1]
	ld d, a
.row_loop
	ld a, BG_MAP_WIDTH
	add e
	ld e, a
	jr nc, .no_overflow
	inc d
.no_overflow
	ld a, d
	and %11
	or HIGH(vBGMap0) ; equivalent of add $98
	ld d, a
	dec b
	jr nz, .row_loop
.tile_loop
	ld a, e
	inc a
	maskbits BG_MAP_WIDTH - 1 ; only works if BG_MAP_WIDTH is 2^n
	ld b, a
	ld a, e
	and ~(BG_MAP_WIDTH - 1)
	or b
	ld e, a
	dec c
	jr nz, .tile_loop
	pop bc
	pop hl
	ret

.GetFlashlightSrc:
	push hl
	ld hl, wTileMap
	ld de, SCREEN_WIDTH
.loop
	ld a, b
	and a
	jr z, .last_row
	add hl, de
	dec b
	jr .loop

.last_row
	add hl, bc
	ld e, l
	ld d, h
	pop hl
	ret

.GetFlashlightSize:
	ldh a, [hOverworldFlashlightEffect]
	dec a
	ld l, a
	ld h, 0
	ld de, .Sizes
	add hl, de
	ld a, [hl]
	ld [wRedrawFlashlightWidthHeight], a
	ret

.Sizes:
	db 7, 5, 3, 1

TryAddMonToParty::
; Check if to copy wild mon or generate a new one
	; Whose is it?
	ld de, wPartyCount
	ld a, [wMonType]
	and $f
	jr z, .getpartylocation ; PARTYMON
	ld de, wOTPartyCount

.getpartylocation
	; Do we have room for it?
	ld a, [de]
	inc a
	cp PARTY_LENGTH + 1
	ret nc
	; Increase the party count
	ld [de], a
	ld a, [de] ; Why are we doing this?
	ldh [hMoveMon], a ; HRAM backup
	add e
	ld e, a
	jr nc, .loadspecies
	inc d

.loadspecies
	; Load the species of the Pokemon into the party list.
	; The terminator is usually here, but it'll be back.
	ld a, [wCurPartySpecies]
	ld [de], a
	; Load the terminator into the next slot.
	inc de
	ld a, -1
	ld [de], a
	; Now let's load the OT name.
	ld hl, wPartyMonOTs
	ld a, [wMonType]
	and $f
	jr z, .loadOTname
	ld hl, wOTPartyMonOT

.loadOTname
	ldh a, [hMoveMon] ; Restore index from backup
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	; Only initialize the nickname for party mon
	ld a, [wMonType]
	and a
	jr nz, .skipnickname
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, wPartyMonNicknames
	ldh a, [hMoveMon]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.skipnickname
	ld hl, wPartyMon1
	ld a, [wMonType]
	and $f
	jr z, .initializeStats
	ld hl, wOTPartyMons

.initializeStats
	ldh a, [hMoveMon]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	push hl
	; Initialize the species
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wMonHIndex]
	ld [de], a
	inc de

	; Copy the item if it's a wild mon
	ld a, [wBattleMode]
	and a
	jr z, .skipitem
	ld a, [wEnemyMonItem]
	ld [de], a
.skipitem
	inc de

	; Copy the moves if it's a wild mon
	push de
	xor a
	ld [wFieldMoveScriptID], a
	predef FillMoves
	pop de
rept NUM_MOVES
	inc de
endr

	; Initialize ID.
	ld a, [wPlayerID]
	ld [de], a
	inc de
	ld a, [wPlayerID + 1]
	ld [de], a
	inc de

	; Initialize Exp.
	push de
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de

	; Initialize stat experience.
	xor a
	ld b, MON_DVS - MON_STAT_EXP

.loop
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	pop hl
	push hl
	ld a, [wMonType]
	and $f
	ln a, 9, 8
	ln b, 8, 8
	jr nz, .initializeDVs

; Check if mon is caught
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	dec a
	ld c, a
	ld b, CHECK_FLAG
	ld hl, wPokedexCaught
	push de
	ld d, 3
	call SmallFarFlagAction
	pop de

; Set the mon's caught and seen flags
	ld a, c
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexSeen
	call SmallFarFlagAction
	pop hl
	push hl
	ld a, [wBattleMode]
	and a
	jr nz, .copywildmonDVs
	call Random
	ld b, a
	call Random
.initializeDVs
	ld [de], a
	inc de
	ld a, b
	ld [de], a
	inc de

	; Initialize PP.
	push hl
	push de
	inc hl
	inc hl
	call FillPP
	pop de
	pop hl
rept NUM_MOVES
	inc de
endr

	; Initialize happiness.
	ld a, BASE_HAPPINESS
	ld [de], a
	inc de

	; Doesn't initialize these three values whatsoever. (Unused1 - Unused3)
	inc de
	inc de
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	xor a
	; Status
	ld [de], a
	inc de
	; Unused
	ld [de], a
	inc de

	; Initialize HP.
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld a, 1
	ld c, a
	xor a ; FALSE
	ld b, a
	call CalcMonStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	jr .initstats

.copywildmonDVs
	ld a, [wEnemyMonDVs]
	ld [de], a
	inc de
	ld a, [wEnemyMonDVs + 1]
	ld [de], a
	inc de

	push hl
	ld hl, wEnemyMonPP
	ld b, NUM_MOVES
.wildmonpploop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .wildmonpploop
	pop hl

	; Initialize happiness.
	ld a, BASE_HAPPINESS
	ld [de], a
	inc de

	; Doesn't initialize these three values whatsoever. (Unused1 - Unused3)
	inc de
	inc de
	inc de

	; Initialize level.
	ld a, [wCurPartyLevel]
	ld [de], a
	inc de

	ld a, [wEnemyMonStatus]
	; Copy wEnemyMonStatus
	ld [de], a
	inc de
	ld a, [wEnemyMonStatus + 1]
	; Copy EnemyMonUnused
	ld [de], a
	inc de
	; Copy wEnemyMonHP
	ld a, [wEnemyMonHP]
	ld [de], a
	inc de
	ld a, [wEnemyMonHP + 1]
	ld [de], a
	inc de

.initstats
	ld a, [wBattleMode]
	dec a
	jr nz, .generatestats
	ld hl, wEnemyMonMaxHP
	ld bc, PARTYMON_STRUCT_LENGTH - MON_MAXHP
	call CopyBytes
	pop hl
	jr .done

.generatestats
	pop hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, FALSE
	call CalcMonStats
.done
	scf
	ret

FillPP::
	ld b, NUM_MOVES
.loop
	ld a, [hli]
	and a
	jr z, .next
	dec a
	push hl
	push de
	push bc
	ld hl, Moves
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld de, wStringBuffer1
	ld a, BANK(Moves)
	call FarCopyBytes
	pop bc
	pop de
	pop hl
	ld a, [wStringBuffer1 + MOVE_PP]
.next
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ret


AddTempmonToParty:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	scf
	ret z

	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartySpecies]
	ld [hli], a
	ld [hl], $ff

	ld hl, wPartyMon1Species
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld e, l
	ld d, h
	ld hl, wTempMonSpecies
	call CopyBytes

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonOT
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	call SkipNames
	ld d, h
	ld e, l
	ld hl, wOTPartyMonNicknames
	ld a, [wCurPartyMon]
	call SkipNames
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndexBuffer], a
	dec a
	ld c, a
	ld b, SET_FLAG
	ld hl, wPokedexCaught
	push bc
	call SmallFarFlagAction
	pop bc
	ld hl, wPokedexSeen
	call SmallFarFlagAction
	and a
	ret

; Sents/Gets mon into/from Box depending on Parameter.
; wPokemonWithdrawDepositParameter == 0: get mon into Party.
; wPokemonWithdrawDepositParameter == 1: sent mon into Box.
; wPokemonWithdrawDepositParameter == 2: get mon from wBufferMon into Party.
; wPokemonWithdrawDepositParameter == 3: put mon into wBufferMon.
SendGetMonIntoFromBox::
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .check_IfPartyIsFull
	cp BUFFERMON_WITHDRAW
	jr z, .check_IfPartyIsFull
	cp BUFFERMON_DEPOSIT
	ld hl, wBufferMon
	jr z, .buffermon

	; we want to sent a mon into the Box
	; so check if there's enough space
	ld hl, wBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .there_is_room
	jr .full
	
.check_IfPartyIsFull
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	jr nz, .there_is_room

.full
	scf
	ret
.there_is_room
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_WITHDRAW
	ld a, [wBufferMonSpecies]
	jr z, .okay1
	ld a, [wCurPartySpecies]

.okay1
	ld [hli], a
	ld [hl], -1
	ld a, [wPokemonWithdrawDepositParameter]
	dec a
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPartyCount]
	jr nz, .okay2
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	ld a, [wBoxCount]

.okay2
	dec a ; wPartyCount - 1
	call AddNTimes
.buffermon
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .okay3
	cp BUFFERMON_WITHDRAW
	ld hl, wBufferMon
	jr z, .okay4
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH

.okay3
	ld a, [wCurPartyMon]
	call AddNTimes

.okay4
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_DEPOSIT
	ld de, wBufferMonOT
	jr z, .okay5
	dec a
	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	jr nz, .okay6
	ld hl, wBoxMonOTs
	ld a, [wBoxCount]

.okay6
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay5
	ld hl, wBoxMonOTs
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay7
	ld hl, wBufferMonOT
	cp BUFFERMON_WITHDRAW
	jr z, .okay8
	ld hl, wPartyMonOTs

.okay7
	ld a, [wCurPartyMon]
	call SkipNames

.okay8
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp BUFFERMON_DEPOSIT
	ld de, wBufferMonNickname
	jr z, .okay9
	dec a
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	jr nz, .okay10
	ld hl, wBoxMonNicknames
	ld a, [wBoxCount]

.okay10
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay9
	ld hl, wBoxMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay11
	ld hl, wBufferMonNickname
	cp BUFFERMON_WITHDRAW
	jr z, .okay12
	ld hl, wPartyMonNicknames

.okay11
	ld a, [wCurPartyMon]
	call SkipNames
.okay12
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl

	ld a, [wPokemonWithdrawDepositParameter]
	cp PC_DEPOSIT
	jr z, .done_clear_carry
	cp BUFFERMON_DEPOSIT
	jr z, .done_clear_carry

	push hl
	srl a
	add $2
	ld [wMonType], a
	predef CopyMonToTempMon
	farcall CalcLevel
	ld a, d
	ld [wCurPartyLevel], a
	pop hl
	ld b, h
	ld c, l
	ld hl, MON_LEVEL
	add hl, bc
	ld [hl], a
	ld hl, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc

	push bc
	ld b, TRUE
	call CalcMonStats
	pop bc

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr nz, .done_clear_carry
	ld hl, MON_HP
	add hl, bc
	ld d, h
	ld e, l
	inc hl
	inc hl
	ld a, [hli]
	ld [de], a
	ld a, [hl]
	inc de
	ld [de], a
.done_clear_carry
	and a
	ret

; TODO: Might not be for breedmon?
RetrieveBreedmonOrBuffermon:
	ld hl, wPartyCount
	ld a, [hl]
	cp PARTY_LENGTH
	push af
	jr nz, .room_in_party_or_box
	ld hl, wBoxCount
	ld a, [hl]
	cp MONS_PER_BOX
	jr nz, .room_in_party_or_box
	pop af
	scf
	ret

.room_in_party_or_box
	inc a
	ld [hl], a
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld a, [wBufferMonSpecies]
	ld de, wBufferMonNickname
	jr z, .okay ; unused in practice

	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld a, -1
	ld [hl], a
	pop af ; if wPartyCount = PARTY_LENGTH
	jr z, .party_full

	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl

	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	dec a
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl

	ld hl, wPartyMons
	ld a, [wPartyCount]
	dec a
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	call GetBaseData

	ld h, d
	ld l, e
	dec hl
	ld a, [hl]
	ld [wCurPartyLevel], a
	inc de
	inc de
	push de
	inc de
	inc de
	push de
	ld bc, -(BOXMON_STRUCT_LENGTH - MON_STAT_EXP)
	add hl, bc
	ld b, TRUE
	call CalcMonStats
	pop hl
	pop de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	jr .done

.party_full
	ld hl, wBoxMonNicknames
	ld a, [wBoxCount]
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	push hl
	ld h, d
	ld l, e
	pop de
	call CopyBytes
	push hl

	ld hl, wBoxMonOTs
	ld a, [wBoxCount]
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call CopyBytes
	push hl
	
	ld hl, wBoxMons
	ld a, [wBoxCount]
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes

.done
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ret z
	ld hl, wBreedMon2Nickname
	ld de, wBreedMon1Nickname
	ld bc, MON_NAME_LENGTH + PLAYER_NAME_LENGTH + BOXMON_STRUCT_LENGTH
	call CopyBytes
	and a
	ret

DepositBreedmonOrBuffermon::
	ld a, [wPokemonWithdrawDepositParameter]
	ld de, wBufferMonNickname
	and a
	jr z, .buffer_mon

	ld hl, wBreedMon1Nickname
	ld de, wBreedMon2Nickname
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld hl, wBreedMon1OT
	ld de, wBreedMon2OT
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld hl, wBreedMon1
	ld de, wBreedMon2
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	ld de, wBreedMon1Nickname

.buffer_mon
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes
	call CopyBytes

	ld a, [wCurPartyMon]
	ld hl, wPartyMonOTs
	ld bc, PLAYER_NAME_LENGTH
	call AddNTimes
	call CopyBytes

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld bc, BOXMON_STRUCT_LENGTH
	jp CopyBytes

; Sends the mon into one of ???'s Boxes.
; The data comes mainly from 'wEnemyMon'.
SendMonIntoBox::
	ld de, wBoxCount
	ld a, [de]
	cp MONS_PER_BOX
	ret nc
	inc a
	ld [de], a

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld c, a
.loop
	inc de ; wBoxSpecies
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp -1
	jr nz, .loop

	call GetBaseData
	ld hl, wBoxMonOTs
	ld bc, PLAYER_NAME_LENGTH
	ld a, [wBoxCount]
	dec a
	jr z, .copy_ot
	dec a
	call AddNTimes
	push hl

	ld bc, PLAYER_NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_mon_ot
	push bc
	push hl
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(PLAYER_NAME_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_mon_ot

.copy_ot
	ld hl, wPlayerName
	ld de, wBoxMonOTs
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld a, [wBoxCount]
	dec a
	jr z, .copy_nickname

	ld hl, wBoxMonNicknames
	ld bc, MON_NAME_LENGTH
	dec a
	call AddNTimes
	push hl

	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_loop_mon_name
	push bc
	push hl
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(MON_NAME_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_loop_mon_name

.copy_nickname
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	ld de, wBoxMonNicknames
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

	ld a, [wBoxCount]
	dec a
	jr z, .copy_boxmon

	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	call AddNTimes
	push hl
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, [wBoxCount]
	dec a
	ld b, a

.shift_loop_boxmon
	push bc
	push hl
	ld bc, BOXMON_STRUCT_LENGTH
	call CopyBytes
	pop hl
	ld d, h
	ld e, l
	ld bc, -(BOXMON_STRUCT_LENGTH)
	add hl, bc
	pop bc
	dec b
	jr nz, .shift_loop_boxmon

.copy_boxmon
	ld hl, wEnemyMon
	ld de, wBoxMons
	ld bc, (wEnemyMonMovesEnd - wEnemyMon)
	call CopyBytes

	; Copy player ID
	ld hl, wPlayerID
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	push de

	; Get experience points
	ld a, [wCurPartyLevel]
	ld d, a
	callfar CalcExpAtLevel
	pop de
	ldh a, [hProduct + 1]
	ld [de], a
	inc de
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	xor a
	ld b, (NUM_EXP_STATS * 2)
.skip_stat_exp
	ld [de], a
	inc de
	dec b
	jr nz, .skip_stat_exp
	ld hl, wEnemyMonDVs
	ld b, (wBoxMon1Happiness - wBoxMon1DVs) + 1
.copy_dvs_pp_happiness
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy_dvs_pp_happiness

	xor a
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld a, [wCurPartyLevel]
	ld [de], a
	scf
	ret

; Noticeably incomplete. Generates a hybrid of the first BreedMon and DEX_EGG.
GiveEgg::
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .party_full
	call TryAddMonToParty
	ld de, wPartyMonNicknames
	ld hl, wPartyCount
	jr .next

.party_full
	ld a, [wBoxCount]
	cp MONS_PER_BOX
	scf
	ret z
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	xor a
	ld [wEnemySubStatus5], a ; ???
	callfar LoadEnemyMon
	call SendMonIntoBox
	ld de, wBoxMonNicknames
	ld hl, wBoxCount

.next
	ld a, [hl]
	push af
	ld b, 0
	ld c, a
	add hl, bc
	ld a, DEX_EGG
	ld [hl], a
	pop af

	dec a
	ld h, d
	ld l, e
	ld bc, MON_NAME_LENGTH
	call AddNTimes

; Print "EGG" as its name
	ld a, "た"
	ld [hli], a
	ld a, "ま"
	ld [hli], a
	ld a, "ご"
	ld [hli], a
	ld [hl], "@"
	and a
	ret

RemoveMonFromPartyOrBox:
	ld hl, wPartyCount

	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay

	ld hl, wBoxCount

.okay
	ld a, [hl]
	dec a
	ld [hli], a
	ld a, [wCurPartyMon]
	ld c, a
	ld b, 0
	add hl, bc
	ld e, l
	ld d, h
	inc de
.loop
	ld a, [de]
	inc de
	ld [hli], a
	inc a
	jr nz, .loop
	ld hl, wPartyMonOTs
	ld d, PARTY_LENGTH - 1
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party
	ld hl, wBoxMonOTs
	ld d, MONS_PER_BOX - 1

.party
	; If this is the last mon in our party (box),
	; shift all the other mons up to close the gap.
	ld a, [wCurPartyMon]
	call SkipNames
	ld a, [wCurPartyMon]
	cp d
	jr nz, .delete_inside
	ld [hl], -1
	ret

.delete_inside
	; Shift the OT names
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party2
	ld bc, wBoxMonNicknames
.party2
	call CopyDataUntil
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party3
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
.party3
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party4
	ld bc, BOXMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wBoxMonOTs
	jr .copy

.party4
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	ld bc, wPartyMonOTs
.copy
	call CopyDataUntil
	ld hl, wPartyMonNicknames
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party5
	ld hl, wBoxMonNicknames
.party5
	ld bc, MON_NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld d, h
	ld e, l
	ld bc, MON_NAME_LENGTH
	add hl, bc
	ld bc, wPartyMonNicknamesEnd
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .party6
	ld bc, wBoxMonNicknamesEnd
.party6
	jp CopyDataUntil

CalcMonStats::
	ld c, $00
.loop
	inc c
	call CalcMonStatC
	ldh a, [hProduct + 2]
	ld [de], a
	inc de
	ldh a, [hProduct + 3]
	ld [de], a
	inc de
	ld a, c
	cp STAT_SDEF
	jr nz, .loop
	ret

CalcMonStatC::
; 'c' is 1-6 and points to the BaseStat
; 1: HP
; 2: Attack
; 3: Defense
; 4: Speed
; 5: SpAtk
; 6: SpDef
	push hl
	push de
	push bc
	ld a, b
	ld d, a

	push hl
	ld hl, wMonHBaseStats
	dec hl
	ld b, $0
	add hl, bc
	ld a, [hl]
	ld e, a
	pop hl
	push hl
	ld a, c
; Special defense shares stat exp with special attack
	cp STAT_SDEF
	jr nz, .not_spdef
	dec hl
	dec hl
	
.not_spdef
	sla c
	ld a, d
	and a
	jr z, .no_stat_exp
	add hl, bc

.sqrt_loop
	xor a
	ldh [hMultiplicand], a
	ldh [hMultiplicand + 1], a
	inc b
	ld a, b
	cp -1
	jr z, .no_stat_exp

	ldh [hMultiplicand + 2], a
	ldh [hMultiplier], a
	call Multiply

	ld a, [hld]
	ld d, a
	ldh a, [hProduct + 3]
	sub d
	ld a, [hli]
	ld d, a
	ldh a, [hProduct + 2]
	sbc d
	jr c, .sqrt_loop

.no_stat_exp
	srl c
	pop hl
	push bc
	ld bc, MON_DVS - MON_HP_EXP + 1
	add hl, bc
	pop bc
	ld a, c
	cp STAT_ATK
	jr z, .Attack
	cp STAT_DEF
	jr z, .Defense
	cp STAT_SPD
	jr z, .Speed
	cp STAT_SATK
	jr z, .Special
	cp STAT_SDEF
	jr z, .Special
; DV_HP = (DV_ATK & 1) << 3 | (DV_DEF & 1) << 2 | (DV_SPD & 1) << 1 | (DV_SPC & 1)
	push bc
	ld a, [hl]
	swap a
	and $01
	add a
	add a
	add a
	ld b, a
	ld a, [hli]
	and $01
	add a
	add a
	add b
	ld b, a
	ld a, [hl]
	swap a
	and $01
	add b
	add b
	ld b, a
	ld a, [hl]
	and $01
	add b
	pop bc
	jr .GotDV

.Attack
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Defense
	ld a, [hl]
	and $f
	jr .GotDV

.Speed
	inc hl
	ld a, [hl]
	swap a
	and $f
	jr .GotDV

.Special
	inc hl
	ld a, [hl]
	and $f

.GotDV
	ld d, $00
	add e
	ld e, a
	jr nc, .no_overflow_1
	inc d

.no_overflow_1
	sla e
	rl d
	srl b
	srl b
	ld a, b
	add e
	jr nc, .no_overflow_2
	inc d
	
.no_overflow_2
	ldh [hMultiplicand + 2], a
	ld a, d
	ldh [hMultiplicand + 1], a
	xor a
	ldh [hMultiplicand], a
	ld a, [wCurPartyLevel]
	ldh [hMultiplier], a
	call Multiply

	ldh a, [hProduct + 1]
	ldh [hDividend], a
	ldh a, [hMultiplicand + 1]
	ldh [hDividend + 1], a
	ldh a, [hMultiplicand + 2]
	ldh [hDividend + 2], a
	ld a, MAX_LEVEL
	ldh [hDivisor], a
	ld a, 3
	ld b, a
	call Divide

	ld a, c
	cp STAT_HP
	ld a, STAT_MIN_NORMAL
	jr nz, .not_hp
	ld a, [wCurPartyLevel]
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_3
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_3
	ld a, STAT_MIN_HP

.not_hp
	ld b, a
	ldh a, [hDividend+3]
	add b
	ldh [hDividend+3], a
	jr nc, .no_overflow_4
	ldh a, [hDividend+2]
	inc a
	ldh [hDividend+2], a

.no_overflow_4
	ldh a, [hDividend+2]
	cp HIGH(MAX_STAT_VALUE + 1) + 1
	jr nc, .max_stat
	cp HIGH(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay
	ldh a, [hDividend+3]
	cp LOW(MAX_STAT_VALUE + 1)
	jr c, .stat_value_okay

.max_stat
	ld a, HIGH(MAX_STAT_VALUE)
	ldh [hDividend+2], a
	ld a, LOW(MAX_STAT_VALUE)
	ldh [hDividend+3], a

.stat_value_okay
	pop bc
	pop de
	pop hl
	ret

GivePoke::
	ld a, [wCurPartySpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	predef SmallFarFlagAction

	push bc
	xor a ; PARTYMON
	ld [wMonType], a
	call TryAddMonToParty
	jr nc, .party_full
	ld hl, wPartyMonNicknames
	ld a, [wPartyCount]
	dec a
	ld bc, MON_NAME_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	pop bc
	ld a, c
	ld b, 0
	push bc
	push de
	jr .give_mon_success

.party_full
	call SendMonIntoBox
	pop bc
	jp nc, .give_mon_failure
	ld a, c
	ld de, wBoxMonNicknames
	ld b, 1
	push bc
	push de
.give_mon_success
	push af
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	call GetPokemonName
	pop af
	and a
	jr nz, .skip_pokedex

	ld hl, wd41c
	bit 4, [hl] ; flag for obtaining the pokedex
	jr z, .skip_pokedex

	ld hl, NewDexDataText
	call PrintText
	call ClearSprites
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	predef NewPokedexEntry
	call LoadTilesetGFX_LCDOff
.skip_pokedex
	ld hl, GotItText
	call PrintText
	call YesNoBox
	pop de
	jr c, .done

	push de
	ld b, NAME_MON
	farcall NamingScreen
	pop de
	ld a, [de]
	cp "@"
	jr nz, .not_empty

	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.not_empty
	call ClearBGPalettes
	ld hl, wSpriteFlags
	ld a, [hl]
	push af
	res SPRITES_SKIP_STANDING_GFX_F, [hl]
	set SPRITES_SKIP_WALKING_GFX_F, [hl]
	call RedrawPlayerSprite
	pop af
	ld [wSpriteFlags], a
	call LoadFontExtra
	call LoadMapPart
	call GetMemSGBLayout
	call WaitBGMap
	call GBFadeInFromWhite
.done
	pop bc
	ld a, b
	and a
	ret z
	ld hl, WasSentToBillsPCText
	ld hl, WasSentToSomeonesPCText
	call PrintText
	ld b, 1
	ret

.give_mon_failure
	ld b, 2
	ret

WasSentToBillsPCText:
	text_from_ram wStringBuffer1
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

WasSentToSomeonesPCText:
	text_from_ram wStringBuffer1
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText:
	text_from_ram wStringBuffer1
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"
	sound_slot_machine_start
	text_waitbutton
	text_end

GotItText:
	text "ゲットした　@" ; "Got it!"

AskGiveNicknameText:
	text_from_ram wStringBuffer1
	text "に" ; "Would you like to"
	line "なまえを　つけますか？" ; "give it a name?"
	done

_BillsPC:
	call .CheckCanUsePC
	ret c
	call LoadStandardMenuHeader
	call ClearTileMap
	call LoadFontsBattleExtra
	ld hl, vChars2 tile $78
	ld de, PokeBallsGFX
	lb bc, BANK(PokeBallsGFX), 1
	call Request2bpp
	ld hl, .PCWhatText
	call MenuTextBox
	ld hl, .MenuHeader
	call LoadMenuHeader
.loop
	call SetPalettes
	xor a
	ld [wWhichIndexSet], a
	call OpenMenu
	jr c, .cancel
	ld a, [wMenuSelection]
	ld hl, .Jumptable
	call CallJumptable
	jr nc, .loop

.cancel
	call CloseWindow
	call CloseWindow
	call LoadTilesetGFX
	call RestoreScreenAndReloadTiles
	call LoadFontExtra
	call CloseWindow
	ret

.PCWhatText:
	text "なんに　するん？" ; (lit. "What are you going to do?")
	done

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, 14, 17
	dw .MenuData
	db 1

.MenuData:
	db MENU_BACKUP_TILES_2
	db 0
	dw .items
	dw PlaceMenuStrings
	dw .strings

.strings
	db "#の　ようすをみる@"   ; (lit "look at Pokemon")
	db "#を　つれていく@"    ; "Withdraw (Pokemon)"
	db "#を　あずける@"      ; "Deposit (Pokemon)"
	db "#を　にがす@"       ; "Release (Pokemon)"
	db "ボックスを　かえる@" ; "Change Box"
	db "さようなら@"        ; "Goodbye"

.Jumptable:
	dw BillsPC_ViewPokemon
	dw BillsPC_WithdrawPokemon
	dw BillsPC_DepositMon
	dw BillsPC_ReleaseMon
	dw BillsPC_ChangeBoxMenu
	dw BillsPC_SeeYa

.items
	db 5 ; # items
	db 0 ; VIEW
	db 1 ; WITHDRAW
	db 2 ; DEPOSIT
	db 3 ; RELEASE
	db 4 ; CHANGE BOX
	db 5 ; SEE YA!
	db -1

.CheckCanUsePC:
	ld a, [wPartyCount]
	and a
	ret nz
	ld hl, .PCGottaHavePokemonText
	call MenuTextBoxBackup
	scf
	ret

.PCGottaHavePokemonText:
	text "#もってへんやつは"
	line "おことわりや！"
	prompt

BillsPC_SeeYa:
	scf
	ret

BillsPC_DepositMon:
	call .CheckPartySize
	jr c, .cant_deposit
	call _DepositPKMN

.cant_deposit
	and a
	ret

.CheckPartySize:
	ld a, [wPartyCount]
	and a
	jr z, .no_mon
	cp 2
	jr c, .only_one_mon
	and a
	ret

.no_mon
	ld hl, .PCNoSingleMonText
	call MenuTextBoxBackup
	scf
	ret

.only_one_mon
	ld hl, .PCCantDepositLastMonText
	call MenuTextBoxBackup
	scf
	ret

.PCNoSingleMonText:
	text "１ぴきも　もってへんやんか！" ; (lit: "I can't even have one!")
	prompt

.PCCantDepositLastMonText:
	text "それ　あずけたら"   ; "You can't deposit"
	line "こまるんとちゃう？" ; "the last #MON!"
	prompt

_DepositPKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_DepositMenu
	call BillsPC_Menu
	call CloseWindow
	ret c

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ld a, PC_DEPOSIT
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

BillsPC_WithdrawPokemon:
	call .CheckPartySize
	jr c, .cant_withdraw
	call _WithdrawPKMN
.cant_withdraw
	and a
	ret

.CheckPartySize:
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .party_full
	and a
	ret

.party_full
	ld hl, .PCCantTakeText
	call MenuTextBoxBackup
	scf
	ret

.PCCantTakeText:
	text "それいじょう　よくばったって" ; "You can't take any"
	line "#　もたれへんで！"          ; "more #MON."
	prompt

_WithdrawPKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_WithdrawReleaseMenu
	call BillsPC_Menu
	call CloseWindow
	ret c

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	xor a ; PC_WITHDRAW
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

BillsPC_ReleaseMon:
	call .ReleasePKMN
	and a
	ret

.ReleasePKMN:
	call LoadStandardMenuHeader
	ld hl, BillsPC_WithdrawReleaseMenu
	call BillsPC_Menu
	call CloseWindow
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ret c

	ld hl, .OnceReleasedText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	ld a, REMOVE_BOX
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

.OnceReleasedText:
	text_from_ram wStringBuffer1
	text "　をほんとうに" ; "Are you sure you"
	next "にがしますか？" ; "want to release (MON)?"
	done

BillsPC_ChangeBoxMenu:
	call _ChangeBox
	and a
	ret

_ChangeBox:
	call InitDummyBoxNames
	call LoadStandardMenuHeader
	call ClearPalettes
	call ClearTileMap
.sub_e3d4
	ld hl, _ChangeBox_MenuHeader
	call CopyMenuHeader
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .sub_e3e9
	call BillsPC_ChangeBoxSubmenu
	jr .sub_e3d4
.sub_e3e9
	call CloseWindow
	ret

; Resets all box names to "ダミーボックス#" ("Dummy Box#"), where # is the box index.
InitDummyBoxNames:
	ld hl, wBoxNames
	ld c, 0
.loop
	push hl
	ld de, .DummyBoxText
	call CopyString
	ld a, "０"
	add c
	dec hl
	ld [hli], a
	ld [hl], "@"
	pop hl
	ld de, BOX_NAME_LENGTH
	add hl, de
	inc c
	ld a, c
	cp NUM_BOXES
	jr c, .loop
	ret

.DummyBoxText:
	db "ダミーボックス@" ; "Dummy Box"

_ChangeBox_MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 0, SCREEN_WIDTH - 1, 12
	dw .MenuData
	db 1

.MenuData:
	db SCROLLINGMENU_ENABLE_FUNCTION3
	db 4, 0
	db SCROLLINGMENU_ITEMS_NORMAL
	dba .Boxes
	dba .PrintBoxNames
	ds 3
	dba BillsPC_PrintBoxCountAndCapacity

.Boxes:
	db NUM_BOXES
for x, NUM_BOXES
	db x + 1
endr
	db -1

.PrintBoxNames:
	push de
	ld a, [wMenuSelection]
	dec a
	ld bc, 6 ; length of "No. 0#" strings
	ld hl, .BoxNumbers
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	push bc
	ld a, [wMenuSelection]
	dec a
	ld bc, BOX_NAME_LENGTH
	ld hl, wBoxNames
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

; TODO: rework this to use a nice macro?
.BoxNumbers:
	db "№．０１　@"
	db "№．０２　@"
	db "№．０３　@"
	db "№．０４　@"
	db "№．０５　@"
	db "№．０６　@"
	db "№．０７　@"
	db "№．０８　@"
	db "№．０９　@"
	db "№．１０　@"

BillsPC_PrintBoxCountAndCapacity:
	ld h, d
	ld l, e
	ld de, .Pokemon
	call PlaceString
	ld hl, 3
	add hl, bc
	push hl
	call .GetBoxCount
	pop hl
	ld de, wStringBuffer1
	ld [de], a
	lb bc, 1, 2
	call PrintNumber
	ld de, .OutOf30
	call PlaceString
	ret

.Pokemon:
	db "あずかっている#" ; "Mon in my care"
	next "　@"

.OutOf30: ; max mon per box
	db "／３０@"

.GetBoxCount:
	ld a, [wMenuSelection]
	dec a
	ld c, a
	ld b, 0
	ld hl, .BoxBankAddresses
	add hl, bc
	add hl, bc
	add hl, bc
	ld a, [hli]
	call OpenSRAM
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	call CloseSRAM
	ret

.BoxBankAddresses:
	table_width 3, BillsPC_PrintBoxCountAndCapacity.BoxBankAddresses
for n, 1, NUM_BOXES + 1
	dba sBox{d:n}
endr
	assert_table_length NUM_BOXES

BillsPC_ChangeBoxSubmenu:
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [wMenuCursorY]
	cp 1
	jr z, .Switch
	cp 2
	jr z, .Name
	and a
	ret

.UnderDev:
	ld hl, .BoxChangeUnderDevText
	call MenuTextBox
	call CloseWindow
	ret

.BoxChangeUnderDevText:
	text "バンクチェンジは" ; "Box change is"
	next "かいはつちゅうです！" ; "under development!"
	prompt

.Switch:
	ld hl, .ChangeBoxSaveText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	jr .UnderDev

.Unreferenced_e54d:
	ld a, [wMenuSelection]
	ret

.ChangeBoxSaveText:
	text "#　ボックスを　かえると" ; "When you change a box"
	line "どうじに　レポートが　かかれます" ; "data will be saved."
	para "<⋯⋯>　それでも　いいですか？" ; "Is that okay?"
	done

.Name:
	ld b, NAME_BOX
	ld de, wTempBoxName
	farcall NamingScreen
	ld a, [wTempBoxName]
	cp "@"
	ret z
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	ld a, [wMenuSelection]
	dec a
	call AddNTimes
	ld de, wTempBoxName
	call CopyString
	ret

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 0, 6, 14, 14
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "ボックスきりかえ@" ; "Change Box"
	db "なまえを　かえる@" ; " Change Name"
	db "やめる@" ; (lit "stop")

BillsPC_ViewPokemon:
	call LoadStandardMenuHeader
	call _ViewPKMN
	call ClearPalettes
	call CloseWindow
	and a
	ret

_ViewPKMN:
.loop
	call ClearBGPalettes
	call .InitViewPokemonDisplay
	call SetPalettes
	ld hl, BillsPC_ViewMenuHeader
	call CopyMenuHeader
	ld a, [wBillsPCCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBillsPCScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBillsPCScrollPosition], a
	ld a, [wMenuCursorY]
	ld [wBillsPCCursor], a
	call ClearPalettes
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit
	call .ViewStats
	jr .loop

.exit
	ret
.ViewStats
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	call LoadStandardMenuHeader
	call LowVolume
	predef StatsScreenMain
	call MaxVolume
	call ExitMenu
	ret

.InitViewPokemonDisplay
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]
	call ClearTileMap

; Note that the name of the box doesn't actually gets printed yet: register 'de' is immediately overwritten,
; so the game displays the placeholder "いまの　ボックス" ("Current Box"). The setup is here, though.
	ld a, [wCurBox]
	ld hl, wBoxNames
	ld bc, BOX_NAME_LENGTH
	call AddNTimes
	ld d, h
	ld e, l

	hlcoord 1, 1
	ld de, .CurrentBox
	call PlaceString
	hlcoord 0, 3
	ld a, "┌"
	ld [hli], a
	ld a, "─"
	ld c, SCREEN_WIDTH - 1

.top_border_loop
	ld [hli], a
	dec c
	jr nz, .top_border_loop
	ld de, SCREEN_WIDTH
	ld a, "│"
	ld c, 8
.left_border_loop
	ld [hl], a
	add hl, de
	dec c
	jr nz, .left_border_loop

	hlcoord 2, 3
	ld de, .SpeciesNameLevel
	call PlaceString
	ld hl, .PCString_ChooseaPKMN
	call PrintText
	pop af
	ld [wOptions], a
	ret

.CurrentBox:
	db "ボックス／いまの　ボックス@" ; "Box/Current Box"

.SpeciesNameLevel:
	db "しゅるい　　なまえ　　　レべル@" ; "Species Name Level"

.PCString_ChooseaPKMN:
	text "どの#が　みたいねん？" ; "Which would you like to see?"
	done

BillsPC_Menu::
	ld a, l
	ld [wListPointer], a
	ld a, h
	ld [wListPointer + 1], a
	hlcoord 4, 2
	ld b, 9
	ld c, 14
	call DrawTextBox
	ld hl, wListPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call ScrollingMenu_FromTable
	ld a, [wMenuJoypad]
	cp B_BUTTON
	jr z, .exit
	ld hl, .PokemonSelected
	call MenuTextBoxBackup
	and a
	ret
	
.exit
	scf
	ret

.PokemonSelected:
	text "#を　えらんだ！" ; "POKéMON selected!"
	prompt

BillsPC_DepositMenu:
	dw .MenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wPartyCount
	dba PlacePartyMonNicknames
	dba PlacePartyMonLevels
	ds 3

BillsPC_WithdrawReleaseMenu:
	dw .MenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wBoxCount
	dba PlaceBoxMonNicknames
	dba PlaceBoxMonLevels
	ds 3

BillsPC_ViewMenu:
	dw BillsPC_ViewMenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

BillsPC_ViewMenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 1, 4, SCREEN_WIDTH - 1, 11
	dw .MenuData
	db 1

.MenuData:
	db 0
	db 4, 0
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wBoxCount
	dba PlaceDetailedBoxMonView
	ds 3
	ds 3

; Brings up the Pokédex entry of the index in wTempSpecies/wNamedObjectIndex to show as if it were caught.
StarterDex::
	call RefreshScreen
	call LowVolume
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hMapAnims], a
	ld hl, wStateFlags
	res SPRITE_UPDATES_DISABLED_F, [hl]
	call ClearBGPalettes
	call ClearSprites
	call LoadStandardMenuHeader
	callfar LoadPokeDexGraphics
	call ClearTileMap
	callfar _NewPokedexEntry
	call ClearBGPalettes
	ld hl, wStateFlags
	set SPRITE_UPDATES_DISABLED_F, [hl]
	call ExitMenu
	call LoadTilesetGFX_LCDOff
	call RestoreScreenAndReloadTiles
	call UpdateTimePals
	pop af
	ldh [hMapAnims], a
	call MaxVolume
	call ScreenCleanup
	ret

; START OF: engine/items/item_effects.asm

_DoItemEffect::
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	cp ITEM_TM01
	jp nc, AskTeachTMHM
	ld hl, ItemEffects
	dec a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

ItemEffects:
; entries correspond to item ids (see constants/item_constants.asm)
	dw PokeBallEffect      ; ITEM_MASTER_BALL
	dw PokeBallEffect      ; ITEM_ULTRA_BALL
	dw NoEffect            ; ITEM_03
	dw PokeBallEffect      ; ITEM_GREAT_BALL
	dw PokeBallEffect      ; ITEM_POKE_BALL
	dw TownMapEffect       ; ITEM_TOWN_MAP 
	dw BicycleEffect       ; ITEM_BICYCLE
	dw EvoStoneEffect      ; ITEM_MOON_STONE
	dw StatusHealingEffect ; ITEM_ANTIDOTE
	dw StatusHealingEffect ; ITEM_BURN_HEAL
	dw StatusHealingEffect ; ITEM_ICE_HEAL
	dw StatusHealingEffect ; ITEM_AWAKENING
	dw StatusHealingEffect ; ITEM_PARLYZ_HEAL
	dw FullRestoreEffect   ; ITEM_FULL_RESTORE
	dw RestoreHPEffect     ; ITEM_MAX_POTION
	dw RestoreHPEffect     ; ITEM_HYPER_POTION
	dw RestoreHPEffect     ; ITEM_SUPER_POTION
	dw RestoreHPEffect     ; ITEM_POTION
	dw EscapeRopeEffect    ; ITEM_ESCAPE_ROPE
	dw RepelEffect         ; ITEM_REPEL
	dw RestorePPEffect     ; ITEM_MAX_ELIXER
	dw EvoStoneEffect      ; ITEM_FIRE_STONE
	dw EvoStoneEffect      ; ITEM_THUNDERSTONE
	dw EvoStoneEffect      ; ITEM_WATER_STONE
	dw NoEffect            ; ITEM_19
	dw VitaminEffect       ; ITEM_HP_UP
	dw VitaminEffect       ; ITEM_PROTEIN
	dw VitaminEffect       ; ITEM_IRON
	dw VitaminEffect       ; ITEM_CARBOS
	dw NoEffect            ; ITEM_1E
	dw VitaminEffect       ; ITEM_CALCIUM
	dw RareCandyEffect     ; ITEM_RARE_CANDY
	dw XAccuracyEffect     ; ITEM_X_ACCURACY
	dw EvoStoneEffect      ; ITEM_LEAF_STONE
	dw NoEffect            ; ITEM_23
	dw Stub_NuggetEffect   ; ITEM_NUGGET
	dw PokeDollEffect      ; ITEM_POKE_DOLL
	dw StatusHealingEffect ; ITEM_FULL_HEAL
	dw ReviveEffect        ; ITEM_REVIVE
	dw ReviveEffect        ; ITEM_MAX_REVIVE
	dw GuardSpecEffect     ; ITEM_GUARD_SPEC
	dw SuperRepelEffect    ; ITEM_SUPER_REPEL
	dw MaxRepelEffect      ; ITEM_MAX_REPEL
	dw DireHitEffect       ; ITEM_DIRE_HIT
	dw NoEffect            ; ITEM_2D
	dw RestoreHPEffect     ; ITEM_FRESH_WATER
	dw RestoreHPEffect     ; ITEM_SODA_POP
	dw RestoreHPEffect     ; ITEM_LEMONADE
	dw XItemEffect         ; ITEM_X_ATTACK
	dw NoEffect            ; ITEM_32
	dw XItemEffect         ; ITEM_X_DEFENSE
	dw XItemEffect         ; ITEM_X_SPEED
	dw XItemEffect         ; ITEM_X_SPECIAL
	dw CoinCaseEffect      ; ITEM_COIN_CASE
	dw PPUpEffect          ; ITEM_ITEMFINDER
	dw PokeFluteEffect     ; ITEM_POKE_FLUTE
	dw NoEffect            ; ITEM_EXP_SHARE
	dw OldRodEffect_Old    ; ITEM_OLD_ROD
	dw GoodRodEffect_Old   ; ITEM_GOOD_ROD
	dw NoEffect            ; ITEM_3C
	dw SuperRodEffect_Old  ; ITEM_SUPER_ROD
	dw PPUpEffect          ; ITEM_PP_UP
	dw RestorePPEffect     ; ITEM_ETHER
	dw RestorePPEffect     ; ITEM_MAX_ETHER
	dw RestorePPEffect     ; ITEM_ELIXER
	dw Dummy_NewItemEffect ; ITEM_MYSTIC_PETAL
	dw Dummy_NewItemEffect ; ITEM_WHITE_FEATHER
	dw Dummy_NewItemEffect ; ITEM_CONFUSE_CLAW
	dw Dummy_NewItemEffect ; ITEM_WISDOM_ORB
	dw Dummy_NewItemEffect ; ITEM_STEEL_SHELL
	dw Dummy_NewItemEffect ; ITEM_UP_GRADE
	dw Dummy_NewItemEffect ; ITEM_STRANGE_THREAD
	dw Dummy_NewItemEffect ; ITEM_BIG_LEAF
	dw Dummy_NewItemEffect ; ITEM_QUICK_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_4B
	dw Dummy_NewItemEffect ; ITEM_SHARP_STONE
	dw Dummy_NewItemEffect ; ITEM_BLACK_FEATHER
	dw Dummy_NewItemEffect ; ITEM_SHARP_FANG
	dw Dummy_NewItemEffect ; ITEM_SNAKESKIN
	dw Dummy_NewItemEffect ; ITEM_ELECTRIC_POUCH
	dw Dummy_NewItemEffect ; ITEM_TOXIC_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_KINGS_ROCK
	dw Dummy_NewItemEffect ; ITEM_STRANGE_POWER
	dw Dummy_NewItemEffect ; ITEM_LIFE_TAG
	dw Dummy_NewItemEffect ; ITEM_POISON_FANG
	dw Dummy_NewItemEffect ; ITEM_CORDYCEPS
	dw Dummy_NewItemEffect ; ITEM_DRAGON_FANG
	dw Dummy_NewItemEffect ; ITEM_SILVERPOWDER
	dw Dummy_NewItemEffect ; ITEM_DIGGING_CLAW
	dw Dummy_NewItemEffect ; ITEM_5A
	dw Dummy_NewItemEffect ; ITEM_AMULET_COIN
	dw Dummy_NewItemEffect ; ITEM_MIGRAINE_SEED
	dw Dummy_NewItemEffect ; ITEM_COUNTER_CUFF
	dw Dummy_NewItemEffect ; ITEM_TALISMAN_TAG
	dw Dummy_NewItemEffect ; ITEM_STRANGE_WATER
	dw Dummy_NewItemEffect ; ITEM_TWISTEDSPOON
	dw Dummy_NewItemEffect ; ITEM_ATTACK_NEEDLE
	dw Dummy_NewItemEffect ; ITEM_POWER_BRACER
	dw Dummy_NewItemEffect ; ITEM_HARD_STONE
	dw Dummy_NewItemEffect ; ITEM_64
	dw Dummy_NewItemEffect ; ITEM_JIGGLING_BALLOON
	dw Dummy_NewItemEffect ; ITEM_FIRE_MANE
	dw Dummy_NewItemEffect ; ITEM_SLOWPOKETAIL
	dw Dummy_NewItemEffect ; ITEM_EARTH
	dw Dummy_NewItemEffect ; ITEM_STICK
	dw Dummy_NewItemEffect ; ITEM_FLEE_FEATHER
	dw Dummy_NewItemEffect ; ITEM_ICE_FANG
	dw Dummy_NewItemEffect ; ITEM_FOSSIL_SHARD
	dw Dummy_NewItemEffect ; ITEM_GROSS_GARBAGE
	dw Dummy_NewItemEffect ; ITEM_BIG_PEARL
	dw Dummy_NewItemEffect ; ITEM_CHAMPION_BELT
	dw Dummy_NewItemEffect ; ITEM_TAG
	dw Dummy_NewItemEffect ; ITEM_SPELL_TAG
	dw Dummy_NewItemEffect ; ITEM_5_YEN_COIN
	dw Dummy_NewItemEffect ; ITEM_GUARD_THREAD
	dw Dummy_NewItemEffect ; ITEM_STIMULUS_ORB
	dw Dummy_NewItemEffect ; ITEM_CALM_BERRY
	dw Dummy_NewItemEffect ; ITEM_THICK_CLUB
	dw Dummy_NewItemEffect ; ITEM_FOCUS_ORB
	dw Dummy_NewItemEffect ; ITEM_78
	dw Dummy_NewItemEffect ; ITEM_DETECT_ORB
	dw Dummy_NewItemEffect ; ITEM_LONG_TONGUE
	dw Dummy_NewItemEffect ; ITEM_LOTTO_TICKET
	dw Dummy_NewItemEffect ; ITEM_EVERSTONE
	dw Dummy_NewItemEffect ; ITEM_SHARP_HORN
	dw Dummy_NewItemEffect ; ITEM_LUCKY_EGG
	dw Dummy_NewItemEffect ; ITEM_LONG_VINE
	dw Dummy_NewItemEffect ; ITEM_MOMS_LOVE
	dw Dummy_NewItemEffect ; ITEM_SMOKESCREEN
	dw Dummy_NewItemEffect ; ITEM_WET_HORN
	dw Dummy_NewItemEffect ; ITEM_SKATEBOARD
	dw Dummy_NewItemEffect ; ITEM_CRIMSON_JEWEL
	dw Dummy_NewItemEffect ; ITEM_INVISIBLE_WALL
	dw Dummy_NewItemEffect ; ITEM_SHARP_SCYTHE
	dw Dummy_NewItemEffect ; ITEM_87
	dw Dummy_NewItemEffect ; ITEM_ICE_BIKINI
	dw Dummy_NewItemEffect ; ITEM_THUNDER_FANG
	dw Dummy_NewItemEffect ; ITEM_FIRE_CLAW
	dw Dummy_NewItemEffect ; ITEM_TWIN_HORNS
	dw Dummy_NewItemEffect ; ITEM_SPIKE
	dw Dummy_NewItemEffect ; ITEM_BERRY
	dw Dummy_NewItemEffect ; ITEM_APPLE
	dw Dummy_NewItemEffect ; ITEM_METAL_COAT
	dw Dummy_NewItemEffect ; ITEM_PRETTY_TAIL
	dw Dummy_NewItemEffect ; ITEM_WATER_TAIL
	dw Dummy_NewItemEffect ; ITEM_LEFTOVERS
	dw Dummy_NewItemEffect ; ITEM_ICE_WING
	dw Dummy_NewItemEffect ; ITEM_THUNDER_WING
	dw Dummy_NewItemEffect ; ITEM_FIRE_WING
	dw Dummy_NewItemEffect ; ITEM_96
	dw Dummy_NewItemEffect ; ITEM_DRAGON_SCALE
	dw Dummy_NewItemEffect ; ITEM_BERSERK_GENE
	dw Dummy_NewItemEffect ; ITEM_HEART_STONE
	dw Dummy_NewItemEffect ; ITEM_FIRE_TAIL
	dw Dummy_NewItemEffect ; ITEM_THUNDER_TAIL
	dw Dummy_NewItemEffect ; ITEM_SACRED_ASH
	dw TMHolderEffect      ; ITEM_TM_HOLDER
	dw Stub_MailEffect     ; ITEM_MAIL
	dw Dummy_NewItemEffect ; ITEM_BALL_HOLDER
	dw Dummy_NewItemEffect ; ITEM_BAG
	dw Dummy_NewItemEffect ; ITEM_IMPORTANT_BAG
	dw Dummy_NewItemEffect ; ITEM_POISON_STONE
	dw Dummy_NewItemEffect ; ITEM_A3
	dw Dummy_NewItemEffect ; ITEM_A4
	dw Dummy_NewItemEffect ; ITEM_A5
	dw Dummy_NewItemEffect ; ITEM_A6
	dw Dummy_NewItemEffect ; ITEM_A7
	dw Dummy_NewItemEffect ; ITEM_A8
	dw Dummy_NewItemEffect ; ITEM_A9
	dw Dummy_NewItemEffect ; ITEM_AA
; ITEM_AB through ITEM_C3 have no entries.

PokeBallEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nz, .room_in_party

	ld a, [wBoxCount]
	cp MONS_PER_BOX
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	call ReturnToBattle_UseBall

	ld hl, ItemUsedText
	call PrintText

	ld a, [wEnemyMonCatchRate]
	ld b, a
	ld a, [wCurItem]
	cp ITEM_MASTER_BALL
	jp z, .catch_without_fail

	cp ITEM_ULTRA_BALL
	jr z, .ultra_ball_modifier

	cp ITEM_GREAT_BALL
	jr z, .great_ball_modifier

	; POKE_BALL
	jr .regular_ball

; 1.5x modifier
.great_ball_modifier
	ld a, b
	srl a
	add b
	ld b, a
	jr nc, .regular_ball
	ld b, $ff
	jr .regular_ball

; 2.0x modifier
.ultra_ball_modifier
	sla b
	jr nc, .regular_ball
	ld b, $ff

.regular_ball
	ld a, b
	ldh [hMultiplicand + 2], a

	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	sla c
	rl b
	
	ld h, d
	ld l, e
	add hl, de
	add hl, de
	ld d, h
	ld e, l
	ld a, d
	and a
	jr z, .okay_1

	srl d
	rr e
	srl d
	rr e
	srl b
	rr c
	srl b
	rr c

	ld a, c
	and a
	jr nz, .okay_1
	ld c, 1
.okay_1
	ld b, e

	push bc
	ld a, b
	sub c
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply
	pop bc

	ld a, b
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 3]
	and a
	jr nz, .statuscheck
	ld a, 1
.statuscheck
; This routine is buggy, even in the final game.
; It was intended that SLP and FRZ provide a higher catch rate than BRN/PSN/PAR,
; which in turn provide a higher catch rate than no status effect at all.
; But instead, it makes BRN/PSN/PAR provide no benefit.
; Uncomment the line below to fix this.
	ld b, a
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	ld c, 10
	jr nz, .addstatus
	; ld a, [wEnemyMonStatus]
	and a
	ld c, 5
	jr nz, .addstatus
	ld c, 0
.addstatus
	ld a, b
	add c
	jr nc, .max_1
	ld a, $ff
.max_1
	; BUG: farcall overwrites a, and GetItemHeldEffect takes b anyway.
	; This might be the reason the HELD_CATCH_CHANCE effect goes unused in the final game.
	; Uncomment the line below to fix.
	ld d, a
	push de
	ld a, [wBattleMonItem]
	; ld b, a
	callfar GetItemHeldEffect
	ld a, b
	cp HELD_CATCH_CHANCE
	pop de
	ld a, d
	jr nz, .max_2
	add c
	jr nc, .max_2
	ld a, $ff
.max_2
	ld b, a
	ld [wFieldMoveScriptID], a
	call Random

	cp b
	ld a, 0
	jr z, .catch_without_fail
	jr nc, .fail_to_catch

.catch_without_fail
	ld a, [wEnemyMonSpecies]

.fail_to_catch
	ld [wWildMon], a
	ld c, 20
	call DelayFrames

	ld a, [wCurItem]
	ld [wBattleAnimParam], a

	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ldh [hBattleTurn], a
	ld [wThrownBallWobbleCount], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wWildMon]
	and a
	jr nz, .caught
	ld a, [wThrownBallWobbleCount]
	cp 1
	ld hl, BallBrokeFreeText
	jp z, .shake_and_break_free
	cp 2
	ld hl, BallAppearedCaughtText
	jp z, .shake_and_break_free
	cp 3
	ld hl, BallAlmostHadItText
	jp z, .shake_and_break_free
	cp 4
	ld hl, BallSoCloseText
	jp z, .shake_and_break_free

.caught
	ld hl, wEnemyMonHP
	ld a, [hli]
	push af
	ld a, [hli]
	push af
	inc hl
	ld a, [hl]

	push af
	push hl
	ld hl, wEnemyMonItem
	ld a, [hl]
	push af
	push hl

; BUG: If a Pokémon is caught while transformed, it is assumed to be a Ditto,
; even if it used Transform via Mirror Move/Mimic or is Mew.
	ld hl, wEnemySubStatus5
	bit SUBSTATUS_TRANSFORMED, [hl]
	jr z, .not_ditto

	ld a, DEX_DITTO
	ld [wTempEnemyMonSpecies], a
; This doesn't seem right... aren't transformed Pokémon the only ones that use backup DVs anyway?
	jr .load_data

.not_ditto
	set SUBSTATUS_TRANSFORMED, [hl]
	ld hl, wEnemyBackupDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a

.load_data
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	callfar LoadEnemyMon

	pop hl
	pop af
	ld [hl], a
	pop hl
	pop af
	ld [hld], a
	dec hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a

	ld a, [wEnemyMonSpecies]
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wTempSpecies], a
	ld a, [wBattleType]
	dec a ; BATTLETYPE_TUTORIAL?
	jp z, .FinishTutorial

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld d, 0
	ld hl, wPokedexCaught
	ld b, CHECK_FLAG
	predef SmallFarFlagAction

	ld a, c
	push af
	ld a, [wTempSpecies]
	dec a
	ld c, a
	ld b, SET_FLAG
	predef SmallFarFlagAction

; Notably doesn't skip the Pokédex if you actually don't have the Pokédex yet, unlike in GivePoke.
; Not a big deal, since you shouldn't have Poké Balls yet anyway.
	pop af
	and a
	jr nz, .skip_pokedex

	ld hl, NewDexDataText_CaughtMon
	call PrintText

	call ClearSprites

	ld a, [wEnemyMonSpecies]
	ld [wTempSpecies], a
	predef NewPokedexEntry

.skip_pokedex
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .SendToPC

	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites

	predef TryAddMonToParty

	ld hl, AskGiveNicknameText_CaughtMon
	call PrintText
	call YesNoBox
	jr c, .return_from_capture

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMonNicknames
	ld bc, MON_NAME_LENGTH
	call AddNTimes

	ld d, h
	ld e, l
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	push de
	call FarCall_hl

	call GBFadeOutToWhite

	pop de
	ld a, [de]
	cp "@" ; Did we just leave the name empty?
	jr nz, .return_from_capture
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	jr .return_from_capture

.SendToPC
	call ClearSprites

	predef SendMonIntoBox

	ld hl, AskGiveNicknameText_CaughtMon
	call PrintText
	call YesNoBox
	jr c, .done_with_nickname_pc

	ld de, wBoxMonNicknames
	ld b, NAME_MON
	farcall NamingScreen

	call GBFadeOutToWhite
	ld de, wBoxMonNicknames
	ld a, [de]
	cp "@"
	jr nz, .done_with_nickname_pc

	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes

.done_with_nickname_pc
; BUG: Clearly there was supposed to be some kind of event flag check, but no flag address is actually loaded.
; 'a' is still the last byte copied in CopyBytes, which is most likely $50 (string terminator), which does not have bit 0 set.
	ld hl, BallSentToBillsPCText
	bit 0, a
	jr nz, .met_bill
	ld hl, BallSentToSomeonesPCText
.met_bill
	call PrintText
	jr .return_from_capture

.FinishTutorial:
	ld hl, Text_GotchaMonWasCaught

.shake_and_break_free
	call PrintText
	call ClearSprites

.return_from_capture
	ld a, [wBattleType]
	and a
	ret nz
	ld hl, wItems
	inc a
	ld [wItemQuantity], a
	jp TossItem

Unreferenced_BallDodgedText:
	text "よけられた！" ; "It dodged the thrown BALL!"
	line "こいつは　つかまりそうにないぞ！" ; "This MON can't be caught!"
	prompt

Unreferenced_BallMissedText:
	text "#に" ; "You missed the"
	line "うまく　あたらなかった！" ; "(MON)!"
	prompt

BallBrokeFreeText:
	text "だめだ！　#が" ; "Oh no! The (MON)"
	line "ボールから　でてしまった！" ; "broke free!"
	prompt

BallAppearedCaughtText:
	text "ああ！" ; "Aww! It appeared"
	line "つかまえたと　おもったのに！" ; "to be caught!"
	prompt

BallAlmostHadItText:
	text "ざんねん！" ; "Aargh!"
	line "もうすこしで　つかまえられたのに！" ; "Almost had it!"
	prompt

BallSoCloseText:
	text "おしい！" ; "Shoot! It was so"
	line "あと　ちょっとの　ところだったのに！" ; "close too!"
	prompt

Text_GotchaMonWasCaught:
	text "やったー！" ; "Gotcha!"
	line "@"
	text_from_ram wEnemyMonNickname
	text "を　つかまえたぞ！@" ; "(MON) was caught!"
	sound_caught_mon
	text_waitbutton
	text_end

BallSentToBillsPCText:
	text_from_ram wBoxMonNicknames
	text "は　マサキの　ところへ" ; "was transferred to"
	line "てんそうされた！" ; "BILL's PC!"
	prompt

BallSentToSomeonesPCText:
	text_from_ram wBoxMonNicknames
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText_CaughtMon:
	text_from_ram wEnemyMonNickname
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"
	sound_slot_machine_start
	text_waitbutton
	text_end

AskGiveNicknameText_CaughtMon:
	text "つかまえた　@"
	text_from_ram wStringBuffer1
	text "に"
	line "なまえを　つけますか"
	done

ReturnToBattle_UseBall:
	call ClearPalettes
	callfar Call_LoadBattleFontsHPBar
	call GetMemSGBLayout
	call CloseWindow
	call LoadStandardMenuHeader
	call WaitBGMap
	call SetPalettes
	ret

TownMapEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	farjp TownMap

BicycleEffect:
	xor a
	ld [wItemEffectSucceeded], a
	call .CheckEnvironment
	ret c
	ldh a, [hROMBank]
	ld hl, .UseBike
	call QueueScript
	ld a, 1
	ld [wItemEffectSucceeded], a
	ret

.CheckEnvironment:
	call GetMapEnvironment
	cp TOWN
	jr z, .ok
	cp ROUTE
	jr z, .ok
	cp CAVE
	jr z, .ok
	jr .nope

.ok
; POSSIBLE BUG: Can't get onto the Bike while on the Skateboard.
	ld a, [wPlayerState]
	and a
	ret z
	cp PLAYER_BIKE
	ret z

.nope
	scf
	ret

.UseBike:
	call RefreshScreen
	ld a, [wPlayerState]
	cp PLAYER_BIKE
	jr z, .get_off_bike
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	ld hl, ItemGotOnText
	jr .done

.get_off_bike
	xor a
	ld [wPlayerState], a
	ld hl, ItemGotOffText
.done
	call MenuTextBox
	call CloseWindow
	call RedrawPlayerSprite
	call PlayMapMusic
	call ScreenCleanup
	ret

EvoStoneEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon

	jr c, .DecidedNotToUse

	ld a, TRUE
	ld [wForceEvolution], a
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call WaitSFX
	pop de
	callfar EvolvePokemon

	ld a, [wMonTriedToEvolve]
	and a
	jr z, .NoEffect
	jp UseDisposableItem

.NoEffect:
	call WontHaveAnyEffectMessage

.DecidedNotToUse
	xor a
	ld [wItemEffectSucceeded], a
	ret

VitaminEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, RareCandy_StatBooster_ExitMenu

	ld a, MON_SPECIES
	call GetPartyParamLocation
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a

	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a

	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick

	call GetStatExpRelativePointer

	pop hl
	push hl
	add hl, bc
	ld bc, MON_STAT_EXP
	add hl, bc
	ld a, [hl]
	cp 100
	jr nc, NoEffectMessage

	add 10
	ld [hl], a
	pop hl
	call UpdateStatsAfterItem

	call GetStatExpRelativePointer

	ld hl, StatStrings
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer2
	ld bc, STRING_BUFFER_LENGTH
	call CopyBytes

	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, ItemStatRoseText
	call PrintText
	jp UseDisposableItem

NoEffectMessage:
	pop hl
	ld hl, ItemWontHaveEffectText
	call PrintText
	jp ClearPalettes

UpdateStatsAfterItem:
	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, MON_STAT_EXP - 1
	add hl, bc
	ld b, TRUE
	predef_jump CalcMonStats

RareCandy_StatBooster_ExitMenu:
	xor a
	ld [wItemEffectSucceeded], a
	call ClearPalettes
	call z, GetMemSGBLayout
	jp ReloadFontAndTileset

ItemStatRoseText:
	text_from_ram wStringBuffer1 ; "(MON)'s"
	text "の　@"
	text_from_ram wStringBuffer2 ; "(STAT) rose."
	text "の"
	line "きそ　ポイントが　あがった！"
	prompt

ItemWontHaveEffectText:
	text "つかっても　こうかが　ないよ" ; "It won't have any effect."
	prompt

StatStrings:
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .special

.health: db "たいりょく@" ; "HEALTH"
.attack: db "こうげきりょく@" ; "ATTACK"
.defense: db "ぼうぎょりょく@" ; "DEFENSE"
.speed: db "すばやさ@" ; "SPEED"
.special: db "とくしゅのうりょく@" ; "SPECIAL"

GetStatExpRelativePointer:
	ld a, [wCurItem]
	ld hl, StatExpItemPointerOffsets
.next
	cp [hl]
	inc hl
	jr z, .got_it
	inc hl
	jr .next

.got_it
	ld a, [hl]
	ld c, a
	ld b, 0
	ret

StatExpItemPointerOffsets:
	db ITEM_HP_UP,    MON_HP_EXP - MON_STAT_EXP
	db ITEM_PROTEIN, MON_ATK_EXP - MON_STAT_EXP
	db ITEM_IRON,    MON_DEF_EXP - MON_STAT_EXP
	db ITEM_CARBOS,  MON_SPD_EXP - MON_STAT_EXP
	db ITEM_CALCIUM, MON_SPC_EXP - MON_STAT_EXP

RareCandyEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, RareCandy_StatBooster_ExitMenu

	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wTempSpecies], a
	push hl

	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl

	push hl
	ld bc, MON_LEVEL
	add hl, bc
	ld a, [hl]
	cp MAX_LEVEL
	jp nc, NoEffectMessage

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	callfar CalcExpAtLevel
	pop de
	pop hl

	push hl
	ld bc, MON_EXP
	add hl, bc
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a
	pop hl

	push hl
	ld bc, MON_MAXHP
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call UpdateStatsAfterItem

	pop hl
	ld bc, MON_MAXHP + 1
	add hl, bc
	pop bc
	ld a, [hld]
	sub c
	ld c, a
	ld a, [hl]
	sbc b
	ld b, a
	dec hl
	ld a, [hl]
	add c
	ld [hld], a
	ld a, [hl]
	adc b
	ld [hl], a

	ld a, PARTYMENUTEXT_LEVEL_UP
	ld [wPartyMenuActionText], a
	callfar WritePartyMenuTilemapAndText

	xor a
	ld [wMonType], a
	predef CopyMonToTempMon

	ld d, 1
	callfar PrintTempMonStats
	call TextboxWaitPressAorB_BlinkCursor

	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wTempSpecies], a
	predef LearnLevelMoves

	xor a
	ld [wForceEvolution], a
	callfar EvolvePokemon
	jp UseDisposableItem

StatusHealingEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a

HealStatus:
	call GetItemHealingAction
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jp z, StatusHealer_NoEffect
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a

	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPlayerSubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]

; This whole section is leftover from an unused mechanic in Generation I, which is broken now
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld de, wBattleMonMaxHP
	ld bc, (NUM_STATS - 1) * 2 ; Doesn't include special defense
	call CopyBytes
	predef DoubleOrHalveSelectedStats_Old

.not_in_battle
	call UseDisposableItem
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	call ItemActionTextWaitButton
	jp StatusHealer_ClearPalettes

GetItemHealingAction:
	push hl
	ld a, [wCurItem]
	ld hl, StatusHealingActions
	ld bc, 3
.next
	cp [hl]
	jr z, .found_it
	add hl, bc
	jr .next

.found_it
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

StatusHealingActions:
	;  item,         party menu action text, status
	db ITEM_ANTIDOTE,     PARTYMENUTEXT_HEAL_PSN, 1 << PSN
	db ITEM_BURN_HEAL,    PARTYMENUTEXT_HEAL_BRN, 1 << BRN
	db ITEM_ICE_HEAL,     PARTYMENUTEXT_HEAL_FRZ, 1 << FRZ
	db ITEM_AWAKENING,    PARTYMENUTEXT_HEAL_SLP,      SLP
	db ITEM_PARLYZ_HEAL,  PARTYMENUTEXT_HEAL_PAR, 1 << PAR
	db ITEM_FULL_HEAL,    PARTYMENUTEXT_HEAL_ALL, %11111111
	db -1, 0, 0 ; end

ReviveEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp nz, StatusHealer_NoEffect

	ld a, [wBattleMode]
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld d, 0
	ld hl, wBattleParticipantsIncludingFainted
	ld b, CHECK_FLAG
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, SET_FLAG
	predef SmallFarFlagAction

.skip_to_revive
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp ITEM_REVIVE
	jr z, .revive_half_hp

	call ReviveFullHP
	jr .finish_revive

.revive_half_hp
	call ReviveHalfHP
.finish_revive
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionefed:
	ret

FullRestoreEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect

	call IsMonAtFullHealth
	jr c, .NotAtFullHealth

	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jp z, StatusHealer_NoEffect

	ld a, ITEM_FULL_HEAL
	ld [wCurItem], a
	jp HealStatus

.NotAtFullHealth
	xor a
	ld [wLowHealthAlarmBuffer], a
	call ReviveFullHP
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a

	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle

	ld hl, wPlayerSubStatus5
	res SUBSTATUS_TOXIC, [hl]
	ld hl, wPlayerSubStatus1
	res SUBSTATUS_NIGHTMARE, [hl]
	xor a
	ld [wBattleMonStatus], a

	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a

.not_in_battle
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionf05a:
	ret

RestoreHPEffect:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage

	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect
	call IsMonAtFullHealth
	jp nc, StatusHealer_NoEffect

	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp ITEM_MAX_POTION
	jr nz, .get_heal_amount
	call ReviveFullHP
	jr .continue_heal

.get_heal_amount
	call GetHealingItemAmount
	call RestoreHealth
.continue_heal
	call IsItemUsedOnBattleMon
	jr nc, .not_in_battle

	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.not_in_battle
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	jp StatusHealer_ClearPalettes

Unreferenced_EmptyFunctionf0af:
	ret

HealHP_SFX_GFX:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	call AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ret

UseItem_SelectMon:
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu_ClearGraphics
	ret

ItemActionTextWaitButton:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, "　"
	call ByteFill
	callfar WritePartyMenuTilemapAndText
	ld a, 1
	ldh [hBGMapMode], a
	ld c, 50
	call DelayFrames
	call TextboxWaitPressAorB_BlinkCursor
	ret

StatusHealer_NoEffect:
	call WontHaveAnyEffectMessage
	jr StatusHealer_ClearPalettes

StatusHealer_ExitMenu:
	xor a
	ld [wFieldMoveSucceeded], a

StatusHealer_ClearPalettes:
	call ClearPalettes
	call z, GetMemSGBLayout
	ld a, [wBattleMode]
	and a
	ret nz
	call ReloadFontAndTileset
	ret

IsItemUsedOnBattleMon:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .nope
	scf
	ret

.nope
	xor a
	ret

ReviveHalfHP:
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

ReviveFullHP:
	call LoadHPFromBuffer1
ContinueRevive:
	ld a, MON_HP
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	call LoadCurHPIntoBuffer3
	ret

RestoreHealth:
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	call LoadCurHPIntoBuffer3
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, MON_MAXHP + 1
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .finish
	call ReviveFullHP
.finish
	ret

IsMonFainted:
	call LoadMaxHPIntoBuffer1
	call LoadCurHPIntoBuffer2
	call LoadHPFromBuffer2
	ld a, d
	or e
	ret

IsMonAtFullHealth:
	call LoadHPFromBuffer2
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer3:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer3 + 1], a
	ld a, [hl]
	ld [wHPBuffer3], a
	ret

; Unreferenced
LoadHPIntoBuffer3:
	ld a, d
	ld [wHPBuffer3 + 1], a
	ld a, e
	ld [wHPBuffer3], a
	ret

; Unreferenced
LoadHPFromBuffer3:
	ld a, [wHPBuffer3 + 1]
	ld d, a
	ld a, [wHPBuffer3]
	ld e, a
	ret

LoadCurHPIntoBuffer2:
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer2 + 1], a
	ld a, [hl]
	ld [wHPBuffer2], a
	ret

LoadHPFromBuffer2:
	ld a, [wHPBuffer2 + 1]
	ld d, a
	ld a, [wHPBuffer2]
	ld e, a
	ret

LoadMaxHPIntoBuffer1:
	push hl
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBuffer1 + 1], a
	ld a, [hl]
	ld [wHPBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1:
	ld a, [wHPBuffer1 + 1]
	ld d, a
	ld a, [wHPBuffer1]
	ld e, a
	ret

GetOneFifthMaxHP:
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	ret

GetHealingItemAmount:
	push hl
	ld a, [wCurItem]
	ld hl, HealingHPAmounts
	ld d, a
.next
	ld a, [hli]
	cp -1
	jr z, .NotFound
	cp d
	jr z, .done
	inc hl
	inc hl
	jr .next

.NotFound:
	scf
.done
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

; INCLUDE IN: "data/items/heal_hp.inc"

HealingHPAmounts:
	dbw ITEM_FRESH_WATER,   50
	dbw ITEM_SODA_POP,      60
	dbw ITEM_LEMONADE,      80
	dbw ITEM_HYPER_POTION, 200
	dbw ITEM_SUPER_POTION,  50
	dbw ITEM_POTION,        20
	dbw -1, 0 ; end

SoftboiledFunction:
	ld a, [wPartyMenuCursor]
	dec a
	ld b, a
.loop
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	predef OpenPartyMenu
	pop bc
	jr c, .skip

	ld a, [wPartyMenuCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .loop

	push bc
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	jr z, .fainted
	call IsMonAtFullHealth
	jp nc, .full_health

	pop bc
	push bc
	ld a, b
	ld [wCurPartyMon], a
	call IsMonFainted
	call GetOneFifthMaxHP
	push de
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld e, a
	ld a, [hl]
	sbc d
	ld [hl], a
	ld d, a
	call LoadHPIntoBuffer3
	call HealHP_SFX_GFX
	pop de
	pop bc

	push bc
	push de
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	pop de
	call RestoreHealth
	call HealHP_SFX_GFX

	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	predef InitPartyMenuLayout
	ld c, 200
	call PartyMenu_WaitForAorB
	pop bc
.skip
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	ret

.fainted
	ld hl, .ItemCantUseOnMonText
	call PartyMenu_TextboxBackup
	pop bc
	jp .loop

; Looks like they might have been intended to have different messages at one point?
.full_health
	ld hl, .ItemCantUseOnMonText
	call PartyMenu_TextboxBackup
	pop bc
	jp .loop

.ItemCantUseOnMonText:
	text "その#には　"
	line "つかえません"
	done

EscapeRopeEffect:
	xor a
	ld [wItemEffectSucceeded], a
	callfar DigFunction
	ret

SuperRepelEffect:
	ld b, 200
	jp UseRepel

MaxRepelEffect:
	ld b, 250
	jp UseRepel

RepelEffect:
	ld b, 100

UseRepel:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld a, b
	ld [wRepelEffect], a
	jp UseItemText

XAccuracyEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_X_ACCURACY, [hl]
	jp UseItemText

PokeDollEffect:
	ld a, [wBattleMode]
	dec a ; WILD_BATTLE?
	jp nz, IsntTheTimeMessage

	ld a, LOSE
	ld [wBattleResult], a
	jp UseItemText

GuardSpecEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_MIST, [hl]
	jp UseItemText

DireHitEffect:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage

	ld hl, wPlayerSubStatus4
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	jp UseItemText

XItemEffect:
	ld a, [wBattleMode]
	and a
	jr nz, .in_battle

	call IsntTheTimeMessage
	ld a, 2
	ld [wItemEffectSucceeded], a
	ret

.in_battle
	ld hl, wPlayerMoveStructAnimation
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
; Uses old index from pokered...
	ld a, [wCurItem]
	sub ITEM_X_ATTACK_RED - EFFECT_ATTACK_UP
	ld [hl], a
	call UseItemText
	ld a, $ae ; XSTATITEM_ANIM in pokered
	ld [wPlayerMoveStructAnimation], a
	call ReloadTilesFromBuffer
	call WaitBGMap
	xor a
	ldh [hBattleTurn], a
; BUG: Wrong bank. Replace $f with BANK(BattleCommand_StatUp) to fix it.
	ld a, $f
	ld hl, BattleCommand_StatUp
	call FarCall_hl

	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ret

; Stubbed with a ret. The rest of the leftover code is intact below here though.
PokeFluteEffect:
	ret

	xor a
	ld [wPokeFluteCuredSleep], a
	ld b, ~SLP
	ld hl, wPartyMon1Status
	call .CureSleep

	ld a, [wBattleMode]
	cp WILD_BATTLE
	jr z, .skip_otrainer
	ld hl, wOTPartyMon1Status
	call .CureSleep
.skip_otrainer

	ld hl, wBattleMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and b
	ld [hl], a

	ld a, [wPokeFluteCuredSleep]
	and a
	ld hl, .PlayedFluteText
	jp z, PrintText
	ld hl, .PlayedTheFlute
	call PrintText

	ld a, [wLowHealthAlarmBuffer]
	and 1 << DANGER_ON_F
	jr nz, .dummy
	; more code was dummied out here
.dummy
	ld hl, .FluteWakeUpText
	jp PrintText

.CureSleep:
	ld de, PARTYMON_STRUCT_LENGTH
	ld c, PARTY_LENGTH
.loop
	ld a, [hl]
	push af
	and SLP
	jr z, .not_asleep
	ld a, TRUE
	ld [wPokeFluteCuredSleep], a
.not_asleep
	pop af
	and b
	ld [hl], a
	add hl, de
	dec c
	jr nz, .loop
	ret

MACRO dbmapcoord
	db \2, \1
ENDM

.Unreferenced_Route12SnorlaxFluteCoords:
	dbmapcoord  9, 62 ; one space West of Snorlax
	dbmapcoord 10, 61 ; one space North of Snorlax
	dbmapcoord 10, 63 ; one space South of Snorlax
	dbmapcoord 11, 62 ; one space East of Snorlax
	db -1 ; end

.Unreferenced_Route16SnorlaxFluteCoords:
	dbmapcoord 27, 10 ; one space East of Snorlax
	dbmapcoord 25, 10 ; one space West of Snorlax
	db -1 ; end

.PlayedFluteText:
	text "#のふえを　ふいた！"
	para "うーん！"
	line "すばらしい　ねいろだ！"
	prompt

.FluteWakeUpText:
	text "すべての　#が"
	line "めを　さました！"
	prompt

.PlayedTheFlute:
	text "<PLAYER>は"
	line "#のふえを　ふいてみた！@"
; BUG: No text_asm.
	ld b, 8
	ld a, [wBattleMode]
	and a
	jr nz, .battle

	push de
	ld de, SFX_POKEFLUTE
	call WaitPlaySFX
	call WaitSFX
	pop de

.battle
	jp GetTerminatingString

CoinCaseEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

	ld hl, CoinCaseCountText
	call MenuTextBox
	call CloseWindow
	ret

CoinCaseCountText:
	text "あなたの　コイン"
	line "@"
	deciram wCoins, 2, 4
	text "まい"
	prompt

; These rod effects haven't been touched since Generation I... like, at all.
; The only change was in FishingInit_Old to force the water check to always fail.
OldRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
	lb bc, 5, MON_MAGIKARP
	ld a, $1
	jr RodResponse_Old

GoodRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
.random_loop
	call Random
	srl a
	jr c, .set_bite
	and %11
	cp $2
	jr nc, .random_loop
	ld hl, .GoodRodMons
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.set_bite
	ld a, 0
	rla
	xor 1
	jr RodResponse_Old

; random choice of 2 good rod encounters
.GoodRodMons:
	; level, species
	db 10, MON_GOLDEEN
	db 10, MON_POLIWAG

SuperRodEffect_Old:
	call FishingInit_Old
	jp c, IsntTheTimeMessage
	call ReadSuperRodData_Old
	ld a, e

RodResponse_Old:
	ld [wRodResponse_Old], a

	dec a
	jr nz, .next

	ld a, 1
	ld [wAttackMissed], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, c
	ld [wTempWildMonSpecies], a

.next
	ld hl, wPlayerState
	ld a, [hl]
	push af
	ld [hl], 0
	push hl
	farcall FishingAnim_Old
	pop hl
	pop af
	ld [hl], a
	ret

FishingInit_Old:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle
	scf
	ret

.not_in_battle
	call Stub_IsNextTileShoreOrWater_Old
	ret c
	ld a, [wPlayerState]
	cp $2 ; PLAYER_SURF at one point
	jr z, .surfing
	call ItemUseReloadOverworldData_Old
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld c, 80
	call DelayFrames
	and a
	ret

.surfing
	scf
	ret

PPUpEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

RestorePPEffect:
	ld a, [wCurItem]
	ld [wTempRestorePPItem], a

.loop
	; Party Screen opens to choose on which mon to use the Item
	ld a, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jr nc, .loop2
	jp PPRestoreItem_Cancel

.loop2
	ld a, [wTempRestorePPItem]
	cp ITEM_ELIXER_RED
	jp nc, Elixer_RestorePPofAllMoves
	ld a, 2
	ld [wMoveSelectionMenuType], a
	ld hl, RaiseThePPOfWhichMoveText
	ld a, [wTempRestorePPItem]
	cp ITEM_ETHER_RED
	jr c, .ppup
	ld hl, RestoreThePPOfWhichMoveText

.ppup
	call PrintText
	callfar MoveSelectionScreen
	jr nz, .loop

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	push hl
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop hl

	ld a, [wTempRestorePPItem]
	cp ITEM_ETHER_RED
	jr nc, Not_PP_Up

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	cp PP_UP_MASK
	jr c, .do_ppup

	ld hl, PPIsMaxedOutText
	call PrintText
	jr .loop2

.do_ppup
	ld a, [hl]
	add PP_UP_ONE
	ld [hl], a
	ld a, TRUE
	ld [wUsePPUp], a
	call ApplyPPUp
	ld hl, PPsIncreasedText
	call PrintText

FinishPPRestore:
	call ClearPalettes
	call GetMemSGBLayout
	jp UseDisposableItem

BattleRestorePP:
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle

	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .not_in_battle

	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call AddNTimes
	ld de, wBattleMonPP
	ld bc, NUM_MOVES
	call CopyBytes
.not_in_battle
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, PPRestoredText
	call PrintText
	jr FinishPPRestore

Not_PP_Up:
	call RestorePP
	jr nz, BattleRestorePP
	jp PPRestoreItem_NoEffect

RestorePP:
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [wTempPP]
	ld b, a

	ld a, [wTempRestorePPItem]
	cp ITEM_MAX_ETHER_RED
	jr z, .restore_all

	ld a, [hl]
	and PP_MASK
	cp b
	ret z

	add 10
	cp b
	jr nc, .restore_some
	ld b, a
	
.restore_some
	ld a, [hl]
	and PP_UP_MASK
	add b
	ld [hl], a
	ret
.restore_all
	ld a, [hl]
	cp b
	ret z
	jr .restore_some

Elixer_RestorePPofAllMoves:
	ld hl, wTempRestorePPItem
	dec [hl]
	dec [hl]

	xor a
	ld hl, wMenuCursorY
	ld [hli], a
	ld [hl], a
	ld b, NUM_MOVES
.move_loop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .next

	call RestorePP
	jr z, .next
	ld hl, wMenuCursorX
	inc [hl]

.next
	ld hl, wMenuCursorY
	inc [hl]
	pop bc
	dec b
	jr nz, .move_loop
	ld a, [wMenuCursorX]
	and a
	jp nz, BattleRestorePP

PPRestoreItem_NoEffect:
	call WontHaveAnyEffectMessage

PPRestoreItem_Cancel:
	call ClearPalettes
	call GetMemSGBLayout
	pop af
	xor a
	ld [wItemEffectSucceeded], a
	ret

RaiseThePPOfWhichMoveText:
	text "どのわざの"
	line "ポイントをふやす？"
	done

RestoreThePPOfWhichMoveText:
	text "どのわざを"
	line "かいふくする？"
	done

PPIsMaxedOutText:
	text_from_ram wStringBuffer2
	text "は　これいじょう"
	line "ふやすことが　できません"
	prompt

PPsIncreasedText:
	text_from_ram wStringBuffer2
	text "の"
	line "わざポイントが　ふえた！"
	prompt

PPRestoredText:
	text "わざポイントが"
	line "かいふくした！"
	prompt

TMHolderEffect:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	jpfar _TMHolder

Stub_NuggetEffect:
	jp IsntTheTimeMessage

NoEffect:
	jp IsntTheTimeMessage

Dummy_NewItemEffect:
	jp IsntTheTimeMessage

Unreferenced_EnterBreeder:
	jp _Breeder

AskTeachTMHM:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	
	ld a, [wCurItem]
	sub ITEM_TM01_RED
	push af
	jr nc, .is_tm_or_hm
	add NUM_TM_HM - 2 ; Generation I only had 5 HMs
.is_tm_or_hm
	inc a
	ld [wTempTMHM], a
	predef GetTMHMMove
	ld a, [wTempTMHM]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop af
	ld hl, .BootedTMText
	jr nc, .TM
	ld hl, .BootedHMText
.TM
	call PrintText
	ld hl, .ContainedMoveText
	call PrintText
	call YesNoBox
	jr nc, .ChooseMonToLearnTMHM

	ld a, 2
	ld [wItemEffectSucceeded], a
	ret

.ChooseMonToLearnTMHM:
.loopback
	ld hl, wStringBuffer2
	ld de, wMonOrItemNameBuffer
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes

	ld a, PARTYMENUACTION_TEACH_TMHM
	call UseItem_SelectMon
	push af
	ld hl, wMonOrItemNameBuffer
	ld de, wStringBuffer2
	ld bc, MOVE_NAME_LENGTH
	call CopyBytes
	pop af
	jr nc, .TeachTMHM

	pop af
	pop af
	call ClearBGPalettes
	call ClearSprites
	call GetMemSGBLayout
	jp ReloadTilesFromBuffer

.TeachTMHM:
	predef CanLearnTMHMMove
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc

	ld a, c
	and a
	jr nz, .compatible
	ld de, SFX_WRONG
	call WaitPlaySFX

	ld hl, .TMHMNotCompatibleText
	call PrintText
	jr .loopback

.compatible
	call KnowsMove
	jr c, .loopback

	predef LearnMove
	ld a, b
	and a
	ret z

	ld a, [wCurItem]
	call IsHM
	ret c

	jp UseDisposableItem

.BootedTMText:
	text "<TM>を　きどうした！"
	prompt

.BootedHMText:
	text "ひでんマシンを　きどうした！"

.ContainedMoveText:
	text "なかには　@"
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"
	para "@"
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

.TMHMNotCompatibleText:
	text_from_ram wStringBuffer1
	text "と　@"
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"
	para "@"
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt

UseItemText:
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call TextboxWaitPressAorB_BlinkCursor

UseDisposableItem:
	ld hl, wItems
	ld a, 1
	ld [wItemQuantity], a
	call TossItem
	ret

UseBallInTrainerBattle:
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimID], a
	ld a, d
	ld [wFXAnimID + 1], a
	xor a
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BallBlockedText
	call PrintText
	ld hl, BallDontBeAThiefText
	call PrintText
	jr UseDisposableItem

Ball_BoxIsFullMessage:
	ld hl, BallBoxFullText
	jr CantUseItemMessage

IsntTheTimeMessage:
	ld hl, ItemOakWarningText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, ItemWontHaveAnyEffectText
	jr CantUseItemMessage

; Unreferenced
BelongsToSomeoneElseMessage:
	ld hl, ItemBelongsToSomeoneElseText
	jr CantUseItemMessage

; Unreferenced
CyclingIsntAllowedMessage:
	ld hl, NoCyclingText
	jr CantUseItemMessage

; Unreferenced
CantGetOnYourBikeMessage:
	ld hl, ItemCantGetOnText

CantUseItemMessage:
	xor a
	ld [wItemEffectSucceeded], a
	jp PrintText

ItemOakWarningText:
	text "オーキドの　ことば<⋯⋯>"
	line "<PLAYER>よ！　こういうものには"
	cont "つかいどきが　あるのじゃ！"
	prompt

ItemBelongsToSomeoneElseText:
	text "たいせつな　あずかりものです！"
	next "つかうことは　できません！"
	prompt

ItemWontHaveAnyEffectText:
	text "つかっても　こうかがないよ"
	prompt

BallBlockedText:
	text "<TRAINER>に　ボールを　はじかれた！"
	prompt

BallDontBeAThiefText:
	text "ひとの　ものを　とったら　どろぼう！"
	prompt

NoCyclingText:
	text "ここでは　じてんしゃに"
	next "のることは　できません"
	prompt

ItemCantGetOnText:
	text "ここでは@"
	text_from_ram wStringBuffer1
	text "に"
	line "のることは　できません"
	prompt

BallBoxFullText:
	text "ボックスに　あずけている　#が"
	line "いっぱいなので　つかえません！"
	prompt

ItemUsedText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "を　つかった！"
	done

ItemGotOnText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "に　のった"
	prompt

ItemGotOffText:
	text "<PLAYER>は@"
	text_low
	text_from_ram wStringBuffer2
	text "から　おりた"
	prompt

SECTION "engine/dumps/bank03.asm@GetMaxPPOfMove", ROMX

GetMaxPPOfMove::
	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wBoxMon1Moves
	ld bc, BOXMON_STRUCT_LENGTH
	dec a
	jr z, .got_partymon ; BOXMON

	ld hl, wBufferMonMoves
	dec a
	jr z, .got_nonpartymon ; TEMPMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; TEMPMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON, BOXMON
	call GetMthMoveOfNthPartymon

.gotdatmove
	ld a, [hl]
	dec a

	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	call AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl

	push bc
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, wEnemyMonPP - wEnemyMonMoves
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wTempPP], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wTempPP], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes

GetMthMoveOfCurrentMon:
	ld a, [wMenuCursorY]
	ld c, a
	ld b, $00
	add hl, bc
	ret

; Dummied out to always return the carry flag.
Stub_IsNextTileShoreOrWater_Old:
	scf
	ret

ReadSuperRodData_Old:
	ld a, [wMapId]
	ld de, 3
	ld hl, SuperRodData
	call FindItemInTable
	jr c, .ReadFishingGroup
	ld e, 2
	ret

.ReadFishingGroup
	inc hl

	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld b, [hl]
	inc hl
	ld e, $00

.random_loop
	call Random
	srl a
	ret c
	and %11
	cp b
	jr nc, .random_loop

	add a
	ld c, a
	ld b, 0
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld e, 1
	ret

SuperRodData:
	dbw $00, .Group1  ; PALLET_TOWN
	dbw $01, .Group1  ; VIRIDIAN_CITY
	dbw $03, .Group3  ; CERULEAN_CITY
	dbw $05, .Group4  ; VERMILION_CITY
	dbw $06, .Group5  ; CELADON_CITY
	dbw $07, .Group10 ; FUCHSIA_CITY
	dbw $08, .Group8  ; CINNABAR_ISLAND
	dbw $0f, .Group3  ; ROUTE_4
	dbw $11, .Group4  ; ROUTE_6
	dbw $15, .Group5  ; ROUTE_10
	dbw $16, .Group4  ; ROUTE_11
	dbw $17, .Group7  ; ROUTE_12
	dbw $18, .Group7  ; ROUTE_13
	dbw $1c, .Group7  ; ROUTE_17
	dbw $1d, .Group7  ; ROUTE_18
	dbw $1e, .Group8  ; ROUTE_19
	dbw $1f, .Group8  ; ROUTE_20
	dbw $20, .Group8  ; ROUTE_21
	dbw $21, .Group2  ; ROUTE_22
	dbw $22, .Group9  ; ROUTE_23
	dbw $23, .Group3  ; ROUTE_24
	dbw $24, .Group3  ; ROUTE_25
	dbw $41, .Group3  ; CERULEAN_GYM
	dbw $5e, .Group4  ; VERMILION_DOCK
	dbw $a1, .Group8  ; SEAFOAM_ISLANDS_B3F
	dbw $a2, .Group8  ; SEAFOAM_ISLANDS_B4F
	dbw $d9, .Group6  ; SAFARI_ZONE_EAST
	dbw $da, .Group6  ; SAFART_ZONE_NORTH
	dbw $db, .Group6  ; SAFARI_ZONE_WEST
	dbw $dc, .Group6  ; SAFARI_ZONE_CENTER
	dbw $e2, .Group9  ; CERULEAN_CAVE_2F
	dbw $e3, .Group9  ; CERULEAN_CAVE_B1F
	dbw $e4, .Group9  ; CERLIEAN_CAVE_1F
	db -1 ; end

.Group1:
	db 2
	db 15, MON_TENTACOOL
	db 15, MON_POLIWAG

.Group2:
	db 2
	db 15, MON_GOLDEEN
	db 15, MON_POLIWAG

.Group3:
	db 3
	db 15, MON_PSYDUCK
	db 15, MON_GOLDEEN
	db 15, MON_KRABBY

.Group4:
	db 2
	db 15, MON_KRABBY
	db 15, MON_SHELLDER

.Group5:
	db 2
	db 23, MON_POLIWHIRL
	db 15, MON_SLOWPOKE

.Group6:
	db 4
	db 15, MON_DRATINI
	db 15, MON_KRABBY
	db 15, MON_PSYDUCK
	db 15, MON_SLOWPOKE

.Group7:
	db 4
	db  5, MON_TENTACOOL
	db 15, MON_KRABBY
	db 15, MON_GOLDEEN
	db 15, MON_MAGIKARP

.Group8:
	db 4
	db 15, MON_STARYU
	db 15, MON_HORSEA
	db 15, MON_SHELLDER
	db 15, MON_GOLDEEN

.Group9:
	db 4
	db 23, MON_SLOWBRO
	db 23, MON_SEAKING
	db 23, MON_KINGLER
	db 23, MON_SEADRA

.Group10:
	db 4
	db 23, MON_SEAKING
	db 15, MON_KRABBY
	db 15, MON_GOLDEEN
	db 15, MON_MAGIKARP

ItemUseReloadOverworldData_Old::
	call LoadMapPart
	jp UpdateSprites

_Breeder::
	ld a, [wBreederStatus]
	cp 2
	jr c, .continue
	cp 3
	jp z, .AskGiveEgg
	cp 4
	jr z, .continue

	call .CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	and a
	jr z, .no_egg_yet
; Autogenerates an egg if the Pokémon are compatible.
	ld a, 3
	ld [wBreederStatus], a
.no_egg_yet
	ld hl, .NoEggYetText
	call PrintText

.continue
	ld hl, .IntroText
	call PrintText
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	push af
	call CloseWindow
	pop af
	jp c, .Exit
	ld a, [wMenuCursorY]
	cp 3
	jp z, .Exit
	cp 1
	jr z, .Deposit

	ld a, [wBreederStatus]
	and a
	jr z, .no_breedmons
	cp 2
	jr nz, .Withdraw

	ld hl, .CheckOnPokemonText
	call PrintText
	call YesNoBox
	jp c, .Exit

	jr .Withdraw

.no_breedmons
	ld hl, .DoesntHavePokemonText
	call PrintText
	jp .Exit

.Withdraw:
	ld a, GET_BREED_MON
	ld [wPokemonWithdrawDepositParameter], a
	predef RetrieveBreedmonOrBuffermon
	jp c, .party_full

	ld a, [wBreederStatus]
	sub 1
	jr z, .last_mon
	ld a, 1
.last_mon
	ld [wBreederStatus], a
	ld a, [wBreedMonGenders]
	srl a
	ld [wBreedMonGenders], a
	ld hl, .WithdrawnText
	call PrintText
	jp .Exit

.Deposit:
	ld a, [wBreederStatus]
	cp 2
	jp nc, .empty

	add PARTYMENUACTION_GIVE_MON
	call UseItem_SelectMon
	jp c, .Exit

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wMonType], a
	predef GetGender

	ld a, [wBreedMonGenders]
	rla
	ld [wBreedMonGenders], a

	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, GET_BREED_MON
	ld [wPokemonWithdrawDepositParameter], a
	predef DepositBreedmonOrBuffermon
	
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	callfar RemoveMonFromPartyOrBox ; in the same bank, no need to farcall!
	ld a, [wCurPartySpecies]
	call PlayCry

	ld hl, .DepositedText
	call PrintText
	ld a, [wBreederStatus]
	inc a
	ld [wBreederStatus], a
	cp 2
	jr nz, .Exit

	ld hl, .LetsMakeBabiesText
	call PrintText

	call .CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	cp 80
	ld hl, .SeemToGetAlongText
	call z, PrintText

	ld a, [wBreedingCompatibility]
	cp 20
	ld hl, .DontSeemToGetAlongText
	call z, PrintText

	ld a, [wBreedingCompatibility]
	and a
	ld hl, .GendersDontMatchText
	call z, PrintText
	jr .Exit
.empty
	ld hl, .AlreadyHasTwoPokemonText
	call PrintText
	jr .Exit

.Exit:
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	call GetMemSGBLayout
	jp ReloadFontAndTileset

.party_full
	ld hl, .BoxAndPartyFullText
	jp PrintText

.CheckBreedmonCompatibility:
; BUG: Assumes that wBreedMonGenders has already been set from opening the Breeder menu with 1 or fewer Pokémon.
; If you open the breeder after saving and resetting the game while they have two Pokémon
; (assuming the BreedMons GET saved at this point in development),
; then this check will fail until you change out the BreedMons again.
	ld a, [wBreedMonGenders]
	ld b, a
	srl b
	xor b
	and $1
	jr z, .done

	ld a, [wBreedMon1ID]
	ld b, a
	ld a, [wBreedMon2ID]
	cp b
	jr nz, .different_id

	ld a, [wBreedMon1ID + 1]
	ld b, a
	ld a, [wBreedMon2ID + 1]
	cp b
	jr nz, .different_id
	ld a, 20
	jr .done
.different_id
	ld a, 80
.done
	ld [wBreedingCompatibility], a
	ret

.IntroText:
	text "わたしは　こずくりやさん"
	line "さて　どうする？"
	done

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 13, 4, 19, 11
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "あずける@"	; Deposit
	db "ひきとる@"	; Withdraw
	db "やめる@"	; Cancel

.DepositedText:
	text "あずけた！"
	prompt

.AlreadyHasTwoPokemonText:
	text "すでに　２ひきの#を"
	line "あずかっています"
	prompt

.CheckOnPokemonText:
	text "こずくりを　ちゅうししますか？"
	done

.DoesntHavePokemonText:
	text "#は　いっぴきも"
	line "あずかってませんが"
	prompt

.WithdrawnText:
	text "ひきとった！"
	prompt

.BoxAndPartyFullText:
	text "てもちも　マサキの　<PC>も"
	line "#で　いっぱいのようです"
	prompt

.LetsMakeBabiesText:
	text "それでは　こづくりします！"
	prompt

.SeemToGetAlongText:
	text "あいしょうが　いいようです"
	prompt

.DontSeemToGetAlongText:
	text "あいしょうが　わるいようです"
	prompt

.GendersDontMatchText:
	text "せいべつが　あわないようです"
	prompt

.NoEggYetText:
	text "ざんねんながら　まだ　うまれて"
	line "こないようです"
	prompt

.AskGiveEgg:
	ld hl, .EggLaidText
	call PrintText
	call YesNoBox
	jp c, .Exit

	ld a, 4
	ld [wBreederStatus], a
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	call PlayCry

	xor a
	ld [wMonType], a
	ld a, 5
	ld [wCurPartyLevel], a
	predef GiveEgg
	jp .Exit

.EggLaidText:
	text "タマゴが　うまれました！"
	line "ひきとりますか？"
	done

Stub_MailEffect::
	ret

; START OF: "engine/battle_anims/pokeball_wobble.asm"

GetPokeBallWobble:
; Returns whether a Poke Ball will wobble in the catch animation.
; Whether a Pokemon is caught is determined beforehand.

	ld a, [wThrownBallWobbleCount]
	inc a
	ld [wThrownBallWobbleCount], a

; Wobble up to 3 times.
	cp 3 + 1
	jr z, .finished
	ld a, [wWildMon]
	and a
	ld c, 0 ; next
	ret nz
	ld hl, WobbleProbabilities
	ld a, [wFinalCatchRate]
	ld b, a
.loop
	ld a, [hli]
	cp b
	jr nc, .checkwobble
	inc hl
	jr .loop
.checkwobble
	ld b, [hl]
	call Random
	cp b
	ld c, 0 ; next
	ret c
	ld c, 2 ; escaped
	ret

.finished
	ld a, [wWildMon]
	and a
	ld c, 1 ; caught
	ret nz
	ld c, 2 ; escaped
	ret

WobbleProbabilities:
; catch rate, chance of wobbling / 255
; nLeft/255 = (nRight/255) ** 4
	db   1,  63
	db   2,  75
	db   3,  84
	db   4,  90
	db   5,  95
	db   7, 103
	db  10, 113
	db  15, 126
	db  20, 134
	db  30, 149
	db  40, 160
	db  50, 169
	db  60, 177
	db  80, 191
	db 100, 201
	db 120, 211
	db 140, 220
	db 160, 227
	db 180, 234
	db 200, 240
	db 220, 246
	db 240, 251
	db 254, 253
	db 255, 255

KnowsMove:
	ld a, MON_MOVES
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, KnowsMoveText
	call PrintText
	scf
	ret

KnowsMoveText:
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Bank03_FillerStart::
Unreferenced_BootedHMTextfde0:
	db "います"
	prompt
; This is missing the preceeding "text_from_ram" byte
	dw wStringBuffer2
	text "を　おぼえています"
	prompt
	db $28, $3c

Unreferenced_KnowsMoveText_Old:
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	cp b
	jr z, .knows_move
	dec c
	jr nz, .loop
	and a
	ret

.knows_move
	ld hl, .KnowsMoveText
	call PrintText
	scf
	ret

.KnowsMoveText
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Unreferenced_Fillerfe23:
	db $e0, $22, $47, $24, $80, $a3, $01, $50
	db $02, $85, $b0, $09, $35, $51, $2c, $08
	db $24, $25, $0b, $84, $84, $00, $4e, $3b
	db $4b, $02, $60, $2a, $26, $21, $01, $40
	db $10, $1f, $31, $44, $80, $08, $02, $3c
	db $41, $00, $68, $49, $57, $41, $94, $00
	db $34, $36, $9c, $e4, $01, $0c, $60, $01
	db $81, $23, $a2, $26, $43, $05, $81, $5f
	db $16, $a2, $80, $34, $0c, $82, $63, $91
	db $44, $52, $02, $ce, $00, $10, $44, $01
	db $96, $0e, $ac, $10, $23, $84, $28, $00
	db $22, $45, $22, $55, $00, $ef, $ff, $77
	db $5b, $fe, $87, $db, $df, $b5, $bf, $d7
	db $1f, $d9, $fc, $e9, $fd, $df, $79, $96
	db $7d, $af, $d7, $5e, $17, $37, $e7, $ef
	db $3e, $ff, $f9, $d4, $7d, $bf, $fb, $df
	db $bb, $fe, $db, $53, $fb, $cc, $d3, $fe
	db $92, $7f, $bb, $bc, $d7, $3b, $dd, $6f
	db $7b, $2f, $b7, $ff, $b9, $d0, $b7, $e5
	db $7b, $e0, $c7, $bf, $dd, $df, $6d, $bb
	db $f6, $f7, $73, $f9, $ff, $bc, $bb, $f7
	db $fd, $bd, $db, $e7, $be, $7b, $35, $5b
	db $f3, $98, $df, $f4, $2f, $fb, $ff, $6b
	db $fe, $ef, $6b, $ec, $1f, $7a, $3e, $ea
	db $9b, $dd, $df, $ed, $ff, $fe, $bf, $26
	db $7d, $9e, $ef, $be, $ff, $77, $fb, $ff
	db $ff, $5e, $f2, $bc, $fd, $7a, $aa, $fa
	db $af, $9d, $ed, $f1, $fd, $10, $10, $2d
	db $d1, $00, $21, $14, $d3, $1b, $27, $22
	db $85, $45, $5a, $43, $0c, $b1, $74, $61
	db $48, $40, $2f, $8c, $84, $08, $c2, $90
	db $f7, $44, $45, $80, $90, $12, $c5, $93
	db $1c, $11, $6e, $c8, $26, $25, $c1, $25
	db $00, $1e, $55, $02, $54, $04, $0f, $10
	db $20, $d7, $a2, $3c, $04, $3b, $02, $01
	db $22, $00, $c0, $00, $13, $d2, $05, $02
	db $48, $2a, $89, $40, $1f, $3e, $44, $12
	db $40, $16, $d8, $91, $10, $01, $54, $87
	db $1f, $99, $40, $d0, $79, $f8, $25, $4c
	db $d0, $a0, $02, $13, $1c, $02, $03, $11
	db $a0, $19, $06, $0e, $70, $97, $44, $0e
	db $11, $24, $0f, $80, $60, $06, $09, $01
	db $c5, $e1, $30, $13, $15, $14, $59, $02
	db $4c, $a9, $11, $08, $04, $eb, $df, $9d
	db $55, $ff, $b7, $57, $fb, $78, $7e, $7e
	db $c7, $3a, $e1, $ff, $5f, $7d, $5f, $fd
	db $5f, $f8, $6d, $2f, $bd, $75, $6f, $3f
	db $ff, $9f, $fc, $b5, $f6, $c5, $14, $fa
	db $d9, $ff, $9d, $fb, $7f, $f3, $ff, $6b
	db $fb, $9f, $eb, $5f, $df, $de, $ed, $bf
	db $7f, $59, $26, $df, $ee, $b3, $5f, $fd
	db $f7, $ff, $ff, $ff, $5b, $f8, $db, $fa
	db $7f, $de, $af, $5f, $df, $9f, $d8, $be
	db $ea, $bf, $fe, $eb, $dd, $eb, $f9, $e5
	db $bd, $f3, $ff, $fe, $ff, $f7, $f7, $d5
	db $f5, $f9, $5f, $bf, $fd, $5e, $df, $de
	db $ff, $bf, $bb, $93, $fc, $ff, $cc, $af
	db $f5, $d7, $7f, $ff, $fe, $b5, $ff, $9f
	db $95, $7a, $6b, $7b, $ff, $6f, $bb, $c7
	db $ef, $34, $ff, $d7, $3d
