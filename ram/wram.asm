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

	ds 1

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

wIncrementTempo:: dw
wMapMusic:: db
wCryPitch:: dw
wCryLength:: dw
wLastVolume:: db
wUnusedMusicF9Flag:: db
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

	ds 68

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

wClockDialogArrowBlinkCounter:: db

	ds 1

; Monster or Trainer test?
wWhichPicTest:: db

	ds 3
NEXTU
wOptionsMenuCursorX:: db
wOptionsMenuCursorY:: db
wOptionsTextSpeedCursorX:: db
wOptionsBattleAnimCursorX:: db
wOptionsBattleStyleCursorX:: db
wOptionsAudioSettingsCursorX:: db
wOptionsBottomRowCursorX:: db
NEXTU
; link patch lists
wPlayerPatchLists:: ds SERIAL_PATCH_LIST_LENGTH
wOTPatchLists:: ds SERIAL_PATCH_LIST_LENGTH
NEXTU
	ds 7

	ds 3

wDayOfWeekBuffer:: db
	ds 9
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
; trade
wPlayerTrademon:: trademon wPlayerTrademon
wOTTrademon::     trademon wOTTrademon
wTradeAnimAddress:: dw
wLinkPlayer1Name:: ds PLAYER_NAME_LENGTH
wLinkPlayer2Name:: ds PLAYER_NAME_LENGTH
wLinkTradeSendmonSpecies:: db
wLinkTradeGetmonSpecies::  db

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
	ds 28
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

wPokerAddress:: ds 13 * 4
wPokerCardNumber:: db
wPokerTurnNumber:: db
wPokerPosition:: db
wPokerPreviousCard:: db
wPokerSortOrder:: ds POKER_NUM_CARDS
wPokerString:: ds 5
wPokerAllow:: db
wPokerPayout:: db
wPokerCurrentBet:: dw
wPokerWork:: db
wPokerDoubleUp:: dw
wPokerColWork:: db
wPokerWorkEnd:: ds 32

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

	ds 4

wDexPlaySlowpokeAnimation:: db

ENDU


SECTION "Map Buffer", WRAM0

wMapBuffer::
wMapScriptNumber:: db
wMapScriptNumberLocation:: dw
wMapScriptPointerLocation:: dw ; TODO
; setting bit 7 seems to disable overworld updates and player control?
; setting bit 6 disables map connections
wOverworldFlags:: db
	ds 18
wMapBufferEnd::

UNION

wLinkData::
wOverworldMapBlocks:: ds 1300
wLinkDataEnd::
wOverworldMapBlocksEnd::

NEXTU
	ds 700
wLinkPlayerMail::
wLinkPlayerMailPreamble:: ds SERIAL_MAIL_PREAMBLE_LENGTH
wLinkPlayerMailMessages:: ds MAIL_STRUCT_LENGTH * PARTY_LENGTH
wLinkPlayerMailPatchSet:: ds 35
wLinkPlayerMailEnd::
	ds 10

NEXTU

wLYOverrides:: ds SCREEN_HEIGHT_PX
wLYOverridesEnd:: db
	ds 15
wLYOverrides2:: ds SCREEN_HEIGHT_PX
wLYOverrides2End::

NEXTU

; link data members
wLinkPlayerName:: ds PLAYER_NAME_LENGTH
wLinkPartyCount:: db
wLinkPartySpecies:: ds PARTY_LENGTH
wLinkPartyEnd:: db ; older code doesn't check PartyCount

; link player data
wLinkPlayerData::
; wLinkPlayerPartyMon1 - wLinkPlayerPartyMon6
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}:: party_struct wLinkPlayerPartyMon{d:n}
endr

wLinkPlayerPartyMonOTs::
; wLinkPlayerPartyMon1OT - wLinkPlayerPartyMon6OT
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}OT:: ds NAME_LENGTH
endr

