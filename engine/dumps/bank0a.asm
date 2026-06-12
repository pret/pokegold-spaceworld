INCLUDE "constants.asm"

SECTION "engine/dumps/bank0a.asm", ROMX

SECTION "engine/dumps/bank0a.asm@CheckTimeCapsuleCompatibility", ROMX
UnknownData299D1:
	db $15, $04, $05, $E3, $59, $DE, $59, $DD, $59, $00, $E3, $59, $C9, $E0, $59, $00, $E7, $57, $16, $16,
	db $16, $16, $16, $17, $18, $22, $1A, $17, $17, $1C, $21, $1E, $17, $17, $1F, $1B, $20, $17, $15, $04,
	db $05, $0B, $5A, $06, $5A, $03, $5A, $00, $0B, $5A, $C3, $DD, $59, $08, $5A, $00, $E7, $57, $16, $16,
	db $16, $16, $16, $17, $18, $19, $1A, $17, $17, $1C, $1D, $1E, $17, $17, $1F, $1B, $20, $17

CheckTimeCapsuleCompatibility:
	ld hl, wPartySpecies
	ld b, PARTY_LENGTH
.loop:
	ldi a, [hl]
	cp -1
	jr z, .checkitem
	cp NUM_KANTO_POKEMON + 1
	jr nc, .mon_too_new
	dec b
	jr nz, .loop
.checkitem:
	ld hl, wPartyMon1Moves
	ld a, [wPartyCount]
	ld b, a
.move_loop:
	ld c, NUM_MOVES
.move_next:
	ld a, [hli]
	cp MOVE_STRUGGLE + 1
	jr nc, .move_too_new
	dec c
	jr nz, .move_next
	ld de, PARTYMON_STRUCT_LENGTH - NUM_MOVES
	add hl, de
	dec b
	jr nz, .move_loop
	ld hl, .ComeOnInText
	call OpenTextbox
	and a
	ret

.mon_too_new:
	ld [wTempSpecies], a
	call GetPokemonName
	ld hl, .mon_too_new_Text
	call OpenTextbox
	scf
	ret

.move_too_new:
	push bc
	ld [wMoveGrammar], a
	call GetMoveName
	call CopyStringToStringBuffer2
	pop bc
	ld a, [wPartyCount]
	sub b
	ld c, a
	inc c
	ld b, $00
	ld hl, wPartyCount
	add hl, bc
	ld a, [hl]
	ld [wTempSpecies], a
	call GetPokemonName
	ld hl, .move_too_new_Text
	call OpenTextbox
	scf
	ret

.ComeOnInText:
	text "それでは　なかへ　どうぞ"
	done

.mon_too_new_Text:
	text_from_ram wStringBuffer1
	text "は"
	line "つれていけません！"
	done

.move_too_new_Text:
	text_from_ram wStringBuffer2
	text "を　もっている"
	line "@"

.mon_too_new_Text2:
	text_from_ram wStringBuffer1
	text "は　つれていけません！"
	done

Link_Receptionist_Intro:
	ld a, $02
	ldh [hVBlank], a
	ld hl, CableClubWelcomeText
	call OpenTextbox
	jr .no_link_action

.connecting:
	ld c, 60
	call DelayFrames
	ld hl, CableClubConnectingText
	call OpenTextbox
	jp Function29BAE

.no_link_action:
	ld a, 90
	ld [wLinkTimeoutFrames], a
.loop:
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, CableClubCheckInPrompt
	cp USING_EXTERNAL_CLOCK
	jr z, CableClubCheckInPrompt
	ld a, CONNECTION_NOT_ESTABLISHED
	ldh [hSerialConnectionStatus], a
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ld a, $80
	ldh [rSC], a
	ld a, [wLinkTimeoutFrames]
	dec a
	ld [wLinkTimeoutFrames], a
	jp z, Function29B9D
	ld a, $01
	ldh [rSB], a
	ld a, $81
	ldh [rSC], a
	call DelayFrame
	jr .loop

