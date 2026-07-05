CopyMonToTempMon::
	ld a, [wCurPartyMon]
	ld e, a
	call GetMonSpecies
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData

	ld a, [wMonType]
	ld hl, wPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	and a
	jr z, .getmonaddress
	ld hl, wOTPartyMons
	ld bc, PARTYMON_STRUCT_LENGTH
	cp OTPARTYMON
	jr z, .getmonaddress
	ld hl, wBoxMons
	ld bc, BOXMON_STRUCT_LENGTH
	cp BOXMON
	jr z, .getmonaddress
	ld hl, wBufferMon
	jr .copywholestruct

.getmonaddress
	ld a, [wCurPartyMon]
	call AddNTimes
.copywholestruct
	ld de, wTempMon
	ld bc, PARTYMON_STRUCT_LENGTH
	call CopyBytes
	ret

GetMonSpecies::
	ld a, [wMonType]
	and a ; PARTYMON
	jr z, .partymon
	cp OTPARTYMON
	jr z, .otpartymon
	cp BOXMON
	jr z, .boxmon
	cp TEMPMON
	jr z, .buffermon
	; WILDMON

.partymon
	ld hl, wPartySpecies
	jr .done

.otpartymon
	ld hl, wOTPartySpecies
	jr .done

.boxmon
	ld hl, wBoxSpecies
	jr .done

.buffermon
	ld a, [wBufferMonSpecies]
	jr .done2

.done
	ld d, 0
	add hl, de
	ld a, [hl]

.done2
	ld [wCurPartySpecies], a
	ret