wLinkPlayerPartyMonNicknames::
; wLinkPlayerPartyMon1Nickname - wLinkPlayerPartyMon6Nickname
for n, 1, PARTY_LENGTH + 1
wLinkPlayerPartyMon{d:n}Nickname:: ds NAME_LENGTH
endr

NEXTU

; Pikachu minigame

wPikachuMinigamePikachuObjectPointer:: dw
wPikachuMinigamePikachuTailObjectPointer:: dw
wPikachuMinigamePikachuNextAnim:: db

wPikachuMinigameControlEnable:: db

wPikachuMinigameJumpCounter:: db ; written to, but is this read from?

wPikachuMinigamePikachuYOffset:: db
wPikachuMinigameNoteTimer:: db
wPikachuMinigameScore:: dw
wPikachuMinigameNoteCounter:: dw ; not used for anything meaningful?

wPikachuMinigameSpawnTypeIndex:: db
wPikachuMinigameSpawnDataIndex:: db
wPikachuMinigameScoreModifier:: db

wPikachuMinigameNoteCaught:: db

; Time keeping
wPikachuMinigameTimeFrames:: db
wPikachuMinigameTimeSeconds:: db

; are these two used?
wPikachuMinigameTimeMinutes:: db
wPikachuMinigameTimeHours:: db

wPikachuMinigameRedrawTimer:: db
wPikachuMinigameMapOffset:: db
wPikachuMinigameScrollSpeed:: db

wPikachuMinigameColumnFlags:: db
wPikachuMinigameSavedColumnPointer:: dw
wPikachuMinigameColumnPointer:: dw

wPikachuMinigameRepeatColumnCounter:: db
wPikachuMinigameRepeatColumnCounter2:: db

wPikachuMinigameSceneTimer:: db

wPikachuMinigameJumptableIndex:: db

wPikachuMinigameBGMapPointer:: dw
wPikachuMinigameTilemapPointer:: dw
wPikachuMinigameTilesPointer:: dw

wPikachuMinigameColumnBuffer:: ds 16

NEXTU

; wFifteenPuzzleBitmap is Panels 1 - 15
wFifteenPuzzleBitmap:: ds 4 * 4 * 15
; wFifteenPuzzleEmptyPanelBitmap is Panel 16 / Empty Panel
wFifteenPuzzleEmptyPanelBitmap:: ds 4 * 4
wFifteenPuzzlePanelNumberOrder:: ds 4 * 4
wFifteenPuzzlePosition:: db
; wFifteenPuzzleEmptyPanelNumber should always be $0f
wFifteenPuzzleEmptyPanelNumber:: db
wFifteenPuzzleJoyStateBuffer:: db
wFifteenPuzzleIconNumber:: db
wFifteenPuzzleTimeFrames:: db
wFifteenPuzzleTimeSeconds:: db
wFifteenPuzzleTimeMinutes:: db
wFifteenPuzzleGFXPointer:: db

NEXTU

wPicrossCursorSpritePointer:: dw
wPicrossCurrentGridNumber:: db
wPicrossCurrentCellNumber:: db
wPicrossCurrentCellType:: db
wPicrossJoypadAction:: db
wPicrossJoyStateBuffer:: db

wPicrossCursorMovementDelay:: db
wPicrossMarkedCells:: ds 4 * 4 * 4 * 4
	ds 1
wPicrossLayoutBuffer:: ds $20
wPicrossLayoutBuffer2:: ds $20 - 1
wPicrossBitmap:: ds 4 * 4 * 4 * 4
wPicrossBase2bppPointer:: dw
wPicrossBaseGFXPointer:: dw
wPicrossDrawingRoutineCounter:: db
	ds 11
wPicrossNumbersBuffer:: ds 4 * 4 * 4 * 4
wPicrossRowGFX2bppBuffer:: ds 144
	ds 112
wPicrossErrorCheck:: db
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
wBattleAnimEnd::

