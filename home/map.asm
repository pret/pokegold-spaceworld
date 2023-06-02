INCLUDE "constants.asm"

SECTION "home/map.asm", ROM0

; Runs a map script indexed by wMapScriptNumber
RunMapScript::
	push hl
	push de
	push bc
	ld a, [wMapScriptNumber]
	add a, a
	add a, a
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .return
	push de
	jp hl

.return
	pop bc
	pop de
	pop hl
	ret

; TODO: is this used?
WriteIntod637::
	push af
	; TODO: figure out what variables are concerned here
	ld a, [wd637]
	ld [wd638], a
	pop af
	ld [wd637], a
	ret

ClearMapBuffer::
	ld hl, wMapBuffer
	ld bc, wMapBufferEnd - wMapBuffer
	ld a, 0
	call ByteFill
	ret

SetUpMapBuffer::
	call ClearMapBuffer
	ldh a, [hROMBank]
	push af
	ld a, BANK(UnknownMapBufferPointers)
	call Bankswitch
	ld hl, UnknownMapBufferPointers
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
.search
	ld a, [hli]
	cp $FF
	jr z, .done
	cp b
	jr nz, .next_with_id
	ld a, [hli]
	cp c
	jr nz, .next_without_id

	; Match found!
	ld de, wMapScriptNumberLocation
	call GetMapScriptNumber ; Read map script from pointed location
	call CopyWord ; Copy map script pointer
	ld de, wUnknownMapPointer
	call CopyWord

.done
	pop af
	call Bankswitch
	ret

.next_with_id
	ld de, 7
	add hl, de
	jr .search

.next_without_id
	ld de, 6
	add hl, de
	jr .search

GetMapScriptNumber::
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [hl]
	ld [wMapScriptNumber], a
	pop hl
	ret

CopyWord::
	ld a, [hli]
	ld [de], a
	ld a, [hli]
	inc de
	ld [de], a
	ret


SetMapScriptNumber::
	ld [wMapScriptNumber], a
	ret

IncMapScriptNumber::
	ld hl, wMapScriptNumber
	inc [hl]
	ret

DecMapScriptNumber::
	ld hl, wMapScriptNumber
	dec [hl]
	ret

WriteBackMapScriptNumber::
	ld a, [wMapScriptNumberLocation]
	ld l, a
	ld a, [wMapScriptNumberLocation + 1]
	ld h, a
	ld a, [wMapScriptNumber]
	ld [hl], a
	ret


GetMapPointer::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
GetAnyMapPointer::
	push bc
	dec b
	ld c, b
	ld b, 0
	ld hl, MapGroupPointers
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop bc
	dec c
	ld b, 0
	ld a, 8
	call AddNTimes
	ret


SwitchToMapBank::
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
SwitchToAnyMapBank::
	push hl
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	call GetAnyMapPointer
	ld a, [hl]
	call Bankswitch
	pop hl
	ret


CopyMapPartial::
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	call GetMapPointer
	ld de, wMapPartial
	ld bc, wMapPartialEnd - wMapPartial
	call CopyBytes
	pop af
	call Bankswitch
	ret

GetMapAttributesPointer::
	push bc
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	call GetAnyMapPointer
	ld bc, 3 ; TODO: constantify this
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	pop af
	call Bankswitch
	pop bc
	ret

GetMapEnvironment::
	push hl
	push bc
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	call GetMapPointer
	ld bc, 2 ; TODO: constantify this
	add hl, bc
	ld b, [hl]
	pop af
	call Bankswitch
	ld a, b
	pop bc
	pop hl
	ret

GetAnyMapEnvironment::
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	call GetAnyMapPointer
	ld bc, 2 ; TODO: constantify this
	add hl, bc
	ld b, [hl]
	pop af
	call Bankswitch
	ld a, b
	ret

GetWorldMapLocation::
	ldh a, [hROMBank]
	push af
	ld a, BANK(MapGroupPointers)
	call Bankswitch
	call GetAnyMapPointer
	ld bc, 5 ; TODO: constantify this
	add hl, bc
	ld b, [hl]
	pop af
	call Bankswitch
	ld a, b
	ret


EmptyFunction2252::
	ret


