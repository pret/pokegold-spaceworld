INCLUDE "constants.asm"


SECTION "Music engine RAM", WRAM0

wMusic::

wChannels::
wChannel1:: channel_struct wChannel1
wChannel2:: channel_struct wChannel2
wChannel3:: channel_struct wChannel3
wChannel4:: channel_struct wChannel4

wSFXChannels::
wChannel5:: channel_struct wChannel5
wChannel6:: channel_struct wChannel6
wChannel7:: channel_struct wChannel7
wChannel8:: channel_struct wChannel8

	ds 1

wCurTrackDuty:: db
wCurTrackIntensity:: db
wCurTrackFrequency:: dw
wSoundLength:: db
wCurNoteDuration:: db
wCurMusicByte:: db

wCurChannel:: db
wVolume:: db
wSoundOutput::
; corresponds to $ff25
; bit 4-7: ch1-4 so2 on/off
; bit 0-3: ch1-4 so1 on/off
	db

wPitchSweep:: db

wMusicID:: dw
wMusicBank:: db

wNoiseSampleAddress:: dw
wNoiseSampleDelay:: db
wc1a2:: db
wNoiseSampleSet:: db

wLowHealthAlarm::
; bit 7: on/off
; bit 4: pitch
; bit 0-3: counter
	db

wMusicFade::
; fades volume over x frames
; bit 7: fade in/out
; bit 0-6: number of frames for each volume level
; $00 = none (default)
	db
wMusicFadeCount:: db
wMusicFadeID::
wMusicFadeIDLow:: db
wMusicFadeIDHigh:: db

wSweepingFadeIndex:: db
wSweepingFadeCounter:: db

wIncrementTempo: dw
wMapMusic:: db
wCryPitch:: dw
wCryLength:: dw
wLastVolume:: db
wc1b3:: db
wSFXPriority:: db
wChannel1JumpCondition:: db
wChannel2JumpCondition:: db
wChannel3JumpCondition:: db
wChannel4JumpCondition:: db

wStereoPanningMask:: db

wCryTracks:: db
; either wChannelsEnd or wMusicEnd, unsure

wSFXDuration:: db

wMusicInitEnd::


SECTION "OAM Buffer", WRAM0

wShadowOAM::
; wShadowOAMSprite00 - wShadowOAMSprite39
for n, NUM_SPRITE_OAM_STRUCTS
        wShadowOAMSprite{02d:n}:: sprite_oam_struct wShadowOAMSprite{02d:n}
endr
wShadowOAMEnd::

wTileMap::
	ds SCREEN_HEIGHT * SCREEN_WIDTH

UNION

wTileMapBackup::
	ds SCREEN_HEIGHT * SCREEN_WIDTH

NEXTU

wc408:: db
wc409:: db

NEXTU

wSpriteAnimDict:: ds NUM_SPRITEANIMDICT_ENTRIES * 2

wSpriteAnimationStructs::
; field  0:   index
; fields 1-3: loaded from SpriteAnimSeqData
wSpriteAnim1::  sprite_anim_struct wSpriteAnim1
wSpriteAnim2::  sprite_anim_struct wSpriteAnim2
wSpriteAnim3::  sprite_anim_struct wSpriteAnim3
wSpriteAnim4::  sprite_anim_struct wSpriteAnim4
wSpriteAnim5::  sprite_anim_struct wSpriteAnim5
wSpriteAnim6::  sprite_anim_struct wSpriteAnim6
wSpriteAnim7::  sprite_anim_struct wSpriteAnim7
wSpriteAnim8::  sprite_anim_struct wSpriteAnim8
wSpriteAnim9::  sprite_anim_struct wSpriteAnim9
wSpriteAnim10:: sprite_anim_struct wSpriteAnim10
wSpriteAnimationStructsEnd::

wSpriteAnimCount:: db
NEXTU

	ds 1

wClockDialogArrowBlinkCounter:: ds 1
wc40a:: ds 1

; Monster or Trainer test?
wWhichPicTest::
	db


wc40c:: ds 1
wc40d:: ds 1
wc40e:: ds 1

	ds 3

wDayOfWeekBuffer:: db

	ds 7

wc41a:: db
	ds 1
wHourBuffer:: db
	ds 9
wMinuteBuffer:: db
	ds 150

wc4bd:: db
	ds 2
wSpriteAnimIDBuffer:: db

	ds 6

wGlobalAnimYOffset::
wc4c7:: db

wGlobalAnimXOffset::
wc4c8:: db

	ds 7

