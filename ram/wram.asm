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
wMusicFadeID:: dw

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
wSpriteAnimData::
; wSpriteAnimDict pairs keys with values
; keys: SPRITE_ANIM_DICT_* indexes (taken from SpriteAnimObjects)
; values: vTiles0 offsets
wSpriteAnimDict::
	ds NUM_SPRITEANIMDICT_ENTRIES * 2

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
NEXTU
wOptionsMenuCursorX:: db
wOptionsMenuCursorY:: db
wOptionsTextSpeedCursorX:: db
wOptionsBattleAnimCursorX:: db
wOptionsBattleStyleCursorX:: db
wOptionsAudioSettingsCursorX:: db
wOptionsBottomRowCursorX:: db
NEXTU
	ds 7

	ds 3

wDayOfWeekBuffer:: db

	ds 7

wc41a:: db
	ds 1
wHourBuffer:: db
	ds 9
wMinuteBuffer:: db
	ds 150

UNION
	wCurSpriteOAMAddr:: dw
NEXTU
	ds 1
	wCurIcon:: db
ENDU
	wCurIconTile:: db

UNION
wCurSpriteOAMFlags:: db
NEXTU
wSpriteAnimAddrBackup:: dw
ENDU

wCurAnimVTile:: db

wCurAnimXCoord:: db
wCurAnimYCoord:: db
wCurAnimXOffset:: db
wCurAnimYOffset:: db

wGlobalAnimYOffset:: db
wGlobalAnimXOffset:: db

wSpriteAnimDataEnd::

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

NEXTU

	ds 200

wPokedexOrder:: ds $100
wPokedexOrderEnd::

wDexListingScrollOffset:: db
wPokedexHandCursorPosIndex:: db
wCurDexMode:: db
wPokedexInputFlags:: db
wPokedexHandCursorStructAddress:: dw

wPokedexCursorStructAddress:: dw
wPokedexSlowpokeAnimStructAddress:: dw

wDexListingEnd:: db
wDexTempCursorY:: db
wDexTempListingScrollOffset:: db
wDexListingCursor:: db

wDexUnownCount::
wDexSearchMonType1:: db

wDexUnownModeListLength::
wDexSearchMonType2:: db
wDexArrowCursorPosIndex:: db

wDexCurUnownIndex::
wDexConvertedMonType:: db

wDexSearchResultCount:: db
wc5e3:: db
wc5e4:: db
wc5e5:: db
wc5e6:: db
wDexPlaySlowpokeAnimation:: db

ENDU

SECTION "Map Buffer", WRAM0

wMapBuffer::
wMapScriptNumber:: db
wMapScriptNumberLocation:: dw
wUnknownMapPointer:: dw ; TODO
; setting bit 7 seems to disable overworld updates and player control?
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
wPicrossJoyStateBuffer:: ds 1

wPicrossCursorMovementDelay:: ds 1
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
	ds $140

wBattleAnimTileDict::
; wBattleAnimTileDict pairs keys with values
; keys: BATTLE_ANIM_GFX_* indexes (taken from anim_*gfx arguments)
; values: vTiles0 offsets
	ds NUM_BATTLEANIMTILEDICT_ENTRIES * 2

wActiveAnimObjects::
; wAnimObject1 - wAnimObject10
for n, 1, NUM_BATTLE_ANIM_STRUCTS + 1
wAnimObject{d:n}:: battle_anim_struct wAnimObject{d:n}
endr

wActiveBGEffects::
wBGEffect1:: battle_bg_effect wBGEffect1
wBGEffect2:: battle_bg_effect wBGEffect2
wBGEffect3:: battle_bg_effect wBGEffect3
wBGEffect4:: battle_bg_effect wBGEffect4
wBGEffect5:: battle_bg_effect wBGEffect5
wActiveBGEffectsEnd::

wLastAnimObjectIndex:: db

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
wBattleObjectTempID:: db
wBattleObjectTempXCoord:: db
wBattleObjectTempYCoord:: db
wBattleObjectTempParam:: db