LoadMap::
	ldh a, [hMapEntryMethod]
	and a ; Possible bug: if the entry method is $X0, this will overflow
	ret z
	and $0F
	dec a
	ld hl, .jumptable
	call CallJumptable
	xor a
	ldh [hMapEntryMethod], a
	scf
	ret

.jumptable
	dw MapSetup_Continue
	dw MapSetup_22af ; TODO
	dw MapSetup_Reload
	dw MapSetup_22de ; TODO
	dw MapSetup_22de ; TODO
	dw MapSetup_Warp
	dw MapSetup_Connection
	dw MapSetup_2275 ; TODO


MapSetup_2275::
	ldh a, [hROMBank]
	push af
	call MapSetup_22af ; TODO
	pop af
	call Bankswitch
	ret

MapSetup_Reload::
	call DisableLCD
	call DisableAudio
	call VolumeOff
	call SwitchToMapBank
	call LoadGraphics
	call ChangeMap
	call SaveScreen
	call LoadMapTimeOfDay
	call EnableLCD
	call PlayMapMusic
	ld a, $88 ; TODO: constantify this
	ld [wMusicFade], a
	ld b, 9 ; TODO: constantify this
	call GetSGBLayout
	call LoadWildMons
	call FadeIn
	ret

MapSetup_22af::
	call DisableLCD
	call DisableAudio
	call VolumeOff
	call SwitchToMapBank
	call SetUpMapBuffer
	call InitUnknownBuffercc9e
	call LoadGraphics
	call ChangeMap
	call LoadMapTimeOfDay
	call EnableLCD
	call PlayMapMusic
	ld a, $88 ; TODO: constantify this
	ld [wMusicFade], a
	ld b, 9 ; TODO: constantify this
	call GetSGBLayout
	call FadeIn
	ret

MapSetup_22de::
	callab OverworldFadeOut

MapSetup_Continue::
	call DisableLCD
	call DisableAudio
	call VolumeOff
	callab LoadSpawnPoint
	call CopyMapPartialAndAttributes
	call SetUpMapBuffer
	call InitUnknownBuffercc9e
	call RefreshPlayerCoords
	call GetCoordOfUpperLeftCorner
	call LoadGraphics
	call ChangeMap
	call LoadMapTimeOfDay
	call InitializeVisibleSprites
	call EnableLCD
	call PlayMapMusic
	ld a, $88 ; TODO: constantify this
	ld [wMusicFade], a
	ld b, 9 ; TODO: constantify this
	call GetSGBLayout
	call LoadWildMons
	call $242C ; TODO
	call FadeIn
	ret

MapSetup_Warp::
	callab OverworldFadeOut
	call DisableLCD
	call Function27C7 ; TODO
	ld a, [wNextWarp]
	ld [wWarpNumber], a
	ld a, [wNextMapGroup]
	ld [wMapGroup], a
	ld a, [wNextMapId]
	ld [wMapId], a
	call CopyMapPartialAndAttributes
	call SetUpMapBuffer
	call InitUnknownBuffercc9e
	call RestoreFacingAfterWarp
	call RefreshPlayerCoords
	call LoadGraphics
	call ChangeMap
	call LoadMapTimeOfDay
	call InitializeVisibleSprites
	call EnableLCD
	call PlayMapMusic
	ld b, 9 ; TODO: constantify this
	call GetSGBLayout
	call LoadWildMons
	call FadeIn
	call Function2407 ; TODO
	ret

LoadMapTimeOfDay::
	callab ReplaceTimeOfDayPals
	call LoadMapPart
	call .ClearBGMap
	call .PushAttrMap
	ret

.ClearBGMap
	ld a, HIGH(vBGMap0)
	ld [wBGMapAnchor + 1], a
	xor a ; LOW(vBGMap0)
	ld [wBGMapAnchor], a
	ldh [hSCY], a
	ldh [hSCX], a

	ld a, "■"
	ld bc, vBGMap1 - vBGMap0
	hlbgcoord 0, 0
	call ByteFill
	ret

.PushAttrMap
	decoord 0, 0
	hlbgcoord 0, 0
	ld c, SCREEN_WIDTH
	ld b, SCREEN_HEIGHT
.row
	push bc