wNamingScreenDestinationPointer:: dw
wNamingScreenCurNameLength:: db
wNamingScreenMaxNameLength:: db
wNamingScreenType:: db
wNamingScreenCursorObjectPointer:: dw
wNamingScreenLastCharacter:: db
wNamingScreenStringEntryCoordY:: db
wNamingScreenStringEntryCoordX:: db

NEXTU

	ds 200

wSlots::
wReel1:: slot_reel wReel1
wReel2:: slot_reel wReel2
wReel3:: slot_reel wReel3
wReel1Stopped:: ds 3
wReel2Stopped:: ds 3
wReel3Stopped:: ds 3
wSlotBias:: db
wSlotBet:: db
wFirstTwoReelsMatching:: db
wFirstTwoReelsMatchingSevens:: db
wSlotMatched:: db
wCurReelStopped:: ds 3
wPayout:: dw
wCurReelXCoord:: db
wCurReelYCoord:: db
	ds 2
wSlotBuildingMatch:: db
wSlotsDataEnd::
	ds 2
wc51a:: ds 1
	ds 25
wSlotsEnd:: db

NEXTU

	ds 200

wMemoryGameCards:: ds 9 * 5
wMemoryGameCardsEnd::
wMemoryGameLastCardPicked:: db
wMemoryGameCard1:: db
wMemoryGameCard2:: db
wMemoryGameCard1Location:: db
wMemoryGameCard2Location:: db
wMemoryGameNumberTriesRemaining:: db
wMemoryGameLastMatches:: ds 5
wMemoryGameCounter:: db
wMemoryGameNumCardsMatched:: db

ENDU


SECTION "Map Buffer", WRAM0

wMapBuffer::
wMapScriptNumber:: db
wMapScriptNumberLocation:: dw
wUnknownMapPointer:: dw ; TODO
wc5ed:: db
	ds 18
wMapBufferEnd::


UNION

wc600::
wOverworldMapBlocks:: ds 1300
wOverworldMapBlocksEnd::

NEXTU

wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd:: db
	ds 15
wLYOverrides2:: ds SCREEN_HEIGHT_PX
wLYOverrides2End::

NEXTU

; Pikachu minigame

wPikachuMinigamePikachuObjectPointer:: ds 2
wPikachuMinigamePikachuTailObjectPointer:: ds 2
wPikachuMinigamePikachuNextAnim:: ds 1

wPikachuMinigameControlEnable:: ds 1

wc606:: ds 1	; written to, but is this read from?

wPikachuMinigamePikachuYOffset:: ds 1
wPikachuMinigameNoteTimer:: ds 1
wPikachuMinigameScore:: ds 2
wPikachuMinigameNoteCounter:: ds 2	; not used for anything meaningful?

wPikachuMinigameSpawnTypeIndex:: ds 1
wPikachuMinigameSpawnDataIndex:: ds 1
wPikachuMinigameScoreModifier:: ds 1

wPikachuMinigameNoteCaught:: ds 1

; Time keeping
wPikachuMinigameTimeFrames:: ds 1
wPikachuMinigameTimeSeconds:: ds 1

; are these two used?
wc613:: ds 1
wc614:: ds 1

wPikachuMinigameRedrawTimer:: ds 1
wc616:: ds 1
wPikachuMinigameScrollSpeed:: ds 1

wPikachuMinigameColumnFlags:: ds 1
wPikachuMinigameSavedColumnPointer:: ds 2
wPikachuMinigameColumnPointer:: ds 2

wPikachuMinigameRepeatColumnCounter:: ds 1
wPikachuMinigameRepeatColumnCounter2:: ds 1

wPikachuMinigameSceneTimer:: ds 1

wPikachuMinigameJumptableIndex:: ds 1

wPikachuMinigameBGMapPointer:: ds 2
wPikachuMinigameTilemapPointer:: ds 2
wPikachuMinigameTilesPointer:: ds 2

wPikachuMinigameColumnBuffer:: ds 16

NEXTU

wPicrossCursorSpritePointer:: ds 2
wPicrossCurrentGridNumber:: ds 1
wPicrossCurrentCellNumber:: ds 1
wPicrossCurrentCellType:: ds 1
wPicrossJoypadAction:: ds 1
	ds 1
wc607:: ds 1
wPicrossMarkedCells:: ds 4*4*4*4
	ds 1
wPicrossLayoutBuffer:: ds $20
wPicrossLayoutBuffer2:: ds $20 - 1
wPicrossBitmap:: ds 4*4*4*4
wPicrossBase2bppPointer:: ds 2
wPicrossBaseGFXPointer:: ds 2
wPicrossDrawingRoutineCounter:: ds 1
	ds 11