NEXTU
wBattleBGEffectTempID:: db
wBattleBGEffectTempJumptableIndex:: db
wBattleBGEffectTempTurn:: db
wBattleBGEffectTempParam:: db

NEXTU
wBattleSineWaveTempProgress:: db
wBattleSineWaveTempOffset:: db
wBattleSineWaveTempAmplitude:: db
wBattleSineWaveTempTimer:: db

NEXTU
wBattleAnimTempOAMFlags:: db
wBattleAnimTempFixY:: db
wBattleAnimTempTileID:: db
wBattleAnimTempXCoord:: db
wBattleAnimTempYCoord:: db
wBattleAnimTempXOffset:: db
wBattleAnimTempYOffset:: db
wBattleAnimTempFrameOAMFlags:: db
wBattleAnimTempPalette:: db

NEXTU
wBattleAnimGFXTempTileID::
wBattleAnimGFXTempPicHeight:: db
wBattlePicResizeTempPointer:: dw

ENDU

	ds $32
wBattleAnimEnd::

	ds $1a3 ; TODO

wBattle::
wEnemyMoveStruct:: move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

wEnemyMonNickname:: ds 6
wBattleMonNickname:: ds 6

UNION
wBattleMon:: battle_struct wBattleMon
NEXTU
	ds 14
wIntroJumptableIndex:: db
wIntroBGMapPointer:: ds 2
wIntroTilemapPointer:: ds 2
wIntroTilesPointer:: ds 2
wIntroFrameCounter1:: ds 1
wIntroFrameCounter2:: ds 1
wIntroSpriteStateFlag:: ds 1
ENDU
wca22:: ds 1
wca23:: ds 1
wca24:: ds 1
	ds 6
wca2b:: ds 1
	ds 10
wCurOTMon:: db

wBattleParticipantsNotFainted::
; Bit array.  Bits 0 - 5 correspond to party members 1 - 6.
; Bit set if the mon appears in battle.
; Bit cleared if the mon faints.
; Backed up if the enemy switches.
; All bits cleared if the enemy faints.
	db

wTypeModifier::
; >10: super-effective
;  10: normal
; <10: not very effective
; bit 7: stab
	db

wCriticalHit::
; 0 if not critical
; 1 for a critical hit
; 2 for a OHKO
	db
	
wAttackMissed::
; nonzero for a miss
wca3a:: db

wPlayerSubStatus1:: db
wPlayerSubStatus2:: db
wPlayerSubStatus3:: db
wPlayerSubStatus4:: db
wPlayerSubStatus5:: db

wEnemySubStatus1:: db
wEnemySubStatus2:: db
wEnemySubStatus3:: db
wEnemySubStatus4:: db
wEnemySubStatus5:: db

wPlayerRolloutCount:: db
wPlayerConfuseCount:: db
wPlayerToxicCount:: db
wPlayerDisableCount:: db
wPlayerEncoreCount:: db
wPlayerPerishCount:: db
wPlayerFuryCutterCount:: db

	ds 1

wEnemyRolloutCount:: db
wEnemyConfuseCount:: db
wEnemyToxicCount:: db
wEnemyDisableCount:: db
wEnemyEncoreCount:: db
wEnemyPerishCount:: db
wEnemyFuryCutterCount:: db

	ds 1


wPlayerDamageTaken:: dw
wEnemyDamageTaken:: dw

UNION
wBattleReward:: ds 3
NEXTU
wPicrossAnimateDust:: ds 1
ENDU

wBattleAnimParam::
wca5c:: ds 1

wBattleScriptBuffer:: ds 30

wBattleScriptBufferAddress:: dw
wTurnEnded:: db

	ds $15

wPlayerStats::
wPlayerAttack::  dw
wPlayerDefense:: dw
wPlayerSpeed::   dw
wPlayerSpAtk::   dw
wPlayerSpDef::   dw
	ds 1

wEnemyStats::
wEnemyAttack::  dw
wEnemyDefense:: dw
wEnemySpeed::   dw
wEnemySpAtk::   dw
wEnemySpDef::   dw
	ds 1

