INCLUDE "constants.asm"

SECTION "engine/link/link.asm", ROMX

StartLinkCommunications:
	ld a, [wLinkMode]
	cp LINK_TIMECAPSULE
	jr z, .CallAndSetupLinkMode
	call Gen2ToGen2LinkComms
	jr .ExitLinkMode

.CallAndSetupLinkMode:
	call LinkCommunications
.ExitLinkMode:
	xor a
	ld hl, wOTPartyMons
	ld [hli], a
	ld [hli], a
	ld [hl], a
	call ReloadFontAndTileset
	xor a
	ld [wLinkMode], a
	ldh [hVBlank], a
	callfar CloseLink
	ret

LinkCommunications:
	ld c, $50
	call DelayFrames
	call ClearTileMap
	call UpdateSprites
	call LoadFont
	call LoadFontsBattleExtra
	call LoadTradeScreenBorderGFX
	hlcoord 3, 8
	ld b, 2
	ld c, 12
	call LinkTextboxAtHL
	hlcoord 4, 10
	ld de, String_PleaseWait
	call PlaceString
	ld hl, wLinkByteTimeout
	xor a
	ld [hli], a
	ld [hl], HIGH(SERIAL_LINK_BYTE_TIMEOUT)

Gen2ToGen1LinkComms:
	call ClearLinkData
	call Link_PrepPartyData_Gen1
	call FixDataForLinkTransfer
	xor a
	ld [wLinkPlayerSyncBuffer], a
	call WaitLinkTransfer
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1

	ld c, 3
	call DelayFrames
	xor a
	ldh [hSerialSend], a
	ld a, $81
	ldh [rSC], a
	call DelayFrame
	xor a
	ldh [hSerialSend], a
	ld a, $81
	ldh [rSC], a