wPicrossNumbersBuffer:: ds 4*4*4*4
wPicrossRowGFX2bppBuffer:: ds 144
	ds 112
wPicrossErrorCheck:: ds 1
	ds 1
NEXTU
; Battle-related
	ds $1ea

wActiveBGEffects::
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
wActiveBGEffectsEnd::

wNumActiveBattleAnims:: db

wBattleAnimFlags:: db
wBattleAnimAddress:: dw
wBattleAnimDuration:: db
wBattleAnimParent:: dw
wBattleAnimLoops:: db
wBattleAnimVar:: db
wBattleAnimByte:: db
wBattleAnimOAMPointerLo:: db
	db

UNION
; unidentified
wBattleAnimTemp0:: db
wBattleAnimTemp1:: db
wBattleAnimTemp2:: db
wBattleAnimTemp3:: db

NEXTU
wBattleAnimTempOAMFlags:: db
wBattleAnimTempField02:: db
wBattleAnimTempTileID:: db
wBattleAnimTempXCoord:: db
wBattleAnimTempYCoord:: db
wBattleAnimTempXOffset:: db
wBattleAnimTempYOffset:: db
wBattleAnimTempAddSubFlags:: db
wBattleAnimTempPalette:: db
ENDU

	ds $32
wBattleAnimEnd::

	ds $1aa ; TODO


wc9ef:: ds 1

	ds 6

wBattleMonNickname:: ds 6
wEnemyMonNickname:: ds 6

wca02:: ds 1
wca03:: ds 1
wca04:: ds 1

	ds 3

wca08:: ds 1
wca09:: ds 1
wca0a:: ds 1

	ds 5 ; TODO

wIntroJumptableIndex::
wca10:: ds 1

UNION
wIntroBGMapPointer:: ds 2
NEXTU
wca11:: ds 1
wca12:: ds 1
ENDU

UNION
wIntroTilemapPointer:: ds 2
NEXTU
wca13:: ds 1
wca14:: ds 1
ENDU

wIntroTilesPointer:: ds 2

wIntroFrameCounter1:: ds 1
wIntroFrameCounter2:: ds 1

wIntroSpriteStateFlag:: ds 1

	ds $1d ; TODO

wca37:: ds 1
wca38:: ds 1
wca39:: ds 1
wca3a:: ds 1
wca3b:: ds 1
wca3c:: ds 1
wPlayerSubStatus3:: db

wca3e:: ds 1
wca3f:: ds 1
wca40:: ds 1
wca41:: ds 1

wEnemySubStatus3:: db

wca43:: db

wca44:: db

	ds $12
wTrainerClass::
	db

wca58:: ds 1
wca59:: ds 1
wca5a:: ds 1
wca5b:: ds 1
wca5c:: ds 1

	ds $5c

wcab9:: ds 1

	ds 6

wcac0:: ds 1
wcac1:: ds 1
wcac2:: ds 1

wLinkBattleRNCount:: db

	ds 12

wcad0:: ds 1

	ds 9

wcada:: ds 1

	ds 6

wcae1:: ds 1

ENDU




SECTION "CB14", WRAM0[$CB14]

UNION
wRedrawRowOrColumnSrcTiles::
; the tiles of the row or column to be redrawn by RedrawRowOrColumn
	ds SCREEN_WIDTH * 2
NEXTU
wRedrawFlashlightDst0:: dw
wRedrawFlashlightSrc0:: dw
wRedrawFlashlightBlackDst0:: dw
wRedrawFlashlightDst1:: dw
wRedrawFlashlightSrc1:: dw
wRedrawFlashlightBlackDst1:: dw
wRedrawFlashlightWidthHeight:: db
; width or height of flashlight redraw region
; in units of two tiles (people event meta tile)
ENDU

SECTION "CB56", WRAM0[$CB4C]
wOtherPlayerLinkMode:: db
wOtherPlayerLinkAction:: db
	ds 3 ; TODO

wPlayerLinkAction:: db
	ds 4 ; TODO

wLinkTimeoutFrames:: dw
wcb58:: ds 2
wMonType:: db

wSelectedItem::
wCurSpecies:: db
wNamedObjectTypeBuffer:: db

SECTION "CB5E", WRAM0[$CB5E]
wJumptableIndex:: db

wSlotsDelay::
wMemoryGameCardChoice::
wFlyDestination::
wIntroSceneFrameCounter::
wTrainerGearPointerPosition::
wBattleTransitionCounter:: db

