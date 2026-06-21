INCLUDE "constants.asm"

SECTION "engine/link/link_2.asm", ROMX

CheckTimeCapsuleCompatibility:
	ld hl, wPartySpecies
	ld b, PARTY_LENGTH
.loop:
	ld a, [hli]
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
	jp LinkTimeout

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
	jp z, ShowLinkInstructions
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
	jr c, ExitCableClub
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
	ld hl, CableClubWaitText
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
	ld a, [hli]
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
	jr LinkTimeout

ShowLinkInstructions:
	ld hl, Text_LinkInstructions
	call OpenTextbox
	jr LinkTimeout

ExitCableClub:
	call CloseLink
	ld hl, CableClubExitText
	call OpenTextbox

LinkTimeout:
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
	res DEBUG_FIELD_F, [hl]
	jr .StartTimeCapsule

.UnreferencedBrokenReturnToOverworld:
	ld c, 20
	call DelayFrames
	xor a
	ld [wLinkPlayerSyncBuffer], a
	inc a
	ld [wLinkMode], a
	ld [wLinkTimeoutFrames], a
	jp OverworldStart ; BUG: Should be a jpfar, instead it jumps to the middle of TradeGameBoyGFX and causes an RST $38 crash.

.UnreferencedCommunicationCancelled:
	ld c, $03
	call DelayFrames
	call CloseLink
	ld hl, Text_Receptionist_CommunicationCancelled
	call OpenTextbox
	ret

.StartTimeCapsule:
	ld a, LINK_TIMECAPSULE
	ld [wLinkMode], a
	ld c, 3
	call DelayFrames
	ld hl, Text_Receptionist_TemporaryStagingInLinkRoom
	call OpenTextbox
	ld c, 80
	call DelayFrames
	callfar StartLinkCommunications
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
	ld [wLinkMode], a
	ld hl, Text_Receptionist_PleaseComeIn
	call OpenTextbox
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	ld a, LINK_TRADECENTER
	jr z, .remove_receptionist
	ld a, LINK_COLOSSEUM
.remove_receptionist:
	call DeleteMapObject
	ret

.UnreferencedIncompatibleRoom:
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
	jr .CloseLink

.FailedLinkToPast:
	ld c, $14
	call DelayFrames
	ld a, $0E
	call .EnsureSync
	ld hl, Text_Receptionist_CantLinkToThePast
	call PrintText
	call OpenTextbox
.CloseLink:
	ld c, $03
	call DelayFrames
	call CloseLink
	ret

.EnsureSync:
	add $D0
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a
.receive_loop:
	call Serial_ExchangeLinkMenuSelection
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	and $F0
	cp $D0
	jr z, .done
	ld a, [wOtherPlayerLinkAction]
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

Link_Receptionist_Old:
	add b
	add $C0
	ld [wLinkPlayerSyncBuffer], a
	ld [wLinkPlayerSyncBuffer + 1], a
	call Serial_ExchangeLinkMenuSelection
	ld a, [wLinkReceivedSyncBuffer]
	ld b, a
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	ret z
	ld a, [wReservedObjectStepDuration]
	cp movement_big_step
	ret nz
	ld a, [wMapId]
	ld a, LINK_TRADECENTER
	jr z, .next
	inc a
.next:
	ld [wLinkMode], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret z
	ld a, [wReservedObjectStepDuration]
	cp movement_step
	ret nz
	ld a, [wMapId]
	ld a, LINK_TRADECENTER
	jr z, .end
	inc a
.end:
	ld [wLinkMode], a
	; incomplete

Text_Receptionist_Old_Wait:
	text "ちょっと　まってね"
	done
