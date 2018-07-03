INCLUDE "constants.asm"


SECTION "Music engine RAM", WRAM0[$C000]

wMusic:: ; c000

wChannels::
wChannel1:: channel_struct wChannel1 ; c000
wChannel2:: channel_struct wChannel2 ; c032
wChannel3:: channel_struct wChannel3 ; c064
wChannel4:: channel_struct wChannel4 ; c096

wSFXChannels::
wChannel5:: channel_struct wChannel5 ; c0c8
wChannel6:: channel_struct wChannel6 ; c0fa
wChannel7:: channel_struct wChannel7 ; c12c
wChannel8:: channel_struct wChannel8 ; c15e

	ds 1 ; c190

wCurTrackDuty:: db ; c191
wCurTrackIntensity:: db ; c192
wCurTrackFrequency:: dw ; c193
wc195:: db ; c195
; c196
	ds 2 ; TODO

wCurChannel:: db ; c198
wVolume:: db ; c199
wSoundOutput:: ; c19a
; corresponds to $ff25
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	db

; c19b
	ds 1 ; TODO

wMusicID:: dw ; c19c
wMusicBank:: db ; c19e
; c19f
	ds 5 ; TODO

wLowHealthAlarm:: ; c1a4
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	db

wMusicFade:: ; c1a5
; fades volume over x frames
; bit 7: fade in/out
; bit 0-6: number of frames for each volume level
; $00 = none (default)
	db

wMusicFadeCount:: db ; c1a6
wMusicFadeID:: dw ; c1a7
; c1a9
    ds 2 ; TODO

wIncrementTempo: dw ; c1ab
wMapMusic:: db ; c1ad
wCryPitch:: dw ; c1ae
wCryLength:: dw ; c1b0
; c1b2
    ds 7 ; TODO

wc1b9:: db ; c1b9
wc1ba:: db ; c1ba
; either wChannelsEnd or wMusicEnd, unsure

; c1bb
	ds 1 ; TODO

wMusicInitEnd:: ; c1bc


SECTION "OAM Buffer", WRAM0[$C200]

wVirtualOAM:: ; c200
    ds SPRITEOAMSTRUCT_LENGTH * NUM_SPRITE_OAM_STRUCTS
wVirtualOAMEnd::

SECTION "Tile Map", WRAM0[$C2A0]

wTileMap:: ; c2a0
    ds SCREEN_HEIGHT * SCREEN_WIDTH

UNION ; c408
wTileMapBackup:: ; c408
    ds SCREEN_HEIGHT * SCREEN_WIDTH

NEXTU ; c408
    ds 3

; Monster or Trainer test?
wWhichPicTest:: ; c40b
    db
ENDU ; c570

	ds 120 ; TODO (is used)

wMapBuffer::
wMapScriptNumber:: db ; c5e8
wMapScriptNumberLocation:: dw ; c5e9
wUnknownMapPointer:: dw ; c5eb ; TODO
wc5ed:: db ; c5ed
    ds 18
wMapBufferEnd:: ; c600

UNION ; c600
wOverworldMapBlocks::
	ds 1300
wOverworldMapBlocksEnd:: ; cb14

NEXTU ; c600
wLYOverrides:: ; c600
    ds SCREEN_HEIGHT_PX
; c690
    ds $10
wLYOverrides2:: ; c6a0

NEXTU ; c600
; Battle-related

	ds 490 ; TODO

wActiveBGEffects:: ; c7ea
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
wActiveBGEffectsEnd::

wNumActiveBattleAnims:: db ; c7fe

wBattleAnimFlags:: db ; c7ff
wBattleAnimAddress:: dw ; c800
wBattleAnimDuration:: db ; c802
wBattleAnimParent:: dw ; c803
wBattleAnimLoops:: db ; c805
wBattleAnimVar:: db ; c806
wBattleAnimByte:: db ; c807
wBattleAnimOAMPointerLo:: db ; c808
	db

