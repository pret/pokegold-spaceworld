INCLUDE "constants.asm"

SECTION "engine/unknown_boxes.asm", ROMX

Function1130a:
	ret

Function1130b:
	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr c, .bigjump
	ld a, [wBoxListLength]
	cp MONS_PER_BOX
	jr nc, .fullbox
	xor a
	ld [wEnemySubStatus5], a
	ld a, [wCurPartySpecies]
	ld [wTempEnemyMonSpecies], a
	callfar LoadEnemyMon
	call RecievePokemon
	predef Functiondd5c
	and $7F
	add a, $F7
	ld hl, wStringBuffer2
	ld [hli], a
	ld [hl], "@"
	ld hl, BoxCantHoldText
	call PrintText
	scf
	ret
.fullbox
	ld hl, BoxFullText
	call PrintText
	and a
	ret
.bigjump
	call RecievePokemon
	predef Functiond886
	scf
	ret

RecievePokemon:
	ld a, [wCurPartySpecies]
	push af
	ld [wNamedObjectIndexBuffer], a
	dec a
	ld c, a
	ld hl, wPokedexCaught
	ld b, 01 ;SET_FLAG
	predef SmallFarFlagAction
	pop af
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, RecievePokemonText
	jp PrintText

RecievePokemonText:
	text "<PLAYER>は"
	line "@"

	db $01, $26, $CD

	text "を　てにいれた！@"

	db $0B, "@"

BoxCantHoldText:
	text "#を　もちきれないので"
	line "<PC>の　ボックス@"
	db $01, $31, $CD
	text "　に"
	cont "@"
	db $01, $17, $DF
	text "を　てんそうした！"
	done

BoxFullText:
	text "#を　もちきれません！"
	para "ボックスも　いっぱいで"
	line "てんそうできません！"
	para "#センターなどで"
	line "ボックスを　かえてきて　ください"
	done