NEXTU
wBattleAnimGFXTempTileID::
wBattleAnimGFXTempPicHeight:: db
wBattlePicResizeTempPointer:: dw

ENDU

	ds 50
wActualBattleAnimEnd::

	ds $1a3

wBattle::
wEnemyMoveStruct:: move_struct wEnemyMoveStruct
wPlayerMoveStruct:: move_struct wPlayerMoveStruct

wEnemyMonNickname:: ds 6
wBattleMonNickname:: ds 6

UNION
; battle mon
wBattleMon:: battle_struct wBattleMon

NEXTU
; intro water/grass/fire cutscene data
	ds 14
wIntroJumptableIndex:: db
wIntroBGMapPointer:: dw
wIntroTilemapPointer:: dw
wIntroTilesPointer:: dw
wIntroFrameCounter1:: db
wIntroFrameCounter2:: db
wIntroSpriteStateFlag:: db
ENDU

wTrainerClass:: db
wEnemyTrainerGraphicsPointer:: dw
	ds 2
wEnemyTrainerBaseReward:: db
	ds 3
wOTClassName:: ds TRAINER_CLASS_NAME_LENGTH
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

wAttackMissed:: db
; nonzero for a miss

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
wPicrossAnimateDust:: db
ENDU

wBattleAnimParam::

	ds 1

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

	ds 1

wPlayerDefLevel::  db
wPlayerSpdLevel::  db
wPlayerSAtkLevel:: db
wPlayerSDefLevel:: db
wPlayerAccLevel:: db
wPlayerEvaLevel:: db

	ds 1

wEnemyStatLevels::
wEnemyAtkLevel::

	ds 1

wEnemyDefLevel::  db
wEnemySpdLevel::  db
wEnemySAtkLevel:: db
wEnemySDefLevel:: db
wEnemyAccLevel:: db
wEnemyEvaLevel:: db

	ds 1

wForceEvolution:: db

wEnemyTurnsTaken:: db

	ds 1

wPlayerSubstituteHP:: db
wEnemySubstituteHP:: db
wPlayerDebugSelectedMove:: db

	ds 1

wMoveSelectionMenuType:: db

wCurPlayerMove:: db
wCurEnemyMove:: db

wLinkBattleRNCount:: db

wEnemyItemState:: db

	ds 2

wCurEnemyMoveNum:: db
wEnemyHPAtTimeOfPlayerSwitch:: dw

wPayDayMoney:: ds 3

wUnused_SafariEscapeFactor:: db
wUnused_SafariBaitFactor:: db

	ds 1

wEnemyBackupDVs:: dw

wAlreadyDisobeyed:: db

wDisabledMove:: db
wEnemyDisabledMove:: db
wWhichMonFaintedFirst:: db

wLastPlayerCounterMove:: db
wLastEnemyCounterMove:: db

wEnemyMinimized:: db
wAlreadyFailed:: db

wBattleParticipantsIncludingFainted:: db
wBattleLowHealthAlarm:: db
wPlayerMinimized:: db

wPlayerScreens:: db
wEnemyScreens:: db

wPlayerSafeguardCount:: db
wEnemySafeguardCount:: db

; There's got to be a better name for this...
wMonSGBPaletteFlagsBuffer:: db

wBattleWeather:: db
wWeatherCount:: db

ENDU
wBattleEnd::

SECTION "Video", WRAM0

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

wTileAnimBuffer:: ds 1 tiles

UNION
wOtherPlayerLinkMode:: db
wOtherPlayerLinkAction::
wBattleAction:: db
	ds 3

wPlayerLinkAction:: db
	ds 4
NEXTU
wLinkReceivedSyncBuffer:: ds 5
wLinkPlayerSyncBuffer:: ds 5
ENDU

wLinkTimeoutFrames:: dw
wLinkByteTimeout:: dw
wMonType:: db

wSelectedItem::
wCurSpecies:: db
wNamedObjectTypeBuffer:: db

	ds 1
