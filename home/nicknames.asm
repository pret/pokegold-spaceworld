GetCurNick::
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames

GetNick::
; Get nickname a from list hl.
	push hl
	push bc
	call SkipNames
	ld de, wStringBuffer1
	push de
	ld bc, MON_NAME_LENGTH
	call CopyBytes
	pop de
	callfar CorrectNickErrors
	pop bc
	pop hl
	ret