CableClubCheckInPrompt:
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	ld c, 50
	call DelayFrames
	ld hl, CableClubCheckInText
	call OpenTextbox
	call YesNoBox
	jr c, Function29BA5
	ld a, [wTempByteValue]
	push af
	ld hl, wSaveFileFlags
	set SAVED_FILE_F, [hl]
	ld hl, wDebugFlags
	set SAVE_FILE_EXISTS_F, [hl]
	callfar SaveOptionsAndGameData
	callfar SavePokemonData
	callfar Dummy_SaveBox
	ld c, $20
	call DelayFrames
	ld de, SFX_SAVE
	call WaitPlaySFX
	call WaitSFX
	ld c, 30
	call DelayFrames
	pop af
	ld [wTempByteValue], a
	ld hl, $5C3B
	call OpenTextbox
	ld hl, wLinkTimeoutFrames
	ld a, $03
	ld [hli], a
	xor a
	ld [hl], a
	ldh [hSerialReceivedNewData], a
	ld a, $01
	ld [wLinkPlayerSyncBuffer], a
	call WaitLinkTransfer
	ld hl, wLinkTimeoutFrames
	ldi a, [hl]
	inc a
	jr nz, Handle_Link_Receptionist
	ld a, [hl]
	inc a
	jr nz, Handle_Link_Receptionist
	ld b, $0A

CableClubCheckLinkFailure:
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, CableClubCheckLinkFailure
	call CloseLink
	ld hl, CableClubLinkFailureText
	call OpenTextbox
	jr Function29BAE

Function29B9D:
	ld hl, Text_LinkInstructions
	call OpenTextbox
	jr Function29BAE

Function29BA5:
	call CloseLink
	ld hl, CableClubExitText
	call OpenTextbox
	
Function29BAE:
	xor a
	ld hl, wLinkTimeoutFrames
	ld [hli], a
	ld [hl], a
	xor a
	ldh [hVBlank], a
	ret

Handle_Link_Receptionist:
	xor a
	ld [hld], a
	ld [hl], a
	call Link_Receptionist
	ret

Text_LinkInstructions:
	text "こちらは　ともだちと"
	line "つうしんケーブルを　つないだ"
	para "かたがたを　とくべつに！"
	line "ごあんない　いたして　おります"
	prompt

CableClubWelcomeText:
	text "つうしん　ケーブル　クラブに"
	line "ようこそ！@"
	db	"ザザザ@" 

CableClubCheckInText:
	text "うけつけは　こちらです"
	para "つうしんを　はじめるまえに"
	line "レポートを　かきます@"
	db	"ザザザ@"

CableClubWaitText:
	text "しょうしょう　おまち　ください@"
	db	"ザザザ@"

CableClubLinkFailureText:
	text "まち　じかんが　ながいので"
	line "うけつけを　ちゅうし　いたします！"
	para "ともだちと　れんらくを　とって"
	line "もういちど　おこし　ください！"
	prompt

CableClubExitText:
	text "それでは　また　おこしください"
	prompt

CableClubConnectingText:
	text "こちらは　ただいま"
	line "じゅんびちゅうです"
	prompt

CloseLink:
	ld c, $03
	call DelayFrames
	ld a, -1
	ldh [hSerialConnectionStatus], a
	ld a, $02
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ld a, $80
	ldh [rSC], a
	ret

LinkCommsBorderGFX:
INCBIN "gfx/trade/border_tiles.2bpp"

Link_Receptionist:
	ld a, [wTempByteValue]
	cp $01
	jp nc, .ChangeRoom
	ld a, [wLinkReceivedSyncBuffer]
	and a
	jp nz, .IncompatibleRoom
	xor a
	ld [wTextboxFlags], a
	ld hl, Text_Receptionist_Empty
	call OpenTextbox
	ld a, $04
	call .EnsureSync
	ld c, 40
	call DelayFrames
	ld hl, Text_Receptionist_PleaseComeInDuplicate
	call OpenTextbox
	ld c, 50
	call DelayFrames
	ld hl, wDebugFlags
	res 1, [hl]
	jr .Function29DB3

.UnreferencedBrokenReturnToOverworld:
	ld c, 20
	call DelayFrames
	xor a
	ld [wLinkPlayerSyncBuffer], a
	inc a
	ld [wLinkMode], a
	ld [wLinkTimeoutFrames], a
	jp OverworldStart	; BUG: Should be a jpfar, instead it jumps to the middle of TradeGameBoyGFX and causes an RST $38 crash.

.UnreferencedCommunicationCancelled:
	ld c, $03
	call DelayFrames
	call CloseLink
	ld hl, Text_Receptionist_CommunicationCancelled
	call OpenTextbox
	ret

