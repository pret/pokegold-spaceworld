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

Functionc9c1:
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
	dw _Functionc9c1
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

_Functionc9c1:
	callfar Functionc9c1
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
; wPokemonWithdrawDepositParameter == 2: get mon from DayCare.
; wPokemonWithdrawDepositParameter == 3: put mon into DayCare.
SendGetMonIntoFromBox::
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .check_IfPartyIsFull
	cp $02
	jr z, .check_IfPartyIsFull
	cp $03
	ld hl, wBufferMon
	jr z, .sub_db1f

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
	ld b, $00
	add hl, bc
	ld a, [wPokemonWithdrawDepositParameter]
	cp $02
	ld a, [wBufferMonSpecies]
	jr z, .okay1
	ld a, [wCurPartySpecies]

.okay1
	ld [hli], a
	ld [hl], $ff
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
.sub_db1f
	push hl
	ld e, l
	ld d, h
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	ld hl, wBoxMon1
	ld bc, BOXMON_STRUCT_LENGTH
	jr z, .okay3
	cp $02
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
	cp $03
	ld de, wBufferMonOT
	jr z, .okay5
	dec a
	ld hl, wPartyMonOTs
	ld a, [wPartyCount]
	jr nz, .okay6
	ld hl, wBoxMonOT
	ld a, [wBoxCount]

.okay6
	dec a
	call SkipNames
	ld d, h
	ld e, l

.okay5
	ld hl, wBoxMonOT
	ld a, [wPokemonWithdrawDepositParameter]
	and a
	jr z, .okay7
	ld hl, wBufferMonOT
	cp $02
	jr z, .okay8
	ld hl, wPartyMonOTs

.okay7
	ld a, [wCurPartyMon]
	call SkipNames

.okay8
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wPokemonWithdrawDepositParameter]
	cp $03
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
	cp $02
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
	cp $01
	jr z, .done_clear_carry
	cp $03
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
RetrieveBreedmon:
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
	jr z, .okay
	ld a, [wBreedMon1Species]
	ld de, wBreedMon1Nickname

.okay
	ld [hli], a
	ld [wCurSpecies], a
	ld a, $ff
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

	ld hl, wBoxMonOT
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

; TODO: Withdraw/Deposit Pokémon in breeder?
Functiondcfc::
	ld a, [wPokemonWithdrawDepositParameter]
	ld de, wBufferMonNickname
	and a
	jr z, .withdraw

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

.withdraw
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
	inc de ; wBoxList
	ld a, [de]
	ld b, a
	ld a, c
	ld c, b
	ld [de], a
	cp -1
	jr nz, .loop

	call GetBaseData
	ld hl, wBoxMonOT
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
	ld de, wBoxMonOT
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

; 
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
	ld hl, wBoxMonOT
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
	ld bc, wBoxMonOT
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
	dw Functione5c5
	dw Functione31b
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
	ld hl, Tablee6da
	call BillsPC_Menu
	call CloseWindow
	ret c

	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ld a, 1
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

Functione31b:
	call .sub_e325
	jr c, .sub_e323
	call Functione350
.sub_e323
	and a
	ret
.sub_e325
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr nc, .sub_e32e
	and a
	ret
.sub_e32e
	ld hl, Texte336
	call MenuTextBoxBackup
	scf
	ret

Texte336:
	text "それいじょう　よくばったって"
	line "#　もたれへんで！"
	prompt

Functione350:
	call LoadStandardMenuHeader
	ld hl, Datae6f8
	call BillsPC_Menu
	call CloseWindow
	ret c
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	predef SendGetMonIntoFromBox
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

BillsPC_ReleaseMon:
	call .sub_e380
	and a
	ret
.sub_e380
	call LoadStandardMenuHeader
	ld hl, Datae6f8
	call BillsPC_Menu
	call CloseWindow
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, [wMenuSelection]
	ld [wCurPartySpecies], a
	ret c
	ld hl, OnceReleasedText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	call RemoveMonFromPartyOrBox
	ret

OnceReleasedText:
	text_from_ram wStringBuffer1
	text "　をほんとうに" ; "Are you sure you"
	next "にがしますか？" ; "want to release (MON)?"
	done

BillsPC_ChangeBoxMenu:
	call _ChangeBox
	and a
	ret

_ChangeBox:
	call BoxSelectFunc
	call LoadStandardMenuHeader
	call ClearPalettes
	call ClearTileMap
.sub_e3d4
	ld hl, Datae414
	call CopyMenuHeader
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e3e9
	call BoxEditMenu
	jr .sub_e3d4
.sub_e3e9
	call CloseWindow
	ret

BoxSelectFunc:
	ld hl, wd4b9
	ld c, $00
.sub_e3f2
	push hl
	ld de, DummyBoxText
	call CopyString
	ld a, "０"
	add c
	dec hl
	ld [hli], a
	ld [hl], "@"
	pop hl
	ld de, $0009
	add hl, de
	inc c
	ld a, c
	cp $0a
	jr c, .sub_e3f2
	ret

DummyBoxText:
	db "ダミーボックス@" ; "Dummy Box"

Datae414:
	db $40, $00, $00, $0c, $13, $1c, $64, $01
	db $20, $04, $00, $01, $03, $2c, $64, $03
	db $38, $64, $00, $00, $00, $03, $9d, $64
	db $0a, $01, $02, $03, $04, $05, $06, $07
	db $08, $09, $0a, $ff

Functione438:
	push de
	ld a, [wMenuSelection]
	dec a
	ld bc, $0006
	ld hl, Texte461
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	push bc
	ld a, [wMenuSelection]
	dec a
	ld bc, $0009
	ld hl, wd4b9
	call AddNTimes
	ld d, h
	ld e, l
	pop hl
	call PlaceString
	ret

Texte461:
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

Functione49d: ; change box screen items
	ld h, d
	ld l, e
	ld de, MonInMyCareText
	call PlaceString
	ld hl, $0003
	add hl, bc
	push hl
	call Functione4ce
	pop hl
	ld de, wStringBuffer1
	ld [de], a
	ld bc, $0102
	call PrintNumber
	ld de, OutOfThirtyText
	call PlaceString
	ret

MonInMyCareText: ; unfinished feature to show how many mon are in your box
	db "あずかっている#" ; "Mon in my care"
	next "　@"

OutOfThirtyText: ; max mon per box
	db "／３０@"

Functione4ce: ; counts available mon in highlighted box
	ld a, [wMenuSelection]
	dec a
	ld c, a
	ld b, $00
	ld hl, Datae4e7
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

Datae4e7: ; checks box slots for mon counting
	db $02, $00, $a0
	db $02, $48, $a5
	db $02, $90, $aa
	db $02, $d8, $af
	db $02, $20, $b5
	db $03, $00, $a0
	db $03, $48, $a5
	db $03, $90, $aa
	db $03, $d8, $af
	db $03, $20, $b5

BoxEditMenu:
	ld hl, BoxEditMenuList
	call LoadMenuHeader
	call VerticalMenu
	call CloseWindow
	ret c
	ld a, [w2DMenuDataEnd]
	cp $01
	jr z, PromptChangeBoxWillYouSave
	cp $02
	jr z, ChangeBoxName
	and a
	ret