.player_1
	ld c, 3
	call DelayFrames
	ld a, $08
	ldh [rIE], a
	ld hl, wcdc7
	ld de, wEnemyMon
	ld bc, SERIAL_RN_PREAMBLE_LENGTH + SERIAL_RNS_LENGTH
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wLinkData
	ld de, wOTPlayerName
	ld bc, $0161
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wOptionsMenuCursorX
	ld de, wPlayerTrademon
	ld bc, $00C8
	call Serial_ExchangeBytes

	ld a, $1D
	ldh [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic
	call Link_CopyRandomNumbers
	ld hl, wOTPlayerName
	call Link_FindFirstNonControlCharacter_SkipZero

	ld de, wLinkData
	ld bc, $0161
	call Link_CopyOTData

	ld de, wPlayerTrademon
	ld hl, wLinkPlayerData
	ld c, $02

.loop
	ld a, [de]
	inc de
	and a
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .next
	push hl
	push bc
	ld b, 0
	dec a
	ld c, a
	add hl, bc
	ld a, SERIAL_NO_DATA_BYTE
	ld [hl], a
	pop bc
	pop hl
	jr .loop

.next
	ld hl, wLinkPlayerData + SERIAL_PATCH_DATA_SIZE
	dec c
	jr nz, .loop

	ld hl, wLinkData
	ld de, wOTPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld de, wOTPartyCount
	ld a, [hli]
	ld [de], a
	inc de

.party_loop
	ld a, [hli]
	cp -1
	jr z, .done_party
	ld [wTempByteValue], a
	push hl
	push de
	callfar ConvertMon_1to2
	pop de
	pop hl
	ld a, [wTempByteValue]
	ld [de], a
	inc de
	jr .party_loop

.done_party:
	ld [de], a
	ld hl, wLinkPlayerData
	call Link_ConvertPartyStruct1to2
	ld a, LOW(wOTPartyMonOT)
	ld [wNamesPointer], a
	ld a, HIGH(wOTPartyMonOT)
	ld [wNamesPointer + 1], a
	ld de, MUSIC_NONE
	call PlayMusic
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld c, 66
	call z, DelayFrames
	ld de, MUSIC_OAK_INTRO
	call PlayMusic
	jp InitTradeMenuDisplay

Gen2ToGen2LinkComms:
	ld c, $50
	call DelayFrames
	call ClearTileMap
	call UpdateSprites
	call LoadFont
	call LoadFontsBattleExtra
	call LoadTradeScreenBorderGFX
	hlcoord 3, 8
	ld b, 2
	ld c, 12
	call LinkTextboxAtHL
	hlcoord 4, 10
	ld de, String_PleaseWait
	call PlaceString
	ld hl, wLinkByteTimeout
	xor a
	ld [hli], a
	ld [hl], HIGH(SERIAL_LINK_BYTE_TIMEOUT)

	call ClearLinkData
	call Link_PrepPartyData_Gen2
	call FixDataForLinkTransfer
	xor a
	ld [wLinkPlayerSyncBuffer], a
	call WaitLinkTransfer
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1

	ld c, 3
	call DelayFrames
	xor a
	ldh [hSerialSend], a
	ld a, $81
	ldh [rSC], a
	call DelayFrame
	xor a
	ldh [hSerialSend], a
	ld a, $81
	ldh [rSC], a
.player_1
	ld c, 3
	call DelayFrames
	ld a, $08
	ldh [rIE], a

	ld hl, wcdc7
	ld de, wEnemyMon
	ld bc, SERIAL_RN_PREAMBLE_LENGTH + SERIAL_RNS_LENGTH
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wLinkData
	ld de, wOTPlayerName
	ld bc, SERIAL_PREAMBLE_LENGTH + PLAYER_NAME_LENGTH + (1 + PARTY_LENGTH + 1) + (PARTYMON_STRUCT_LENGTH + PLAYER_NAME_LENGTH * 2) * PARTY_LENGTH + 7
	call Serial_ExchangeBytes
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a

	ld hl, wOptionsMenuCursorX
	ld de, wPlayerTrademon
	ld bc, SERIAL_PATCH_LIST_LENGTH
	call Serial_ExchangeBytes

	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr nz, .not_trading
	ld hl, wLinkPlayerMail
	ld de, wBattle
	ld bc, $0118
	call ExchangeBytes
.not_trading
	ld a, $1D
	ldh [rIE], a
	ld de, MUSIC_NONE
	call PlayMusic
	call Link_CopyRandomNumbers

	ld hl, wOTPlayerName
	call Link_FindFirstNonControlCharacter_SkipZero
	ld de, wLinkData
	ld bc, PLAYER_NAME_LENGTH + 1 + PARTY_LENGTH + 1 + (PARTYMON_STRUCT_LENGTH + MON_NAME_LENGTH * 2) * PARTY_LENGTH
	call Link_CopyOTData

	ld de, wPlayerTrademon
	ld hl, wLinkPlayerData
	ld c, 2
.loop1:
	ld a, [de]
	inc de
	and a
	jr z, .loop1
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop1
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop1
	cp SERIAL_PATCH_LIST_PART_TERMINATOR
	jr z, .next1
	push hl
	push bc
	ld b, 0
	dec a
	ld c, a
	add hl, bc
	ld a, SERIAL_NO_DATA_BYTE
	ld [hl], a
	pop bc
	pop hl
	jr .loop1

.next1:
	ld hl, wPicrossLayoutBuffer + 1
	dec c
	jr nz, .loop1
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr nz, .skip_mail

	ld hl, wBattle
.loop2
	ld a, [hli]
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr nz, .loop2
.loop3
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop3
	cp SERIAL_MAIL_PREAMBLE_BYTE
	jr z, .loop3
	dec hl

	ld de, wLinkPlayerMail
.loop4
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop4
	ld [de], a
	inc de
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr nz, .loop4
	ld de, wLinkPlayerMail
.loop5:
	ld a, [de]
	inc de
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr z, .okay
	cp $22
	jr nz, .loop5
	dec de
	ld a, SERIAL_NO_DATA_BYTE
	ld [de], a
	inc de
	jr .loop5

.okay:
	dec de
	xor a
	ld [de], a
.skip_mail:
	ld hl, wLinkData
	ld de, wOTPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld de, wOTPartyCount
	ld bc, VBlank.blanks + 3
	call CopyBytes

	ld a, LOW(wOTPartyMonOT)
	ld [wNamesPointer], a
	ld a, HIGH(wOTPartyMonOT)
	ld [wNamesPointer + 1], a

	ld de, MUSIC_NONE
	call PlayMusic
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ld c, 66
	call z, DelayFrames
	ld a, [wLinkMode]
	cp LINK_COLOSSEUM
	jr nz, .ready_to_trade
	ld a, TRAINER_PROTAGONIST 
	ld [wOtherTrainerClass], a
	call ClearTileMap
	call WaitBGMap
	ld hl, wOptions
	res BATTLE_SCENE_F, [hl]
	predef StartBattle
	predef HealParty
	jp ExitLinkCommunications

.ready_to_trade:
	ld de, MUSIC_OAK_INTRO
	call PlayMusic
	jp InitTradeMenuDisplay

ExchangeBytes:
; This is similar to Serial_ExchangeBytes,
; but without a SERIAL_PREAMBLE_BYTE check.
	ld a, $01
	ldh [hSerialIgnoringInitialData], a
.loop:
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, 48
.wait
	dec a
	jr nz, .wait
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	xor a
	ldh [hSerialIgnoringInitialData], a
	jr .loop

.load
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

String_PleaseWait:
	db "つうしんじゅんびちゅう！@"

ClearLinkData:
	ld hl, wLinkData
	ld bc, wLinkDataEnd - wLinkData
.loop
	xor a
	ld [hli], a
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

FixDataForLinkTransfer:
	ld hl, wcdc7
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_RN_PREAMBLE_LENGTH
.preamble_loop
	ld [hli], a
	dec b
	jr nz, .preamble_loop
	ld b, SERIAL_RNS_LENGTH
	ld de, wLinkBattleRNs
.rn_loop
	call Random
	cp SERIAL_PREAMBLE_BYTE
	jr nc, .rn_loop
	ld [hli], a
	ld [de], a
	inc de
	dec b
	jr nz, .rn_loop

	ld hl, wOptionsMenuCursorX
	ld a, SERIAL_PREAMBLE_BYTE
rept SERIAL_PATCH_PREAMBLE_LENGTH
	ld [hli], a
endr
	ld b, SERIAL_PATCH_LIST_LENGTH
	xor a
.clear_loop:
	ld [hli], a
	dec b
	jr nz, .clear_loop

	ld hl, wLinkData + SERIAL_PREAMBLE_LENGTH + PLAYER_NAME_LENGTH + (1 + PARTY_LENGTH + 1) - 1
	ld de, wDayOfWeekBuffer
	lb bc, 0, 0
.patch_loop:
; Check if we've gone over the entire area
	inc c
	ld a, c
	cp SERIAL_PATCH_DATA_SIZE + 1
	jr z, .data1_done

; If we're processing the second patch area, check if we've reached the end
	ld a, b
	dec a
	jr nz, .process
	push bc
	ld a, [wLinkMode]
	cp LINK_TIMECAPSULE
	ld b, REDMON_STRUCT_LENGTH * PARTY_LENGTH - SERIAL_PATCH_DATA_SIZE + 1
	jr z, .got_size
	ld b, PARTYMON_STRUCT_LENGTH * PARTY_LENGTH - SERIAL_PATCH_DATA_SIZE + 1
.got_size
	ld a, c
	cp b
	pop bc
	jr z, .data2_done

.process
; Replace the "no data" byte, and record it in the array
	inc hl
	ld a, [hl]
	cp SERIAL_NO_DATA_BYTE
	jr nz, .patch_loop
	ld a, c
	ld [de], a
	inc de
	ld [hl], SERIAL_PATCH_REPLACEMENT_BYTE
	jr .patch_loop

.data1_done:
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	inc de
	lb bc, 1, 0
	jr .patch_loop

.data2_done:
	ld a, SERIAL_PATCH_LIST_PART_TERMINATOR
	ld [de], a
	ret

Link_PrepPartyData_Gen1:
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_PREAMBLE_LENGTH
.loop1
	ld [de], a
	inc de
	dec b
	jr nz, .loop1

	ld hl, wPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	push de

	ld hl, wPartyCount
	ld a, [hli]
	ld [de], a
	inc de
.loop2
	ld a, [hli]
	cp -1
	jr z, .done_party
	ld [wTempByteValue], a
	push hl
	push de
	callfar ConvertMon_2to1
	pop de
	pop hl
	ld a, [wTempByteValue]
	ld [de], a
	inc de
	jr .loop2

.done_party
	ld [de], a
	pop de
	ld hl, 1 + PARTY_LENGTH + 1
	add hl, de

	ld d, h
	ld e, l
	ld hl, wPartyMon1Species
	ld c, PARTY_LENGTH
.mon_loop
	push bc
	call .ConvertPartyStruct2to1
	ld bc, PARTYMON_STRUCT_LENGTH
	add hl, bc
	pop bc
	dec c
	jr nz, .mon_loop

	ld hl, wPartyMon1OT
	ld bc, PARTY_LENGTH * PLAYER_NAME_LENGTH
	call CopyBytes
	ld hl, wPartyMon1Nickname
	ld bc, PARTY_LENGTH * MON_NAME_LENGTH
	call CopyBytes
	ret

.ConvertPartyStruct2to1:
	ld b, h
	ld c, l
	push de
	push bc
	ld a, [hl]
	ld [wTempByteValue], a
	callfar ConvertMon_2to1
	pop bc
	pop de
	ld a, [wTempByteValue]
	ld [de], a
	inc de
	ld hl, MON_HP
	add hl, bc
	ld a, [hli]
	ld [de], a
	inc de
	ld a, [hl]
	ld [de], a
	inc de
	xor a
	ld [de], a
	inc de
	ld hl, MON_STATUS
	add hl, bc
	ld a, [hl]
	ld [de], a
	inc de

	push bc
	ld a, [bc]
	dec a
	ld hl, BaseData + BASE_TYPES
	ld bc, BASE_DATA_SIZE
	call AddNTimes
	ld bc, BASE_CATCH_RATE - BASE_TYPES
	ld a, BANK(BaseData)
	call FarCopyBytes
	pop bc

	push bc
	ld hl, MON_ITEM
	add hl, bc
	ld bc, MON_HAPPINESS - MON_ITEM
	call CopyBytes
	pop bc
	ld hl, MON_LEVEL
	add hl, bc
	ld a, [hl]
	ld [de], a
	ld [wCurPartyLevel], a
	inc de

	push bc
	ld hl, MON_MAXHP
	add hl, bc
	ld bc, MON_SAT - MON_MAXHP
	call CopyBytes
	pop bc
	push de
	push bc

	ld a, [bc]
	dec a
	push bc
	ld b, $00
	ld c, a
	ld hl, $4CD7
	add hl, bc
	ld a, [hl]
	ld [wMonHBaseSpecialAtt], a
	pop bc

	ld hl, MON_STAT_EXP - 1
	add hl, bc
	ld c, STAT_SATK
	ld b, TRUE
	predef CalcMonStatC

	pop bc
	pop de

	ldh a, [hQuotient + 2]
	ld [de], a
	inc de
	ldh a, [hQuotient + 3]
	ld [de], a
	inc de
	ld h, b
	ld l, c
	ret

Link_PrepPartyData_Gen2:
	ld de, wLinkData
	ld a, SERIAL_PREAMBLE_BYTE
	ld b, SERIAL_PREAMBLE_LENGTH
.preamble_loop:
	ld [de], a
	inc de
	dec b
	jr nz, .preamble_loop

	ld hl, wPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes

	ld hl, wPartyCount
	ld bc, 1 + PARTY_LENGTH + 1
	call CopyBytes

	ld hl, wPartyMon1Species
	ld bc, PARTY_LENGTH * PARTYMON_STRUCT_LENGTH
	call CopyBytes

	ld hl, wPartyMon1OT
	ld bc, PARTY_LENGTH * PLAYER_NAME_LENGTH
	call CopyBytes

	ld hl, wPartyMon1Nickname
	ld bc, PARTY_LENGTH * MON_NAME_LENGTH
	call CopyBytes

; Okay, we did all that.  Now, are we in the trade center?
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ret nz

; Fill 5 bytes at wLinkPlayerMailPreamble with $20
	ld de, wLinkPlayerMail
	ld a, SERIAL_MAIL_PREAMBLE_BYTE
	call Link_CopyMailPreamble

	ld hl, sPartyMail
	ld bc, MAIL_STRUCT_LENGTH * PARTY_LENGTH
	ld a, $02
	call OpenSRAM
	call CopyBytes
	call CloseSRAM

	ld a, MAIL_MSG_LENGTH + 1
	ld [de], a
	ld hl, wLinkPlayerMailMessages
.loop:
	ld a, [hli]
	cp SERIAL_MAIL_REPLACEMENT_BYTE
	jr z, .end
	cp SERIAL_NO_DATA_BYTE
	jr nz, .loop
	dec hl
	ld [hl], $22
	inc hl
	jr .loop

.end:
	ret

Link_CopyMailPreamble:
	ld c, SERIAL_MAIL_PREAMBLE_LENGTH
.loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Link_ConvertPartyStruct1to2:
	push hl
	ld d, h
	ld e, l
	ld bc, wEnemyMoveStructPower
	ld hl, wBattle
	ld a, c
	ld [hli], a
	ld [hl], b
	ld hl, wOTPartyMons
	ld c, $06
.loop
	push bc
	call .ConvertToGen2
	pop bc
	dec c
	jr nz, .loop
	pop hl
	ld bc, $0108
	add hl, bc
	ld de, wOTPartyMon1OT
	ld bc, $0024
	call CopyBytes
	ld de, wOTPartyMon1Nickname
	ld bc, $0024
	call CopyBytes
	ret

.ConvertToGen2:
	ld b, h
	ld c, l
	ld a, [de]
	inc de
	push bc
	push de
	ld [wTempByteValue], a
	callfar ConvertMon_1to2
	pop de
	pop bc
	ld a, [wTempByteValue]
	ld [bc], a
	ld [wCurSpecies], a
	ld hl, MON_HP
	add hl, bc
	ld a, [de]
	inc de
	ld [hli], a
	ld a, [de]
	inc de
	ld [hl], a
	inc de
	ld hl, MON_STATUS
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	ld hl, wBattle
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hli], a
	inc de
	ld a, l
	ld [wBattle], a
	ld a, h
	ld [wEnemyMoveStructEffect], a
	push bc
	ld hl, MON_ITEM
	add hl, bc
	push hl
	ld h, d
	ld l, e
	pop de
	ld bc, $001A
	call CopyBytes
	pop bc
	ld d, h
	ld e, l
	ld hl, $001F
	add hl, bc
	ld a, [de]
	inc de
	ld [hl], a
	ld [wCurPartyLevel], a
	push bc
	ld hl, $0024
	add hl, bc
	push hl
	ld h, d
	ld l, e
	pop de
	ld bc, $0008
	call CopyBytes
	pop bc
	call GetBaseData
	push de
	push bc
	ld d, h
	ld e, l
	ld hl, MON_STAT_EXP - 1
	add hl, bc
	ld c, STAT_SATK
	ld b, TRUE
	predef CalcMonStatC
	pop bc
	pop hl
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hli], a
	push hl
	push bc
	ld hl, MON_STAT_EXP - 1
	add hl, bc
	ld c, STAT_SDEF
	ld b, TRUE
	predef CalcMonStatC
	pop bc
	pop hl
	ldh a, [hQuotient + 2]
	ld [hli], a
	ldh a, [hQuotient + 3]
	ld [hli], a
	push hl
	ld hl, $1b
	add hl, bc
	ld a, $46
	ld [hli], a
	xor a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	pop hl
	inc de
	inc de
	ret