wPlayerStatLevels::
wPlayerAtkLevel::
wcaa9:: ds 1

wPlayerDefLevel::  db
wPlayerSpdLevel::  db
wPlayerSAtkLevel:: db
wPlayerSDefLevel:: db
wPlayerAccLevel:: db
wPlayerEvaLevel:: db

	ds 1


wEnemyStatLevels::
wEnemyAtkLevel::
wcab1:: ds 1

wEnemyDefLevel::  db
wEnemySpdLevel::  db
wEnemySAtkLevel:: db
wEnemySDefLevel:: db
wEnemyAccLevel:: db
wEnemyEvaLevel:: db

	ds 1

wForceEvolution:: db
wcaba:: ds 1

	ds 1

wPlayerSubstituteHP:: ds 1
wEnemySubstituteHP:: ds 1
wPlayerDebugSelectedMove:: ds 1

	ds 1

wMoveSelectionMenuType:: ds 1

wCurPlayerSelectedMove:: db
wCurEnemySelectedMove:: db

wLinkBattleRNCount:: db

wEnemyItemState:: db

	ds 2

wCurEnemyMoveNum:: db
wEnemyHPAtTimeOfPlayerSwitch:: dw

UNION
wPayDayMoney:: ds 3
NEXTU
wcaca:: ds 1
wcacb:: ds 1
wcacc:: ds 1
ENDU

wcacd:: ds 1
wcace:: ds 1

	ds 1

wEnemyBackupDVs:: dw

wAlreadyDisobeyed::
wcad2:: ds 1

wDisabledMove:: ds 1
wEnemyDisabledMove:: ds 1
wcad5:: ds 1

UNION
wCurPlayerMove:: ds 1
wCurEnemyMove:: ds 1
NEXTU
wcad6:: ds 1
wcad7:: ds 1
ENDU

wEnemyMinimized:: db
wAlreadyFailed:: db

wBattleParticipantsIncludingFainted:: db
wBattleLowHealthAlarm:: db
wPlayerMinimized:: db

wPlayerScreens::
wcadd:: db

wEnemyScreens::
wcade:: db

wPlayerSafeguardCount:: db
wEnemySafeguardCount:: db

; There's got to be a better name for this...
wMonSGBPaletteFlagsBuffer:: db

wBattleWeather:: db
wWeatherCount:: db

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
wPokedexSlowpokeNumSearchEntries::
wNestIconBlinkCounter::
wBattleTransitionCounter:: db

UNION
wBattleTransitionSineWaveOffset::
wBattleTransitionSpinQuadrant::
wIntroSceneTimer::
wTrainerGearCard::
wcb60:: ds 1

wTrainerGearRadioIndex::
wSlotReelIconDelay:: db
NEXTU
wFlyIconAnimStructPointer:: dw
ENDU

wVBCopySize:: ds 1
wVBCopySrc:: ds 2
wVBCopyDst:: ds 2
wVBCopyDoubleSize:: ds 1
wVBCopyDoubleSrc:: ds 2
wVBCopyDoubleDst:: ds 2
wPlayerStepVectorX:: db
wPlayerStepVectorY:: db
wPlayerStepFlags:: db
wPlayerStepDirection:: db

SECTION "CB71", WRAM0[$CB70]

wQueuedMinorObjectGFX:: db

wVBCopyFarSize:: ds 1
wVBCopyFarSrc:: ds 2
wVBCopyFarDst:: ds 2
wVBCopyFarSrcBank:: ds 1
wPlayerMovement:: db
wMovementObject:: db
	ptrba wMovementData

wIndexedMovement2Pointer:: dw

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
wMenuFlags:: db
wMenuBorderTopCoord:: db
wMenuBorderLeftCoord:: db
wMenuBorderBottomCoord:: db
wMenuBorderRightCoord:: db
wMenuDataPointer:: dw
wMenuCursorPosition:: db
	ds 8
wMenuDataHeaderEnd::

wMenuData::
wMenuDataFlags:: db