wJumptableIndex:: db

wSlotsDelay::
wMemoryGameCardChoice::
wFlyDestination::
wIntroSceneFrameCounter::
wTrainerGearPointerPosition::
wPokedexSlowpokeNumSearchEntries::
wNestIconBlinkCounter::
wFrameCounter::
wBattleTransitionCounter:: db

UNION
wBattleTransitionSineWaveOffset::
wBattleTransitionSpinQuadrant::
wIntroSceneTimer::
wTrainerGearCard::
wFrameCounter2:: db

wTrainerGearRadioIndex::
wSlotReelIconDelay:: db
NEXTU
wFlyIconAnimStructPointer:: dw
ENDU

wVBCopySize:: db
wVBCopySrc:: dw
wVBCopyDst:: dw
wVBCopyDoubleSize:: db
wVBCopyDoubleSrc:: dw
wVBCopyDoubleDst:: dw
wPlayerStepVectorX:: db
wPlayerStepVectorY:: db
wPlayerStepFlags:: db
wPlayerStepDirection:: db

wQueuedMinorObjectGFX:: db

wVBCopyFarSize:: db
wVBCopyFarSrc:: dw
wVBCopyFarDst:: dw
wVBCopyFarSrcBank:: db
wPlayerMovement:: db
wMovementObject:: db
	ptrba wMovementData

wIndexedMovement2Pointer:: dw

	ds 18

; collision buffer
wTileDown::  db
wTileUp::    db
wTileLeft::  db
wTileRight:: db

wScreenSave::
	ds 6 * 5

wToolgearBuffer::
	ds $40

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

	ds 8

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

	ds 3

wVBlankJoyFrameCounter:: db

wVBlankOccurred:: db
wLastSpawnMapGroup:: db
wLastSpawnMapNumber:: db

	ds 2

;Controls what type of opening (fire/notes) you get.
wTitleSequenceOpeningType:: db

wDefaultSpawnPoint:: db

UNION

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
wMovementXBuffer:: db
wMovementYBuffer:: db
wMovementSpriteViewerDirection:: db
	ds 53

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
wSwitchItemBuffer:: dw

NEXTU

wBattleMenuRows:: db
wBattleMenuColumns:: db

NEXTU
; trade
wCurTradePartyMon:: db
wCurOTTradePartyMon:: db
wBufferTrademonNickname:: ds MON_NAME_LENGTH

NEXTU

wTempBoxName:: ds BOX_NAME_LENGTH

NEXTU
wPlayerSpinInPlaceAnimFrameDelay_Old:: db
wPlayerSpinInPlaceAnimFrameDelayDelta_Old:: db
wPlayerSpinInPlaceAnimFrameDelayEndValue_Old:: db
wPlayerSpinInPlaceAnimSoundID_Old:: db
	ds 6
	db ; temporary space used when wFacingDirectionList_Old is rotated
wFacingDirectionList_Old:: ds 4
	ds 3
wSavedPlayerScreenY_Old:: db
wSavedPlayerFacingDirection_Old:: db

NEXTU
wPlayerSpinWhileMovingUpOrDownAnimDeltaY_Old:: db
wPlayerSpinWhileMovingUpOrDownAnimMaxY_Old:: db
wPlayerSpinWhileMovingUpOrDownAnimFrameDelay_Old:: db

NEXTU
wFlyAnimUsingCoordList_Old:: db
wFlyAnimCounter_Old:: db
wFlyAnimBirdSpriteImageIndex_Old:: db
	ds 15
wEmotionBubbleSpriteIndex_Old:: db

ENDU

	ds 35

wSkatingDirection:: db
wCompanionCollisionFrameCounter:: db

wObjectMasks::
	ds NUM_OBJECTS