Link_CopyOTData:
.loop
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec bc
	ld a, b
	or c
	jr nz, .loop
	ret

Link_CopyRandomNumbers:
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld hl, wEnemyMon
	call Link_FindFirstNonControlCharacter_AllowZero
	ld de, wLinkBattleRNs
	ld c, 10
.loop:
	ld a, [hli]
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	ld [de], a
	inc de
	dec c
	jr nz, .loop
	ret

Link_FindFirstNonControlCharacter_SkipZero:
.loop
	ld a, [hli]
	and a
	jr z, .loop
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

Link_FindFirstNonControlCharacter_AllowZero:
.loop
	ld a, [hli]
	cp SERIAL_PREAMBLE_BYTE
	jr z, .loop
	cp SERIAL_NO_DATA_BYTE
	jr z, .loop
	dec hl
	ret

InitTradeMenuDisplay:
	call ClearTileMap
	call LoadTradeScreenBorderGFX
	call PlaceTradeScreenTextbox
	call PlaceTradeScreenFooter
	xor a
	ld hl, wOtherPlayerLinkMode
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ld [hl], a
	ld a, $01
	ld [wMenuCursorY], a
	inc a
	ld [wLinkPlayerSyncBuffer], a
	jp LinkTrade_PlayerPartyMenu