UNION ; c80a
; unidentified
wBattleAnimTemp0:: db
wBattleAnimTemp1:: db
wBattleAnimTemp2:: db
wBattleAnimTemp3:: db

NEXTU ; c80a
wBattleAnimTempOAMFlags:: db
wBattleAnimTempField02:: db
wBattleAnimTempTileID:: db
wBattleAnimTempXCoord:: db
wBattleAnimTempYCoord:: db
wBattleAnimTempXOffset:: db
wBattleAnimTempYOffset:: db
wBattleAnimTempAddSubFlags:: db
wBattleAnimTempPalette:: db
ENDU ; c813

	ds 50
wBattleAnimEnd::
; c845
	ds 433 ; TODO

wBattleMonNickname:: ds 6 ; c9f6
wEnemyMonNickname:: ds 6 ; c9fc
; ca02
	ds 59 ; TODO

wPlayerSubStatus3:: db ; ca3d
; ca3e
	ds 4 ; TODO

wEnemySubStatus3:: db ; ca42
wca43:: db ; ca43
wca44:: db ; ca44

	ds 18
wTrainerClass:: db ; ca57
; ca58
	ds 107 ; TODO

wLinkBattleRNCount:: db ; cac3

ENDU

UNION
wRedrawRowOrColumnSrcTiles:: ; cb14
; the tiles of the row or column to be redrawn by RedrawRowOrColumn
    ds SCREEN_WIDTH * 2
NEXTU
wRedrawFlashlightDst0:: dw ; cb14
wRedrawFlashlightSrc0:: dw ; cb16
wRedrawFlashlightBlackDst0:: dw ; cb18
wRedrawFlashlightDst1:: dw ; cb1a
wRedrawFlashlightSrc1:: dw ; cb1c
wRedrawFlashlightBlackDst1:: dw ; cb1e
wRedrawFlashlightWidthHeight:: db ; cb20
; width or height of flashlight redraw region
; in units of two tiles (people event meta tile)
ENDU
; cb3c
	ds 16 ; TODO

wOtherPlayerLinkMode:: db ; cb4c
wOtherPlayerLinkAction:: db ; cb4d
; cb4e
	ds 3 ; TODO

wPlayerLinkAction:: db ; cb51
; cb52
	ds 4 ; TODO

wLinkTimeoutFrames:: dw ; cb56
wcb58:: ds 2 ; cb58
wMonType:: db ; cb5a
wCurSpecies:: db ; cb5b
wNamedObjectTypeBuffer:: db ; cb5c
; cb5d
	ds 1 ; TODO

wJumptableIndex:: db ; cb5e
wFlyDestination:: db ; cb5f
; cb60
	ds 2 ; TODO

wVBCopySize:: ds 1 ; cb62
wVBCopySrc:: ds 2 ; cb63
wVBCopyDst:: ds 2 ; cb65
wVBCopyDoubleSize:: ds 1 ; cb67
wVBCopyDoubleSrc:: ds 2 ; cb68
wVBCopyDoubleDst:: ds 2 ; cb6a
; cb6b
	ds 2 ; TODO

wcb6e:: db
wPlayerStepDirection:: db
wcb70:: db

wVBCopyFarSize:: ds 1 ; cb71
wVBCopyFarSrc:: ds 2 ; cb72
wVBCopyFarDst:: ds 2 ; cb74
wVBCopyFarSrcBank:: ds 1 ; cb76
wPlayerMovement:: db ; cb77
wMovementObject:: db ; cb78
wMovementDataBank:: db ; cb79
wMovementDataAddr:: dw ; cb7a
; cb7c
	ds 20

wTileDown::  db ; cb90
wTileUp::    db ; cb91
wTileLeft::  db ; cb92
wTileRight:: db ; cb93

wScreenSave:: ; cb94
	ds 6 * 5

wToolgearBuffer:: ; cbb2
	ds 64
; cbe2