wBattleTransitionSineWaveOffset::
wBattleTransitionSpinQuadrant::
wIntroSceneTimer::
wTrainerGearCard::
wcb60:: ds 1

wTrainerGearRadioIndex::
wcb61:: ds 1

wVBCopySize:: ds 1
wVBCopySrc:: ds 2
wVBCopyDst:: ds 2
wVBCopyDoubleSize:: ds 1
wVBCopyDoubleSrc:: ds 2
wVBCopyDoubleDst:: ds 2
wcb6c:: db
wcb6d:: db
wcb6e:: db
wPlayerStepDirection:: db

SECTION "CB71", WRAM0[$CB70]

wcb70:: db

wVBCopyFarSize:: ds 1
wVBCopyFarSrc:: ds 2
wVBCopyFarDst:: ds 2
wVBCopyFarSrcBank:: ds 1
wPlayerMovement:: db
wMovementObject:: db
	ptrba wMovementData

wcb7c:: ds 1

SECTION "Collision buffer", WRAM0[$CB90]

wTileDown::  db
wTileUp::    db
wTileLeft::  db
wTileRight:: db

wScreenSave::
	ds 6 * 5

SECTION "CBB2", WRAM0[$CBB2]
wToolgearBuffer::
	ds $40

SECTION "CBF2", WRAM0[$CBF2]

wWindowData::
wWindowStackPointer:: dw
wMenuJoypad:: db
wMenuSelection:: db
wMenuSelectionQuantity:: db
wFieldDebugPage::
wWhichIndexSet::
wActiveBackpackPocket:: db
wScrollingMenuCursorPosition:: db
wWindowStackSize:: db

SECTION "CC09", WRAM0[$CC02]

wMenuDataHeader::
	db
wMenuBorderTopCoord:: db
wMenuBorderLeftCoord:: db
wMenuBorderBottomCoord:: db
wMenuBorderRightCoord:: db
wMenuDataPointer:: dw
wMenuCursorBuffer:: db
	ds 8 ; TODO
wMenuDataHeaderEnd::

wMenuData2::
wMenuDataFlags:: db
wMenuDataItems:: db
wMenuDataIndicesPointer:: dw
wMenuDataDisplayFunctionPointer:: dw
wMenuDataPointerTableAddr:: dw
	ds 2
wcc1c:: dw
	ds 1
wcc1f:: dw
	ds 1
wMenuData3::

w2DMenuCursorInitY:: db
w2DMenuCursorInitX:: db
w2DMenuNumRows:: db
w2DMenuNumCols:: db
w2DMenuFlags:: dw
w2DMenuCursorOffsets:: db
wMenuJoypadFilter:: db
w2DMenuDataEnd::

wMenuCursorY:: db
wMenuCursorX:: db
wCursorOffCharacter:: db
wCursorCurrentTile:: dw

SECTION "CC32", WRAM0[$CC32] ; Please merge when more is disassembled
wVBlankJoyFrameCounter: db

wVBlankOccurred: db
wLastSpawnMapGroup: db
wLastSpawnMapNumber: db

	ds 2

;Controls what type of opening (fire/notes) you get.
wcc38::
wTitleSequenceOpeningType::
	db

wDefaultSpawnPoint::
	db


UNION

wcc40:: ; XXX fix this to cc3a
wMovementBufferCount:: db

wcc41:: ; XXX fix this to cc3b
wMovementBufferObject:: db

	ptrba wMovementBufferPointer

wMovementBuffer::
	ds 55

NEXTU

wSpriteViewerMenuStartingItem:: db

	ds 2

wSpriteViewerSavedMenuPointerY:: db
wSpriteViewerJumptableIndex:: db

	ds 56

ENDU

SECTION "CC9A", WRAM0[$CC9A]

wSkatingDirection:: db
wCompanionCollisionFrameCounter:: db

wUnknownWordcc9c::
	dw

wUnknownBuffercc9e::
	ds 14


wSpriteCurPosX          : ds 1
wSpriteCurPosY          : ds 1
wSpriteWidth            : ds 1
wSpriteHeight           : ds 1
wSpriteInputCurByte     : ds 1
wSpriteInputBitCounter  : ds 1
wSpriteOutputBitOffset  : ds 1
wSpriteLoadFlags        : ds 1
wSpriteUnpackMode       : ds 1
wSpriteFlipped          : ds 1
wSpriteInputPtr         : ds 2
wSpriteOutputPtr        : ds 2
wSpriteOutputPtrCached  : ds 2
wSpriteDecodeTable0Ptr  : ds 2
wSpriteDecodeTable1Ptr  : ds 2