LinkTrade_OTPartyMenu:
	ld a, $01
	ld [wMonType], a
	ld a, A_BUTTON | D_LEFT | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wOTPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 3
	ld [w2DMenuCursorInitY], a
	ld a, 12
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	ld a, MENU_UNUSED
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a

LinkTradeOTPartymonMenuLoop:
	call ScrollingMenuJoypad
	and a
	jp z, LinkTradePartiesMenuMasterLoop
	bit A_BUTTON_F, a
	jr z, .not_a_button
	ld a, $01
	ld [wce34], a
	callfar Function50c48
	ld hl, wOTPartyMons
	call LinkMonStatsScreen
	jp LinkTradePartiesMenuMasterLoop

.not_a_button:
	bit D_LEFT_F, a
	jr z, .not_d_left
	xor a
	ld [wMonType], a
	call HideCursor
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wPartyCount]
	cp b
	jr nc, LinkTrade_PlayerPartyMenu
	ld [wMenuCursorY], a
	jr LinkTrade_PlayerPartyMenu

.not_d_left:
	bit D_DOWN_F, a
	jp z, LinkTradePartiesMenuMasterLoop
	jp LinkTradeOTPartymonMenuCheckCancel

LinkTrade_PlayerPartyMenu:
	xor a
	ld [wMonType], a
	ld a, A_BUTTON | D_RIGHT | D_DOWN
	ld [wMenuJoypadFilter], a
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 3
	ld [w2DMenuCursorInitY], a
	ld a, 2
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	ld a, MENU_UNUSED
	ld [w2DMenuFlags1], a
	xor a
	ld [w2DMenuFlags2], a