wSpriteCurPosX::         db
wSpriteCurPosY::         db
wSpriteWidth::           db
wSpriteHeight::          db
wSpriteInputCurByte::    db
wSpriteInputBitCounter:: db
wSpriteOutputBitOffset:: db
wSpriteLoadFlags::       db
wSpriteUnpackMode::      db
wSpriteFlipped::         db
wSpriteInputPtr::        dw
wSpriteOutputPtr::       dw
wSpriteOutputPtrCached:: dw
wSpriteDecodeTable0Ptr:: dw
wSpriteDecodeTable1Ptr:: dw

wFXAnimID:: dw

wPlaceBallsX:: db
wPlaceBallsY:: db

; Both RBY and final GSC write directly to wLowHealth, this prototype writes it here.
; TODO: Investigate how it actually functions.
wLowHealthAlarmBuffer:: db

wTileAnimationTimer:: db

	ds 1

wDisableVBlankOAMUpdate:: db

	ds 2

wBGP:: db
wOBP0:: db
wOBP1:: db

wNumHits:: db

wDisableVBlankWYUpdate:: db
wSGB:: db

wSGBPalBuffer:: db
wPlayerHPPal:: db
wEnemyHPPal:: db

wHPPals:: ds PARTY_LENGTH
wCurHPPal:: db

	ds 7

wSGBPals::  ds PALPACKET_LENGTH * 3

wMonOrItemNameBuffer:: ds MON_NAME_LENGTH

	ds MON_NAME_LENGTH

wTMHMMoveNameBackup:: ds 8

	ds 1

wStringBuffer1:: ds STRING_BUFFER_LENGTH

	ds 1

UNION
wStartDay:: db
wStartHour:: db
wStartMinute:: db

NEXTU
wHPBarTempHP:: dw

NEXTU
wStringBuffer2:: ds STRING_BUFFER_LENGTH

NEXTU

	ds 2
wGainBoostedExp:: db

ENDU

	ds 1

wPartyMenuCursor::
wBillsPCCursor:: db
wRegularItemsCursor:: db
wBackpackAndKeyItemsCursor:: db

wBattleMenuCursorPosition::
wStartmenuCursor:: db

wCurMoveNum:: db
wCurBattleMon:: db

wTMHolderCursor:: db
wFieldDebugMenuCursorBuffer:: db
wRegularItemsScrollPosition:: db
wBackpackAndKeyItemsScrollPosition:: db
wBillsPCScrollPosition:: db
wTMHolderScrollPosition:: db

; TODO: change to wSwitchItem, wSwitchMon, wSwappingMove
wSelectedSwapPosition:: db
wMenuScrollPosition:: db

wTextDest:: dw

wQueuedScriptBank:: db
wQueuedScriptAddr:: dw

wPredefID:: db

wPredefHL:: dw
wPredefDE:: dw
wPredefBC::

wFarCallBCBuffer:: dw

	ds 1

wNumMoves:: db

wItemEffectSucceeded::
wFieldMoveSucceeded::
; 0 - use move
; 1 - use item
; 2 - switch
wBattlePlayerAction:: db

wStateFlags:: db

	ds 3

wBattleResult:: db

	ds 1

wChosenStarter:: db
wCurMartCount:: db

	ds 15

wListPointer:: dw
wNamesPointer:: dw

; Start of WRAM 1 in pokegold

wItemAttributesPointer:: dw

wCurItem:: db
wCurItemQuantity::
wItemIndex:: db

wCurPartySpecies:: db
wCurPartyMon:: db

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

	ds 1

wHandlePlayerStep:: db

	ds 1

; Leftovers from pokered
wAudioFadeOutControl:: db
wAudioFadeOutCounterReloadValue:: db
wAudioFadeOutCounter:: db

	ds 2

wPartyMenuActionText:: db

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
wBoostExpByExpAll::
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
wVRAMViewerPage:: db
wSwitchMonTo:: db
wSwitchMonFrom:: db
	ds 1
wLinkBattleRNPreamble:: db
wMapBGEventCount:: db
	ds 1
