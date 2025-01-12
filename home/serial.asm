INCLUDE "constants.asm"

SECTION "home/serial.asm", ROM0

Serial::
	push af
	push bc
	push de
	push hl
	ldh a, [hLinkPlayerNumber]
	inc a
	jr z, .init_player_number

	ldh a, [rSB]
	ldh [hSerialReceive], a
	ldh a, [hSerialSend]
	ldh [rSB], a
	ldh a, [hLinkPlayerNumber]
	cp USING_INTERNAL_CLOCK
	jr z, .done
	ld a, 1 << rSC_ON
	ldh [rSC], a
	jr .done

.init_player_number
	ldh a, [rSB]
	ldh [hSerialReceive], a
	ldh [hLinkPlayerNumber], a
	cp USING_INTERNAL_CLOCK
	jr z, .master
	xor a
	ldh [rSB], a
	ld a, 3
	ldh [rDIV], a
.wait
	ldh a, [rDIV]
	bit 7, a
	jr nz, .wait
	ld a, 1 << rSC_ON
	ldh [rSC], a
	jr .done
.master
	xor a
	ldh [rSB], a
.done
	ld a, TRUE
	ldh [hSerialReceived], a
	ld a, SERIAL_NO_DATA_BYTE
	ldh [hSerialSend], a
	pop hl
	pop de
	pop bc
	pop af
	reti

Serial_ExchangeBytes::
	ld a, $1
	ldh [hSerialIgnoringInitialData], a
.loop
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	push bc
	ld b, a
	inc hl
	ld a, $30
.wait
	dec a
	jr nz, .wait
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, b
	pop bc
	jr z, .load
	dec hl
	cp SERIAL_PREAMBLE_BYTE
	jr nz, .loop
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

Serial_ExchangeByte::
.loop
	xor a
	ldh [hSerialReceived], a
	ldh a, [hLinkPlayerNumber]
	cp USING_INTERNAL_CLOCK
	jr nz, .not_player_2
	ld a, (1 << rSC_ON) | 1
	ldh [rSC], a
.not_player_2
.loop2
	ldh a, [hSerialReceived]
	and a
	jr nz, .reset_ffca
	ldh a, [hLinkPlayerNumber]
	cp $1
	jr nz, .not_player_1_or_wLinkTimeoutFrames_zero
	call CheckwLinkTimeoutFramesNonzero
	jr z, .not_player_1_or_wLinkTimeoutFrames_zero
	call .delay_15_cycles
	push hl
	ld hl, wLinkTimeoutFrames + 1
	inc [hl]
	jr nz, .no_rollover_up
	dec hl
	inc [hl]

.no_rollover_up
	pop hl
	call CheckwLinkTimeoutFramesNonzero
	jr nz, .loop2
	jp SerialDisconnected

.not_player_1_or_wLinkTimeoutFrames_zero
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp 1 << SERIAL
	jr nz, .loop2
	ld a, [wcb58]
	dec a
	ld [wcb58], a
	jr nz, .loop2
	ld a, [wcb58 + 1]
	dec a
	ld [wcb58 + 1], a
	jr nz, .loop2
	ldh a, [hLinkPlayerNumber]
	cp USING_EXTERNAL_CLOCK
	jr z, .reset_ffca

	ld a, 255
.delay_255_cycles
	dec a
	jr nz, .delay_255_cycles

.reset_ffca
	xor a
	ldh [hSerialReceived], a
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	sub 1 << SERIAL
	jr nz, .rIE_not_equal_8

	; LOW($5000)
	ld [wcb58], a
	ld a, HIGH($5000)
	ld [wcb58 + 1], a

.rIE_not_equal_8
	ldh a, [hSerialReceive]
	cp SERIAL_NO_DATA_BYTE
	ret nz
	call CheckwLinkTimeoutFramesNonzero
	jr z, .linkTimeoutFrames_zero
	push hl
	ld hl, wLinkTimeoutFrames + 1
	ld a, [hl]
	dec a
	ld [hld], a
	inc a
	jr nz, .no_rollover
	dec [hl]