PrintBoxChangeUnderDev:
	ld hl, BoxChangeUnderDevText
	call MenuTextBox
	call CloseWindow
	ret

BoxChangeUnderDevText:
	text "バンクチェンジは" ; "Box change is"
	next "かいはつちゅうです！" ; "under development!"
	prompt

PromptChangeBoxWillYouSave:
	ld hl, WhenYouChangeBoxText
	call MenuTextBox
	call YesNoBox
	call CloseWindow
	ret c
	jr PrintBoxChangeUnderDev

Functione54d:
	ld a, [wMenuSelection]
	ret

WhenYouChangeBoxText:
	text "#　ボックスを　かえると" ; "When you change a box"
	line "どうじに　レポートが　かかれます" ; "data will be saved."
	para "<⋯⋯>　それでも　いいですか？" ; "Is that okay?"
	done

ChangeBoxName:
	ld b, NAME_BOX
	ld de, wMovementBufferCount
	farcall NamingScreen
	ld a, [wMovementBufferCount]
	cp $50
	ret z
	ld hl, wd4b9
	ld bc, $0009
	ld a, [wMenuSelection]
	dec a
	call AddNTimes
	ld de, wMovementBufferCount
	call CopyString
	ret

BoxEditMenuList:
	db $40, $06, $00, $0e, $0e
	dw BoxEditMenuListItems
	db $01

BoxEditMenuListItems:
	db $80, $03
	db "ボックスきりかえ@" ; "Change Box"
	db "なまえを　かえる@" ; " Change Name"
	db "やめる@" ; (lit "stop")

Functione5c5:
	call LoadStandardMenuHeader
	call Functione5d3
	call ClearPalettes
	call CloseWindow
	and a
	ret

Functione5d3:
	call ClearBGPalettes
	call .sub_e62a
	call SetPalettes
	ld hl, Datae71c
	call CopyMenuHeader
	ld a, [wBillsPCCursor]
	ld [wMenuCursorPosition], a
	ld a, [wBillsPCScrollPosition]
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuScrollPosition]
	ld [wBillsPCScrollPosition], a
	ld a, [w2DMenuDataEnd]
	ld [wBillsPCCursor], a
	call ClearPalettes
	ld a, [wMenuJoypad]
	cp $02
	jr z, .sub_e60c
	call .sub_e60d
	jr Functione5d3
.sub_e60c
	ret
.sub_e60d
	ld a, [wScrollingMenuCursorPosition]
	ld [wCurPartyMon], a
	ld a, $02
	ld [wMonType], a
	call LoadStandardMenuHeader
	call LowVolume
	predef Function502b5
	call MaxVolume
	call ExitMenu
	ret

.sub_e62a
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL_F, [hl]
	call ClearTileMap
	ld a, [wd4b6]
	ld hl, wd4b9
	ld bc, $0009
	call AddNTimes
	ld d, h
	ld e, l
	coord hl, 1, 1
	ld de, CurrentBoxText
	call PlaceString
	coord hl, 0, 3
	ld a, $79
	ld [hli], a
	ld a, $7a
	ld c, $13
.sub_e655
	ld [hli], a
	dec c
	jr nz, .sub_e655
	ld de, $0014
	ld a, $7c
	ld c, $08
.sub_e660
	ld [hl], a
	add hl, de
	dec c
	jr nz, .sub_e660
	coord hl, 2, 3
	ld de, SpeciesNameLevelText
	call PlaceString
	ld hl, WhichOneWouldYouLikeToSeeText
	call PrintText
	pop af
	ld [wOptions], a
	ret

CurrentBoxText:
	db "ボックス／いまの　ボックス@" ; "Box/Current Box (Name)"

SpeciesNameLevelText:
	db "しゅるい　　なまえ　　　レべル@" ; "Species Name Level"

WhichOneWouldYouLikeToSeeText:
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
	ld hl, MonSelectedText
	call MenuTextBoxBackup
	and a
	ret
	
.exit
	scf
	ret

MonSelectedText:
	text "#を　えらんだ！" ; "(MON) selected!"
	prompt

Tablee6da:
	dw .MenuHeader
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw Datae6e8
	db 1

Datae6e8:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	dbw 0, wPartyCount
	dba PlacePartyMonNicknames
	dba PlacePartyMonLevels
	ds 3

Datae6f8:
	dw Datae6fe
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

Datae6fe:
	db MENU_BACKUP_TILES
	menu_coords 5, 3, 18, 11
	dw Datae706
	db 1

Datae706:
	db 0
	db 4, 8
	db SCROLLINGMENU_ITEMS_NORMAL
	
	dbw 0, wBoxCount
	dba PlaceBoxMonNicknames
	dba PlaceBoxMonLevels
	ds 3

Datae716:
	dw Datae71c
	dw wBillsPCCursor
	dw wBillsPCScrollPosition

Datae71c:
	db $40
	menu_coords 1, 4, SCREEN_WIDTH - 1, 11
	dw Datae724
	db 1

Datae724:
	db $00
	db $04, $00
	db 1
	dbw 0, wBoxCount
	dba PlaceDetailedBoxMonView
	ds 3
	ds 3

Function6734:
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
	call Function1fea
	ret

_UseItem:
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	call CopyStringToStringBuffer2
	ld a, $01
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	cp $c4
	jp nc, Functionf678
	ld hl, Tablee7a5
	dec a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

Tablee7a5:
	dw PokeBallEffect    ; ITEM_MASTER_BALL
	dw PokeBallEffect    ; ITEM_ULTRA_BALL
	dw Functionf66f
	dw PokeBallEffect    ; ITEM_GREAT_BALL
	dw PokeBallEffect    ; ITEM_POKE_BALL
	dw TownMapEffect     ; ITEM_TOWN_MAP 
	dw Functioneca4
	dw Functioned00
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionef02
	dw Functionefee
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf2b5
	dw Functionf2cc
	dw Functionf4d1
	dw Functioned00
	dw Functioned00
	dw Functioned00
	dw Functionf66f
	dw Functioned37
	dw Functioned37
	dw Functioned37
	dw Functioned37
	dw Functionf66f
	dw Functioned37
	dw Functionee42
	dw Functionf2dc
	dw Functioned00
	dw Functionf66f
	dw Functionf66c
	dw Functionf2eb
	dw Functionef02
	dw Functionef8c
	dw Functionef8c
	dw Functionf2fa
	dw Functionf2c2
	dw Functionf2c7
	dw Functionf309
	dw Functionf66f
	dw Functionf05b
	dw Functionf05b
	dw Functionf05b
	dw Functionf318
	dw Functionf66f
	dw Functionf318
	dw Functionf318
	dw Functionf318
	dw Functionf413
	dw Functionf4ca
	dw Functionf354
	dw Functionf66f
	dw Functionf437
	dw Functionf444
	dw Functionf66f
	dw Functionf46e
	dw Functionf4ca
	dw Functionf4d1
	dw Functionf4d1
	dw Functionf4d1
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf65d
	dw Functionfd45
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672
	dw Functionf672

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
	jp z, .sub_e9d6

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
	jr z, .sub_e978
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
	jr nz, .sub_e978
	ld c, $01