wEnemyItemUsed:: db

NEXTU
; battle HUD
wBattleHUDTiles:: ds PARTY_LENGTH

NEXTU
; thrown ball data
wFinalCatchRate:: db
wThrownBallWobbleCount:: db

NEXTU
; move AI
wEnemyAIMoveScores:: ds NUM_MOVES

NEXTU
; evolution data
wEvolutionOldSpecies:: db
wEvolutionNewSpecies:: db
wEvolutionPicOffset::  db
wEvolutionCanceled::   db

ENDU

wLinkBattleRNs:: ds 10

wTempEnemyMonSpecies:: db
wTempBattleMonSpecies:: db

wEnemyMon:: battle_struct wEnemyMon
wEnemyMonBaseStats:: ds NUM_EXP_STATS
wEnemyMonCatchRate:: db
wEnemyMonBaseExp:: db
wEnemyMonEnd::

wBattleMode:: db
wTempWildMonSpecies:: db
wOtherTrainerClass:: db
wBattleType:: db
wUnused_GymLeaderNo:: db ; Unused
wOtherTrainerID:: db
wBattleEnded:: db

wMonHeader::

wMonHIndex::
; In the ROM base stats data structure, this is the dex number, but it is
; overwritten with the dex number after the header is copied to WRAM.
	ds 1

wMonHBaseStats::
wMonHBaseHP:: db
wMonHBaseAttack:: db
wMonHBaseDefense:: db
wMonHBaseSpeed:: db
wMonHBaseSpecialAtt:: db
wMonHBaseSpecialDef:: db

wMonHTypes::
wMonHType1:: db
wMonHType2:: db

wMonHCatchRate:: db
wMonHBaseEXP:: db

wMonHItems::
wMonHItem1:: db
wMonHItem2:: db

wMonHGenderRatio:: db

wMonHUnk0:: db
wMonHUnk1:: db
wMonHUnk2:: db

wMonHSpriteDim:: db
wMonHFrontSprite:: dw
wMonHBackSprite:: dw

wMonHGrowthRate:: db

wMonHLearnset::
; bit field
	flag_array 50 + 5 ; size = 7
	ds 1
wMonHeaderEnd::

wMapAnimsBackup:: db

	ds 2

wCurDamage:: dw

	ds 2

wRepelEffect:: db

wListMoves_MoveIndicesBuffer:: ds NUM_MOVES
wPutativeTMHMMove:: db

	ds 1

wInitListType:: db
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
	db

wFailedToFlee:: db
wNumFleeAttempts:: db

wMonTriedToEvolve:: db

wVBlankSavedROMBank:: db

wBuffer:: db

wTimeOfDay:: db
; based on RTC
; Time of Day   Regular    Debug
; 00 - Day      09--15h    00--30s
; 01 - Night    15--06h    30--35s
; 02 - Cave                35--50s
; 03 - Morning  06--09h    50--59s

	ds 1

wNewGameWRAMEnd::

	ds 32

SECTION "Options", WRAM0

wOptions::
; bit 0-2: number of frames to delay when printing text
;   fast 1; mid 3; slow 5
; bit 3: ?
; bit 4: no text delay
; bit 5: stereo off/on
; bit 6: battle style shift/set
; bit 7: battle scene off/on
	db

; Used as a buffer for sOptions to check if a save file exists.
; Only checks the bottom bit (since all valid text speeds have that bit set).
wSaveFileExists::
wSaveFileFlags:: db

wActiveFrame:: db

; bit 0: 1-frame text delay
; bit 1: when unset, no text delay
wTextboxFlags::  db

wDebugFlags:: db
; Bit 0: Debug battle indicator
; Bit 1: Debug field indicator
; Bit 2-3: Game is continued (set when selecting continue on the main menu)
wDebugFlags2:: db
wDebugFlags3:: db
wDebugFlags4:: db

SECTION "Game Data", WRAM0

wGameData::
wPlayerName:: ds 6