.no_rollover
	pop hl
	call CheckwLinkTimeoutFramesNonzero
	jr z, SerialDisconnected

.linkTimeoutFrames_zero
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp 1 << SERIAL
	ld a, SERIAL_NO_DATA_BYTE
	ret z
	ld a, [hl]
	ldh [hSerialSend], a
	call DelayFrame
	jp .loop

.delay_15_cycles:
	ld a, 15
.delay_cycles
	dec a
	jr nz, .delay_cycles
	ret

CheckwLinkTimeoutFramesNonzero:
	push hl
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	or [hl]
	pop hl
	ret

SerialDisconnected:
	dec a
	ld [wLinkTimeoutFrames], a
	ld [wLinkTimeoutFrames + 1], a
	ret

; This is used to exchange the button press and selected menu item on the link menu.
; The data is sent thrice and read twice to increase reliability.
Serial_ExchangeLinkMenuSelection::
	ld hl, wPlayerLinkAction
	ld de, wOtherPlayerLinkMode
	ld c, 2
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.asm_0730
	call DelayFrame
	ld a, [hl]
	ldh [hSerialSend], a
	call Serial_ExchangeByte
	ld b, a
	inc hl
	ldh a, [hSerialIgnoringInitialData]
	and a
	ld a, FALSE
	ldh [hSerialIgnoringInitialData], a
	jr nz, .asm_0730
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .asm_0730
	ret

Serial_PrintWaitingTextAndSyncAndExchangeNybble::
	call BackUpTilesToBuffer
	callfar PlaceWaitingText
	call WaitLinkTransfer
	jp ReloadTilesFromBuffer

WaitLinkTransfer::
	ld a, $ff
	ld [wOtherPlayerLinkAction], a
.loop
	call LinkTransfer
	call DelayFrame
	call CheckwLinkTimeoutFramesNonzero
	jr z, .check
	push hl
	ld hl, wLinkTimeoutFrames + 1
	dec [hl]
	jr nz, .skip
	dec hl
	dec [hl]
	jr nz, .skip
	; We might be disconnected
	pop hl
	xor a
	jp SerialDisconnected

.skip
	pop hl
.check
	ld a, [wOtherPlayerLinkAction]
	inc a
	jr z, .loop

	ld b, 10
.receive
	call DelayFrame
	call LinkTransfer
	dec b
	jr nz, .receive

	ld b, 10
.acknowledge
	call DelayFrame
	call LinkDataReceived
	dec b
	jr nz, .acknowledge

	ld a, [wOtherPlayerLinkAction]
	ld [wOtherPlayerLinkMode], a
	ret

LinkTransfer::
	push bc
	ld b, $60
	ld a, [wLinkMode]
	cp $2
	jr c, .asm_07ac
	ld b, $70

.asm_07ac
	call .Receive
	ld a, [wPlayerLinkAction]
	add b
	ldh [hSerialSend], a
	ldh a, [hLinkPlayerNumber]
	cp USING_INTERNAL_CLOCK
	jr nz, .player_1
	ld a, (1 << rSC_ON) | 1
	ldh [rSC], a

.player_1
	call .Receive
	pop bc
	ret

.Receive:
	ldh a, [hSerialReceive]
	ld [wOtherPlayerLinkMode], a
	and $f0
	cp b
	ret nz
	xor a
	ldh [hSerialReceive], a
	ld a, [wOtherPlayerLinkMode]
	and $f
	ld [wOtherPlayerLinkAction], a
	ret

LinkDataReceived::
; Let the other system know that the data has been received.
	xor a
	ldh [hSerialSend], a
	ldh a, [hLinkPlayerNumber]
	cp USING_INTERNAL_CLOCK
	ret nz
	ld a, (1 << rSC_ON) | 1
	ldh [rSC], a
	ret

Unreferenced_Function7e6::
	ld a, [wLinkMode]
	and a
	ret nz
	ld a, USING_INTERNAL_CLOCK
	ldh [rSB], a
	xor a
	ldh [hSerialReceive], a
	ld a, (1 << rSC_ON)
	ldh [rSC], a
	ret