.sub_e978
	ld b, e
	push bc
	ld a, b
	sub c
	ldh [hDivisor], a
	xor a
	ldh [hQuotient], a
	ldh [hQuotient + 1], a
	ldh [hQuotient + 2], a
	call Multiply
	pop bc
	ld a, b
	ldh [hDivisor], a
	ld b, $04
	call Divide
	ldh a, [hQuotient + 3]
	and a
	jr nz, .sub_e998
	ld a, $01
.sub_e998
	ld b, a
	ld a, [wEnemyMonStatus]
	and $27
	ld c, $0a
	jr nz, .sub_e9a9
	and a
	ld c, $05
	jr nz, .sub_e9a9
	ld c, $00
.sub_e9a9
	ld a, b
	add c
	jr nc, .sub_e9af
	ld a, $ff
.sub_e9af
	ld d, a
	push de
	ld a, [wBattleMonItem]
	callfar GetItemHeldEffect
	ld a, b
	cp $46
	pop de
	ld a, d
	jr nz, .sub_e9c8
	add c
	jr nc, .sub_e9c8
	ld a, $ff
.sub_e9c8
	ld b, a
	ld [wFieldMoveScriptID], a
	call Random
	cp b
	ld a, $00
	jr z, .sub_e9d6
	jr nc, .sub_e9d9
.sub_e9d6
	ld a, [wEnemyMonSpecies]
.sub_e9d9
	ld [wWildMon], a
	ld c, $14
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
	ld [wMapBlocksAddress], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld a, [wWildMon]
	and a
	jr nz, .sub_ea29
	ld a, [wMapBlocksAddress]
	cp $01
	ld hl, BallBrokeFreeText
	jp z, .sub_eb59
	cp $02
	ld hl, BallAppearedCaughtText
	jp z, .sub_eb59
	cp $03
	ld hl, BallAlmostHadItText
	jp z, .sub_eb59
	cp $04
	ld hl, BallSoCloseText
	jp z, .sub_eb59
.sub_ea29
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
	ld hl, wEnemySubStatus5
	bit 3, [hl]
	jr z, .sub_ea48
	ld a, $84
	ld [wTempEnemyMonSpecies], a
	jr .sub_ea55
.sub_ea48
	set 3, [hl]
	ld hl, wEnemyBackupDVs
	ld a, [wEnemyMonDVs]
	ld [hli], a
	ld a, [wEnemyMonDVs + 1]
	ld [hl], a
.sub_ea55
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a
	ld hl, LoadEnemyMon
	ld a, BANK(LoadEnemyMon)
	call FarCall_hl
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
	ld [wce37], a
	ld a, [wce03]
	dec a
	jp z, .sub_eb56
	ld hl, GotchaText
	call PrintText
	call ClearSprites
	ld a, [wce37]
	dec a
	ld c, a
	ld d, $00
	ld hl, wPartyMonNicknamesEnd
	ld b, $02
	predef SmallFarFlagAction
	ld a, c
	push af
	ld a, [wce37]
	dec a
	ld c, a
	ld b, $01
	predef SmallFarFlagAction
	pop af
	and a
	jr nz, .sub_eac7
	ld hl, NewDexDataText_2
	call PrintText
	call ClearSprites
	ld a, [wEnemyMonSpecies]
	ld [wce37], a
	predef NewPokedexEntry
.sub_eac7
	ld a, [wPartyCount]
	cp $06
	jr z, .sub_eb13
	xor a
	ld [wMonType], a
	call ClearSprites
	predef TryAddMonToParty
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb5f
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
	cp "@"
	jr nz, .sub_eb5f
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	jr .sub_eb5f
.sub_eb13
	call ClearSprites
	predef SendMonIntoBox
	ld hl, Textec61
	call PrintText
	call YesNoBox
	jr c, .sub_eb47
	ld de, wBoxMonNicknames
	ld b, NAME_MON
	ld a, BANK(NamingScreen)
	ld hl, NamingScreen
	call FarCall_hl
	call GBFadeOutToWhite
	ld de, wBoxMonNicknames
	ld a, [de]
	cp "@"
	jr nz, .sub_eb47
	ld hl, wStringBuffer1
	ld bc, MON_NAME_LENGTH
	call CopyBytes
.sub_eb47
	ld hl, Textec0e
	bit 0, a
	jr nz, .sub_eb51
	ld hl, BallSentToSomeonesPCText_2
.sub_eb51
	call PrintText
	jr .sub_eb5f
.sub_eb56
	ld hl, GotchaText
.sub_eb59
	call PrintText
	call ClearSprites
.sub_eb5f
	ld a, [wce03]
	and a
	ret nz
	ld hl, wItems
	inc a
	ld [wItemQuantity], a
	jp TossItem

BallDodgedText:
	text "よけられた！" ; "It dodged the thrown BALL!"
	line "こいつは　つかまりそうにないぞ！" ; "This MON can't be caught!"
	prompt

BallMissedText:
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

GotchaText:
	text "やったー！" ; "Gotcha"
	line "@"

Textebfd:
	text_from_ram wEnemyMonNickname
	text "を　つかまえたぞ！@"

Textec0b:
	sound_caught_mon
	text_waitbutton
	text_end

Textec0e:
	text_from_ram wBoxMonNicknames
	text "は　マサキの　ところへ"
	line "てんそうされた！"
	prompt

BallSentToSomeonesPCText_2:
	text_from_ram wBoxMonNicknames
	text "は　だれかの　<PC>に" ; "was transferred to"
	line "てんそうされた！" ; "Someone's PC!"
	prompt

NewDexDataText_2:
	text_from_ram wEnemyMonNickname
	text "の　データが　あたらしく" ; "New Dex data will"
	line "#ずかんに　セーブされます！@" ; "be added for (MON)!"

Textec5e:
	sound_slot_machine_start
	text_waitbutton
	text_end

Textec61:
	text "つかまえた　@"

Textec69:
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

Functioneca4:
	xor a
	ld [wFieldMoveSucceeded], a
	call .sub_ecba
	ret c
	ldh a, [hROMBank]
	ld hl, Functionecd5
	call QueueScript
	ld a, $01
	ld [wFieldMoveSucceeded], a
	ret
.sub_ecba
	call GetMapEnvironment
	cp $01
	jr z, .sub_eccb
	cp $02
	jr z, .sub_eccb
	cp $04
	jr z, .sub_eccb
	jr .sub_ecd3
.sub_eccb
	ld a, [wPlayerState]
	and a
	ret z
	cp $01
	ret z
.sub_ecd3
	scf
	ret

Functionecd5:
	call RefreshScreen
	ld a, [wPlayerState]
	cp $01
	jr z, .sub_ece9
	ld a, $01
	ld [wPlayerState], a
	ld hl, ItemGotOnText
	jr .sub_ecf0
.sub_ece9
	xor a
	ld [wPlayerState], a
	ld hl, ItemGotOffText
.sub_ecf0
	call MenuTextBox
	call CloseWindow
	call RedrawPlayerSprite
	call PlayMapMusic
	call Function1fea
	ret