LinkTradePartymonMenuLoop:
	call ScrollingMenuJoypad
	and a
	jr nz, .check_joypad
	jp LinkTradePartiesMenuMasterLoop

.check_joypad:
	bit A_BUTTON_F, a
	jr z, .not_a_button
	jp LinkTrade_TradeStatsMenu

.unreferenced:	
		ld a, $04
		ld [wce34], a
		callfar Function50c48
		call LinkMonStatsScreen
		jp LinkTradePartiesMenuMasterLoop

.not_a_button:
	bit D_RIGHT_F, a
	jr z, .not_d_right
	ld a, $01
	ld [wMonType], a
	call HideCursor
	ld a, [wMenuCursorY]
	ld b, a
	ld a, [wOTPartyCount]
	cp b
	jr nc, .cursor_ok
	ld [wMenuCursorY], a
.cursor_ok:
	jp LinkTrade_OTPartyMenu

.not_d_right:
	bit D_DOWN_F, a
	jr z, LinkTradePartiesMenuMasterLoop
	jp LinkTradeOTPartymonMenuCheckCancel

LinkTradePartiesMenuMasterLoop:
	ld a, [wMonType]
	and a
	jp z, LinkTradePartymonMenuLoop
	jp LinkTradeOTPartymonMenuLoop

LinkTrade_TradeStatsMenu:
	call BackUpTilesToBuffer
	call PlaceHollowCursor
	ld a, [wMenuCursorY]
	push af
	hlcoord 0, 14
	ld b, 2
	ld c, 18
	call LinkTextboxAtHL
	hlcoord 2, 16
	ld de, .String_Stats_Trade
	call PlaceString

.joy_loop:
	ld a, $7F
	ld [$C3eb], a
	ld a, $13
	ld [wMenuJoypadFilter], a
	ld a, $01
	ld [w2DMenuNumRows], a
	ld a, $01
	ld [w2DMenuNumCols], a
	ld a, $10
	ld [w2DMenuCursorInitY], a
	ld a, $01
	ld [w2DMenuCursorInitX], a
	ld a, $01
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call ScrollingMenuJoypad
	bit 4, a
	jr nz, .d_right
	bit 1, a
	jr z, .show_stats