UNION
wMenuDataItems:: db
wMenuDataIndicesPointer:: dw
wMenuDataDisplayFunctionPointer:: dw
wMenuDataPointerTableAddr:: dw
wMenuDataEnd::
	ds 2
NEXTU
; 2D Menu
wMenuData_2DMenuDimensions:: db
wMenuData_2DMenuSpacing:: db
wMenuData_2DMenuItemStringsBank:: db
wMenuData_2DMenuItemStringsAddr:: dw
wMenuData_2DMenuFunctionBank:: db
wMenuData_2DMenuFunctionAddr:: dw
NEXTU
wMenuData_ScrollingMenuHeight:: db
wMenuData_ScrollingMenuWidth:: db
wMenuData_ScrollingMenuItemFormat:: db
wMenuData_ItemsPointerBank:: db
wMenuData_ItemsPointerAddr:: dw
wMenuData_ScrollingMenuFunction1:: ds 3
wMenuData_ScrollingMenuFunction2:: ds 3
wMenuData_ScrollingMenuFunction3:: ds 3
ENDU

wMoreMenuData::

w2DMenuCursorInitY:: db
w2DMenuCursorInitX:: db
w2DMenuNumRows:: db
w2DMenuNumCols:: db
w2DMenuFlags1::
; bit 7: Disable checking of wMenuJoypadFilter
; bit 6: Enable sprite animations
; bit 5: Wrap around vertically
; bit 4: Wrap around horizontally
; bit 3: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far down
; bit 2: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 5 is disabled and we tried to go too far up
; bit 1: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far left
; bit 0: Set bit 7 in w2DMenuFlags2 and exit the loop if bit 4 is disabled and we tried to go too far right
	db
w2DMenuFlags2:: db
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

wcc3a::
wChargeMoveNum::
wPrevPartyLevel::
wRodResponse_Old::
wPokeFluteCuredSleep::
wTempRestorePPItem:: db

NEXTU

wMovementBufferCount:: db
wMovementBufferObject:: db

	ptrba wMovementBufferPointer

wMovementBuffer::
	ds 55

NEXTU

wSpriteViewerMenuStartingItem:: db

	ds 2

wSpriteViewerSavedMenuPointerY:: db
wSpriteViewerJumptableIndex:: db

NEXTU
; trainer HUD data
	ds 1
wPlaceBallsDirection:: db
wTrainerHUDTiles:: ds 4

NEXTU
; switching items in pack
wSwitchItemBuffer:: ds 2

NEXTU

wBattleMenuRows:: db
wBattleMenuColumns:: db

NEXTU

wTempBoxName:: ds BOX_NAME_LENGTH

ENDU

SECTION "CC9A", WRAM0[$CC9A]

wSkatingDirection:: db
wCompanionCollisionFrameCounter:: db

wObjectMasks::
	ds NUM_OBJECTS


wSpriteCurPosX::         ds 1
wSpriteCurPosY::         ds 1
wSpriteWidth::           ds 1
wSpriteHeight::          ds 1
wSpriteInputCurByte::    ds 1
wSpriteInputBitCounter:: ds 1
wSpriteOutputBitOffset:: ds 1
wSpriteLoadFlags::       ds 1
wSpriteUnpackMode::      ds 1
wSpriteFlipped::         ds 1
wSpriteInputPtr::        ds 2
wSpriteOutputPtr::       ds 2
wSpriteOutputPtrCached:: ds 2
wSpriteDecodeTable0Ptr:: ds 2
wSpriteDecodeTable1Ptr:: ds 2

wFXAnimID:: dw

wPlaceBallsX:: db
wPlaceBallsY:: db

; Both RBY and final GSC write directly to wLowHealth, this prototype writes it here.
; TODO: Investigate how it actually functions.
wLowHealthAlarmBuffer:: db

SECTION "CCC7", WRAM0[$CCC7]

wDisableVBlankOAMUpdate:: db

SECTION "CCCA", WRAM0[$CCCA]

wBGP:: db
wOBP0:: db
wOBP1:: db

wNumHits:: db

wDisableVBlankWYUpdate:: db
wSGB:: db