Functioned00:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_EVO_STONE
	call Functionf0cf
	jr c, .sub_ed32
	ld a, $01
	ld [wcab9], a
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call WaitSFX
	pop de
	ld hl, Function4af93
	ld a, BANK(Function4af93)
	call FarCall_hl
	ld a, [wce3a]
	and a
	jr z, .sub_ed2f
	jp Functionf7a2
.sub_ed2f
	call WontHaveAnyEffectMessage
.sub_ed32
	xor a
	ld [wFieldMoveSucceeded], a
	ret

Functioned37:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	push hl
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wce37], a
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	call Functionee26
	pop hl
	push hl
	add hl, bc
	ld bc, $000b
	add hl, bc
	ld a, [hl]
	cp $64
	jr nc, Functioneda1
	add $0a
	ld [hl], a
	pop hl
	call Functionedab
	call Functionee26
	ld hl, Tableedf7
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wHPBarTempHP
	ld bc, $000a
	call CopyBytes
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Textedcb
	call PrintText
	jp Functionf7a2

Functioneda1:
	pop hl
	ld hl, Textede7
	call PrintText
	jp ClearPalettes

Functionedab:
	push hl
	ld bc, $0024
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld bc, $000a
	add hl, bc
	ld b, $01
	predef_jump CalcMonStats

Functionedbe:
	xor a
	ld [wFieldMoveSucceeded], a
	call ClearPalettes
	call z, GetMemSGBLayout
	jp ReloadFontAndTileset

Textedcb:
	text_from_ram wStringBuffer1
	text "の　@"

Textedd2:
	text_from_ram wStringBuffer2
	text "の"
	line "きそ　ポイントが　あがった！"
	prompt



Textede7:
	text "つかっても　こうかが　ないよ"
	prompt

Tableedf7:
	dw Textee01
	dw Textee07
	dw Textee0f
	dw Textee17
	dw Textee1c

Textee01:
	db "たいりょく@"

Textee07:
	db "こうげきりょく@"

Textee0f:
	db "ぼうぎょりょく@"

Textee17:
	db "すばやさ@"

Textee1c:
	db "とくしゅのうりょく@"

Functionee26:
	ld a, [wCurItem]
	ld hl, Dataee38
.sub_ee2c
	cp [hl]
	inc hl
	jr z, .sub_ee33
	inc hl
	jr .sub_ee2c
.sub_ee33
	ld a, [hl]
	ld c, a
	ld b, $00
	ret

Dataee38:
	db $1a, $00
	db $1b, $02
	db $1c, $04
	db $1d, $06
	db $1f, $08

Functionee42:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionedbe
	ld a, $00
	call GetPartyParamLocation
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wce37], a
	push hl
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop hl
	push hl
	ld bc, $001f
	add hl, bc
	ld a, [hl]
	cp $64
	jp nc, Functioneda1
	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	ld hl, CalcExpAtLevel
	ld a, BANK(CalcExpAtLevel)
	call FarCall_hl
	pop de
	pop hl
	push hl
	ld bc, $0008
	add hl, bc
	ldh a, [hQuotient + 1]
	ld [hli], a
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hl], a
	pop hl
	push hl
	ld bc, $0024
	add hl, bc
	ld a, [hli]
	ld b, a
	ld c, [hl]
	pop hl
	push bc
	push hl
	call Functionedab
	pop hl
	ld bc, $0025
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
	callfar Function5087e
	xor a
	ld [wMonType], a
	predef CopyMonToTempMon
	ld d, $01
	ld hl, Function50628
	ld a, BANK(Function50628)
	call FarCall_hl
	call TextboxWaitPressAorB_BlinkCursor
	xor a
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wce37], a
	predef Function421f8
	xor a
	ld [wcab9], a
	ld hl, Function4af93
	ld a, BANK(Function4af93)
	call FarCall_hl
	jp Functionf7a2

Functionef02:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a

Functionef17:
	call .sub_ef61
	ld a, $20
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jp z, Functionf0fb
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a
	call Functionf113
	jr nc, .sub_ef50
	xor a
	ld [wBattleMonStatus], a
	ld hl, wPlayerSubStatus5
	res 0, [hl]
	ld hl, wPlayerSubStatus1
	res 0, [hl]
	ld a, $24
	call GetPartyParamLocation
	ld de, wBattleMonMaxHP
	ld bc, $000a
	call CopyBytes
	predef Function3e1a4
.sub_ef50
	call Functionf7a2
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	call Functionf0d8
	jp Functionf104
.sub_ef61
	push hl
	ld a, [wCurItem]
	ld hl, Dataef77
	ld bc, $0003
.sub_ef6b
	cp [hl]
	jr z, .sub_ef71
	add hl, bc
	jr .sub_ef6b
.sub_ef71
	inc hl
	ld b, [hl]
	inc hl
	ld c, [hl]
	pop hl
	ret

Dataef77:
	db $09, $f0, $08
	db $0a, $f1, $10
	db $0b, $f2, $20
	db $0c, $f3, $07
	db $0d, $f4, $40
	db $26, $f6, $ff
	db $ff, $00, $00

Functionef8c:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp nz, Functionf0fb
	ld a, [wBattleMode]
	and a
	jr z, .sub_efc9
	ld a, [wCurPartyMon]
	ld c, a
	ld d, $00
	ld hl, wBattleParticipantsIncludingFainted
	ld b, $02
	predef SmallFarFlagAction
	ld a, c
	and a
	jr z, .sub_efc9
	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, $01
	predef SmallFarFlagAction
.sub_efc9
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp $27
	jr z, .sub_efd9
	call Functionf130
	jr .sub_efdc
.sub_efd9
	call Functionf127
.sub_efdc
	call Functionf0b0
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionefed:
	ret

Functionefee:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp z, Functionf0fb
	call Functionf171
	jr c, .sub_f01a
	ld a, $20
	call GetPartyParamLocation
	ld a, [hl]
	and a
	jp z, Functionf0fb
	ld a, $26
	ld [wCurItem], a
	jp Functionef17
.sub_f01a
	xor a
	ld [wLowHealthAlarmBuffer], a
	call Functionf130
	ld a, $20
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call Functionf113
	jr nc, .sub_f049
	ld hl, wPlayerSubStatus5
	res 0, [hl]
	ld hl, wPlayerSubStatus1
	res 0, [hl]
	xor a
	ld [wBattleMonStatus], a
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.sub_f049
	call Functionf0b0
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionf05a:
	ret

Functionf05b:
	ld a, [wPartyCount]
	and a
	jp z, IsntTheTimeMessage
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jp c, Functionf100
	call Functionf165
	jp z, Functionf0fb
	call Functionf171
	jp nc, Functionf0fb
	xor a
	ld [wLowHealthAlarmBuffer], a
	ld a, [wCurItem]
	cp $0f
	jr nz, .sub_f086
	call Functionf130
	jr .sub_f08c
.sub_f086
	call Functionf1e9
	call Functionf13f
.sub_f08c
	call Functionf113
	jr nc, .sub_f09e
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
.sub_f09e
	call Functionf0b0
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call Functionf0d8
	call Functionf7a2
	jp Functionf104

Functionf0af:
	ret