.b_button:
	pop af
	ld [wMenuCursorY], a
	call ReloadTilesFromBuffer
	jp LinkTrade_PlayerPartyMenu

.d_right:
	ld a, '　'
	ldcoord_a 1, 16
	ld a, A_BUTTON | B_BUTTON | D_LEFT
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [w2DMenuNumRows], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 16
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	ln a, 2, 0
	ld [w2DMenuCursorOffsets], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	call ScrollingMenuJoypad
	bit D_LEFT_F, a
	jp nz, .joy_loop
	bit B_BUTTON_F, a
	jr nz, .b_button
	jr .try_trade

.show_stats:
	pop af
	ld [wMenuCursorY], a
	ld a, 4
	ld [wce34], a
	callfar Function50c48
	call LinkMonStatsScreen
	call ReloadTilesFromBuffer
	jp LinkTrade_PlayerPartyMenu

.try_trade
	call PlaceHollowCursor
	pop af
	ld [wMenuCursorY], a
	dec a
	ld [wBattleMenuRows], a
	ld [wLinkPlayerSyncBuffer], a
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wLinkReceivedSyncBuffer]
	cp $f
	jp z, InitTradeMenuDisplay
	ld [wBattleMenuColumns], a
	call LinkTradePlaceArrow
	ld c, 100
	call DelayFrames
	call ValidateOTTrademon
	jp c, LinkTrade
	xor a
	ld [wLinkPlayerSyncBuffer + 1], a
	ld [wBattleAction], a
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	ld [wTempByteValue], a
	call GetPokemonName
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call LinkTextboxAtHL
	ld hl, LinkAbnormalMonText
	bccoord 1, 14
	call TextCommandProcessor
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	call PlaceString
	ld a, $01
	ld [wLinkPlayerSyncBuffer], a
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

.String_Stats_Trade:
	db "ステイタスをみる　　こうかんにだす@"

LinkAbnormalMonText:
	text "あいてがわが　えらんだ　@" 
	text_from_ram wStringBuffer1
	text "の"
	line "データが　こわれているようです！！"
	prompt

LinkTradeOTPartymonMenuCheckCancel:
	ld a, [wMenuCursorY]
	cp 1
	jp nz, LinkTradePartiesMenuMasterLoop
	call HideCursor
.loop1
	ld a, '▶'
	ldcoord_a 1, 16
.loop2
	call GetJoypadDebounced
	ldh a, [hJoySum]
	and a
	jr z, .loop2
	bit A_BUTTON_F, a
	jr nz, .a_button
	bit D_UP_F, a
	jr z, .loop2
	ld a, '　'
	ldcoord_a 1, 16
	ld a, [wPartyCount]
	ld [wMenuCursorY], a
	jp LinkTrade_PlayerPartyMenu

.a_button
	ld a, '▷'
	ldcoord_a 1, 16
	ld a, $f
	ld [wPlayerLinkAction], a
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	cp $f
	jr nz, .loop1
ExitLinkCommunications:
	call ClearBGPalettes
	xor a
	ld [wd4a7 + 1], a
	ld a, $F8
	ldh [hMapEntryMethod], a
	call LoadMap
	call GBFadeInFromWhite
	ret

PlaceTradeScreenFooter:
; Fill the screen footer with pattern tile
	hlcoord 11, 15
	ld a, $7e
	ld bc, 2 * SCREEN_WIDTH + 9
	call ByteFill
; Place the cancel string
	hlcoord 0, 15
	ld b, 1
	ld c, 9
	call LinkTextboxAtHL
	hlcoord 2, 16
	ld de, .CancelString
	jp PlaceString

; Data from 28903 to 2890B (9 bytes)
.CancelString:
	db "こうかんちゅうし@"

LinkTradePlaceArrow:
; Indicates which pokemon the other player has selected to trade
	ld a, [wOtherPlayerLinkMode]
	hlcoord 12, 3
	ld bc, 2 * SCREEN_WIDTH
	call AddNTimes
	ld [hl], '▷'
	ret

LinkMonStatsScreen:
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	call LowVolume
	predef StatsScreenMain
	call ClearTileMap
	call MaxVolume
	call SetPalettes
	call LoadTradeScreenBorderGFX
	call PlaceTradeScreenTextbox
	jp PlaceTradeScreenFooter

ValidateOTTrademon:
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartyMons
	ld bc, $0030
	call AddNTimes
	push hl
	ld a, [wBattleMenuColumns]
	inc a
	ld c, a
	ld b, $00
	ld hl, wOTPartyCount
	add hl, bc
	ld a, [hl]
	pop hl
	cp [hl]
	jr nz, .Function28990
	ld b, h
	ld c, l
	ld hl, $001F
	add hl, bc
	ld a, [hl]
	cp $65
	jr nc, .Function28990
	ld a, [wLinkMode]
	cp $01
	jr nz, .Function2898E
	ld hl, wOTPartySpecies
	ld a, [wBattleMenuColumns]
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld hl, wEnemyMoveStructPower
	add hl, bc
	add hl, bc
	ld a, [wMonHType1]
	cp [hl]
	jr nz, .Function28990
	inc hl
	ld a, [wMonHType2]
	cp [hl]
	jr nz, .Function28990