SECTION "CCD0", WRAM0[$CCD0]

wccd0:: ds 1
wPlayerHPPal:: ds 1
wEnemyHPPal:: ds 1

wHPPals:: ds PARTY_LENGTH
wCurHPPal:: db

	ds 7

; Todo: Replace instances of wcce1-f4 with "wSGBPals + #"
wSGBPals:: ; ds PALPACKET_LENGTH * 3
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

wMonOrItemNameBuffer:: ds MON_NAME_LENGTH

	ds MON_NAME_LENGTH

wTMHMMoveNameBackup:: ds 8

	ds 1


wStringBuffer1:: ds STRING_BUFFER_LENGTH

SECTION "CD31", WRAM0[$CD31]

UNION
wStartDay:: db
wStartHour:: db
wStartMinute:: db

NEXTU
wHPBarTempHP:: dw

NEXTU
wStringBuffer2:: ds STRING_BUFFER_LENGTH

NEXTU

wcd31:: db
wcd32:: db
wcd33:: db

ENDU

SECTION "CD3C", WRAM0[$CD3C]

wcd3c::
wPartyMenuCursor::
wBillsPCCursor:: db
wRegularItemsCursor:: db
wBackpackAndKeyItemsCursor:: db

wBattleMenuCursorPosition::
wStartmenuCursor:: db

wCurMoveNum:: db
wCurBattleMon:: db

wTMHolderCursor:: db
wFieldDebugMenuCursorBuffer::
wcd43:: db
wRegularItemsScrollPosition:: db
wBackpackAndKeyItemsScrollPosition:: db
wBillsPCScrollPosition:: db
wTMHolderScrollPosition:: db

; TODO: change to wSwitchItem, wSwitchMon, wSwappingMove
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
wNumMoves::
wcd57:: ds 1

wItemEffectSucceeded::
wFieldMoveSucceeded::
; 0 - use move
; 1 - use item
; 2 - switch
wBattlePlayerAction:: db

wStateFlags:: db

	ds 3 ; TODO
wcd5d:: db
	db
wChosenStarter:: db
wcd60:: db

SECTION "CD70", WRAM0[$CD70]
wListPointer:: dw
wNamesPointer:: dw
wItemAttributesPointer:: dw

wCurItem:: db
wCurItemQuantity::
wItemIndex:: db

wCurPartySpecies: db
wCurPartyMon: db

	ds 1

wWhichHPBar:: db
wPokemonWithdrawDepositParameter:: db

wItemQuantity:: db
wItemQuantityBuffer:: db

wTempMon:: party_struct wTempMon

wSpriteFlags:: db

wTalkingTargetType:: db
;bit 0 = has engaged NPC in dialogue
;bit 1 = has engaged sign in dialogue

wcdb1:: ds 1
wHandlePlayerStep:: ds 1

	ds 1

wcdb4:: ds 1
wcdb5:: ds 1
wcdb6:: ds 1

	ds 2

wPartyMenuActionText:: ds 1

wItemAttributeValue:: db

wCurPartyLevel:: db

wScrollingMenuListSize:: db

wLinkMode:: db
; 00 -
; 01 -
; 02 -
; 03 -

wNextWarp:: db
wNextMapGroup:: db
wNextMapNumber:: db
wPrevWarp:: db

wEvolvableFlags:: db

UNION
wSkipMovesBeforeLevelUp::
wListMovesLineSpacing::
wFieldMoveScriptID:: db
wMapBlocksAddress:: dw
wReplacementBlock:: db

NEXTU
wMonSubmenuCount:: db
wMonSubmenuItems:: ds NUM_MONMENU_ITEMS + 1

NEXTU
; general-purpose HP buffers
wHPBuffer1:: dw
wHPBuffer2:: dw
wHPBuffer3:: dw

NEXTU

wHPBarMaxHP:: dw
wHPBarOldHP:: dw
wHPBarNewHP:: dw
wHPBarDelta:: dw
wHPBarHPDifference:: dw