Functionf0b0:
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	coord hl, 11, 0
	ld bc, $0028
	call AddNTimes
	ld a, $02
	ld [wWhichHPBar], a
	predef UpdateHPBar
	ret

Functionf0cf:
	ld [wPartyMenuActionText], a
	predef PartyMenuInBattle_Setup
	ret

Functionf0d8:
	xor a
	ldh [hBGMapMode], a
	ld hl, wTileMap
	ld bc, VBlank.return
	ld a, $7f
	call ByteFill
	callfar Function5087e
	ld a, $01
	ldh [hBGMapMode], a
	ld c, $32
	call DelayFrames
	call TextboxWaitPressAorB_BlinkCursor
	ret

Functionf0fb:
	call WontHaveAnyEffectMessage
	jr Functionf104

Functionf100:
	xor a
	ld [wFieldMoveSucceeded], a

Functionf104:
	call ClearPalettes
	call z, GetMemSGBLayout
	ld a, [wBattleMode]
	and a
	ret nz
	call ReloadFontAndTileset
	ret

Functionf113:
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .sub_f125
	scf
	ret
.sub_f125
	xor a
	ret

Functionf127:
	call Functionf1c5
	srl d
	rr e
	jr Functionf133

Functionf130:
	call Functionf1c5

Functionf133:
	ld a, $22
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	call Functionf17e
	ret

Functionf13f:
	ld a, $23
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	call Functionf17e
	ld a, $23
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, $25
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	jr c, .sub_f164
	call Functionf130
.sub_f164
	ret

Functionf165:
	call Functionf1b5
	call Functionf19e
	call Functionf1ac
	ld a, d
	or e
	ret

Functionf171:
	call Functionf1ac
	ld h, d
	ld l, e
	call Functionf1c5
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

Functionf17e:
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wHPBarNewHP+1], a
	ld a, [hl]
	ld [wHPBarNewHP], a
	ret

Functionf18c:
	ld a, d
	ld [wHPBarNewHP+1], a
	ld a, e
	ld [wHPBarNewHP], a
	ret

Functionf195:
	ld a, [wHPBarNewHP+1]
	ld d, a
	ld a, [wHPBarNewHP]
	ld e, a
	ret

Functionf19e:
	ld a, $22
	call GetPartyParamLocation
	ld a, [hli]
	ld [wReplacementBlock], a
	ld a, [hl]
	ld [wHPBarOldHP], a
	ret

Functionf1ac:
	ld a, [wReplacementBlock]
	ld d, a
	ld a, [wHPBarOldHP]
	ld e, a
	ret

Functionf1b5:
	push hl
	ld a, $24
	call GetPartyParamLocation
	ld a, [hli]
	ld [wMapBlocksAddress], a
	ld a, [hl]
	ld [wFieldMoveScriptID], a
	pop hl
	ret

Functionf1c5:
	ld a, [wMapBlocksAddress]
	ld d, a
	ld a, [wFieldMoveScriptID]
	ld e, a
	ret

Functionf1ce:
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, $05
	ldh [hDivisor], a
	ld b, $02
	call Divide
	ldh a, [hQuotient + 2]
	ld d, a
	ldh a, [hQuotient + 3]
	ld e, a
	ret

Functionf1e9:
	push hl
	ld a, [wCurItem]
	ld hl, Dataf203
	ld d, a
.sub_f1f1
	ld a, [hli]
	cp $ff
	jr z, .sub_f1fd
	cp d
	jr z, .sub_f1fe
	inc hl
	inc hl
	jr .sub_f1f1
.sub_f1fd
	scf
.sub_f1fe
	ld e, [hl]
	inc hl
	ld d, [hl]
	pop hl
	ret

Dataf203:
	db $2e, $32, $00
	db $2f, $3c, $00
	db $30, $50, $00
	db $10, $c8, $00
	db $11, $32, $00
	db $12, $14, $00
	db $ff, $00, $00

Functionf218:
	ld a, [wBillsPCCursor]
	dec a
	ld b, a