wccc0:: ds 1
wccc1:: ds 1
wccc2:: ds 1
wccc3:: ds 1
wccc4:: ds 1

SECTION "CCC7", WRAM0[$CCC7]

wDisableVBlankOAMUpdate:: db

SECTION "CCCA", WRAM0[$CCCA]

wBGP:: db
wOBP0:: db
wOBP1:: db

wcccd:: ds 1

wDisableVBlankWYUpdate:: db
wSGB:: db

SECTION "CCD0", WRAM0[$CCD0]

wccd0:: ds 1
wccd1:: ds 1
wccd2:: ds 1
wccd3:: ds 1

	ds 5

wccd9:: ds 1

SECTION "CCE1", WRAM0[$CCE1]

wcce1:: ds 1
wcce2:: ds 1
wcce3:: ds 1
wcce4:: ds 1

	ds 6

wcceb:: ds 1

	ds 5

wccf1:: ds 1
wccf2:: ds 1
wccf3:: ds 1
wccf4:: ds 1

SECTION "CD11", WRAM0[$CD11]

wcd11:: ds 1

	ds 11

wcd1d:: ds 8

	ds 1

wStringBuffer1:: ds 1 ; How long is this?
wcd27:: ds 1
SECTION "CD31", WRAM0[$CD31]

UNION
wStartDay:: db
wStartHour:: db
wStartMinute:: db

NEXTU
wHPBarTempHP:: dw

NEXTU
wStringBuffer2:: db ; How long is this?

ENDU


SECTION "CD3C", WRAM0[$CD3C]

wcd3c:: db
wRegularItemsCursor:: db
wBackpackAndKeyItemsCursor:: db
wStartmenuCursor:: db
wcd40:: db
wcd41:: db
wcd42:: db
wFieldDebugMenuCursorBuffer::
wcd43:: db
wRegularItemsScrollPosition:: db
wBackpackAndKeyItemsScrollPosition:: db
wcd46:: ds 1
wcd47:: ds 1
wSelectedSwapPosition:: db
wMenuScrollPosition:: db

wTextDest:: ds 2

wQueuedScriptBank:: db
wQueuedScriptAddr:: dw

wPredefID::
	db

wPredefHL::
	dw
wPredefDE::
	dw
wPredefBC::

wFarCallBCBuffer::
	dw

wcd56:: ds 1
wcd57:: ds 1
wFieldMoveSucceeded:: db
wVramState:: db

	ds 3 ; TODO
wcd5d:: db
	db
wChosenStarter:: db
wcd60:: db

SECTION "CD70", WRAM0[$CD70]
wcd70:: ds 1
wcd71:: ds 1
wcd72:: dw
wcd74:: db
wcd75:: db

wCurItem:: db
wItemIndex:: db
wMonDexIndex: db
wWhichPokemon: db

SECTION "CD7B", WRAM0[$CD7B]

wHPBarType:: db
wcd7c:: ds 1

wItemQuantity:: db
wItemQuantityBuffer:: db
wcd7f:: db
wcd80:: db
wcd81:: db

SECTION "CD9E", WRAM0 [$CD9E]
wLoadedMonLevel:: db

SECTION "CDAF", WRAM0 [$CDAF]
wcdaf:: db

SECTION "CDB0", WRAM0 [$CDB0]
wTalkingTargetType:: db
;bit 0 = has engaged NPC in dialogue
;bit 1 = has engaged sign in dialogue

wcdb1:: ds 1
wcdb2:: ds 1

ds 1

wcdb4:: ds 1
wcdb5:: ds 1
wcdb6:: ds 1

SECTION "CDB9", WRAM0[$CDB9]

wcdb9:: ds 1

wItemAttributeParamBuffer:: db
wCurPartyLevel:: db
wcdbc:: db
wLinkMode:: db
; 00 -
; 01 -
; 02 -
; 03 -

wNextWarp:: db
wNextMapGroup:: db
wNextMapId:: db
wPrevWarp:: db

	ds 1

UNION
wFieldMoveScriptID:: db
wMapBlocksAddress:: dw
wReplacementBlock:: db

NEXTU

wHPBarMaxHP:: dw
wHPBarOldHP:: dw

NEXTU

wcdc3:: db
wcdc4:: db
wcdc5:: db
wcdc6:: db

ENDU

UNION
wHPBarNewHP:: dw
NEXTU
wcdc7:: db
wcdc8:: db
ENDU
wHPBarDelta::   db
wcdca:: db
wHPBarHPDifference:: dw

wLinkBattleRNs:: ds 10