wMomsName:: ds 6

wPlayerID:: dw

	ds 1

wObjectFollow_Leader:: db
wObjectFollow_Follower:: db
wCenteredObject:: db
wFollowerMovementQueueLength:: db
wFollowMovementQueue:: ds 5

wObjectStructs::
UNION
; Object struct reserved for the map viewer cursor and for Blue in Silent Hill.
; Presumably needed any time they needed something to have a higher priority than the player.
wReservedObjectStruct:: object_struct wReservedObject

NEXTU
	ds 2
wSpritePlayerStateData1ImageIndex_Old:: db
	ds 1
wSpritePlayerStateData1YPixels_Old:: db
ENDU

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

wToolgearFlags:: db
; 76543210
; |    | \- show toolgear
; |    |
; |    \--- transfer toolgear to window
; \-------- hide toolgear

	ds 2

wTimeOfDayPal:: db
; Applied according to wCurTimeOfDay from wTimeOfDayPalset

wTimeOfDayDebugFlags:: db
; 76543210
; |      \- show player coords in toolgear instead of time
; \-------- switch overworld palettes according to minutes not hours

	ds 3
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

	ds 1

wCoins:: dw
wMoney:: ds 3

	ds 3

wBadges::
wJohtoBadges::
	flag_array NUM_JOHTO_BADGES
wKantoBadges::
	flag_array NUM_KANTO_BADGES

wTMsHMs:: ds NUM_TM_HM

wItems::
wNumBagItems:: db
wBagItems:: ds MAX_ITEMS * 2 + 1

wNumKeyItems:: db
wKeyItems:: ds MAX_KEY_ITEMS + 1

wNumBallItems:: db
wBallQuantities:: ds MAX_BALLS + 1

wNumPCItems:: db
wPCItems:: ds MAX_PC_ITEMS * 2 + 1

	ds 6

wRegisteredItem:: db
wRegisteredItemQuantity:: db
wRivalName:: ds 6
	ds 6

wPlayerState:: db
; 00 - walking
; 01 - bicycle
; 02 - skateboard
; 04 - surfing

wPlayerStarter:: db
wRivalStarter:: db

	ds 51
; map scene ids
wPlayerHouse2FSceneID:: db
wPlayerHouse1FSceneID:: db
wSilentHillSceneID:: db
wSilentHillLabFrontSceneID:: db
wSilentHillLabBackSceneID:: db
wSilentHillPokecenterSceneID:: db
wSilentHillHouseSceneID:: db
wRoute1P1SceneID:: db
wRoute1P2SceneID:: db
wRoute1Gate1FSceneID:: db
wRoute1Gate2FSceneID:: db
wSilentHillsSceneID:: db
wOldCityPokecenter2FSceneID:: db

	ds 243
; map flags
wPlayerHouse2FFlags:: db
wPlayerHouse1FFlags:: db
wSilentHillFlags:: db
wSilentHillLabFrontFlags:: db
wSilentHillLabBackFlags:: db
wSilentHillPokecenterFlags:: db
wSilentHillHouseFlags:: db
wRoute1P1Flags:: db
wRoute1P2Flags:: db
wRoute1Gate1FFlags:: db
wRoute1Gate2FFlags:: db
wSilentHillsFlags:: db
wOldCityPokecenter2FFlags:: db

	ds 115

wEventFlags:: flag_array NUM_EVENTS

	ds 136

; Bit 0 set when exiting a battle.
; Bit 1 set when viewing summary/opening new dex entry, and reset when closing new dex entry.
wPokedexMenuFlags:: db

wUnusedLinkCommunicationByte:: db
wGameModeFlags:: db

	ds 1

; TODO: change to wJoypadDisable, constantify flags
wJoypadFlags:: db
; 76543210
; ||||\__/
; ||||  \-- unkn
; |||\----- set for rival intro textbox
; ||\------ don't wait for keypress to close text box
; |\------- joypad sync mtx
; \-------- joypad disabled
	ds 1