.column
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .column
	ld bc, BG_MAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

LoadWildMons::
	callab _LoadWildMons
	ret

LoadGraphics::
	call LoadTileset
	call LoadTilesetGFX
	callba RefreshSprites
	call LoadFontExtra
	ret

InitializeVisibleSprites::
	callab _InitializeVisibleSprites
	ret

FadeIn:: ; This is not OverworldFadeIn, but I don't know what it is
	call InitToolgearBuffer
	call RefreshTiles
	ld hl, wVramState
	set 0, [hl]
	call Function2407
	callab _UpdateSprites
	call DelayFrame
	callab OverworldFadeIn
	ret

Function2407::
	ld a, NO_MOVEMENT
	ld [wPlayerMovement], a
	xor a
	ld [wPlayerAction], a
	ld a, [wPlayerFacing]
	and $c
	ld [wPlayerFacing], a
	ld a, [wPlayerTile]
	and $f0
	cp $70
	ret nz
	ld a, [wPlayerTile]
	cp $72
	ret z
	cp $70
	ret z
	cp $78
	ret z
	ld a, $0
	ld [wPlayerFacing], a
	ld a, $0
	ld d, $0
	call SetObjectFacing
	ret

MapSetup_Connection::
	call EnterMapConnection
	call CopyMapPartialAndAttributes
	call SetUpMapBuffer
	call InitUnknownBuffercc9e
	call RefreshPlayerCoords
	call InitializeVisibleSprites
	call ChangeMap
	call SaveScreen
	call FadeToMapMusic
	ld b, 9 ; TODO: constantify this
	call GetSGBLayout
	call LoadWildMons
	scf
	ret

CheckMovingOffEdgeOfMap::
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	and a ; DOWN
	jr z, .down
	cp UP
	jr z, .up
	cp LEFT
	jr z, .left
	cp RIGHT
	jr z, .right
	and a
	ret

.down
	ld a, [wPlayerMapY]
	sub 4
	ld b, a
	ld a, [wMapHeight]
	add a
	cp b
	jr z, .ok
	and a
	ret

.up
	ld a, [wPlayerMapY]
	sub 4
	cp -1
	jr z, .ok
	and a
	ret

.left
	ld a, [wPlayerMapX]
	sub 4
	cp -1
	jr z, .ok
	and a
	ret

.right
	ld a, [wPlayerMapX]
	sub 4
	ld b, a
	ld a, [wMapWidth]
	add a
	cp b
	jr z, .ok
	and a
	ret

.ok
	ld a, MAPSETUP_CONNECTION
	ldh [hMapEntryMethod], a
	scf
	ret

EnterMapConnection:
; Return carry if a connection has been entered.
	ld a, [wPlayerStepDirection]
	and a
	jp z, .south
	cp UP
	jp z, .north
	cp LEFT
	jp z, .west
	cp RIGHT
	jp z, .east
	ret