wcdd7:: ds 1
wcdd8:: ds 1
wcdd9:: ds 1
wcdda:: ds 1
wcddb:: ds 1
wcddc:: ds 1
wcddd:: ds 1
wcdde:: ds 1
wcddf:: ds 1
wcde0:: ds 1
wcde1:: ds 1
wcde2:: ds 1
wcde3:: ds 1
wcde4:: ds 1
wcde5:: ds 1
wcde6:: ds 1
wcde7:: ds 1
wcde8:: ds 1
wcde9:: ds 1
wcdea:: ds 1
wcdeb:: ds 1


SECTION "CDFE", WRAM0[$CDFE]

wcdfe:: ds 1
wcdff:: ds 1
wBattleMode:: db
wce01:: ds 1
wce02:: ds 1
wce03:: ds 1
wce04:: ds 1
wce05:: ds 1
wce06:: ds 1

wMonHeader::

wMonHIndex::
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the dex number after the header is copied to WRAM.
	ds 1

wMonHBaseStats::
wMonHBaseHP::
	ds 1
wMonHBaseAttack::
	ds 1
wMonHBaseDefense::
	ds 1
wMonHBaseSpeed::
	ds 1
wMonHBaseSpecialAtt::
	ds 1
wMonHBaseSpecialDef::
	ds 1

wMonHTypes::
wMonHType1::
	ds 1
wMonHType2::
	ds 1

wMonHCatchRate::
	ds 1
wMonHBaseEXP::
	ds 1

wMonHItems::
wMonHItem1::
	ds 1
wMonHItem2::
	ds 1

wMonHGenderRatio::
	ds 1

wMonHUnk0::
	ds 1
wMonHUnk1::
	ds 1
wMonHUnk2::
	ds 1

wMonHSpriteDim::
	ds 1
wMonHFrontSprite::
	ds 2
wMonHBackSprite::
	ds 2

wMonHGrowthRate::
	ds 1

wMonHLearnset::
; bit field
	flag_array 50 + 5 ; size = 7
	ds 1

SECTION "CE2D", WRAM0[$CE2D]
wce2d:: ds 1
wce2e:: ds 1
wce2f:: ds 1
wce30:: ds 1
wce31:: ds 1
wce32:: ds 1
wce33:: ds 1
wce34:: ds 1
wce35:: ds 1
wce36:: ds 1

wNamedObjectIndexBuffer::
wCountSetBitsResult::
wce37::
	db

SECTION "CE3A", WRAM0[$CE3A]

wce3a:: ds 1

wVBlankSavedROMBank::
	db

wBuffer::
	db

wTimeOfDay:: db
; based on RTC
; Time of Day   Regular    Debug
; 00 - Day      09--15h    00--30s
; 01 - Night    15--06h    30--35s
; 02 - Cave                35--50s
; 03 - Morning  06--09h    50--59s

wcd3f: ds 1

SECTION "CE5F", WRAM0[$CE5F]

wce5f:: ; debug menu writes $41 to it
	db

wce60::
	db ; main menu checks this, maybe states if there's a save present?

wActiveFrame:: db

wTextBoxFlags::  db

wDebugFlags:: db
; Bit 0: Debug battle indicator
; Bit 1: Debug field indicator
; Bit 2-3: Game is continued (set when selecting continue on the main menu)

wce64:: ds 1
wce65:: ds 1
wce66:: ds 1

wPlayerName:: ds 6

wMomsName:: ds 6

SECTION "CE73", WRAM0[$CE73]

wce73: ds 1
wce74: ds 1
wce75: ds 1

wObjectFollow_Leader::
	db
wObjectFollow_Follower::
	db
wCenteredObject::
	db
wFollowerMovementQueueLength::
	db
wFollowMovementQueue::
	ds 5