.Function2898E:
	scf
	ret

.Function28990:
	and a
	ret

PlaceTradeScreenTextbox:
	hlcoord 0, 1
	ld b, $0C
	ld c, $08
	call LinkTextboxAtHL
	hlcoord 10, 1
	ld b, $0C
	ld c, $08
	call LinkTextboxAtHL
	hlcoord 3, 1
	ld de, wPlayerName
	call PlaceString
	hlcoord 13, 1
	ld de, wOTPlayerName
	call PlaceString
	hlcoord 3, 3
	ld de, wPartySpecies
	call .Function289C7
	hlcoord 13, 3
	ld de, wOTPartySpecies
.Function289C7:
	ld c, $00
.Function289C9:
	ld a, [de]
	cp -1
	ret z
	ld [wTempByteValue], a
	push bc
	push hl
	push de
	push hl
	ld a, c
	ldh [hDividend], a
	call GetPokemonName
	pop hl
	call PlaceString
	pop de
	inc de
	pop hl
	ld bc, 2 * SCREEN_WIDTH
	add hl, bc
	pop bc
	inc c
	jr .Function289C9

LinkTrade:
	xor a
	ld [wLinkPlayerSyncBuffer + 1], a
	ld [wBattleAction], a
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call LinkTextboxAtHL
	ld a, [wBattleMenuRows]
	ld hl, wPartySpecies
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	ld [wTempByteValue], a
	call GetPokemonName
	ld hl, wStringBuffer1
	ld de, wMovementBufferPointerBank
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartySpecies
	ld c, a
	ld b, $00
	add hl, bc
	ld a, [hl]
	ld [wTempByteValue], a
	call GetPokemonName
	ld hl, LinkAskTradeForText
	bccoord 1, 14
	call TextCommandProcessor
	call BackUpTilesToBuffer
	hlcoord 10, 7
	ld b, $03
	ld c, $05
	call LinkTextboxAtHL
	ld de, String_TradeCancel
	hlcoord 12, 8
	call PlaceString
	ld a, 8
	ld [w2DMenuCursorInitY], a
	ld a, 11
	ld [w2DMenuCursorInitX], a
	ld a, 1
	ld [w2DMenuNumCols], a
	ld a, 2
	ld [w2DMenuNumRows], a
	xor a
	ld [w2DMenuFlags1], a
	ld [w2DMenuFlags2], a
	ld a, $20
	ld [w2DMenuCursorOffsets], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ld a, 1
	ld [wMenuCursorY], a
	ld [wMenuCursorX], a
	call ScrollingMenuJoypad
	push af
	call ReloadTilesFromBuffer
	pop af
	bit B_BUTTON_F, a
	jr nz, .canceled
	ld a, [wMenuCursorY]
	dec a
	jr z, .try_trade

.canceled:
	ld a, $01
	ld [wPlayerLinkAction], a
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	call PlaceString
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	jp InitTradeMenuDisplay_Delay

.try_trade:
	ld a, $02
	ld [wPlayerLinkAction], a
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	ld a, [wOtherPlayerLinkMode]
	dec a
	jr nz, .do_trade
	hlcoord 0, 12
	ld b, 4
	ld c, 18
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TooBadTheTradeWasCanceled
	call PlaceString
	jp InitTradeMenuDisplay_Delay

.do_trade:
	ld hl, sPartyMail
	ld a, [wBattleMenuRows]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	ld a, $02
	call OpenSRAM
	ld d, h
	ld e, l
	ld bc, MAIL_STRUCT_LENGTH
	add hl, bc
	ld a, [wBattleMenuRows]
	ld c, a
.copy_mail
	inc c
	ld a, c
	cp PARTY_LENGTH
	jr z, .copy_player_data
	push bc
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	pop bc
	jr .copy_mail