.west
	ld a, [wWestConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wWestConnectedMapNumber]
	ld [wMapId], a
	ld a, [wWestConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wWestConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wWestConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .skip_to_load
	ld a, [wWestConnectedMapWidth]
	add 6
	ld e, a
	ld d, 0

.loop
	add hl, de
	dec c
	jr nz, .loop

.skip_to_load
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp .done

.east
	ld a, [wEastConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wEastConnectedMapNumber]
	ld [wMapId], a
	ld a, [wEastConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wEastConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wEastConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .skip_to_load2
	ld a, [wEastConnectedMapWidth]
	add 6
	ld e, a
	ld d, 0

.loop2
	add hl, de
	dec c
	jr nz, .loop2

.skip_to_load2
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp .done

.north
	ld a, [wNorthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wNorthConnectedMapNumber]
	ld [wMapId], a
	ld a, [wNorthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wNorthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wNorthConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp .done

.south
	ld a, [wSouthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wSouthConnectedMapNumber]
	ld [wMapId], a
	ld a, [wSouthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wSouthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wSouthConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
.done
	scf
	ret


WarpCheck::
	call GetDestinationWarpPointer
	ret nc
	ld a, [hli]
	ld [wNextWarp], a
	ld a, [hli]
	ld [wNextMapGroup], a
	ld a, [hli]
	ld [wNextMapId], a
	ld a, c
	ld [wPrevWarp], a
	ld a, MAPSETUP_WARP
	ldh [hMapEntryMethod], a
	scf
	ret

GetDestinationWarpPointer:
	ld a, [wPlayerMapY]
	sub 4
	ld d, a
	ld a, [wPlayerMapX]
	sub 4
	ld e, a
	ld a, [wCurrMapWarpCount]
	ld c, a
	and a
	ret z

	ld hl, wCurrMapWarps
.next
	ld a, [hli]
	cp d
	jr nz, .nope
	ld a, [hl]
	cp e
	jr z, .found_warp
.nope
	push de
	ld de, 4 ; TODO: constantify this
	add hl, de
	pop de
	dec c
	jr nz, .next
	xor a
	ret

.found_warp
	ld a, [wCurrMapWarpCount]
	inc a
	sub c
	ld c, a
	inc hl
	scf
	ret


CopyMapPartialAndAttributes::
	call SwitchToMapBank
	call CopyAndReadHeaders
	call ReadObjectEvents
	ret

CopyAndReadHeaders::
	call CopyMapPartial
	call GetMapAttributesPointer
	ld hl, wMapAttributesPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wMapAttributes
	ld c, wMapAttributesEnd - wMapAttributes
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy
	call GetMapConnections
	ld hl, wMapObjectsPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	inc hl
	inc hl
	call ReadWarps
	call ReadSigns
	ret

GetMapConnections::
	ld a, $ff
	ld [wNorthConnectedMapGroup], a
	ld [wSouthConnectedMapGroup], a
	ld [wWestConnectedMapGroup], a
	ld [wEastConnectedMapGroup], a

	ld a, [wMapConnections]
	ld b, a
	bit 3, b
	jr z, .no_north
	ld de, wNorthMapConnection
	call GetMapConnection
.no_north

	bit 2, b
	jr z, .no_south
	ld de, wSouthMapConnection
	call GetMapConnection
.no_south

	bit 1, b
	jr z, .no_west
	ld de, wWestMapConnection
	call GetMapConnection
.no_west

	bit 0, b
	jr z, .no_east
	ld de, wEastMapConnection
	call GetMapConnection
.no_east

	ret

GetMapConnection::
	ld c, wSouthMapConnection - wNorthMapConnection
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .copy
	ret


ReadWarps::
	ld a, [hli]
	ld [wCurrMapWarpCount], a
	and a
	ret z
	ld c, a
	ld de, wCurrMapWarps
.next
	ld b, 5 ; TODO: constantify this
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy
	inc hl
	inc hl
	dec c
	jr nz, .next
	ret


ReadSigns::
	ld a, [hli]
	ld [wCurrMapSignCount], a
	and a
	ret z
	ld c, a
	ld de, wCurrMapSigns
.next
	ld b, 4
.copy
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .copy
	dec c
	jr nz, .next
	ret


ReadObjectEvents::
	push hl
	call ClearObjectStructs
	pop de
	ld hl, wMap2Object
	ld a, [de]
	inc de
	ld [wCurrMapObjectCount], a
	and a
	jr z, .skip

	ld c, a
.next
	push bc
	push hl
	ld a, $ff
	ld [hli], a
	ld b, OBJECT_EVENT_SIZE
.copy
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .copy
	pop hl
	ld bc, MAPOBJECT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .next

.skip
	ld a, [wCurrMapObjectCount]
	ld c, a
	ld a, NUM_OBJECTS 
	sub c
	jr z, .finish

	ld bc, 1
	add hl, bc ; Very thorough optimization. Don't do this at home, kids.
	ld bc, MAPOBJECT_LENGTH
.clear
	ld [hl], 0
	add hl, bc
	dec a
	jr nz, .clear

.finish
	ld h, d
	ld l, e
	ret

ClearObjectStructs::
	xor a
	ld [wUnkObjectStruct], a ; TODO
	ld hl, wObject2Struct
	ld de, OBJECT_LENGTH
	ld c, 7
.clear_struct
	ld [hl], a
	add hl, de
	dec c
	jr nz, .clear_struct

	ld hl, wCmdQueue
	ld de, CMDQUEUE_ENTRY_SIZE
	ld c, 4
	xor a
.clear_cmd_queue
	ld [hl], a
	add hl, de
	dec c
	jr nz, .clear_cmd_queue
	ret


ReadWord:: ; TODO: is this used?
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ret


InitUnknownBuffercc9e::
	xor a
	ld hl, wUnknownWordcc9c
	ld [hli], a
	ld [hli], a
	ld hl, wUnknownBuffercc9e ; useless
	ld bc, 14 ; TODO: constantify this
	ld a, $ff
	call ByteFill
	ld hl, wUnknownMapPointer
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, e
	or d
	jr z, .null

	ld a, [wMapBuffer]
	ld l, a
	ld h, 0
	add hl, hl
	add hl, hl
	add hl, de
	inc hl
	inc hl
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld de, wUnknownBuffercc9e - 2
.next
	ld a, [bc]
	inc bc
	cp $ff ; Could have used one of the `inc a` below
	jr z, .done
	inc a
	inc a
	and $0f
	ld l, a
	ld h, 0
	add hl, de
	ld [hl], 0
	jr .next

.null
	ld hl, wUnknownBuffercc9e
	ld bc, 14 ; TODO: constantify this
	xor a
	call ByteFill
.done
	ret


RestoreFacingAfterWarp::
	ld hl, wMapObjectsPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	; Point to 1st warp
	inc hl
	inc hl
	inc hl
	ld a, [wWarpNumber]
	dec a
	ld c, a
	ld b, 0
	ld a, 7 ; Size of warp ; TODO: constantify this
	call AddNTimes
	ld a, [hli]
	ld [wYCoord], a
	ld a, [hli]
	ld [wXCoord], a
	call GetCoordOfUpperLeftCorner
	ret


Function275e:: ; TODO: is this used?
	inc hl
	inc hl
	inc hl
	ld a, [hli]
	ld [wOverworldMapAnchor], a
	ld a, [hl]
	ld [wOverworldMapAnchor + 1], a
	ld a, [wYCoord]
	and 1
	ld [wMetatileNextY], a
	ld a, [wXCoord]
	and 1
	ld [wMetatileNextX], a
	ret


GetCoordOfUpperLeftCorner::
	ld hl, wOverworldMapBlocks
	ld a, [wXCoord]
	bit 0, a
	jr nz, .increment_then_halve1
	srl a
	add a, 1
	jr .resume

.increment_then_halve1
	add a, 1
	srl a

.resume
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wMapWidth]
	add a, 6
	ld c, a
	ld b, 0
	ld a, [wYCoord]
	bit 0, a
	jr nz, .increment_then_halve2
	srl a
	add a, 1
	jr .resume2

.increment_then_halve2
	add a, 1
	srl a

.resume2
	call AddNTimes
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	ld a, [wYCoord]
	and 1
	ld [wMetatileNextY], a
	ld a, [wXCoord]
	and 1
	ld [wMetatileNextX], a
	ret

Function27C7:: ; TODO
	call GetMapEnvironment
	cp 2
	jr z, .interior
	cp 1
	jr z, .interior
	ret
.interior
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapId]
	ld c, a
	call GetAnyMapEnvironment
	cp 3
	jr z, .exterior
	cp 4
	jr z, .exterior
	cp 6
	jr z, .exterior
	ret

.exterior
	ld hl, $D4B2 ; TODO: figure out what this is
	ld a, [wPrevWarp]
	ld [hli], a
	ld a, [wMapGroup]
	ld [hli], a
	ld a, [wMapId]
	ld [hli], a
	ret

LoadMapPart::
	callab UpdateTimeOfDayPal

	ldh a, [hROMBank]
	push af
	ld a, [wTilesetBank]
	call Bankswitch

	call LoadMetatiles
	ld a, "■"
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	call ByteFill

	call ApplyFlashlight

	pop af
	call Bankswitch
	ret

LoadMetatiles::
	ld a, [wOverworldMapAnchor]
	ld e, a
	ld a, [wOverworldMapAnchor + 1]
	ld d, a
	ld hl, wTileMapBackup
	ld b, 5 ; TODO: constantify this
.row
	push de
	push hl
	ld c, 6 ; TODO: constantify this
.tile
	push bc
	push de
	push hl
	ld a, [de]
	ld c, a
	call DrawMetatile
	pop hl
	ld bc, 4
	add hl, bc
	pop de
	inc de
	pop bc
	dec c
	jr nz, .tile
	pop hl
	ld de, BG_MAP_WIDTH * 3
	add hl, de
	pop de
	ld a, [wMapWidth]
	add a, 6
	add a, e
	ld e, a
	jr nc, .nocarry
	inc d
.nocarry
	dec b
	jr nz, .row
	ret

ApplyFlashlight::
	ld hl, wTileMapBackup
	ld a, [wMetatileNextY]
	and a
	jr z, .top_row
	ld bc, $30 ; TODO: constantify this
	add hl, bc
.top_row
	ld a, [wMetatileNextX]
	and a
	jr z, .left_col
	inc hl
	inc hl
.left_col

	ldh a, [hOverworldFlashlightEffect]
	and a
	jr z, .no_flashlight
	cp 1
	jr z, .force_1
	cp 2
	jr z, .force_2
	cp 3
	jr z, .force_3
	jp .force_4

.no_flashlight
	ld de, wTileMap
	ld b, SCREEN_HEIGHT ; TODO: constantify this
.row
	ld c, SCREEN_WIDTH
.tile
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .tile

	ld a, l
	add a, 4
	ld l, a
	jr nc, .nocarry
	inc h
.nocarry
	dec b
	jr nz, .row
	ret

; redraw_with_flashlight force
; force = 1, 2 or 3
; 0 and 4 have special handling, see above and below
MACRO redraw_with_flashlight
	decoord \1 * 2, \1 * 2
	ld bc, \1 * $32 ; TODO: constantify the $32
	add hl, bc
	ld c, SCREEN_HEIGHT - \1 * 4
.row\1
	ld b, SCREEN_HEIGHT - \1 * 4
.tile\1
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .tile\1
	ld a, l
	add a, 6 + \1 * 4
	ld l, a
	jr nc, .nohlcarry\1
	inc h
.nohlcarry\1
	ld a, e
	add a, 2 + \1 * 4
	ld e, a
	jr nc, .nodecarry\1
	inc d
.nodecarry\1
	dec c
	jr nz, .row\1
ENDM

.force_1
	redraw_with_flashlight 1
	ret

.force_2
	redraw_with_flashlight 2
	ret

.force_3
	redraw_with_flashlight 3
	ret

.force_4
	; This also applies to larger values than 4
	decoord 4 * 2, 4 * 2
	ld bc, 4 * $32 ; TODO: constantify the $32
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ld bc, 6 + 4 * 4
	add hl, bc
	ld a, e
	add a, 2 + 4 * 4 + 1 ; Compensate missing `inc de`
	ld e, a
	jr nc, .nocarry9001
	inc d
.nocarry9001
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	ret

DrawMetatile::
	push hl
	ld hl, wTilesetBlocksAddress
	ld a, [hli]
	ld h, [hl]
	ld l, a
	swap c
	ld a, c
	and $0f
	ld b, a
	ld a, c
	and $f0
	ld c, a
	add hl, bc
	pop de
	lb bc, $14, 4 ; TODO: constantify $14
.row
REPT 4
	ld a, [hli]
	ld [de], a
	inc de
ENDR
	ld a, e
	add a, b
	ld e, a
	jr nc, .nocarry
	inc d
.nocarry
	dec c
	jr nz, .row
	ret


ChangeMap::
	ld hl, wOverworldMapBlocks
	ld bc, wOverworldMapBlocksEnd - wOverworldMapBlocks
	ld a, 0
	call ByteFill

	ld hl, wOverworldMapBlocks
	ld a, [wMapWidth]
	ldh [hConnectedMapWidth], a
	add a, 6
	ldh [hConnectionStripLength], a
	ld c, a
	ld b, 0
	add hl, bc
	add hl, bc
	add hl, bc
	ld c, 3
	add hl, bc

	ld a, [wMapBlocksPointer]
	ld e, a
	ld a, [wMapBlocksPointer + 1]
	ld d, a
	ld a, [wMapHeight]
	ld b, a
.row
	push hl
	ldh a, [hConnectedMapWidth]
	ld c, a
.col
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .col
	pop hl
	ldh a, [hConnectionStripLength]
	add l
	ld l, a
	jr nc, .okay
	inc h
.okay
	dec b
	jr nz, .row

; FillMapConnections::

	ld a, [wNorthConnectedMapGroup]
	cp $ff
	jr z, .south
	ld b, a
	ld a, [wNorthConnectedMapNumber]
	ld c, a
	call SwitchToAnyMapBank

	ld a, [wNorthConnectionStripPointer]
	ld l, a
	ld a, [wNorthConnectionStripPointer + 1]
	ld h, a
	ld a, [wNorthConnectionStripLocation]
	ld e, a
	ld a, [wNorthConnectionStripLocation + 1]
	ld d, a
	ld a, [wNorthConnectionStripLength]
	ldh [hConnectionStripLength], a
	ld a, [wNorthConnectedMapWidth]
	ldh [hConnectedMapWidth], a
	call FillNorthConnectionStrip

.south
	ld a, [wSouthConnectedMapGroup]
	cp $ff
	jr z, .west
	ld b, a
	ld a, [wSouthConnectedMapNumber]
	ld c, a
	call SwitchToAnyMapBank

	ld a, [wSouthConnectionStripPointer]
	ld l, a
	ld a, [wSouthConnectionStripPointer + 1]
	ld h, a
	ld a, [wSouthConnectionStripLocation]
	ld e, a
	ld a, [wSouthConnectionStripLocation + 1]
	ld d, a
	ld a, [wSouthConnectionStripLength]
	ldh [hConnectionStripLength], a
	ld a, [wSouthConnectedMapWidth]
	ldh [hConnectedMapWidth], a
	call FillSouthConnectionStrip

.west
	ld a, [wWestConnectedMapGroup]
	cp $ff
	jr z, .east
	ld b, a
	ld a, [wWestConnectedMapNumber]
	ld c, a
	call SwitchToAnyMapBank

	ld a, [wWestConnectionStripPointer]
	ld l, a
	ld a, [wWestConnectionStripPointer + 1]
	ld h, a
	ld a, [wWestConnectionStripLocation]
	ld e, a
	ld a, [wWestConnectionStripLocation + 1]
	ld d, a
	ld a, [wWestConnectionStripLength]
	ld b, a
	ld a, [wWestConnectedMapWidth]
	ldh [hConnectionStripLength], a
	call FillWestConnectionStrip

.east
	ld a, [wEastConnectedMapGroup]
	cp $ff
	jr z, .done
	ld b, a
	ld a, [wEastConnectedMapNumber]
	ld c, a
	call SwitchToAnyMapBank

	ld a, [wEastConnectionStripPointer]
	ld l, a
	ld a, [wEastConnectionStripPointer + 1]
	ld h, a
	ld a, [wEastConnectionStripLocation]
	ld e, a
	ld a, [wEastConnectionStripLocation + 1]
	ld d, a
	ld a, [wEastConnectionStripLength]
	ld b, a
	ld a, [wEastConnectedMapWidth]
	ldh [hConnectionStripLength], a
	call FillEastConnectionStrip

.done
	ret

FillNorthConnectionStrip::
FillSouthConnectionStrip::

	ld c, 3
.y
	push de

	push hl
	ldh a, [hConnectionStripLength]
	ld b, a
.x
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .x
	pop hl

	ldh a, [hConnectedMapWidth]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ld a, [wMapWidth]
	add a, 6
	add e
	ld e, a
	jr nc, .okay
	inc d
.okay
	dec c
	jr nz, .y
	ret

FillWestConnectionStrip::
FillEastConnectionStrip::

.loop
	ld a, [wMapWidth]
	add a, 6
	ldh [hConnectedMapWidth], a

	push de

	push hl
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hli]
	ld [de], a
	inc de
	pop hl

	ldh a, [hConnectionStripLength]
	ld e, a
	ld d, 0
	add hl, de
	pop de

	ldh a, [hConnectedMapWidth]
	add e
	ld e, a
	jr nc, .okay
	inc d
.okay
	dec b
	jr nz, .loop
	ret

Function2a85::
.asm_2a85:
	call LoadMap
	call Function2a8d
	jr .asm_2a85

Function2a8d::
	push hl
	push de
	push bc
	push af

	ld a, [wd637]
	and $f
	add a
	ld e, a
	ld d, $0
	ld hl, .Pointers
	add hl, de
	add hl, de

	ld a, [hli]
	call Bankswitch

	inc hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .Return
	push de
	jp hl

.Return:
	pop af
	pop bc
	pop de
	pop hl
	ret

.Pointers:
	dbbw $00, $55, Function2ae5
	dbbw $00, $55, Function2b52
	dbbw $00, $55, Function2b77
	dbbw $0e, $33, Function3904
	dbbw $00, $55, Function2b39
	dbbw $0e, $33, Function391f
	dbbw $00, $33, Function2b78
	dbbw $00, $33, Function2b78
	dbbw $0e, $33, Function3904
	dbbw $00, $55, Function2b79
	dbbw $00, $55, Function2b87
	dbbw $0e, $33, Function3920
	dbbw $05, $33, Function14777

Function2ae5::
.loop:
	ld hl, wJoypadFlags
	set 4, [hl]
	set 6, [hl]
	call UpdateTime
	call TimeOfDayPals
	ld hl, wJoypadFlags
	res 4, [hl]
	res 6, [hl]
	call GetJoypad
	call Function2be5
	ld hl, wc5ed
	bit 7, [hl]
	res 7, [hl]
	ret nz
	call TestWildBattleStart
	ret nz
	call OverworldStartButtonCheck
	ret nz
	callab OverworldMovementCheck
	ldh a, [hMapEntryMethod]
	and a
	ret nz
	call Function2c4a
	jr nc, .loop
	callba Function824c
	ld a, [wc5ed]
	bit 6, a
	jr nz, .loop
	call CheckMovingOffEdgeOfMap
	ret c
	call WarpCheck
	ret c
	jr .loop

Function2b39::
	ld hl, wJoypadFlags
	res 4, [hl]
	res 6, [hl]
	ld hl, wDebugFlags
	res 6, [hl]
	res 7, [hl]
	ld hl, wVramState
	res 7, [hl]
	ld a, $0
	call WriteIntod637
	ret

Function2b52::
.asm_2b52:
	call UpdateTime
	ld a, [wVramState]
	bit 7, a
	jr z, Function2b39
	ldh a, [hMapEntryMethod]
	and a
	ret nz
	call Function2c4a
	jr nc, .asm_2b52
	callba Function824c
	call CheckMovingOffEdgeOfMap
	ret c
	call WarpCheck
	ret c
	jr .asm_2b52

Function2b77::
	ret

Function2b78::
	ret

Function2b79::
	callab DebugMapViewer
	ld a, $4
	call WriteIntod637
	ret

Function2b87::
.asm_2b87:
	call UpdateTime
	call GetJoypad
	call OverworldStartButtonCheck
	ret nz
	callab OverworldMovementCheck
	call Function2ba8
	jr nc, .asm_2b87
	callba Function824c
	jr .asm_2b87

Function2ba8::
	ldh a, [hROMBank]
	push af
	ld a, BANK(Function50b9)
	call Bankswitch
	call Function50b9
	call Function18a0
	ld a, BANK(Functiond6e4)
	call Bankswitch
	call Functiond6e4
	ld a, BANK(_UpdateSprites)
	call Bankswitch
	call _UpdateSprites
	call DelayFrame
	call UpdateToolgear
	ld hl, wToolgearFlags
	set 2, [hl] ; transfer toolgear to window
	call DelayFrame
	pop af
	call Bankswitch
	and a
	ld a, [wcb6e]
	bit 5, a
	ret z
	bit 6, a
	jr z, Function2ba8
	scf
	ret

Function2be5:: ; TODO
	ld a, [wDebugFlags]
	bit 7, a
	ret nz
	ld a, [wMapGroup]
	ld b, a
	ld a, [wMapId]
	ld c, a
	call SwitchToAnyMapBank
	call QueueMapTextSubroutine
	ld hl, wMapScriptPtr
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .Return
	push de
	jp hl

.Return:
	ret