wMovementFlags_Old:: db

	ds 4

wDigWarpNumber:: db

	ds 3

; Doesn't get written to at any point yet, but it's read... once.
wCurBox:: db

	ds 2

wBoxNames:: ds BOX_NAME_LENGTH * NUM_BOXES

; warp data
wWarpNumber:: db

wCurrMapWarpCount:: db

wCurrMapWarps::
REPT 32
	ds 5
ENDR

wCurMapBGEventCount:: db

wCurrMapBGEvents::
REPT 16
	ds 4
ENDR

wCurrMapObjectCount:: db

wCurrMapInlineTrainers::
REPT NUM_OBJECTS
	ds 2 ; inline trainers. each pair of bytes is direction, distance
ENDR
	ds 32

wMapStatus:: db ;OW battle state? $3 wild battle, $8 is trainer battle $4 is left battle, $B is load overworld? $0 is in overworld
wLastMapStatus:: db ;wMapStatus's last written-to value

wGameDataEnd::

; Sort of redundant to separate data like this when they're right next to each other.
wGameData2::

	ds 9

wUnusedAddOutdoorSpritesReturnValue:: db
wBGMapAnchor:: dw

wUsedSprites:: db
wUsedFollowerSprites:: db
wUsedNPCSprites::
	ds 8
wUsedStaticSprites::
	ds 2
wUsedSpritesEnd::

	ds 5

; map header
wMapGroup:: db
wMapId:: db

wOverworldMapAnchor:: dw

wYCoord:: db
wXCoord:: db

wMetatileNextY:: db
wMetatileNextX:: db

wMapIdStack:: db

wMapPartial::
wMapAttributesBank:: db
wMapTileset:: db
wMapPermissions:: db
wMapAttributesPtr:: dw
wMapPartialEnd::

wMapAttributes::
wMapHeight:: db
wMapWidth:: db
wMapBlocksPointer:: dw
wMapTextPtr:: dw
wMapScriptPtr:: dw
wMapObjectsPtr:: dw
wMapConnections:: db
wMapAttributesEnd::

wNorthMapConnection:: map_connection_struct wNorth
wSouthMapConnection:: map_connection_struct wSouth
wWestMapConnection::  map_connection_struct wWest
wEastMapConnection::  map_connection_struct wEast

wTileset::
wTilesetBank:: db
wTilesetBlocksAddress:: dw
wTilesetTilesAddress:: dw
wTilesetCollisionAddress:: dw
wTilesetAnim:: dw
	ds 2 ; unused
wTilesetEnd::

wGameData2End::

SECTION "Party", WRAM0

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

wAnnonID:: db

	ds 1

; Buffer used for withdrawing Breeder Pokémon, as well as checking gender.

wBufferMonNickname:: ds MON_NAME_LENGTH
wBufferMonOT:: ds PLAYER_NAME_LENGTH
wBufferMon:: box_struct wBufferMon

; 1 = One Pokémon deposited.
; 2 = Two Pokémon deposited.
; 3 = Egg laid.
; 4 = Egg received, don't lay another egg.
wBreederStatus:: db

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
wOTPlayerName:: ds PLAYER_NAME_LENGTH

	ds 15

wOTPartyData::
wOTPartyCount:: db
wOTPartySpecies:: ds PARTY_LENGTH
wOTPartySpeciesEnd:: db

; wildmon buffer
UNION
wWildMonData::

wMornEncounterRate::  db
wDayEncounterRate::   db
wNiteEncounterRate::  db

wWildMons:: ds NUM_GRASSMON * 2

	ds 2

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

wPokemonDataEnd::

wBox:: box wBox


SECTION "Stack Bottom", WRAM0

; Where SP is set at game init
wStackBottom::
; Due to the way the stack works (`push` first decrements, then writes), the byte at $DFFF is actually wasted