wWindowData::
wWindowStackPointer:: dw ; cbf2
wMenuJoypad:: db ; cbf4
wMenuSelection:: db ; cbf5
wMenuSelectionQuantity:: db ; cbf6
wWhichIndexSet::
wActiveBackpackPocket:: db ; cbf7
wScrollingMenuCursorPosition:: db ; cbf8
wWindowStackSize:: db ; cbf9
; cbfa
	ds 8

wMenuDataHeader:: db ; cc02
wMenuBorderTopCoord:: db ; cc03
wMenuBorderLeftCoord:: db ; cc04
wMenuBorderBottomCoord:: db ; cc05
wMenuBorderRightCoord:: db ; cc06
wMenuDataPointer:: dw ; cc07
wMenuCursorBuffer:: db ; cc09
; cc0a
	ds 8 ; TODO

wMenuData2::
wMenuDataFlags:: db ; cc12
wMenuDataItems:: db ; cc13
wMenuDataIndicesPointer:: dw ; cc14
wMenuDataDisplayFunctionPointer:: dw ; cc16
wMenuDataPointerTableAddr:: dw ; cc18
; cc1a
	ds 8

wMenuData3:: ; cc22

w2DMenuCursorInitY:: db ; cc22
w2DMenuCursorInitX:: db ; cc23
w2DMenuNumRows:: db ; cc24
w2DMenuNumCols:: db ; cc25
w2DMenuFlags:: dw ; cc26
w2DMenuCursorOffsets:: db ; cc28
wMenuJoypadFilter:: db ; cc29
w2DMenuDataEnd::

wMenuCursorY:: db ; cc2a
wMenuCursorX:: db ; cc2b
wCursorOffCharacter:: db ; cc2c
wCursorCurrentTile:: dw ; cc2d
; cc2f
	ds 3 ; TODO

wVBlankJoyFrameCounter: db ; cc32

wVBlankOccurred: db ; cc33
wLastSpawnMapGroup: db ;cc34
wLastSpawnMapNumber: db ; cc35
; cc36
	ds 2

;Controls what type of opening (fire/notes) you get.
wcc38::
wTitleSequenceOpeningType:: ; cc38
	db

wDefaultSpawnPoint:: ; cc39
	db

wMovementBufferCount:: db ; cc3a
wMovementBufferObject:: db ; cc3b
wMovementBufferBank:: db ; cc3c
wMovementBufferAddr:: dw ; cc3d
wMovementBuffer:: ; cc3f
	ds 55
; cc76
	ds 36 ; TODO

wSkatingDirection:: db ; cc9a
wCompanionCollisionFrameCounter:: db ; cc9b
wUnknownWordcc9c:: dw ; cc9c
wUnknownBuffercc9e:: ; cc9e
	ds 14

wSpriteCurPosX          : ds 1 ; ccac
wSpriteCurPosY          : ds 1 ; ccad
wSpriteWidth            : ds 1 ; ccae
wSpriteHeight           : ds 1 ; ccaf
wSpriteInputCurByte     : ds 1 ; ccb0
wSpriteInputBitCounter  : ds 1 ; ccb1
wSpriteOutputBitOffset  : ds 1 ; ccb2
wSpriteLoadFlags        : ds 1 ; ccb3
wSpriteUnpackMode       : ds 1 ; ccb4
wSpriteFlipped          : ds 1 ; ccb5
wSpriteInputPtr         : ds 2 ; ccb6
wSpriteOutputPtr        : ds 2 ; ccb8
wSpriteOutputPtrCached  : ds 2 ; ccba
wSpriteDecodeTable0Ptr  : ds 2 ; ccbc
wSpriteDecodeTable1Ptr  : ds 2 ; ccbe
; ccc0
	ds 7 ; TODO

wDisableVBlankOAMUpdate:: db ; ccc7
; ccc8
	ds 2 ; TODO

wBGP:: db ; ccca
wOBP0:: db ; cccb
wOBP1:: db ; cccc
; cccd
	ds 1 ; TODO

wDisableVBlankWYUpdate:: db ; ccce
wSGB:: db ; cccf

SECTION "CD26", WRAM0[$CD26]