.sub_f21d
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	predef PartyMenuInBattle
	pop bc
	jr c, .sub_f28c
	ld a, [wBillsPCCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .sub_f21d
	push bc
	ld a, c
	ld [wCurPartyMon], a
	call Functionf165
	jr z, .sub_f292
	call Functionf171
	jp nc, .sub_f29c
	pop bc
	push bc
	ld a, b
	ld [wCurPartyMon], a
	call Functionf165
	call Functionf1ce
	push de
	ld a, $23
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld e, a
	ld a, [hl]
	sbc d
	ld [hl], a
	ld d, a
	call Functionf18c
	call Functionf0b0
	pop de
	pop bc
	push bc
	push de
	ld a, c
	ld [wCurPartyMon], a
	call Functionf165
	pop de
	call Functionf13f
	call Functionf0b0
	xor a
	ldh [hBGMapMode], a
	call ClearTileMap
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	predef Function5081f
	ld c, $c8
	call Function3872
	pop bc
.sub_f28c
	ld a, b
	inc a
	ld [wBillsPCCursor], a
	ret
.sub_f292
	ld hl, Textf2a6
	call Function385a
	pop bc
	jp .sub_f21d
.sub_f29c
	ld hl, Textf2a6
	call Function385a
	pop bc
	jp .sub_f21d

Textf2a6:
	text "その#には　"
	line "つかえません"
	done

Functionf2b5:
	xor a
	ld [wFieldMoveSucceeded], a
	ld hl, DigFunction
	ld a, $03
	call FarCall_hl
	ret

Functionf2c2:
	ld b, $c8
	jp Functionf2ce

Functionf2c7:
	ld b, $fa
	jp Functionf2ce

Functionf2cc:
	ld b, $64

Functionf2ce:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, b
	ld [wce2d], a
	jp Functionf793

Functionf2dc:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 0, [hl]
	jp Functionf793

Functionf2eb:
	ld a, [wBattleMode]
	dec a
	jp nz, IsntTheTimeMessage
	ld a, LOSE
	ld [wBattleResult], a
	jp Functionf793

Functionf2fa:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 1, [hl]
	jp Functionf793

Functionf309:
	ld a, [wBattleMode]
	and a
	jp z, IsntTheTimeMessage
	ld hl, wPlayerSubStatus4
	set 2, [hl]
	jp Functionf793

Functionf318:
	ld a, [wBattleMode]
	and a
	jr nz, .sub_f327
	call IsntTheTimeMessage
	ld a, $02
	ld [wFieldMoveSucceeded], a
	ret
.sub_f327
	ld hl, wPlayerMoveStruct
	ld a, [hli]
	push af
	ld a, [hl]
	push af
	push hl
	ld a, [wCurItem]
	sub $37
	ld [hl], a
	call Functionf793
	ld a, $ae
	ld [wPlayerMoveStruct], a
	call ReloadTilesFromBuffer
	call WaitBGMap
	xor a
	ldh [hBattleTurn], a
; wrong bank
	ld a, $f
	ld hl, BattleCommand_StatUp
	call FarCall_hl
	pop hl
	pop af
	ld [hld], a
	pop af
	ld [hl], a
	ret

Functionf354:
	ret

Functionf355:
	xor a
	ld [wMovementBufferCount], a
	ld b, $f8
	ld hl, wPartyMon1Status
	call Functionf397
	ld a, [wBattleMode]
	cp $01
	jr z, .sub_f36e
	ld hl, wOTPartyMon1Status
	call Functionf397
.sub_f36e
	ld hl, wBattleMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld hl, wEnemyMonStatus
	ld a, [hl]
	and b
	ld [hl], a
	ld a, [wMovementBufferCount]
	and a
	ld hl, Textf3bd
	jp z, PrintText
	ld hl, Textf3ec
	call PrintText
	ld a, [wLowHealthAlarmBuffer]
	and $80
	jr nz, .sub_f391
.sub_f391
	ld hl, Textf3da
	jp PrintText

Functionf397:
	ld de, $0030
	ld c, $06
.sub_f39c
	ld a, [hl]
	push af
	and $07
	jr z, .sub_f3a7
	ld a, $01
	ld [wMovementBufferCount], a
.sub_f3a7
	pop af
	and b
	ld [hl], a
	add hl, de
	dec c
	jr nz, .sub_f39c
	ret

Dataf3af:
	db $3e, $09
	db $3d, $0a
	db $3f, $0a
	db $3e, $0b
	db $ff

Dataf3b8:
	db $0a, $1b
	db $0a, $19
	db $ff

Textf3bd:
	text "#のふえを　ふいた！"
	para "うーん！"
	line "すばらしい　ねいろだ！"
	prompt

Textf3da:
	text "すべての　#が"
	line "めを　さました！"
	prompt

Textf3ec:
	text "<PLAYER>は"
	line "#のふえを　ふいてみた！@"

Functionf3fd:
	ld b, $08
	ld a, [wBattleMode]
	and a
	jr nz, .sub_f410
	push de
	ld de, SFX_POKEFLUTE
	call WaitPlaySFX
	call WaitSFX
	pop de
.sub_f410
	jp Function32d0

Functionf413:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld hl, Textf424
	call MenuTextBox
	call CloseWindow
	ret

Textf424:
	text "あなたの　コイン"
	line "@"

Textf42f:
	deciram wCoins, 2, 4
	text "まい"
	prompt

Functionf437:
	call Functionf49f
	jp c, IsntTheTimeMessage
	ld bc, $0585
	ld a, $01
	jr Functionf478

Functionf444:
	call Functionf49f
	jp c, IsntTheTimeMessage
.sub_f44a
	call Random
	srl a
	jr c, .sub_f463
	and $03
	cp $02
	jr nc, .sub_f44a
	ld hl, Dataf46a
	ld c, a
	ld b, $00
	add hl, bc
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	and a
.sub_f463
	ld a, $00
	rla
	xor $01
	jr Functionf478

Dataf46a:
	db $0a, $9d, $0a, $47

Functionf46e:
	call Functionf49f
	jp c, IsntTheTimeMessage
	call Functionf9d9
	ld a, e

Functionf478:
	ld [wMovementBufferCount], a
	dec a
	jr nz, .sub_f48b
	ld a, $01
	ld [wca3a], a
	ld a, b
	ld [wCurPartyLevel], a
	ld a, c
	ld [wce01], a
.sub_f48b
	ld hl, wPlayerState
	ld a, [hl]
	push af
	ld [hl], $00
	push hl
	ld a, $23
	ld hl, PutItemInPocket.loop
	call FarCall_hl
	pop hl
	pop af
	ld [hl], a
	ret

Functionf49f:
	ld a, [wBattleMode]
	and a
	jr z, .sub_f4a7
	scf
	ret
.sub_f4a7
	call Functionf9d7
	ret c
	ld a, [wPlayerState]
	cp $02
	jr z, .sub_f4c8
	call Functionfab4
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld c, $50
	call DelayFrames
	and a
	ret
.sub_f4c8
	scf
	ret

Functionf4ca:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage

Functionf4d1:
	ld a, [wCurItem]
	ld [wMovementBufferCount], a
.sub_f4d7
	ld a, PARTYMENUACTION_HEALING_ITEM
	call Functionf0cf
	jr nc, .sub_f4e1
	jp Functionf5f3
.sub_f4e1
	ld a, [wMovementBufferCount]
	cp $52
	jp nc, Functionf5bd
	ld a, $02
	ld [wcac0], a
	ld hl, Textf5ff
	ld a, [wMovementBufferCount]
	cp $50
	jr c, .sub_f4fb
	ld hl, Textf610
.sub_f4fb
	call PrintText
	callfar Function3daa7
	jr nz, .sub_f4d7
	ld hl, wPartyMon1Moves
	ld bc, $0030
	call GetMthMoveOfNthPartymon
	push hl
	ld a, [hl]
	ld [wce37], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop hl
	ld a, [wMovementBufferCount]
	cp $50
	jr nc, Functionf580
	ld bc, $0015
	add hl, bc
	ld a, [hl]
	cp $c0
	jr c, .sub_f535
	ld hl, Textf61f
	call PrintText
	jr .sub_f4e1
.sub_f535
	ld a, [hl]
	add $40
	ld [hl], a
	ld a, $01
	ld [wce37], a
	call ApplyPPUp
	ld hl, Textf639
	call PrintText

Functionf547:
	call ClearPalettes
	call GetMemSGBLayout
	jp Functionf7a2

Functionf550:
	ld a, [wBattleMode]
	and a
	jr z, .sub_f572
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .sub_f572
	ld hl, wPartyMon1PP
	ld bc, $0030
	call AddNTimes
	ld de, wBattleMonPP
	ld bc, $0004
	call CopyBytes
.sub_f572
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	ld hl, Textf64c
	call PrintText
	jr Functionf547

Functionf580:
	call Functionf588
	jr nz, Functionf550
	jp Functionf5f0

Functionf588:
	xor a
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld bc, $0015
	add hl, bc
	ld a, [wce37]
	ld b, a
	ld a, [wMovementBufferCount]
	cp $51
	jr z, .sub_f5b8
	ld a, [hl]
	and $3f
	cp b
	ret z
	add $0a
	cp b
	jr nc, .sub_f5b2
	ld b, a
.sub_f5b2
	ld a, [hl]
	and $c0
	add b
	ld [hl], a
	ret
.sub_f5b8
	ld a, [hl]
	cp b
	ret z
	jr .sub_f5b2

Functionf5bd:
	ld hl, wMovementBufferCount
	dec [hl]
	dec [hl]
	xor a
	ld hl, w2DMenuDataEnd
	ld [hli], a
	ld [hl], a
	ld b, $04
.sub_f5ca
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .sub_f5e1
	call Functionf588
	jr z, .sub_f5e1
	ld hl, wMenuCursorX
	inc [hl]
.sub_f5e1
	ld hl, w2DMenuDataEnd
	inc [hl]
	pop bc
	dec b
	jr nz, .sub_f5ca
	ld a, [wMenuCursorX]
	and a
	jp nz, Functionf550

Functionf5f0:
	call WontHaveAnyEffectMessage

Functionf5f3:
	call ClearPalettes
	call GetMemSGBLayout
	pop af
	xor a
	ld [wFieldMoveSucceeded], a
	ret

Textf5ff:
	text "どのわざの"
	line "ポイントをふやす？"
	done

Textf610:
	text "どのわざを"
	line "かいふくする？"
	done

Textf61f:
	text_from_ram wStringBuffer2
	text "は　これいじょう"
	line "ふやすことが　できません"
	prompt

Textf639:
	text_from_ram wStringBuffer2
	text "の"
	line "わざポイントが　ふえた！"
	prompt

Textf64c:
	text "わざポイントが"
	line "かいふくした！"
	prompt

Functionf65d:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld hl, TryTeleport
	ld a, $0b
	jp FarCall_hl

Functionf66c:
	jp IsntTheTimeMessage

Functionf66f:
	jp IsntTheTimeMessage

Functionf672:
	jp IsntTheTimeMessage

Functionf675:
	jp Functionfaba

Functionf678:
	ld a, [wBattleMode]
	and a
	jp nz, IsntTheTimeMessage
	ld a, [wCurItem]
	sub $c9
	push af
	jr nc, .sub_f689
	add $37
.sub_f689
	inc a
	ld [wce37], a
	predef GetTMHMMove
	ld a, [wce37]
	ld [wPutativeTMHMMove], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop af
	ld hl, Textf723
	jr nc, .sub_f6a7
	ld hl, Textf72e
.sub_f6a7
	call PrintText
	ld hl, Textf73d
	call PrintText
	call YesNoBox
	jr nc, .sub_f6bb
	ld a, $02
	ld [wFieldMoveSucceeded], a
	ret
.sub_f6bb
	ld hl, wHPBarTempHP
	ld de, wMonOrItemNameBuffer
	ld bc, $0008
	call CopyBytes
	ld a, PARTYMENUACTION_TEACH_TMHM
	call Functionf0cf
	push af
	ld hl, wMonOrItemNameBuffer
	ld de, wHPBarTempHP
	ld bc, $0008
	call CopyBytes
	pop af
	jr nc, .sub_f6ea
	pop af
	pop af
	call ClearBGPalettes
	call ClearSprites
	call GetMemSGBLayout
	jp ReloadTilesFromBuffer
.sub_f6ea
	predef CanLearnTMHMMove
	push bc
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	pop bc
	ld a, c
	and a
	jr nz, .sub_f70c
	ld de, SFX_WRONG
	call WaitPlaySFX
	ld hl, Textf768
	call PrintText
	jr .sub_f6bb
.sub_f70c
	call Functionfdab
	jr c, .sub_f6bb
	predef LearnMove
	ld a, b
	and a
	ret z
	ld a, [wCurItem]
	call IsHM
	ret c
	jp Functionf7a2

Textf723:
	text "<TM>を　きどうした！"
	prompt

Textf72e:
	text "ひでんマシンを　きどうした！"

Textf73d:
	text "なかには　@"

Textf744:
	text_from_ram wStringBuffer2
	text "が"
	line "きろくされていた！"
	para "@"

Textf755:
	text_from_ram wStringBuffer2
	text "を"
	line "#に　おぼえさせますか？"
	done

Textf768:
	text_from_ram wStringBuffer1
	text "と　@"

Textf76f:
	text_from_ram wStringBuffer2
	text "は"
	line "あいしょうが　わるかった！"
	para "@"

Textf784:
	text_from_ram wStringBuffer2
	text "は　おぼえられない！"
	prompt

Functionf793:
	ld hl, ItemUsedText
	call PrintText
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	call TextboxWaitPressAorB_BlinkCursor

Functionf7a2:
	ld hl, wItems
	ld a, $01
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
	jr Functionf7a2

Ball_BoxIsFullMessage:
	ld hl, BallBoxFullText
	jr CantUseItemMessage

IsntTheTimeMessage:
	ld hl, ItemOakWarningText
	jr CantUseItemMessage

WontHaveAnyEffectMessage:
	ld hl, ItemWontHaveAnyEffectText
	jr CantUseItemMessage

BelongsToSomeoneElseMessage:	; unreferenced
	ld hl, ItemBelongsToSomeoneElseText
	jr CantUseItemMessage

CyclingIsntAllowedMessage:	; unreferenced
	ld hl, NoCyclingText
	jr CantUseItemMessage

CantGetOnYourBikeMessage:	; unreferenced
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

Unreferenced_CantUseText:
	db ""
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

GetMaxPPOfMove:
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
	ld bc, $0006
.notwild
	add hl, bc
	ld a, [hl]
	and PP_UP_MASK
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wce37], a
	call ComputeMaxPP
	ld a, [hl]
	and PP_MASK
	ld [wce37], a
	ret

