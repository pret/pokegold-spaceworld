INCLUDE "constants.asm"

SECTION "Serial handler", ROM0[$602]

Serial::
	push af
	push bc
	push de
	push hl
	ldh a, [hLinkPlayerNumber]
	inc a
	jr z, .init_player_number

	ld a, [rSB]
	ldh [hSerialReceive], a
	ldh a, [hSerialSend]
	ld [rSB], a
	ldh a, [hLinkPlayerNumber]
	cp 2
	jr z, .done
	ld a, 1 << rSC_ON
	ld [rSC], a
	jr .done

.init_player_number
	ld a, [rSB]
	ldh [hSerialReceive], a
	ldh [hLinkPlayerNumber], a
	cp 2
	jr z, .master
	xor a
	ld [rSB], a
	ld a, 3
	ld [rDIV], a
.wait
	ld a, [rDIV]
	bit 7, a
	jr nz, .wait
	ld a, 1 << rSC_ON
	ld [rSC], a
	jr .done
.master
	xor a
	ld [rSB], a
.done
	ld a, 1
	ldh [hSerialReceived], a
	ld a, SERIAL_NO_DATA_BYTE
	ldh [hSerialSend], a
	pop hl
	pop de
	pop bc
	pop af
	reti