.copy_player_data
	ld hl, sPartyMail
	ld a, [wPartyCount]
	dec a
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	push hl
	ld hl, wLinkPlayerMail
	ld a, [wBattleMenuColumns]
	ld bc, MAIL_STRUCT_LENGTH
	call AddNTimes
	pop de
	ld bc, MAIL_STRUCT_LENGTH
	call CopyBytes
	call CloseSRAM
	ld hl, wPlayerName
	ld de, wPlayerTrademonSenderName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wBattleMenuRows]
	ld hl, wPartySpecies
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wPlayerTrademon], a
	ld a, [wBattleMenuRows]
	ld hl, wPartyMon1OT
	call SkipNames
	ld de, wPlayerTrademonOTName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld hl, wPartyMon1ID
	ld a, [wBattleMenuRows]
	ld bc, $0030
	call AddNTimes
	ld a, [hli]
	ld [wPlayerTrademonID], a
	ld a, [hl]
	ld [wPlayerTrademonID + 1], a
	ld hl, wOTPlayerName
	ld de, wOTTrademonSenderName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartySpecies
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wOTTrademon], a
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartyMon1OT
	call SkipNames
	ld de, wOTTrademonOTName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	ld hl, wOTPartyMon1ID
	ld a, [wBattleMenuColumns]
	ld bc, $0030
	call AddNTimes
	ld a, [hli]
	ld [wOTTrademonID], a
	ld a, [hl]
	ld [wPokerTurnNumber], a
	ld a, [wBattleMenuRows]
	ld [wCurPartyMon], a
	ld hl, wPartySpecies
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wBattleMenuRows], a
	xor a
	ld [wPokemonWithdrawDepositParameter], a
	callfar RemoveMonFromPartyOrBox
	ld a, [wBattleMenuColumns]
	ld c, a
	ld [wCurPartyMon], a
	ld hl, wOTPartySpecies
	ld d, $00
	ld e, a
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	ld hl, wOTPartyMons
	ld a, c
	ld bc, $0030
	call AddNTimes
	ld de, wTempMon
	ld bc, $0030
	call CopyBytes
	predef AddTempmonToParty
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld a, $01
	ld [wForceEvolution], a
	ld a, [wBattleMenuColumns]
	ld hl, wOTPartySpecies
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wBattleMenuColumns], a
	ld c, 100
	call DelayFrames
	call ClearTileMap
	call LoadFontsBattleExtra
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .player_2
	predef TradeAnimation
	jr .finished_trade

.player_2
	predef TradeAnimationPlayer2
.finished_trade
	callfar EvolvePokemon
	call ClearTileMap
	call LoadTradeScreenBorderGFX
	call Serial_PrintWaitingTextAndSyncAndExchangeNybble
	ld c, $28
	call DelayFrames
	hlcoord 0, 12
	ld b, $04
	ld c, $12
	call LinkTextboxAtHL
	hlcoord 1, 14
	ld de, String_TradeCompleted
	call PlaceString
	ld a, $45
	call Predef
	ld c, $32
	call DelayFrames
	jp Gen2ToGen1LinkComms

InitTradeMenuDisplay_Delay:
	ld c, 100
	call DelayFrames
	jp InitTradeMenuDisplay

String_TradeCancel:
	db   "こうかん"
	next "やめる@"

LinkAskTradeForText:
	text_from_ram wTrainerHUDTiles
	text "　と　@"
	text_from_ram wStringBuffer1
	text "　を"
	line "こうかんします"
	done

String_TradeCompleted:
	db   "こうかんしゅうりょう！@"

String_TooBadTheTradeWasCanceled:
	db   "ざんねんながら"
	next "こうかんは　キャンセルされました@"

LinkTextboxAtHL:
	push hl
	ld a, $78
	ld [hli], a
	inc a
	call .PlaceRow
	inc a
	ld [hl], a
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
.loop
	push hl
	ld a, $7b
	ld [hli], a
	ld a, '　'
	call .PlaceRow
	ld [hl], $77
	pop hl
	ld de, SCREEN_WIDTH
	add hl, de
	dec b
	jr nz, .loop

	ld a, $7c
	ld [hli], a
	ld a, $76
	call .PlaceRow
	ld [hl], $7d
	ret

.PlaceRow
	ld d, c
.row_loop
	ld [hli], a
	dec d
	jr nz, .row_loop
	ret

LoadTradeScreenBorderGFX:
	ld de, LinkCommsBorderGFX
	ld hl, vChars2 tile $76
	lb bc, BANK(LinkCommsBorderGFX), 9
	jp Request2bpp

UnreferencedData28CD7:
	db $41, $50, $64, $32, $41, $55, $32, $41, $55, $14, $19, $50, $14, $19, $2D, $23
	db $32, $46, $19, $32, $1F, $3D, $28, $41, $32, $5A, $1E, $37, $28, $37, $4B, $28
	db $37, $4B, $3C, $55, $41, $64, $19, $32, $28, $4B, $4B, $55, $64, $37, $50, $28
	db $5A, $2D, $46, $28, $41, $32, $50, $23, $3C, $32, $50, $28, $32, $46, $69, $78
	db $87, $23, $32, $41, $46, $55, $64, $64, $78, $1E, $2D, $37, $41, $50, $28, $50
	db $5F, $78, $3A, $23, $3C, $46, $5F, $28, $41, $2D, $55, $64, $73, $82, $1E, $5A
	db $73, $19, $32, $37, $50, $3C, $7D, $28, $32, $23, $23, $3C, $3C, $55, $1E, $2D
	db $69, $64, $28, $46, $5F, $32, $50, $46, $64, $64, $37, $5F, $55, $55, $37, $46
	db $14, $64, $5F, $30, $41, $6E, $6E, $6E, $4B, $5A, $73, $2D, $46, $3C, $41, $7D
	db $7D, $7D, $32, $46, $64, $9A, $64