GetMthMoveOfNthPartymon:
	ld a, [wCurPartyMon]
	call AddNTimes

GetMthMoveOfCurrentMon:
	ld a, [w2DMenuDataEnd]
	ld c, a
	ld b, $00
	add hl, bc
	ret

Functionf9d7:
	scf
	ret

Functionf9d9:
	ld a, [wMapId]
	ld de, $0003
	ld hl, Datafa08
	call FindItemInTable
	jr c, .sub_f9ea
	ld e, $02
	ret
.sub_f9ea
	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, [hl]
	inc hl
	ld e, $00
.sub_f9f2
	call Random
	srl a
	ret c
	and $03
	cp b
	jr nc, .sub_f9f2
	add a
	ld c, a
	ld b, $00
	add hl, bc
	ld b, [hl]
	inc hl
	ld c, [hl]
	ld e, $01
	ret

Datafa08:
	dbw $00, Datafa6c
	dbw $01, Datafa6c
	dbw $03, Datafa76
	dbw $05, Datafa7d
	dbw $06, Datafa82
	dbw $07, Datafaab
	dbw $08, Datafa99
	dbw $0f, Datafa76
	dbw $11, Datafa7d
	dbw $15, Datafa82
	dbw $16, Datafa7d
	dbw $17, Datafa90
	dbw $18, Datafa90
	dbw $1c, Datafa90
	dbw $1d, Datafa90
	dbw $1e, Datafa99
	dbw $1f, Datafa99
	dbw $20, Datafa99
	dbw $21, Datafa71
	dbw $22, Datafaa2
	dbw $23, Datafa76
	dbw $24, Datafa76
	dbw $41, Datafa76
	dbw $5e, Datafa7d
	dbw $a1, Datafa99
	dbw $a2, Datafa99
	dbw $d9, Datafa87
	dbw $da, Datafa87
	dbw $db, Datafa87
	dbw $dc, Datafa87
	dbw $e2, Datafaa2
	dbw $e3, Datafaa2
	dbw $e4, Datafaa2
	db $ff

Datafa6c:
	db $02, $0f, $18, $0f, $47

Datafa71:
	db $02, $0f, $9d, $0f, $47

Datafa76:
	db $03, $0f, $2f, $0f, $9d, $0f, $4e

Datafa7d:
	db $02, $0f, $4e, $0f, $17

Datafa82:
	db $02, $17, $6e, $0f, $25

Datafa87:
	db $04, $0f, $58, $0f, $4e, $0f, $2f, $0f, $25

Datafa90:
	db $04, $05, $18, $0f, $4e, $0f, $9d, $0f, $85

Datafa99:
	db $04, $0f, $1b, $0f, $5c, $0f, $17, $0f, $9d