.Function29DB3:
	ld a, $01
	ld [wLinkMode], a	; wLinkMode = $CDBD
	ld c, LINK_COLOSSEUM
	call DelayFrames
	ld hl, Text_Receptionist_TemporaryStagingInLinkRoom
	call OpenTextbox
	ld c, 80
	call DelayFrames
	callfar Function28000
	ret

.ChangeRoom:
	ld a, [wLinkReceivedSyncBuffer]
	and a
	jr z, .FailedLinkToPast
	ld a, [wTempByteValue]
	call .EnsureSync
	push af
	call LinkDataReceived
	call DelayFrame
	call LinkDataReceived
	pop af
	ld b, a
	ld a, [wTempByteValue]
	cp b
	jr nz, .IncompatibleRoom_Textbox
	ld a, [wTempByteValue]
	inc a
	ld [wLinkMode], a	; wLinkMode = $CDBD
	ld hl, Text_Receptionist_PleaseComeIn
	call OpenTextbox
	ld a, [wLinkMode]	; wLinkMode = $CDBD
	cp LINK_TRADECENTER
	ld a, LINK_TRADECENTER
	jr z, .remove_receptionist
	ld a, LINK_COLOSSEUM
.remove_receptionist:
	call DeleteMapObject
	ret

.UnreferencedFunction29E0B:
	ld [bc], a
	ld a, [bc]
	inc de
	ld e, [hl]
	inc bc
	ld a, [bc]
	inc de
	ld e, [hl]
	rlca
	ld [hld], a
.IncompatibleRoom:
	ld a, $0E
	call .EnsureSync
.IncompatibleRoom_Textbox:
	ld hl, Text_Receptionist_IncompatibleRooms
	call OpenTextbox
	jr .Function29E35

.FailedLinkToPast:
	ld c, $14
	call DelayFrames
	ld a, $0E
	call .EnsureSync
	ld hl, Text_Receptionist_CantLinkToThePast
	call PrintText
	call OpenTextbox
.Function29E35:
	ld c, $03
	call DelayFrames
	call CloseLink
	ret

.EnsureSync:
	add $D0
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a	; wLinkPlayerSyncBuffer + 1 = $CB52
.receive_loop:
	call Serial_ExchangeLinkMenuSelection
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	and $F0
	cp $D0
	jr z, .done
	ld a, [wBattleAction]	; wBattleAction = $CB4D
	ld b, a
	and $F0
	cp $D0
	jr nz, .receive_loop
.done:
	ld a, b
	and $0F
	ret

Text_Receptionist_PleaseComeInDuplicate:
	text "それでは　これより"
	line "ごあんない　いたします"
	prompt
Text_Receptionist_CommunicationCancelled:
	text "つうしんは　キャンセル　されました"
	prompt
Text_Receptionist_TemporaryStagingInLinkRoom:
	text "とりあえず　つうしんべやに"
	line "いったことに　します"
	done
Text_Receptionist_CantLinkToThePast:
	text "こちらでは　１との"
	line "つうしんは　できません"
	prompt
Text_Receptionist_IncompatibleRooms:
	text "おともだちと　えらんだ　へやが"
	line "ちがうようです"
	prompt
Text_Receptionist_PleaseComeIn:
	text "それでは　へやへ"
	line "どうぞ"
	prompt
Text_Receptionist_Options:
	db "トレードセンター"
	next "コロシアム"
	next "やめる@"
Text_Receptionist_Empty:
	db "@"

UnreferencedFunction29ef7:
	add b
	add $C0
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a	; wLinkPlayerSyncBuffer + 1 = $CB52
	call Serial_ExchangeLinkMenuSelection
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ret z
	ld a, [wReservedObjectStepDuration]	; wReservedObjectStepDuration = $CE88
	cp $0C
	ret nz
	ld a, [wMapId]	; wMapId = $D657
	ld a, $02
	jr z, .Function29F1A
	inc a
.Function29F1A:
	ld [wLinkMode], a	; wLinkMode = $CDBD
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld a, [wReservedObjectStepDuration]	; wReservedObjectStepDuration = $CE88
	cp $08
	ret nz
	ld a, [wMapId]	; wMapId = $D657
	ld a, $02
	jr z, .Function29F30
	inc a
.Function29F30:
	ld [wLinkMode], a	; wLinkMode = $CDBD
	; incomplete

Text_Link_WaitUnreferenced:
	text "ちょっと　まってね"
	done
