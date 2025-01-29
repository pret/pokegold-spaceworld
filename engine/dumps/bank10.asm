INCLUDE "constants.asm"

SECTION "engine/dumps/bank10.asm@ConvertMon_2to1", ROMX

ConvertMon_2to1::
	push bc
	push hl
	ld a, [wce37]	; wMoveGrammar = $CE37
	ld b, a
	ld c, $00
	ld hl, Pokered_MonIndices
.loop
	inc c
	ld a, [hli]
	cp b
	jr nz, .loop
	ld a, c
	ld [wce37], a	; wMoveGrammar = $CE37
	pop hl
	pop bc
	ret

ConvertMon_1to2::
	push bc
	push hl
	ld a, [wMoveGrammar]	; wMoveGrammar = $CE37
	dec a
	ld hl, Pokered_MonIndices
	ld b, $00
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wce37], a	; wMoveGrammar = $CE37
	pop hl
	pop bc
	ret

Pokered_MonIndices::
	db DEX_RHYDON			; 01
	db DEX_KANGASKHAN		; 02
	db DEX_NIDORAN_M		; 03
	db DEX_CLEFAIRY			; 04
	db DEX_SPEAROW			; 05
	db DEX_VOLTORB			; 06
	db DEX_NIDOKING			; 07
	db DEX_SLOWBRO			; 08
	db DEX_IVYSAUR			; 09
	db DEX_EXEGGUTOR		; 0a
	db DEX_LICKITUNG		; 0b
	db DEX_EXEGGCUTE		; 0c
	db DEX_GRIMER			; 0d
	db DEX_GENGAR			; 0e
	db DEX_NIDORAN_F		; 0f
	db DEX_NIDOQUEEN		; 10

	db DEX_CUBONE			; 11
	db DEX_RHYHORN			; 12
	db DEX_LAPRAS			; 13
	db DEX_ARCANINE			; 14
	db DEX_MEW				; 15
	db DEX_GYARADOS			; 16
	db DEX_SHELLDER			; 17
	db DEX_TENTACOOL		; 18
	db DEX_GASTLY			; 19
	db DEX_SCYTHER			; 1a
	db DEX_STARYU			; 1b
	db DEX_BLASTOISE		; 1c
	db DEX_PINSIR			; 1d
	db DEX_TANGELA			; 1e
	db DEX_KAPOERER			; 1f
	db DEX_PUDIE			; 20

	db DEX_GROWLITHE		; 21
	db DEX_ONIX				; 22
	db DEX_FEAROW			; 23
	db DEX_PIDGEY			; 24
	db DEX_SLOWPOKE			; 25
	db DEX_KADABRA			; 26
	db DEX_GRAVELER			; 27
	db DEX_CHANSEY			; 28
	db DEX_MACHOKE			; 29
	db DEX_MRMIME			; 2a
	db DEX_HITMONLEE		; 2b
	db DEX_HITMONCHAN		; 2c
	db DEX_ARBOK			; 2d
	db DEX_PARASECT			; 2e
	db DEX_PSYDUCK			; 2f
	db DEX_DROWZEE			; 30

	db DEX_GOLEM			; 31
	db DEX_HANEKO			; 32
	db DEX_MAGMAR			; 33
	db DEX_TAIL				; 34
	db DEX_ELECTABUZZ		; 35
	db DEX_MAGNETON			; 36
	db DEX_KOFFING			; 37
	db DEX_POPONEKO			; 38
	db DEX_MANKEY			; 39
	db DEX_SEEL				; 3a
	db DEX_DIGLETT			; 3b
	db DEX_TAUROS			; 3c
	db DEX_WATANEKO			; 3d
	db DEX_BARIRINA			; 3e
	db DEX_LIP				; 3f
	db DEX_FARFETCHD		; 40

	db DEX_VENONAT			; 41
	db DEX_DRAGONITE		; 42
	db DEX_ELEBABY			; 43
	db DEX_BOOBY			; 44
	db DEX_KIREIHANA		; 45
	db DEX_DODUO			; 46
	db DEX_POLIWAG			; 47
	db DEX_JYNX				; 48
	db DEX_MOLTRES			; 49
	db DEX_ARTICUNO			; 4a
	db DEX_ZAPDOS			; 4b
	db DEX_DITTO			; 4c
	db DEX_MEOWTH			; 4d
	db DEX_KRABBY			; 4e
	db DEX_TSUBOMITTO		; 4f
	db DEX_MILTANK			; 50
	
	db DEX_BOMBSEEKER		; 51
	db DEX_VULPIX			; 52
	db DEX_NINETALES		; 53
	db DEX_PIKACHU			; 54
	db DEX_RAICHU			; 55
	db DEX_GIFT				; 56
	db DEX_KOTORA			; 57
	db DEX_DRATINI			; 58
	db DEX_DRAGONAIR		; 59
	db DEX_KABUTO			; 5a
	db DEX_KABUTOPS			; 5b
	db DEX_HORSEA			; 5c
	db DEX_SEADRA			; 5d
	db DEX_RAITORA			; 5e
	db DEX_MADAME			; 5f
	db DEX_SANDSHREW		; 60

	db DEX_SANDSLASH		; 61
	db DEX_OMANYTE			; 62
	db DEX_OMASTAR			; 63
	db DEX_JIGGLYPUFF		; 64
	db DEX_WIGGLYTUFF		; 65
	db DEX_EEVEE			; 66
	db DEX_FLAREON			; 67
	db DEX_JOLTEON			; 68
	db DEX_VAPOREON			; 69
	db DEX_MACHOP			; 6a
	db DEX_ZUBAT			; 6b
	db DEX_EKANS			; 6c
	db DEX_PARAS			; 6d
	db DEX_POLIWHIRL		; 6e
	db DEX_POLIWRATH		; 6f
	db DEX_WEEDLE			; 70

	db DEX_KAKUNA			; 71
	db DEX_BEEDRILL			; 72
	db DEX_NOROWARA			; 73
	db DEX_DODRIO			; 74
	db DEX_PRIMEAPE			; 75
	db DEX_DUGTRIO			; 76
	db DEX_VENOMOTH			; 77
	db DEX_DEWGONG			; 78
	db DEX_KYONPAN			; 79
	db DEX_YAMIKARASU		; 7a
	db DEX_CATERPIE			; 7b
	db DEX_METAPOD			; 7c
	db DEX_BUTTERFREE		; 7d
	db DEX_MACHAMP			; 7e
	db DEX_HAPPI			; 7f
	db DEX_GOLDUCK			; 80

	db DEX_HYPNO			; 81
	db DEX_GOLBAT			; 82
	db DEX_MEWTWO			; 83
	db DEX_SNORLAX			; 84
	db DEX_MAGIKARP			; 85
	db DEX_SCISSORS			; 86
	db DEX_PURAKKUSU		; 87
	db DEX_MUK				; 88
	db DEX_DEVIL			; 89
	db DEX_KINGLER			; 8a
	db DEX_CLOYSTER			; 8b
	db DEX_HELGAA			; 8c
	db DEX_ELECTRODE		; 8d
	db DEX_CLEFABLE			; 8e
	db DEX_WEEZING			; 8f
	db DEX_PERSIAN			; 90
	
	db $69, $ED, $5D, $3F, $41, $11, $12, $79, $01, $03, $49, $EE, $76, $77, $EF, $F0
	db $F1, $F2, $4D, $4E, $13, $14, $21, $1E, $4A, $89, $8E, $F3, $51, $F4, $F5, $04
	db $07, $05, $08, $06, $F6, $F7, $F8, $F9, $2B, $2C, $2D, $45, $46, $47, $98, $99
	db $9A, $9B, $9C, $9D, $9E, $9F, $A0, $A1, $A2, $A3, $A4, $A5, $A6, $A7, $A8, $A9
	db $AA, $AB, $AC, $AD, $AE, $AF, $B0, $B1, $B2, $B3, $B4, $B5, $B6, $B7, $B8, $B9
	db $BA, $BB, $BC, $BD, $BE, $BF, $C0, $C1, $C2, $C3, $C4, $C5, $C6, $C7, $C8, $C9
	db $CA, $CB, $CC, $CD, $CE, $CF, $D0, $D1, $D2, $D3, $CA, $CA, $21, $5E, $CB, $7E
	db $F5, $AF, $77, $21, $A5, $FF, $7E, $F5, $3E, $01, $77, $CD, $DC, $32, $CD, $98
	db $4C, $FA, $5E, $CB, $CB, $7F, $20, $08, $CD, $A3, $4C, $CD, $17, $03, $18, $F1
	db $F1, $E0, $A5, $F1, $EA, $5E, $CB, $C9, $21, $DD, $C5, $0E, $0A, $AF, $22, $0D
	db $20, $FC, $C9, $FA, $5E, $CB, $5F, $16, $00, $21, $B2, $4C, $19, $19, $2A, $66
	db $6F, $E9, $C6, $4C, $D5, $4C, $E5, $4C, $EC, $4C, $25, $4D, $34, $4D, $44, $4D
	db $4B, $4D, $87, $4D, $91, $4D, $AF, $21, $DE, $C5, $22, $22, $22, $CD, $E6, $4D
	db $21, $5E, $CB, $34, $C9, $CD, $84, $08, $11, $DE, $C5, $CD, $9C, $4D, $D0, $3E
	db $08, $EA, $5E, $CB, $C9, $11, $57, $4E, $CD, $C5, $4D, $C9, $CD, $84, $08, $21
	db $A2, $FF, $7E, $E6, $01, $20, $0F, $7E, $E6, $02, $20, $04, $CD, $A8, $4F, $C9
	db $3E, $00, $EA, $5E, $CB, $C9, $FA, $E0, $C5, $A7, $28, $0A, $FE, $01, $28, $0F
	db $3E, $08, $EA, $5E, $CB, $C9, $CD, $F2, $4F, $3E, $09, $EA, $5E, $CB, $C9, $3E
	db $04, $EA, $5E, $CB, $C9, $AF, $EA, $DF, $C5, $EA, $E0, $C5, $CD, $E6, $4D, $21
	db $5E, $CB, $34, $C9, $CD, $84, $08, $11, $DF, $C5, $CD, $9C, $4D, $D0, $3E, $02
	db $EA, $5E, $CB, $C9, $11, $65, $4E, $CD, $C5, $4D, $C9, $CD, $84, $08, $21, $A2
	db $FF, $7E, $E6, $01, $20, $0F, $7E, $E6, $02, $20, $04, $CD, $A8, $4F, $C9, $3E
	db $04, $EA, $5E, $CB, $C9, $FA, $E0, $C5, $A7, $28, $0A, $FE, $01, $28, $12, $3E
	db $08, $EA, $5E, $CB, $C9, $CD, $F2, $4F, $3E, $09, $EA, $5E, $CB, $C9, $CD, $B6
	db $48, $3E, $00, $EA, $5E, $CB, $C9, $AF, $EA, $E7, $C5, $21, $5E, $CB, $CB, $FE
	db $C9, $3E, $01, $EA, $E7, $C5, $21, $5E, $CB, $CB, $FE, $C9, $21, $A2, $FF, $7E
	db $E6, $01, $20, $0C, $7E, $E6, $02, $20, $05, $CD, $17, $4F, $A7, $C9, $37, $C9
	db $21, $DD, $C5, $FA, $E0, $C5, $86, $3C, $12, $CD, $94, $4E, $CD, $77, $50, $21
	db $5E, $CB, $34, $A7, $C9, $D5, $FA, $E0, $C5, $CD, $8E, $4F, $36, $7F, $21, $9D
	db $C3, $36, $ED, $AF, $EA, $E0, $C5, $D1, $21, $9E, $C3, $CD, $93, $0E, $CD, $77
	db $50, $21, $5E, $CB, $34, $C9, $AF, $E0, $DE, $21, $A0, $C2, $01, $68, $01, $36
	db $6B, $23, $0B, $79, $B0, $20, $F8, $21, $A1, $C2, $01, $0A, $02, $CD, $18, $0E
	db $21, $AD, $C2, $01, $06, $02, $CD, $18, $0E, $21, $C8, $C2, $01, $0C, $10, $CD
	db $09, $45, $21, $D4, $C2, $01, $08, $06, $CD, $09, $45, $21, $74, $C3, $01, $08
	db $08, $CD, $09, $45, $21, $B5, $C2, $11, $45, $4E, $CD, $93, $0E, $21, $C1, $C2
	db $11, $50, $4E, $CD, $93, $0E, $CD, $73, $4E, $CD, $94, $4E, $21, $F2, $C2, $36
	db $ED, $CD, $77, $50, $C9, $2F, $B8, $BE, $B2, $7F, $33, $7F, $BB, $26, $BD, $50
	db $B4, $D7, $DE, $30, $D3, $C9, $50, $BB, $26, $BD, $4E, $D3, $B3, $CB, $C4, $C2
	db $4E, $D4, $D2, $D9, $50, $BB, $26, $BD, $4E, $D4, $D8, $C5, $B5, $BC, $4E, $D4
	db $D2, $D9, $50, $FA, $DD, $C5, $CD, $BE, $4E, $21, $F3, $C2, $0E, $07, $C5, $D5
	db $E5, $CD, $93, $0E, $E1, $11, $28, $00, $19, $D1, $13, $13, $13, $13, $13, $C1
	db $0D, $20, $EB, $C9, $FA, $DE, $C5, $CD, $AD, $4E, $21, $FE, $C2, $CD, $93, $0E
	db $FA, $DF, $C5, $CD, $AD, $4E, $21, $26, $C3, $CD, $93, $0E, $C9, $A7, $28, $05
	db $3D, $CD, $BE, $4E, $C9, $11, $B9, $4E, $C9, $E3, $E3, $E3, $E3, $50, $5F, $16
	db $00, $21, $CC, $4E, $19, $19, $19, $19, $19, $5D, $54, $C9

	/*
	db DEX_			; 31
	db DEX_			; 32
	db DEX_			; 33
	db DEX_			; 34
	db DEX_		; 35
	db DEX_		; 36
	db DEX_			; 37
	db DEX_		; 38
	db DEX_			; 39
	db DEX_				; 3a
	db DEX_			; 3b
	db DEX_			; 3c
	db DEX_			; 3d
	db DEX_			; 3e
	db DEX_				; 3f
	db DEX_		; 40
	*/

	