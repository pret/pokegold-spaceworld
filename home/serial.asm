INCLUDE "constants.asm"

SECTION "home/serial.asm", ROM0

; The serial interrupt.
Serial::
	push af
	push bc
	push de
	push hl

	ldh a, [hSerialConnectionStatus]
	inc a
	jr z, .establish_connection

	ldh a, [rSB]
	ldh [hSerialReceive], a

	ldh a, [hSerialSend]
	ldh [rSB], a

	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr z, .player2
	
	ld a, 1 << rSC_ON
	ldh [rSC], a
	jr .player2

.establish_connection
	ldh a, [rSB]
	ldh [hSerialReceive], a
	ldh [hSerialConnectionStatus], a
	cp USING_INTERNAL_CLOCK
	jr z, ._player2

	xor a
	ldh [rSB], a

	ld a, 3
	ldh [rDIV], a
.delay_loop
	ldh a, [rDIV]
	bit 7, a
	jr nz, .delay_loop ; wait until rDIV has incremented from 3 to $80 or more

	ld a, 1 << rSC_ON
	ldh [rSC], a
	jr .player2

._player2
	xor a
	ldh [rSB], a

.player2
	ld a, TRUE
	ldh [hSerialReceivedNewData], a
	ld a, SERIAL_NO_DATA_BYTE
	ldh [hSerialSend], a
	pop hl
	pop de
	pop bc
	pop af
	reti

; Send bc bytes from hl, receive bc bytes to de.
Serial_ExchangeBytes::
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.loop
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
	cp SERIAL_PREAMBLE_BYTE
	jr nz, .loop
	xor a ; FALSE
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
.timeout_loop
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	jr nz, .not_player_2
	ld a, (1 << rSC_ON) | 1
	ldh [rSC], a
.not_player_2
.loop
	ldh a, [hSerialReceivedNewData]
	and a
	jr nz, .await_new_data
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr nz, .not_player_1_or_timed_out
	call CheckwLinkTimeoutFramesNonzero
	jr z, .not_player_1_or_timed_out
	call .ShortDelay
	push hl
	ld hl, wLinkTimeoutFrames + 1
	inc [hl]
	jr nz, .no_rollover_up
	dec hl
	inc [hl]

.no_rollover_up
	pop hl
	call CheckwLinkTimeoutFramesNonzero
	jr nz, .loop
	jp SerialDisconnected

.not_player_1_or_timed_out
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp 1 << SERIAL
	jr nz, .loop
	ld a, [wLinkByteTimeout]
	dec a
	ld [wLinkByteTimeout], a
	jr nz, .loop
	ld a, [wLinkByteTimeout + 1]
	dec a
	ld [wLinkByteTimeout + 1], a
	jr nz, .loop
	ldh a, [hSerialConnectionStatus]
	cp USING_EXTERNAL_CLOCK
	jr z, .await_new_data

	ld a, 255
.long_delay_loop
	dec a
	jr nz, .long_delay_loop

.await_new_data
	xor a
	ldh [hSerialReceivedNewData], a
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	sub 1 << SERIAL
	jr nz, .non_serial_interrupts_enabled

	assert LOW(SERIAL_LINK_BYTE_TIMEOUT) == 0
	; LOW(SERIAL_LINK_BYTE_TIMEOUT)
	ld [wLinkByteTimeout], a
	ld a, HIGH(SERIAL_LINK_BYTE_TIMEOUT)
	ld [wLinkByteTimeout + 1], a

.non_serial_interrupts_enabled
	ldh a, [hSerialReceive]
	cp SERIAL_NO_DATA_BYTE
	ret nz
	call CheckwLinkTimeoutFramesNonzero
	jr z, .timed_out
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

.timed_out
	ldh a, [rIE]
	and (1 << SERIAL) | (1 << TIMER) | (1 << LCD_STAT) | (1 << VBLANK)
	cp 1 << SERIAL
	ld a, SERIAL_NO_DATA_BYTE
	ret z
	ld a, [hl]
	ldh [hSerialSend], a
	call DelayFrame
	jp .timeout_loop

.ShortDelay:
	ld a, 15
.delay_cycles
	dec a
	jr nz, .delay_cycles
	ret

CheckwLinkTimeoutFramesNonzero::
	push hl
	ld hl, wLinkTimeoutFrames
	ld a, [hli]
	or [hl]
	pop hl
	ret

; This sets wLinkTimeoutFrames to $ffff, since
; a is always 0 when it is called.
SerialDisconnected::
	dec a
	ld [wLinkTimeoutFrames], a
	ld [wLinkTimeoutFrames + 1], a
	ret

; This is used to exchange the button press and selected menu item on the link menu.
; The data is sent thrice and read twice to increase reliability.
Serial_ExchangeLinkMenuSelection::
	ld hl, wLinkPlayerSyncBuffer
	ld de, wLinkReceivedSyncBuffer
	ld c, 2
	ld a, TRUE
	ldh [hSerialIgnoringInitialData], a
.exchange
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
	jr nz, .exchange
	ld a, b
	ld [de], a
	inc de
	dec c
	jr nz, .exchange
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
	ld b, SERIAL_TRADECENTER
	ld a, [wLinkMode]
	cp LINK_TRADECENTER
	jr c, .got_high_nybble
	ld b, SERIAL_BATTLE

.got_high_nybble
	call .Receive
	ld a, [wPlayerLinkAction]
	add b
	ldh [hSerialSend], a
	ldh a, [hSerialConnectionStatus]
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
	ldh a, [hSerialConnectionStatus]
	cp USING_INTERNAL_CLOCK
	ret nz
	ld a, (1 << rSC_ON) | 1
	ldh [rSC], a
	ret

; Unreferenced in the final game, but used here.
SetBitsForTimeCapsuleRequestIfNotLinked::
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