wObjectStructs::
; Note: this might actually not be an object. TODO: Investigate (if indexing starts at 1, then this isn't an object)
; It might just be unused/a leftover.
wUnkObjectStruct:: object_struct wUnkObject
wPlayerStruct::   object_struct wPlayer
; wObjectStruct1 - wObjectStruct12
for n, 1, NUM_OBJECT_STRUCTS - 1
wObject{d:n}Struct:: object_struct wObject{d:n}
endr

wCmdQueue::
wCmdQueueEntry1:: ds 16
wCmdQueueEntry2:: ds 16
wCmdQueueEntry3:: ds 16
wCmdQueueEntry4:: ds 16

wMapObjects::
wPlayerObject:: map_object wPlayer ; player is map object 0
; wMap1Object - wMap15Object
for n, 1, NUM_OBJECTS
wMap{d:n}Object:: map_object wMap{d:n}
endr

wToolgearFlags:: db
; 76543210
; |    | \- show toolgear
; |    |
; |    \--- transfer toolgear to window
; \-------- hide toolgear

	ds 2 ; TODO

wTimeOfDayPal:: db
; Applied according to wCurTimeOfDay from wTimeOfDayPalset

wd153:: db
; 76543210
; |      \- show player coords in toolgear instead of time
; \-------- switch overworld palettes according to minutes not hours

	ds 3 ; TODO
wTimeOfDayPalFlags:: db
; 76543210
; \-------- disable overworld palette switch

wTimeOfDayPalset:: db
; 76543210
; \/\/\/\/
;  | | | \- Map Palette for TimeOfDay $00 (MORN)
;  | | \--- Map Palette for TimeOfDay $01 (DAY)
;  | \----- Map Palette for TimeOfDay $02 (NITE)
;  \------- Map Palette for TimeOfDay $03 (DARK)

wCurTimeOfDay:: db

SECTION "D15B", WRAM0[$D15B]

wCoins:: db

wd15c:: db

wd15d:: db

wd15e:: db

wd15f:: db

SECTION "D163", WRAM0[$D163]

wBadges::
wJohtoBadges::
	flag_array NUM_JOHTO_BADGES
wKantoBadges::
	flag_array NUM_KANTO_BADGES

wTMsHMs:: db

SECTION "D19E", WRAM0[$D19E]

wItems::
wNumBagItems:: db

SECTION "D1C8", WRAM0[$D1C8]

wNumKeyItems:: db
wKeyItems:: db

SECTION "D1DE", WRAM0[$D1DE]

wNumBallItems:: db
wBallQuantities:: db

	ds 10

wUnknownListLengthd1ea:: db
wUnknownListd1eb:: db

SECTION "Rival's Name", WRAM0[$D256]
wRegisteredItem:: db
wRegisteredItemQuantity:: db
wRivalName:: ds 6
	ds 6

wPlayerState:: db
; 00 - walking
; 01 - bicycle
; 02 - skateboard
; 04 - surfing

wd265:: db
wd266:: db

;The starting house's map script number is stored at d29a. Others are probably nearby.
SECTION "D29A", WRAM0[$D29A]
wd29a:: db
wd29b:: db
wd29c::	db
wd29d:: db
wd29e::	db
	db
wd2a0:: db

SECTION "D35F", WRAM0[$D35F]
wOptions:: db

SECTION "D39D", WRAM0[$D39D]
wd39d:: db

SECTION "D3A5", WRAM0[$D3A5]
wd3a5:: db

SECTION "Game Event Flags", WRAM0[$D41A]
wd41a:: db
; 76543210
; |      \- read email?
; \-------- talked to Blue, triggers Oak
wd41b:: db
; 76543210
;      |\-- followed Oak to his back room
;      \--- chose a starter
wd41c:: db
; 76543210
;    \----- recieved pokedexes
wd41d:: db
; 76543210
;      \--- beat rival in the lab
wd41e:: db

SECTION "D4A9", WRAM0[$D4A9]

wd4a9:: db
	ds 1 ; TODO
wJoypadFlags:: db
; 76543210
; ||||\__/
; ||||  \-- unkn
; |||\----- set for rival intro textbox
; ||\------ don't wait for keypress to close text box
; |\------- joypad sync mtx
; \-------- joypad disabled

SECTION "wDigWarpNumber", WRAM0[$D4B2]

wDigWarpNumber:: db
wd4b3:: ds 1
wd4b4:: ds 1
wd4b5:: ds 1
wd4b6:: ds 1
wd4b7:: ds 1
wd4b8:: ds 1
wd4b9:: ds 1


SECTION "Warp data", WRAM0[$D513]

wWarpNumber:: db

wCurrMapWarpCount::
	db

wCurrMapWarps::
REPT 32 ; TODO: confirm this
	ds 5
ENDR


wCurrMapSignCount::
	db

wCurrMapSigns::
REPT 16 ; TODO: confirm this
	ds 4
ENDR

wCurrMapObjectCount::
	db

wCurrMapInlineTrainers::
REPT 32 ; TODO: confirm this
	ds 2 ; inline trainers. each pair of bytes is direction, distance
ENDR

SECTION "D637", WRAM0[$D637]
wd637:: db ;OW battle state? $3 wild battle, $8 is trainer battle $4 is left battle, $B is load overworld? $0 is in overworld
wd638:: db ;wd637's last written-to value

SECTION "Used sprites", WRAM0[$D642]
wd642:: db
wBGMapAnchor::
	dw

UNION

wUsedSprites::
	ds 2

NEXTU

	ds 1

wd646:: db

ENDU

wUsedNPCSprites::
	ds 8

wUsedStaticSprites::
	ds 2

wUsedSpritesEnd::


SECTION "Map header", WRAM0[$D656]

wMapGroup:: db
wMapId:: db

wOverworldMapAnchor::
	dw

wYCoord:: db
wXCoord:: db

wMetatileNextY:: db
wMetatileNextX:: db

wd65e::
	db

wMapPartial::
wMapAttributesBank::
	db
wMapTileset::
	db
wMapPermissions::
	db
wMapAttributesPtr::
	dw
wMapPartialEnd::

wMapAttributes::
wMapHeight::
	db
wMapWidth::
	db
wMapBlocksPointer::
	dw
wMapTextPtr::
	dw
wMapScriptPtr::
	dw
wMapObjectsPtr::
	dw
wMapConnections::
	db
wMapAttributesEnd::

wNorthMapConnection:: map_connection_struct wNorth
wSouthMapConnection:: map_connection_struct wSouth
wWestMapConnection::  map_connection_struct wWest
wEastMapConnection::  map_connection_struct wEast


wTileset::
wTilesetBank::
	db
wTilesetBlocksAddress::
	dw
wTilesetTilesAddress::
	dw
wTilesetCollisionAddress::
	dw
wTilesetAnim::
	dw
	ds 2 ; TODO
wTilesetEnd::

wPartyCount:: db
wPartySpecies:: ds PARTY_LENGTH
wPartyEnd:: db

wPartyMons::
wPartyMon1:: party_struct wPartyMon1
wPartyMon2:: party_struct wPartyMon2
wPartyMon3:: party_struct wPartyMon3
wPartyMon4:: party_struct wPartyMon4
wPartyMon5:: party_struct wPartyMon5
wPartyMon6:: party_struct wPartyMon6
wPlayerPartyEnd::

wPartyMonOT::
	ds PARTY_LENGTH * 6
wPartyMonOTEnd::

wPartyMonNicknames::
	ds PARTY_LENGTH * MON_NAME_LENGTH ; = $24
wPartyMonNicknamesEnd::

wPokedexOwned::
	flag_array NUM_POKEMON
wPokedexOwnedEnd::

wPokedexSeen::
	flag_array NUM_POKEMON
wPokedexSeenEnd::

wAnnonDex:: ds 26

wAnnonID:: ds 1

wd875:: ds 1
wd876:: ds 1

	ds 5

wd87c:: ds 1

	ds 5

wd882:: ds 1
wd883:: ds 1
wd884:: ds 1

SECTION "D8A2", WRAM0[$D8A2]

wd8a2:: ds 1
wd8a3:: ds 1
wd8a4:: ds 1
wd8a5:: ds 1

	ds 5

wd8ab:: ds 1

SECTION "wd8b1", WRAM0[$D8B1]

wd8b1:: ds 1

	ds 5

wd8b7:: ds 1
wd8b8:: ds 1

SECTION "D8D1", WRAM0[$D8D1]

wd8d1:: ds 1

	ds 5

wd8d7:: ds 1

	ds 5

wd8dd:: ds 1

SECTION "D8E3", WRAM0[$D8E3]

wd8e3:: ds 1
wd8e4:: ds 1

SECTION "D8FD", WRAM0[$D8FD]

wd8fd:: ds 1

SECTION "D913", WRAM0[$D913]

wd913:: ds 1

SECTION "Wild mon buffer", WRAM0[$D91B]

UNION
wWildMons::
	ds 41
NEXTU
	ds 2
wd91d:: ds 1
	ds 29
wd93b:: ds 1
ENDU

SECTION "DA3B", WRAM0[$DA3B]

wOTPartyMonOT:: db

SECTION "DA5F", WRAM0[$DA5F]

wda5f:: db

SECTION "DA83", WRAM0[$DA83]

wBoxListLength:: db
wBoxList:: ds MONS_PER_BOX

SECTION "DAA3", WRAM0[$DAA3]

wdaa3:: db
wdaa4:: db
wdaa5:: db

SECTION "DE63", WRAM0[$DE63]

wde63:: db

SECTION "DF17", WRAM0[$DF17]
wdf17:: ds 1

SECTION "DFCB", WRAM0[$DFCB]
wdfcb:: ds 1

SECTION "Stack Bottom", WRAM0

; Where SP is set at game init
wStackBottom::
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