Datafaa2:
	db $04, $17, $08, $17, $9e, $17, $8a, $17, $5d

Datafaab:
	db $04, $17, $9e, $0f, $4e, $0f, $9d, $0f, $85

Functionfab4:
	call LoadMapPart
	jp UpdateSprites

Functionfaba:
	ld a, [wd8a2]
	cp $02
	jr c, .sub_fade
	cp $03
	jp z, Functionfd03
	cp $04
	jr z, .sub_fade
	call Functionfbf0
	ld a, [wce37]
	and a
	jr z, .sub_fad8
	ld a, $03
	ld [wd8a2], a
.sub_fad8
	ld hl, Breeder_NoEggYetText
	call PrintText
.sub_fade
	ld hl, Breeder_IntroText
	call PrintText
	ld hl, Breeder_Menu
	call LoadMenuHeader
	call VerticalMenu
	push af
	call CloseWindow
	pop af
	jp c, Functionfbde
	ld a, [w2DMenuDataEnd]
	cp $03
	jp z, Functionfbde
	cp $01
	jr z, .sub_fb4c
	ld a, [wd8a2]
	and a
	jr z, .sub_fb19
	cp $02
	jr nz, .sub_fb22
	ld hl, Breeder_CheckOnPokemonText
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	jr .sub_fb22
.sub_fb19
	ld hl, Breeder_DoesntHavePokemonText
	call PrintText
	jp Functionfbde
.sub_fb22
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	predef RetrieveBreedmon
	jp c, Functionfbea
	ld a, [wd8a2]
	sub $01
	jr z, .sub_fb38
	ld a, $01
.sub_fb38
	ld [wd8a2], a
	ld a, [wd8fd]
	srl a
	ld [wd8fd], a
	ld hl, Breeder_WithdrawnText
	call PrintText
	jp Functionfbde
.sub_fb4c
	ld a, [wd8a2]
	cp $02
	jp nc, .sub_fbd6
	add PARTYMENUACTION_GIVE_MON
	call Functionf0cf
	jp c, Functionfbde
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wMonType], a
	predef GetGender
	ld a, [wd8fd]
	rla
	ld [wd8fd], a
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, $01
	ld [wPokemonWithdrawDepositParameter], a
	predef Functiondcfc
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	callfar RemoveMonFromPartyOrBox ; in the same bank, no need to farcall!
	ld a, [wCurPartySpecies]
	call PlayCry
	ld hl, Breeder_DepositedText
	call PrintText
	ld a, [wd8a2]
	inc a
	ld [wd8a2], a
	cp $02
	jr nz, Functionfbde
	ld hl, Breeder_LetsMakeBabiesText
	call PrintText
	call Functionfbf0
	ld a, [wce37]
	cp $50
	ld hl, Breeder_SeemToGetAlongText
	call z, PrintText
	ld a, [wce37]
	cp $14
	ld hl, Breeder_DontSeemToGetAlongText
	call z, PrintText
	ld a, [wce37]
	and a
	ld hl, Breeder_GendersDontMatchText
	call z, PrintText
	jr Functionfbde
.sub_fbd6
	ld hl, Breeder_AlreadyHasTwoPokemonText
	call PrintText
	jr Functionfbde

Functionfbde:
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	call GetMemSGBLayout
	jp ReloadFontAndTileset

Functionfbea:
	ld hl, Textfc91
	jp PrintText

Functionfbf0:
	ld a, [wd8fd]
	ld b, a
	srl b
	xor b
	and $01
	jr z, .sub_fc15
	ld a, [wBreedMon1ID]
	ld b, a
	ld a, [wBreedMon2ID]
	cp b
	jr nz, .sub_fc13
	ld a, [wBreedMon1ID + 1]
	ld b, a
	ld a, [wBreedMon2ID + 1]
	cp b
	jr nz, .sub_fc13
	ld a, $14
	jr .sub_fc15
.sub_fc13
	ld a, $50
.sub_fc15
	ld [wce37], a
	ret

Breeder_IntroText:
	text "わたしは　こずくりやさん"
	line "さて　どうする？"
	done

Breeder_Menu:
	db $40, $04, $0d, $0b, $13
	dw Breeder_MenuOptions
	db $01

Breeder_MenuOptions:
	db $80, $03
	db "あずける@"	; Deposit
	db "ひきとる@"	; Withdraw
	db "やめる@"	; Cancel

Breeder_DepositedText:
	text "あずけた！"
	prompt

Breeder_AlreadyHasTwoPokemonText:
	text "すでに　２ひきの#を"
	line "あずかっています"
	prompt

Breeder_CheckOnPokemonText:
	text "こずくりを　ちゅうししますか？"
	done

Breeder_DoesntHavePokemonText:
	text "#は　いっぴきも"
	line "あずかってませんが"
	prompt

Breeder_WithdrawnText:
	text "ひきとった！"
	prompt

Textfc91:
	text "てもちも　マサキの　<PC>も"
	line "#で　いっぱいのようです"
	prompt

Breeder_LetsMakeBabiesText:
	text "それでは　こづくりします！"
	prompt

Breeder_SeemToGetAlongText:
	text "あいしょうが　いいようです"
	prompt

Breeder_DontSeemToGetAlongText:
	text "あいしょうが　わるいようです"
	prompt

Breeder_GendersDontMatchText:
	text "せいべつが　あわないようです"
	prompt

Breeder_NoEggYetText:
	text "ざんねんながら　まだ　うまれて"
	line "こないようです"
	prompt

Functionfd03:
	ld hl, Breeder_EggLaidText
	call PrintText
	call YesNoBox
	jp c, Functionfbde
	ld a, $04
	ld [wd8a2], a
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	call PlayCry
	xor a
	ld [wMonType], a
	ld a, 5
	ld [wCurPartyLevel], a
	predef GiveEgg
	jp Functionfbde

Breeder_EggLaidText:
	text "タマゴが　うまれました！"
	line "ひきとりますか？"
	done

Functionfd45:
	ret

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

Functionfdab:
	ld a, $02
	call GetPartyParamLocation
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, $04
.sub_fdb6
	ld a, [hli]
	cp b
	jr z, .sub_fdbf
	dec c
	jr nz, .sub_fdb6
	and a
	ret
.sub_fdbf
	ld hl, .knows_move_text
	call PrintText
	scf
	ret

.knows_move_text
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
Textfdd2:
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Textfde0:
	db "います"
	prompt

; NOTE: This is missing the preceeding "text_from_ram"  byte
Textfde4:
	dw wStringBuffer2
	text "を　おぼえています"
	prompt

Datafdf1:
	db $28, $3c

Functionfdf3:
	ld a, [wPutativeTMHMMove]
	ld b, a
	ld c, $04
.sub_fdf9
	ld a, [hli]
	cp b
	jr z, .sub_fe02
	dec c
	jr nz, .sub_fdf9
	and a
	ret
.sub_fe02
	ld hl, .knows_move_text
	call PrintText
	scf
	ret

.knows_move_text
	text_from_ram wStringBuffer1
	text "は　すでに"
	line "@"
Textfe15:
	text_from_ram wStringBuffer2
	text "を　おぼえています"
	prompt

Datafe23:
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