wStringBuffer1:: ds 1 ; How long is this? ; cd26

SECTION "CD31", WRAM0[$CD31]

UNION
wStartDay:: db ;cd31
wStartHour:: db ;cd32
wStartMinute:: db ;cd33

NEXTU
wHPBarTempHP:: dw ; cd31

NEXTU
wStringBuffer2:: db ; How long is this? ; cd31

ENDU


SECTION "CD3E", WRAM0[$CD3D]

wRegularItemsCursor:: db ; cd3d
wBackpackAndKeyItemsCursor:: db ;cd3e
wStartmenuCursor:: db ; cd3f
    ds 4 ; TODO
wRegularItemsScrollPosition:: db ; cd44
wBackpackAndKeyItemsScrollPosition:: db ; cd45
    ds 3 ; TODO
wMenuScrollPosition:: db ; cd49

wTextDest:: ds 2; cd4a

wQueuedScriptBank:: db ; cd4c
wQueuedScriptAddr:: dw ; cd4d

wPredefID:: ; cd4f
    db

wPredefHL:: ; cd50
    dw
wPredefDE:: ; cd52
    dw
wPredefBC:: ; cd54

wFarCallBCBuffer:: ; cd54
    dw

    ds 2 ; TODO

wFieldMoveSucceeded:: db ; cd58
wVramState:: db ; cd59

	ds 3 ; TODO
wcd5d:: db ; cd5d
	db
wChosenStarter:: db ; cd5f

SECTION "CD72", WRAM0[$CD72]
wcd72:: dw ; cd72

	ds 2 ; TODO

wCurItem:: db ; cd76
wItemIndex:: db ;cd77
wMonDexIndex: db ; cd78
wWhichPokemon: db ; cd79

SECTION "CD7B", WRAM0[$CD7B]

wHPBarType:: db ; cd76
	
	ds 1

wItemQuantity:: db ; cd7d
wItemQuantityBuffer:: db ; cd7e

SECTION "CD9E", WRAM0 [$CD9E]
wcd9e:: db ; cd9e

SECTION "CDAF", WRAM0 [$CDAF]
wcdaf:: db ; cdaf

SECTION "CDB0", WRAM0 [$CDB0]
wTalkingTargetType:: db ; cdb0 
;bit 0 = has engaged NPC in dialogue 
;bit 1 = has engaged sign in dialogue

SECTION "CDBA", WRAM0[$CDBA]

wItemAttributeParamBuffer:: db ; cdba
wCurPartyLevel:: db ; cdbb

SECTION "CDBD", WRAM0[$CDBD]

wLinkMode:: db ; cdbd
; 00 - 
; 01 - 
; 02 - 
; 03 -  

wNextWarp:: db ; cdbe
wNextMapGroup:: db ; cdbf
wNextMapId:: db ; cdc0
wPrevWarp:: db ; cdc1

	ds 1

UNION
wFieldMoveScriptID:: db; cdc3
wMapBlocksAddress:: dw ; cdc4
wReplacementBlock:: db ; cdc6

NEXTU

wHPBarMaxHP:: dw ; cdc3
wHPBarOldHP:: dw ; cdc5

ENDU

wHPBarNewHP:: dw ; cdc7
wHPBarDelta::   db ; cdc9
wcdca:: db ; cdca
wHPBarHPDifference:: dw ; cdcb

wLinkBattleRNs:: ds 10 ; cdcd

wcdd7:: db ; cdd7
; cddd


SECTION "CE00", WRAM0[$CE00]

wBattleMode:: db ; ce00
    db
wce02:: db ; ce02
	ds 2
wce05:: db ; ce05

SECTION "CE07", WRAM0[$CE07]

wMonHeader::

wMonHIndex:: ; ce07
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the dex number after the header is copied to WRAM.
    ds 1

wMonHBaseStats:: ; ce08
wMonHBaseHP:: ; ce08
    ds 1
wMonHBaseAttack:: ; ce09
    ds 1