NEXTU
; switch AI
wEnemyEffectivenessVsPlayerMons:: flag_array PARTY_LENGTH
wPlayerEffectivenessVsEnemyMons:: flag_array PARTY_LENGTH	

NEXTU
wBuySellItemPrice:: dw

NEXTU
; Used for an old nickname function
wMiscStringBuffer:: ds STRING_BUFFER_LENGTH

NEXTU
wExpToNextLevel:: ds 3

NEXTU
wcdc3:: db
wcdc4:: db
wcdc5:: db

wcdc6:: db
wcdc7:: db
wcdc8:: db
	ds 1
wcdca:: db

NEXTU
; battle HUD
wBattleHUDTiles:: ds PARTY_LENGTH

NEXTU
; thrown ball data
wFinalCatchRate:: db
wThrownBallWobbleCount:: db

NEXTU
; evolution data
wEvolutionOldSpecies:: db
wEvolutionNewSpecies:: db
wEvolutionPicOffset::  db
wEvolutionCanceled::   db

ENDU

wLinkBattleRNs:: ds 10

wTempEnemyMonSpecies:: ds 1
wTempBattleMonSpecies:: ds 1


wEnemyMon:: battle_struct wEnemyMon
wEnemyMonBaseStats:: ds NUM_EXP_STATS

wEnemyMonCatchRate:: db
wcdff:: ds 1
wBattleMode:: db
wTempWildMonSpecies:: ds 1
wOtherTrainerClass:: ds 1
wBattleType:: db
wce04:: ds 1
wOtherTrainerID:: ds 1
wBattleResult:: ds 1

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
wMonHeaderEnd::


wce26:: ds 1

	ds 2

wCurDamage:: dw

	ds 2

wRepelEffect:: db

wListMoves_MoveIndicesBuffer:: ds NUM_MOVES
wPutativeTMHMMove:: db
wce33:: ds 1
wce34:: ds 1
wWildMon:: db
wBattleHasJustStarted:: db

wNamedObjectIndexBuffer::
wNumSetBits::
wTextDecimalByte::
wTempIconSpecies::
wTempPP::
wTempTMHM::
wUsePPUp::
wTempSpecies::
wMoveGrammar::
wTypeMatchup::
wCurType::
wBreedingCompatibility::
wTempByteValue::
wApplyStatLevelMultipliersToEnemy::
wce37::
	db

wce38:: ds 1

wNumFleeAttempts::
wce39:: ds 1

wMonTriedToEvolve:: db

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

wcd3e: ds 1
wcd3f: ds 1

SECTION "Options", WRAM0[$CE5F]

wOptions::
; bit 0-2: number of frames to delay when printing text
;   fast 1; mid 3; slow 5
; bit 3: ?
; bit 4: no text delay
; bit 5: stereo off/on
; bit 6: battle style shift/set
; bit 7: battle scene off/on
	db

; A buffer for sOptions that is used to check if a save file exists.
; Only checks the bottom bit, for whatever reason.
wSaveFileExists:: db

wActiveFrame:: db

; bit 0: 1-frame text delay
; bit 1: when unset, no text delay
wTextboxFlags::  db

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

UNION
wPlayerID:: dw
NEXTU
wce73: ds 1
wce74: ds 1
ENDU
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
; Object struct reserved for the map viewer cursor and for Blue in Silent Hill.
; Presumably needed any time they needed something to have a higher priority than the player.
wReservedObjectStruct:: object_struct wReservedObject

wPlayerStruct::   object_struct wPlayer
; wObjectStruct1 - wObjectStruct12
for n, 1, NUM_OBJECT_STRUCTS - 1
wObject{d:n}Struct:: object_struct wObject{d:n}
endr

wMinorObjects::
for n, 0, NUM_MINOR_OBJECTS
wMinorObject{d:n}Struct:: minor_object wMinorObject{d:n}
endr

wMapObjects::
wPlayerObject:: map_object wPlayer ; player is map object 0
; wMap1Object - wMap15Object
for n, 1, NUM_OBJECTS
wMap{d:n}Object:: map_object wMap{d:n}
endr