wMonHBaseDefense:: ; ce0a
    ds 1
wMonHBaseSpeed:: ; ce0b
    ds 1
wMonHBaseSpecialAtt:: ; ce0c
    ds 1
wMonHBaseSpecialDef:: ; ce0d
    ds 1

wMonHTypes:: ; ce0e
wMonHType1:: ; ce0e
    ds 1
wMonHType2:: ; ce0f
    ds 1

wMonHCatchRate:: ; ce10
    ds 1
wMonHBaseEXP:: ; ce11
    ds 1

wMonHItems:: ; ce12
wMonHItem1:: ; ce12
    ds 1
wMonHItem2:: ; ce13
    ds 1

wMonHGenderRatio:: ; ce14
    ds 1

wMonHUnk0:: ; ce15
    ds 1
wMonHUnk1:: ; ce16
    ds 1
wMonHUnk2:: ; ce17
    ds 1

wMonHSpriteDim:: ; ce18
    ds 1
wMonHFrontSprite:: ; ce19
    ds 2
wMonHBackSprite:: ; ce1b
    ds 2

wMonHGrowthRate:: ; ce1d
    ds 1

wMonHLearnset:: ; ce1e
; bit field
    flag_array 50 + 5 ; size = 7
    ds 1

SECTION "CE2E", WRAM0[$CE2E]
wce2e:: ; ce2e
	ds 9

SECTION "CE37", WRAM0[$CE37]

wNamedObjectIndexBuffer::
wCountSetBitsResult:: 
wce37:: ; ce37
    db

SECTION "CE3B", WRAM0[$CE3B]

wVBlankSavedROMBank:: ; ce3b
    db

wBuffer:: ; ce3c
    db

wTimeOfDay:: db ; ce3d
; based on RTC
; Time of Day   Regular    Debug
; 00 - Day      09--15h    00--30s
; 01 - Night    15--06h    30--35s
; 02 - Cave                35--50s
; 03 - Morning  06--09h    50--59s

SECTION "CE5F", WRAM0[$CE5F]

wce5f:: ; ce5f ; debug menu writes $41 to it
    db

wce60:: ; ce60
	db ; main menu checks this, maybe states if there's a save present?

wActiveFrame:: db ; ce61

wTextBoxFlags::  db ; ce62

wDebugFlags:: db ; ce63
; Bit 0: Debug battle indicator
; Bit 1: Debug field indicator
; Bit 2-3: Game is continued (set when selecting continue on the main menu)

	ds 3
	
wPlayerName:: ds 6 ; ce67

wMomsName:: ds 6 ; ce6d

SECTION "CE7F", WRAM0[$CE76]

wObjectFollow_Leader:: ; ce76
    db
wObjectFollow_Follower:: ; ce77
    db
wCenteredObject:: ; ce78
	db
wFollowerMovementQueueLength:: ; ce79
	db
wFollowMovementQueue:: ; ce7a
	ds 5