wd14f::
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

wMoney:: ds 3

;wd15d:: db

;wd15e:: db

;wd15f:: db

SECTION "D163", WRAM0[$D163]

wBadges::
wJohtoBadges::
	flag_array NUM_JOHTO_BADGES
wKantoBadges::
	flag_array NUM_KANTO_BADGES

wTMsHMs:: ds NUM_TM_HM

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
wd35f:: db

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

SECTION "D4A9", WRAM0[$D4A7]
; Bit 0 set when exiting a battle.
; Bit 1 set when viewing summary/opening new dex entry, and reset when closing new dex entry.
wd4a7:: db
	ds 1
wd4a9:: db
	ds 1 ; TODO

; TODO: change to wJoypadDisable, constantify flags
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

; Doesn't get written to at any point yet, but it's read... once.
wCurBox:: db

	ds 2

wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES


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
wUnusedAddOutdoorSpritesReturnValue:: db
wBGMapAnchor::
	dw

wUsedSprites::
	ds 2

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

wPokemonData::
wPartyCount:: db
wPartySpecies:: ds PARTY_LENGTH
wPartyEnd:: db

wPartyMons::
; wPartyMon1 - wPartyMon6
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}:: party_struct wPartyMon{d:n}
endr

wPartyMonOTs::
; wPartyMon1OT - wPartyMon6OT
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}OT:: ds PLAYER_NAME_LENGTH
endr

wPartyMonNicknames::
; wPartyMon1Nickname - wPartyMon6Nickname
for n, 1, PARTY_LENGTH + 1
wPartyMon{d:n}Nickname:: ds MON_NAME_LENGTH
endr
wPartyMonNicknamesEnd::

wPokedexCaught:: flag_array NUM_POKEMON
wEndPokedexCaught::

wPokedexSeen:: flag_array NUM_POKEMON
wEndPokedexSeen::

wUnownDex:: ds NUM_UNOWN

wAnnonID:: ds 1

	ds 1

; Buffer used for withdrawing Breeder Pokémon, as well as checking gender.

wBufferMonNickname:: ds MON_NAME_LENGTH
wBufferMonOT:: ds PLAYER_NAME_LENGTH
wBufferMon:: box_struct wBufferMon

; 1 = One Pokémon deposited.
; 2 = Two Pokémon deposited.
; 3 = Egg laid.
; 4 = Egg received, don't lay another egg.
wBreederStatus:: ds 1

	ds 2

wBreedMon1Nickname:: ds MON_NAME_LENGTH
wBreedMon1OT:: ds PLAYER_NAME_LENGTH
wBreedMon1:: box_struct wBreedMon1

wBreedMon2Nickname:: ds MON_NAME_LENGTH
wBreedMon2OT:: ds PLAYER_NAME_LENGTH
wBreedMon2:: box_struct wBreedMon2

; Uses the last two bits to keep track of your breeder mons' genders.
; Bit clear = male, bit set = female
wBreedMonGenders:: db
wd8fe:: ds 1

SECTION "D913", WRAM0[$D913]

wOTPartyCount:: db
wOTPartySpecies:: ds PARTY_LENGTH
wOTPartySpeciesEnd:: db

SECTION "Wild mon buffer", WRAM0[$D91B]

UNION
wWildMons::
	ds 41
NEXTU
wOTPartyMons::
; wOTPartyMon1 - wOTPartyMon6
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}:: party_struct wOTPartyMon{d:n}
endr

wOTPartyMonOT::
; wOTPartyMon1OT - wOTPartyMon6OT
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}OT:: ds PLAYER_NAME_LENGTH
endr

wOTPartyMonNicknames::
; wOTPartyMon1Nickname - wOTPartyMon6Nickname
for n, 1, PARTY_LENGTH + 1
wOTPartyMon{d:n}Nickname:: ds MON_NAME_LENGTH
endr
wOTPartyDataEnd::
ENDU

wBox:: box wBox

SECTION "Stack Bottom", WRAM0

; Where SP is set at game init
wStackBottom::
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