wObjectStructs:: ; ce7f
; Note: this might actually not be an object. TODO: Investigate (if indexing starts at 1, then this isn't an object)
; It might just be unused/a leftover.
wUnkObjectStruct:: object_struct wUnkObject ; ce7f
wPlayerStruct::   object_struct wPlayer ; cea7
wObject1Struct::  object_struct wObject1 ; cecf
wObject2Struct::  object_struct wObject2 ; cef7
wObject3Struct::  object_struct wObject3 ; cf1f
wObject4Struct::  object_struct wObject4 ; cf47
wObject5Struct::  object_struct wObject5 ; cf6f
wObject6Struct::  object_struct wObject6 ; cf97
wObject7Struct::  object_struct wObject7 ; cfbf
wObject8Struct::  object_struct wObject8 ; cfe7
wObjectStructsEnd:: ; d00f

wCmdQueue:: ; d00f
wCmdQueueEntry1:: ds 16
wCmdQueueEntry2:: ds 16
wCmdQueueEntry3:: ds 16
wCmdQueueEntry4:: ds 16

wMapObjects:: ; d04f
wPlayerObject:: map_object wPlayer
wMap1Object::   map_object wMap1
wMap2Object::   map_object wMap2
wMap3Object::   map_object wMap3
wMap4Object::   map_object wMap4
wMap5Object::   map_object wMap5
wMap6Object::   map_object wMap6
wMap7Object::   map_object wMap7
wMap8Object::   map_object wMap8
wMap9Object::   map_object wMap9
wMap10Object::  map_object wMap10
wMap11Object::  map_object wMap11
wMap12Object::  map_object wMap12
wMap13Object::  map_object wMap13
wMap14Object::  map_object wMap14
wMap15Object::  map_object wMap15
wMapObjectsEnd:: ; d14f

wToolgearFlags:: db ; d14f
; 76543210
; |    | \- show toolgear
; |    |
; |    \--- transfer toolgear to window
; \-------- hide toolgear

	ds 2 ; TODO

wTimeOfDayPal:: db ; d152
; Applied according to wCurTimeOfDay from wTimeOfDayPalset

wd153:: db ; d153
; 76543210
; |      \- show player coords in toolgear instead of time
; \-------- switch overworld palettes according to seconds not hours

    ds 3 ; TODO
wTimeOfDayPalFlags:: db ; d157
; 76543210
; \-------- disable overworld palette switch

wTimeOfDayPalset:: db ; d158
; 76543210
; \/\/\/\/
;  | | | \- Map Palette for TimeOfDay 0x00
;  | | \--- Map Palette for TimeOfDay 0x01
;  | \----- Map Palette for TimeOfDay 0x02
;  \------- Map Palette for TimeOfDay 0x03

wCurTimeOfDay:: db ; d159

SECTION "D15D", WRAM0[$D15D]

wd15d:: db ; d15d

wd15e:: db ; d15e

wd15f:: db ; d15f

SECTION "D163", WRAM0[$D163]

wd163:: db ; d163

wd164:: db ; d164

wTMsHMs:: db ; d165

SECTION "D19E", WRAM0[$D19E]

wNumBagItems:: db ; d19e

SECTION "D1C8", WRAM0[$D1C8]

wNumKeyItems:: db ; d1c8
wKeyItems:: db ; d1c9

SECTION "D1DE", WRAM0[$D1DE]

wNumBallItems:: db ; d1de
wBallQuantities:: db ; d1df

SECTION "Rival's Name", WRAM0[$D258]
wRivalName:: ds 6 ; d258
	ds 6

wPlayerState:: db ; d264
; 00 - walking
; 01 - bicycle
; 02 - skateboard
; 04 - surfing

wd265:: db ; d265
wd266:: db ; d266
	
SECTION "D29A", WRAM0[$D29A]
wd29a:: db ; d29a
wd29b:: db ; d29b
	db ; d29c
wd29d:: db ; d29d
	db
	db
wd2a0:: db ; d2a0

SECTION "D39D", WRAM0[$D39D]
wd39d:: db

SECTION "Game Event Flags", WRAM0[$D41A]
wd41a:: db
wd41b:: db
wd41c:: db
wd41d:: db
wd41e:: db

SECTION "D4A9", WRAM0[$D4A9]

wd4a9:: db ; d4a9
	ds 1 ; TODO
wJoypadFlags:: db ; d4ab
; 76543210
; ||||\__/
; ||||  \-- unkn
; |||\----- set for rival intro textbox
; ||\------ don't wait for keypress to close text box
; |\------- joypad sync mtx
; \-------- joypad disabled

SECTION "wDigWarpNumber", WRAM0[$D4B2]

wDigWarpNumber:: db ; d4b2


SECTION "Warp data", WRAM0[$D514]

wCurrMapWarpCount:: ; d514
    db

wCurrMapWarps:: ; d515
REPT 32 ; TODO: confirm this
    ds 5
ENDR


wCurrMapSignCount:: ; d5b5
    db

wCurrMapSigns:: ; d5b6
REPT 16 ; TODO: confirm this
    ds 4
ENDR

wCurrMapObjectCount:: ; d5f6
    db
	
wCurrMapInlineTrainers:: ; d5f7
REPT 32 ; TODO: confirm this
	ds 2 ; inline trainers. each pair of bytes is direction, distance
ENDR

SECTION "D637", WRAM0[$D637]
wd637:: db ; d637 ;OW battle state? $3 wild battle, $8 is trainer battle $4 is left battle, $B is load overworld? $0 is in overworld
wd638:: db ; d638 ;wd637's last written-to value

SECTION "Used sprites", WRAM0[$D643]

wBGMapAnchor:: ; d643
	dw

wUsedSprites:: ; d645
	dw ; This is for the player
	ds 2 * 5 ; This is for the NPCs
wUsedSpritesEnd:: ; d651


SECTION "Map header", WRAM0[$D656]

wMapGroup:: db ; d656
wMapId:: db ; d657

wOverworldMapAnchor:: ; d658
	dw

wYCoord:: db ; d65a
wXCoord:: db ; d65b

wMetatileNextY:: db ; d65c
wMetatileNextX:: db ; d65d

wd65e:: ; d65e
	db

wMapPartial:: ; d65f
wMapAttributesBank:: ; d65f
    db
wMapTileset:: ; d660
    db
wMapPermissions:: ; d661
    db
wMapAttributesPtr:: ; d662
    dw
wMapPartialEnd:: ; d664

wMapAttributes:: ; d664
wMapHeight:: ; d664
    db
wMapWidth:: ; d665
    db
wMapBlocksPointer:: ; d666
	dw
wMapTextPtr::
	dw
wMapScriptPtr:: ; d66a
    dw
wMapObjectsPtr:: ; d66c
    dw
wMapConnections:: ; d66e
    db
wMapAttributesEnd:: ; d66f

wNorthMapConnection:: map_connection_struct wNorth ; d66f
wSouthMapConnection:: map_connection_struct wSouth ; d67b
wWestMapConnection::  map_connection_struct wWest  ; d687
wEastMapConnection::  map_connection_struct wEast  ; d693


wTileset:: ; d69f
wTilesetBank:: ; d69f
	db
wTilesetBlocksAddress:: ; d6a0
	dw
wTilesetTilesAddress:: ; d6a2
	dw
wTilesetCollisionAddress:: ; d6a4
	dw
	ds 4 ; TODO
wTilesetEnd:: ; d6aa

wPartyCount:: db
wPartySpecies:: ds PARTY_LENGTH
wPartyEnd:: db

wPartyMons::
wPartyMon1:: party_struct wPartyMon1 ; d6b2
wPartyMon2:: party_struct wPartyMon2 ; d6e2
wPartyMon3:: party_struct wPartyMon3 ; d712
wPartyMon4:: party_struct wPartyMon4 ; d742
wPartyMon5:: party_struct wPartyMon5 ; d772
wPartyMon6:: party_struct wPartyMon6 ; d7a2
wPlayerPartyEnd:: ; d7d2

wPartyMonOT:: ; d7d2
	ds PARTY_LENGTH * 6
wPartyMonOTEnd:: ; d7f6

wPartyMonNicknames:: ; d7f6
	ds PARTY_LENGTH * MON_NAME_LENGTH ; = $24
wPartyMonNicknamesEnd:: ; d81a

wPokedexOwned::    ; d81a
    flag_array NUM_POKEMON
wPokedexOwnedEnd:: ; d839

wPokedexSeen::     ; d83a
    flag_array NUM_POKEMON
wPokedexSeenEnd::  ; d859

wAnnonDex:: ds 26  ; d85a

wAnnonID:: ds 1    ; d874

	
SECTION "Wild mon buffer", WRAM0[$D91B]

wWildMons:: ; d91b
	ds 41


SECTION "Stack bottom", WRAM0[$DFFF]

; Where SP is set at game init
wStackBottom:: ; dfff
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
