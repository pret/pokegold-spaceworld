INCLUDE "constants.asm"

SECTION "engine/dumps/bank14.asm@Function50000", ROMX

Function50000::
    ld a, [wWhichPokemon]
    ld e, a
    call Function50045
    ld a, [wMonDexIndex]
    ld [wCurSpecies], a
    call GetMonHeader
    ld a, [wMonType]
    ld hl, wPartyMon1Species
    ld bc, (wPartyMon2 - wPartyMon1)
    and a
    jr z, .asm_50035
    ld hl, wWildMons
    ld bc, (wPartyMon2 - wPartyMon1)
    cp 1
    jr z, .asm_50035
    ld hl, wdaa3
    ld bc, $0020
    cp 2
    jr z, .asm_50035
    ld hl, wd882
    jr .asm_5003b

.asm_50035
    ld a, [wWhichPokemon]
    call AddNTimes
.asm_5003b
    ld de, wcd7f
    ld bc, (wPartyMon2 - wPartyMon1)
    call CopyBytes
    ret

Function50045::
    ld a, [wMonType]
    and a
    jr z, .asm_50057
    cp 1
    jr z, .asm_5005c
    cp 2
    jr z, .asm_50061
    cp 3
    jr z, .asm_50066
.asm_50057
    ld hl, wPartySpecies
    jr .asm_5006b
.asm_5005c
    ld hl, wd914
    jr .asm_5006b
.asm_50061
    ld hl, wBoxList
    jr .asm_5006b
.asm_50066
    ld a, [wd882]
    jr .asm_5006f

.asm_5006b
    ld d, 0
    add hl, de
    ld a, [hl]
.asm_5006f
    ld [wMonDexIndex], a
    ret

Function50073::
    push hl
    call GetMonHeader
    pop hl
    push hl
    ld a, [wMonHType1]
    call .asm_5008e
    ld a, [wMonHType1]
    ld b, a
    ld a, [wMonHType2]
    cp b
    pop hl
    jr z, .asm_50091
    ld bc, $0028
    add hl, bc
.asm_5008e
    push hl
    jr Function500b7

.asm_50091
    ld a, $7f
    ld bc, $0011
    add hl, bc
    ld [hl], a
    inc bc
    add hl, bc
    ld bc, $0005
    jp ByteFill

Function500a0::
    push hl
    ld a, b
    dec a
    ld bc, $0007
    ld hl, Moves
    call AddNTimes
    ld de, wStringBuffer1
    ld a, BANK(Moves)
    call FarCopyBytes
    ld a, [wcd29]
Function500b7::
    add a
    ld hl, TypeNames
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hli]
    ld e, a
    ld d, [hl]
    pop hl
    jp PlaceString

Function500c6::
    ld a, [wMoveGrammar]
    ld hl, TypeNames
    ld e, a
    ld d, 0
    add hl, de
    add hl, de
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wStringBuffer1
    ld bc, 5
    jp CopyBytes

SECTION "engine/dumps/bank14.asm@GetTrainerClassName_Old", ROMX

GetTrainerClassName_Old::
; Seemingly unreferenced.
; Loads a name to wStringBuffer1 from a partial list of Trainer classes leftover from Red/Green.
    ld hl, .name_table
    ld a, [wca22]
    dec a
    ld c, a
    ld b, 0
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wStringBuffer1
.copy_byte
    ld a, [hli]
    ld [de], a
    inc de
    cp "@"
    jr nz, .copy_byte
    ret

.name_table:
    dw .youngster, .bug_catcher, .lass, wca2b
    dw .jr_trainer_male, .jr_trainer_female, .pokemaniac, .super_nerd
    dw wca2b, wca2b, .burglar, .engineer
    dw .jack, wca2b, .swimmer, wca2b
    dw wca2b, .beauty, wca2b, .rocker
    dw .juggler, wca2b, wca2b, .blackbelt
    dw wca2b, .prof_oak, .chief, .scientist
    dw wca2b, .rocket, .cooltrainer_male, .cooltrainer_female
    dw wca2b, wca2b, wca2b, wca2b
    dw wca2b, wca2b, wca2b, wca2b
    dw wca2b, wca2b, wca2b, wca2b
    dw wca2b, wca2b, wca2b


.youngster
    db "たんパン@"

.bug_catcher
    db "むしとり@"

.lass
    db "ミニスカ@"

.jr_trainer_male
    db "ボーイ@"

.jr_trainer_female
    db "ガール@"

.pokemaniac
    db "マニア@"

.super_nerd
    db "りかけい@"

.burglar
    db "どろぼう@"

.engineer
    db "オヤジ@"

.jack
; Removed trainer class from original game, whose name string didn't make it to Gen I but somehow ended up in Gen II.
    db "ジャック@"

.swimmer
    db "かいパン@"

.beauty
    db "おねえさん@"

.rocker
    db "グループ@"

.juggler
    db "ジャグラー@"

.blackbelt
    db "からて@"

.prof_oak
    db "オーキド@"

.chief
    db "チーフ@"

.scientist
    db "けんきゅういん@"

.rocket
    db "だんいん@"

.cooltrainer_male
    db "エりート♂@"

.cooltrainer_female
    db "エりート♀@"

Function50244::
    ld a, 1
    jr .asm_5024a
.asm_50248
    ld a, 2
.asm_5024a
    ld [wHPBarType], a
    push hl
    push bc
    ld a, [wMonType]
    cp 2
    jr z, .asm_5026a
    ld a, [wcda1]
    ld b, a
    ld a, [wcda2]
    ld c, a
    or b
    jr nz, .asm_5026a
    xor a
    ld c, a
    ld e, a
    ld a, 6
    ld d, a
    jp .asm_50284
.asm_5026a
    ld a, [wcda3]
    ld d, a
    ld a, [wcda4]
    ld e, a
    ld a, [wMonType]
    cp 2
    jr nz, .asm_5027b
    ld b, d
    ld c, e
.asm_5027b
    ld a, $e
    call Predef
    ld a, 6
    ld d, a
    ld c, a
.asm_50284
    ld a, c
    pop bc
    ld c, a
    pop hl
    push de
    push hl
    push hl
    call DrawBattleHPBar
    pop hl
    ld bc, $0015
    add hl, bc
    ld de, wcda1
    ld a, [wMonType]
    cp 2
    jr nz, .asm_502a0
    ld de, wcda3
.asm_502a0
    ld bc, $0203
    call PrintNumber
    ld a, "／"  ; $f3
    ld [hli], a
    ld de, wcda3
    ld bc, $0203
    call PrintNumber
    pop hl
    pop de
    ret

Function502b5::
    ld a, [wMonDexIndex]
    cp DEX_EGG
    jr z, .asm_502d9

    call Function50000
    ld a, [wMonType]
    cp 2
    jr c, .asm_502d9

    ld a, [wLoadedMonLevel]
    ld [wCurPartyLevel], a
    ld hl, wcd89
    ld de, wcda3
    ld b, 1
    predef Functiondf7d
.asm_502d9
    ld hl, wd4a7
    set 1, [hl]
    call ClearBGPalettes
    call ClearTileMap
    call UpdateSprites
    callfar LoadPokemonStatsGraphics

    ldh a, [hMapAnims]
    push af
    xor a
    ldh [hMapAnims], a
    ld c, 1
    ld b, 0
    ld hl, Function50340
.asm_502fc
    push bc
    ld de, .asm_50302
    push de
    jp hl

.asm_50302
    pop bc
.asm_50303
    call GetJoypadDebounced
    ldh a, [hJoySum]
    and (D_LEFT | D_RIGHT | B_BUTTON | A_BUTTON)
    jr z, .asm_50303
    bit B_BUTTON_F, a
    jr nz, .asm_50333
    bit D_LEFT_F, a
    jr nz, .asm_5031e
    inc c
    ld a, 3
    cp c
    jr nc, .asm_50323
    ld c, 1
    jr .asm_50323

.asm_5031e
    dec c
    jr nz, .asm_50323
    ld c, 3
.asm_50323
    ld hl, .data_5033a
    dec c
    ld b, 0
    add hl, bc
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    inc c
    ld b, 1
    jr .asm_502fc

.asm_50333
    call ClearBGPalettes
    pop af
    ldh [hMapAnims], a
    ret

.data_5033a
    dw Function50340, Function504e5, Function50562

Function50340::
    call WaitBGMap
    xor a
    ldh [hBGMapMode], a
    ld a, [wMonHIndex]
    ld [wMoveGrammar], a
    ld [wCurSpecies], a
    ld a, b
    and a
    jr nz, .asm_503b3
    push bc
    hlcoord 1, 0
    ld [hl], $74
    inc hl
    ld [hl], $f2
    inc hl

    ld de, wMoveGrammar
    ld bc, $8103
    call PrintNumber
    hlcoord 1, 8
    call PrintLevel

    ld hl, NicknamePointers
    call Function50611
    ld d, h
    ld e, l
    hlcoord 1, 10
    call PlaceString
    push bc
    call Function5069e
    ld a, "♂"
    jr c, .asm_50384
    ld a, "♀"
.asm_50384
    pop hl
    ld [hl], a
    hlcoord 1, 12
    ld a, "／"
    ld [hli], a
    ld a, [wMonHIndex]
    ld [wMoveGrammar], a
    call GetPokemonName
    call PlaceString
    hlcoord 7, 0
    ld bc, SCREEN_WIDTH
    ld d, SCREEN_HEIGHT

.place_vertical_divider
    ld a, $31
    ld [hl], a
    add hl, bc
    dec d
    jr nz, .place_vertical_divider

    inc a
    hlcoord 2, 16
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hli], a
    inc a
    ld [hl], a
    pop bc
.asm_503b3
    push bc
    ld b, 1
    call Function505d9
    hlcoord 8, 0
    ld bc, TextCommands
    call ClearBox

    hlcoord 10, 1
    ld b, 0
    call Function50244

    hlcoord 18, 1
    ld [hl], $41

    ld hl, wccd9
    call SetHPPal
    ld b, SGB_STATS_SCREEN_HP_PALS
    call GetSGBLayout

    hlcoord 9, 4
    ld de, StatusText_StatusType
    call PlaceString

    hlcoord 15, 4
    ld a, [wMonType]
    cp 2
    jr z, .asm_503f5
    push hl
    ld de, wcd9f
    call Function50b7d
    pop hl
.asm_503f5
    ld de, StatusText_OK
    call z, PlaceString
    hlcoord 14, 6
    call Function50073

    hlcoord 8, 10
    ld b, 6
    ld c, 10
    call DrawTextBox

    hlcoord 10, 10
    ld de, StatusText_ExpPoints
    call PlaceString

    ld a, [wLoadedMonLevel]
    push af
    cp 100
    jr z, .asm_50420

    inc a
    ld [wLoadedMonLevel], a
.asm_50420
    hlcoord 16, 14
    call PrintLevel

    pop af
    ld [wLoadedMonLevel], a
    ld de, wcd87
    hlcoord 12, 11
    ld bc, $0307
    call PrintNumber

    call Function50491
    ld de, wcdc3
    hlcoord 10, 13
    ld bc, $0307
    call PrintNumber

    hlcoord 9, 13
    ld de, StatusText_Ato
    call PlaceString

    hlcoord 17, 13
    ld de, StatusText_De
    call PlaceString

    ld a, [wLoadedMonLevel]
    ld b, a
    ld de, wcd89
    hlcoord 10, 16
    predef Function3e874

    hlcoord 9, 16
    ld [hl], $40
    hlcoord 18, 16
    ld [hl], $41
    call WaitBGMap

    ld a, 1
    ldh [hBGMapMode], a
    pop bc
    ld a, b
    and a
    ret nz

    call SetPalettes
    ld hl, wcd94
    call Function50ed9

    hlcoord 0, 1
    call PrepMonFrontpic
    ld a, [wMonDexIndex]
    call PlayCry
    ret

Function50491::
    ld a, [wLoadedMonLevel]
    cp 100
    jr z, .asm_504b8

    inc a
    ld d, a
    call Function50cd1

    ld hl, wcd89
    ld hl, wcd89    ; Seemingly an unnecessary duplicate line
    ldh a, [hQuotient + 2]
    sub [hl]
    dec hl
    ld [wcdc5], a

    ldh a, [hQuotient + 1]
    sbc [hl]
    dec hl
    ld [wcdc4], a

    ldh a, [hQuotient]
    sbc a, [hl]
    ld [wcdc3], a
    ret

.asm_504b8
    ld hl, wcdc3
    xor a
    ld [hli], a
    ld [hli], a
    ld [hl], a
    ret

NicknamePointers:
    dw wPartyMonNicknames, wOTPartyMonNicknames, wBoxMonNicknames, wBufferMonNickname

StatusText_StatusType:
    db   "じょうたい／"
    next "タイプ／@"

StatusText_OK:
    db "ふつう@"

StatusText_ExpPoints:
    db "　けいけんち　@"

StatusText_Ato:
; This string and the one below are used to present the
; remaining amount of EXP to level up in a grammatical manner.
; Equivalent to the English version's "LEVEL UP - <amount> to :L<level>".
    db "あと@"

StatusText_De:
    db "で@"

Function504e5::
    call WaitBGMap
    xor a
    ldh [hBGMapMode], a
    ld b, 2
    call Function505d9

    hlcoord 8, 0
    ld bc, TextCommands
    call ClearBox

    hlcoord 8, 1
    ld de, .Item
    call PlaceString

    ld a, [wcd80]
    and a
    ld de, .NoItem
    jr z, .asm_50511
    ld [wNamedObjectIndexBuffer], a
    call GetItemName
.asm_50511
    hlcoord 11, 2
    call PlaceString

    ld hl, wcd81
    ld de, wce2e
    ld bc, $0004
    call CopyBytes

    hlcoord 8, 4
    ld b, 12
    ld c, 10
    call DrawTextBox

    hlcoord 11, 4
    ld de, .Moves
    call PlaceString

    hlcoord 9, 6
    ld a, $3c
    ld [wcdc3], a
    call Function50bfe

    hlcoord 11, 7
    ld a, $3c
    ld [wcdc3], a
    call Function506d4

    call WaitBGMap
    ld a, 1
    ldh [hBGMapMode], a
    ret

.Item
    db "そうび@"

.NoItem
    db "なし@"

.Moves
    db "　もちわざ　@"

Function50562::
    call WaitBGMap
    xor a
    ldh [hBGMapMode], a
    ld b, 3
    call Function505d9

    hlcoord 8, 0
    ld bc, TextCommands
    call ClearBox

    hlcoord 9, 1
    ld de, .IDNo_OT
    call PlaceString

    hlcoord 12, 1
    ld de, wcd85
    ld bc, $8205
    call PrintNumber

    ld hl, .OTPointers
    call Function50611

    ld de, wStringBuffer1
    push de
    ld bc, 6
    call CopyBytes

    pop de
    callfar CorrectNickErrors
    hlcoord 12, 3
    call PlaceString

    ld d, 0
    call Function50628
    hlcoord 10, 6
    ld de, .Parameters
    call PlaceString

    call WaitBGMap
    ld a, 1
    ldh [hBGMapMode], a
    ret

.IDNo_OT
    db   "<ID>№／"
    next "おや／"
    next "@"

.Parameters
    db "　パラメータ　@"

.OTPointers
    dw wPartyMonOT, wOTPartyMonOT, wBoxMonOT, wBufferMonOT

Function505d9::
    hlcoord 1, 14
    ld a, $36
    call .asm_50603

    hlcoord 3, 14
    ld a, $36
    call .asm_50603

    hlcoord 5, 14
    ld a, $36
    call .asm_50603

    ld a, b
    cp 2
    ld a, $3a

    hlcoord 3, 14
    jr c, .asm_50603
    hlcoord 5, 14
    jr z, .asm_50603
    hlcoord 1, 14

.asm_50603
    ld [hli], a
    inc a
    ld [hld], a
    push bc
    ld bc, $0014
    add hl, bc
    pop bc
    inc a
    ld [hli], a
    inc a
    ld [hl], a
    ret

Function50611::
    ld a, [wMonType]
    add a
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld a, [wMonType]
    cp 3
    ret z
    ld a, [wWhichPokemon]
    jp SkipNames

Function50628::
    ld a, d
    and a
    jr nz, .asm_5063e

    hlcoord 8, 6
    ld b, 10
    ld c, 10
    call DrawTextBox

    hlcoord 9, 8
    ld bc, $0006
    jr .asm_5064e

.asm_5063e
    hlcoord 9, 0
    ld b, 10
    ld c, 9
    call DrawTextBox

    hlcoord 11, 2
    ld bc, $0004
.asm_5064e
    push bc
    push hl
    ld de, Data_50684
    call PlaceString

    pop hl
    pop bc
    add hl, bc
    ld de, wcda5
    ld bc, $0203
    call .asm_5067a

    ld de, wcda7
    call .asm_5067a

    ld de, wcdab
    call .asm_5067a

    ld de, wcdad
    call .asm_5067a

    ld de, wcda9
    jp PrintNumber

.asm_5067a
    push hl
    call PrintNumber
    pop hl
    ; Print next numbers two tiles lower
    ld de, $0028
    add hl, de
    ret

Data_50684:
    db   "こうげき"
    next "ぼうぎょ"
    next "とくこう"
    next "とくぼう"
    next "すばやさ"
    next "@"

Function5069e::
    ld hl, wPartyMon1DVs
    ld bc, $0030
    ld a, [wMonType]
    and a
    jr z, .asm_506be

    ld hl, wd930
    dec a
    jr z, .asm_506be

    ld hl, wdab8
    ld bc, $0020
    dec a
    jr z, .asm_506be
    ld hl, wcddf
    jr .asm_506c4

.asm_506be
    ld a, [wWhichPokemon]
    call AddNTimes

.asm_506c4
    ld a, [hli]
    and $f0
    ld b, a
    ld a, [hl]
    and $f0
    swap a
    or b
    ld b, a
    ld a, [wMonHGenderRatio]
    cp b
    ret

Function506d4::
    ld a, [wcd57]
    inc a
    ld c, a
    ld a, 4
    sub c
    ld b, a
    push hl
    ld a, [wcdc3]
    ld e, a
    ld d, 0
    ld a, $3e
    call .asm_5074f

    ld a, b
    and a
    jr z, .asm_506f3
    ld c, a
    ld a, $e3
    call .asm_5074f

.asm_506f3
    pop hl
    inc hl
    inc hl
    inc hl
    ld d, h
    ld e, l
    ld hl, wcd81
    ld b, 0
.asm_506fe
    ld a, [hli]
    and a
    jr z, .asm_5074e

    push bc
    push hl
    push de
    ld hl, wMenuCursorY
    ld a, [hl]
    push af
    ld [hl], b
    push hl
    callfar Functionf960

    pop hl
    pop af
    ld [hl], a
    pop de
    pop hl
    push hl
    ld bc, $0014
    add hl, bc
    ld a, [hl]

    and $3f
    ld [wcd2a], a
    ld h, d
    ld l, e
    push hl

    ld de, wcd2a
    ld bc, $0102
    call PrintNumber

    ld a, "／"
    ld [hli], a
    ld de, wNamedObjectIndexBuffer
    ld bc, $0102
    call PrintNumber

    pop hl
    ld a, [wcdc3]
    ld e, a
    ld d, 0
    add hl, de
    ld d, h
    ld e, l
    pop hl
    pop bc
    inc b
    ld a, b
    cp 4
    jr nz, .asm_506fe
.asm_5074e
    ret

.asm_5074f::
    ld [hli], a
    ld [hld], a
    add hl, de
    dec c
    jr nz, .asm_5074f
    ret

SECTION "engine/dumps/bank14.asm@Party Menu Routines", ROMX

ClearGraphicsForPartyMenu::
    ldh a, [rLCDC]
    bit rLCDC_ENABLE, a
    jr z, .asm_5075f
    call ClearBGPalettes

.asm_5075f
    ld hl, wVramState
    res 0, [hl]
    call ClearSprites
    xor a
    ldh [hBGMapMode], a
    call ClearTileMap
    call UpdateSprites
    ret

PartyMenuInBattle_Setup::
    call ClearGraphicsForPartyMenu
    ; Fallthrough
PartyMenuInBattle::
    ldh a, [hMapAnims]
    push af
    xor a
    ldh [hMapAnims], a
    ld hl, wce5f
    set 4, [hl]

    call PartyMenuInBattle_SetMenuAttributes
    call Function5081f
    call Function507cf

    ld hl, wce5f
    res 4, [hl]
    pop bc
    ld a, b
    ldh [hMapAnims], a
    ret

PartyMenuInBattle_SetMenuAttributes::
    call LoadFontsBattleExtra
    xor a
    ld [wMonType], a
    ld de, Data_507c7
    call SetMenuAttributes

    ld a, [wPartyCount]
    ld [w2DMenuNumRows], a

    ld b, a
    ld a, [wce38]
    and a
    ld a, $03
    jr z, .asm_507b4
    xor a
    ld [wce38], a
    ld a, $01
.asm_507b4
    ld [wMenuJoypadFilter], a
    ld a, [wcd3c]
    and a
    jr z, .asm_507c1
    inc b
    cp b
    jr c, .asm_507c3
.asm_507c1
    ld a, $01
.asm_507c3
    ld [wMenuCursorY], a
    ret

Data_507c7:
    db $01, $00, $00, $01, $60, $00, $20, $00

Function507cf::
    call Get2DMenuJoypad
    call PlaceHollowCursor
    ld a, [wMenuCursorY]
    ld [wcd3c], a
    ldh a, [hJoySum]
    ld b, a
    ld a, [wSelectedSwapPosition]
    and a
    jp nz, .asm_50808
    ld a, [wPartyCount]
    and a
    jr z, .asm_50806
    bit 1, b
    jr nz, .asm_50806

    ld a, [wMenuCursorY]
    dec a
    ld [wWhichPokemon], a

    ld c, a
    ld b, $00
    ld hl, wPartySpecies
    add hl, bc
    ld a, [hl]
    ld [wMonDexIndex], a
    ld [wcdd8], a
    and a
    ret

.asm_50806
    scf
    ret
.asm_50808
    bit 1, b
    jr nz, .asm_5080f
    call Function50d9c
.asm_5080f
    call Function50eca
    xor a
    ld [wSelectedSwapPosition], a
    ld [wcdb9], a
    call Function5081f
    jp Function507cf

Function5081f::
    ld a, [wcdb9]
    cp $04
    jp z, Function509dd
    callfar Function8f0cc
    call Function50eca
    callfar Function95f8
    hlcoord 3, 1
    ld de, wPartySpecies
    ld a, [wWhichPokemon]
    push af
    xor a
    ld [wWhichPokemon], a
    ld [wcce1], a
.asm_5084b
    ld a, [de]
    cp $FF
    jp z, .asm_50877
    push de
    call Function508c4
    pop de
    ld a, [wWhichPokemon]
    ldh [hEventID], a
    push hl
    push de

    ld hl, Function8f0e3
    ld a, BANK(Function8f0e3)   ; ...What macro do I use here?
    ld e, 0
    call FarCall_hl

    pop de
    inc de
    pop hl
    ld bc, $0028
    add hl, bc
    ld a, [wWhichPokemon]
    inc a
    ld [wWhichPokemon], a

    jr .asm_5084b

.asm_50877
    pop af
    ld [wWhichPokemon], a
    jp Function509d8

Function5087e::
    ld a, [wcdb9]
    cp $04
    jp z, Function509dd
    callfar Function95f8
    ld hl, $c2b7
    ld de, wPartySpecies
    ld a, [wWhichPokemon]
    push af
    xor a
    ld [wWhichPokemon], a
    ld [wcce1], a
.asm_5089f
    ld a, [de]
    cp $FF
    jp z, .asm_508bd
    push de
    call Function508c4
    pop de
    ld a, [wWhichPokemon]
    ldh [hEventID], a
    inc de
    ld bc, $0028
    add hl, bc
    ld a, [wWhichPokemon]
    inc a
    ld [wWhichPokemon], a
    jr .asm_5089f
.asm_508bd
    pop af
    ld [wWhichPokemon], a
    jp Function509d8

Function508c4::
    push bc
    push hl
    push hl
    ld hl, wPartyMonNicknames
    ld a, [wWhichPokemon]
    call GetNick
    pop hl
    call PlaceString
    call Function50000
    pop hl
    push hl
    ld a, [wSelectedSwapPosition]
    and a
    jr z, .asm_508ef
    dec a
    ld b, a
    ld a, [wWhichPokemon]
    cp b
    jr nz, .asm_508ef
    dec hl
    dec hl
    dec hl
    ld a, "▷" ; $ec
    ld [hli], a
    inc hl
    inc hl
.asm_508ef
    ld a, [wcdb9]
    cp $03
    jr z, .asm_50922
    cp $05
    jr z, .DetermineCompatibility
    cp $06
    jp z, .asm_509b5
    cp $07
    jp z, .asm_509b5
    push hl
    ld bc, hRTCRandom
    add hl, bc
    ld de, wcd9f
    call Function50b7d
    pop hl
    push hl
    ld bc, hCurMapTextSubroutinePtr + 1
    add hl, bc
    ld b, $00
    call Function50244.asm_50248
    push de
    call Function50b66
    pop de
    pop hl
    jr .asm_5093c

.asm_50922
    push hl
    ld a, $1a
    call Predef
    pop hl
    ld de, .text_50948
    ld a, c
    and a
    jr nz, .asm_50933
    ld de, .text_5094f
.asm_50933
    push hl
    ld bc, $0009
    add hl, bc
    call PlaceString
    pop hl
.asm_5093c
    ld bc, $0005
    add hl, bc
    push de
    call PrintLevel
    pop de
    pop hl
    pop bc
    ret

.text_50948:
    db "おぼえられる@"
    ;db $b5, $3e, $b4, $d7, $da, $d9, $50

.text_5094f:
    db "おぼえられない@"
    ;db $b5, $3e, $b4, $d7, $da, $c5, $b2, $50

.DetermineCompatibility:
    push hl
    ld hl, EvosAttacksPointers
    ld a, [wcd7f]   ; Species of selected pokemon?
    dec a
    ld c, a
    ld b, $00
    add hl, bc
    add hl, bc
    ld de, wStringBuffer1
    ld a, BANK(EvosAttacksPointers)
    ld bc, 2
    call FarCopyBytes
    ld hl, wStringBuffer1
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ld de, wStringBuffer1
    ld a, BANK(EvosAttacks)
    ld bc, 10
    call FarCopyBytes
    ld hl, wStringBuffer1
    ld de, .string_not_able
    ; Fallthrough
.asm_50986
    ld a, [hli]
    and a
    jr z, .asm_5099e
    inc hl
    inc hl
    cp EVOLVE_STONE
    jr nz, .asm_50986
    dec hl
    dec hl
    ld b, [hl]
    ld a, [wCurItem]
    inc hl
    inc hl
    cp b
    jr nz, .asm_50986
    ld de, .string_able
.asm_5099e
    pop hl
    push hl
    ld bc, $0009
    add hl, bc
    call PlaceString
    pop hl
    jr .asm_5093c

.string_able
    db "つかえる@"
.string_not_able
    db "つかえない@"

.asm_509b5
    xor a
    ld [wMonType], a
    push hl
    call Function5069e
    pop hl
    ld de, .male
    jr c, .asm_509c6
    ld de, .female
.asm_509c6
    push hl
    ld bc, $0009
    add hl, bc
    call PlaceString
    pop hl
    jp .asm_5093c

.male
    db "オス@"

.female
    db "メス@"

Function509d8::
    ld b, $0a
    call GetSGBLayout
Function509dd::
    ld hl, wce5f
    ld a, [hl]
    push af
    push hl
    set 4, [hl]
    ld a, [wcdb9]
    cp $f0
    jr nc, .asm_509fc
    add a
    ld c, a
    ld b, $00
    ld hl, .data_50a33
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    call PrintText
    jr .asm_50a17

.asm_509fc
    and $0f
    add a
    ld c, a
    ld b, $00
    ld hl, .data_50a21
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    push hl
    ld a, [wWhichPokemon]
    ld hl, wPartyMonNicknames
    call GetNick
    pop hl
    call PrintText
.asm_50a17
    pop hl
    pop af
    ld [hl], a
    call WaitBGMap
    call SetPalettes
    ret

.data_50a21
    dw Text_50acb
    dw Text_50af9
    dw Text_50b09
    dw Text_50b1d
    dw Text_50ae5
    dw Text_50ab0
    dw Text_50b2b
    dw Text_50b3b
    dw Text_50b4e

.data_50a33
    dw Text_50a43
    dw Text_50a51
    dw Text_50a5f
    dw Text_50a6c
    dw Text_50a7a
    dw Text_50a51
    dw Text_50a88
    dw Text_50a9c

Text_50a43: ; Choose a pokemon
    text "#を　えらんで　ください"
    done

Text_50a51:
    text "どの#に　つかいますか？"
    done

Text_50a5f:
    text "どの#を　だしますか？"
    done

Text_50a6c:
    text "どの#に　おしえますか？"
    done

Text_50a7a:
    text "どこに　いどうしますか？"
    done

Text_50a88: ; first Pokemon in Daycare?
    text "１ぴきめの　#を"
    line "えらんで　ください"
    done

Text_50a9c: ; second Pokemon in Daycare?
    text "２ひきめの　#を"
    line "えらんで　ください"
    done

Text_50ab0: ; restored hp
    text_from_ram wStringBuffer1
    text "の　たいりょくが"
    line "@"
    deciram wHPBarHPDifference, 2, 3
    text "　かいふくした"
    done

Text_50acb: ; cured poison
    text_from_ram wStringBuffer1
    text "の　どくは"
    line "きれい　さっぱり　なくなった！"
    done

Text_50ae5: ; cured paralysis
    text_from_ram wStringBuffer1
    text "の　からだの"
    line "しびれが　とれた"
    done

Text_50af9: ; cured burn
    text_from_ram wStringBuffer1
    text "の"
    line "やけどが　なおった"
    done

Text_50b09: ; cured frozen
    text_from_ram wStringBuffer1
    text "の　からだの"
    line "こおりが　とけた"
    done

Text_50b1d: ; cured asleep
    text_from_ram wStringBuffer1
    text "は"
    line "めを　さました"
    done

Text_50b2b: ; health returned (presumably for Sacred Fire)
    text_from_ram wStringBuffer1
    text "は"
    line "けんこうになった！"
    done

Text_50b3b: ; revived
    text_from_ram wStringBuffer1
    text "は"
    line "げんきを　とりもどした！"
    done

Text_50b4e: ; leveled up
    text_from_ram wStringBuffer1
    text "の　レべルが@"
    deciram wCurPartyLevel, 1, 3
    text "になった@"
    sound_dex_fanfare_50_79
    text_waitbutton
    db "@"

Function50b66::
    ld hl, wccd3
    ld a, [wcce1]
    ld c, a
    ld b, $00
    add hl, bc
    call SetHPPal
    ld b, SGB_PARTY_MENU_HP_PALS
    call GetSGBLayout
    ld hl, wcce1
    inc [hl]
    ret

Function50b7d::
    push de
    inc de
    inc de
    ld a, [de]
    ld b, a
    inc de
    ld a, [de]
    or b
    pop de
    jr nz, Function50b92
    ld a, $cb
    ld [hli], a
    ld a, $de
    ld [hli], a
    ld [hl], $bc
    and a
    ret

Function50b92::
    ld a, [de]
    bit 3, a
    jr nz, .asm_50baf
    bit 4, a
    jr nz, .asm_50bb5
    bit 5, a
    jr nz, .asm_50bbe
    bit 6, a
    jr nz, .asm_50bc7
    and %111
    ret z
    ld a, $c8
    ld [hli], a
    ld a, $d1
    ld [hli], a
    ld [hl], $d8
    ret

.asm_50baf
    ld a, $70
    ld [hli], a
    ld [hl], $b8
    ret

.asm_50bb5
    ld a, $d4
    ld [hli], a
    ld a, $b9
    ld [hli], a
    ld [hl], $70
    ret

.asm_50bbe
    ld a, $ba
    ld [hli], a
    ld a, $b5
    ld [hli], a
    ld [hl], $d8
    ret

.asm_50bc7
    ld a, $cf
    ld [hli], a
    ld [hl], $cb
    ret

Function50bcd::
    ld a, $00
    call OpenSRAM
    push hl
    ld hl, $a188 ; SRAM_188
    ld de, $a000 ; SRAM_0
    ld bc, $0188
    call CopyBytes
    ld hl, $a310 ; SRAM_310
    ld de, $a188 ; SRAM_188
    ld bc, $0188
    call CopyBytes
    call _InterlaceMergeSpriteBuffers
    pop hl
    ld de, $a188 ; SRAM_188
    ld c, $24
    ldh a, [hROMBank]
    ld b, a
    call Get2bpp
    call CloseSRAM
    ret

Function50bfe::
    ld de, wce2e
    ld b, $00
.asm_50c03
    ld a, [de]
    inc de
    and a
    jr z, .asm_50c36
    push de
    push hl
    push hl
    ld [wCurSpecies], a
    ld a, $02
    ld [wNamedObjectTypeBuffer], a
    call GetName
    ld de, wStringBuffer1
    pop hl
    push bc
    call PlaceString
    pop bc
    ld a, b
    ld [wcd57], a
    inc b
    pop hl
    push bc
    ld a, [wHPBarMaxHP]
    ld c, a
    ld b, $00
    add hl, bc
    pop bc
    pop de
    ld a, b
    cp $04
    jr z, .asm_50c47
    jr .asm_50c03

.asm_50c36
    ld a, b
.asm_50c37
    push af
    ld [hl], $e3
    ld a, [wHPBarMaxHP]
    ld c, a
    ld b, $00
    add hl, bc
    pop af
    inc a
    cp $04
    jr nz, .asm_50c37
.asm_50c47
    ret

Function50c48::
    ld a, [wce34]
    cp $01
    jr nz, .asm_50c59
    ld hl, wd913
    ld de, wOTPartyMonOT
    ld a, $06
    jr .asm_50c8b


.asm_50c59
    cp $04
    jr nz, .asm_50c67
    ld hl, wPartyCount
    ld de, wPartyMonOT
    ld a, $05
    jr .asm_50c8b


.asm_50c67
    cp $05
    jr nz, .asm_50c75
    ld hl, wcd60
    ld de, PokemonNames
    ld a, $01
    jr .asm_50c8b


.asm_50c75
    cp $02
    jr nz, .asm_50c83

    ld hl, wItems
    ld de, $6fec ; ItemNames?
    ld a, $04
    jr .asm_50c8b


.asm_50c83
    ld hl, wcd60
    ld de, $6fec
    ld a, $04
.asm_50c8b
    ld [wNamedObjectTypeBuffer], a
    ld a, l
    ld [wcd70], a
    ld a, h
    ld [wcd71], a
    ld a, e
    ld [wcd72], a
    ld a, d
    ld [wcd72 + 1], a
    ld bc, $68F3    ; ItemAttributes?
    ld a, c
    ld [wcd74], a
    ld a, b
    ld [wcd75], a
    ret

Function50caa::
    ld a, [wcd7f]
    ld [wCurSpecies], a
    call GetMonHeader
    ld d, $01
.asm_50cb5
    inc d
    call Function50cd1
    push hl
    ld hl, wcd89
    ldh a, [hQuotient + 2]
    ld c, a
    ld a, [hld]
    sub c
    ldh a, [hQuotient + 1]
    ld c, a
    ld a, [hld]
    sbc a, c
    ldh a, [hQuotient]
    ld c, a
    ld a, [hl]
    sbc a, c
    pop hl
    jr nc, .asm_50cb5
    dec d
    ret

Function50cd1::
    ld a, [wMonHGrowthRate]
    add a
    add a
    ld c, a
    ld b, $00
    ld hl, Data50d84
    add hl, bc
    call Function50d77

    ld a, d
    ldh [hPrintNumDivisor], a
    call Multiply

    ld a, [hl]
    and $f0
    swap a
    ldh [hPrintNumDivisor], a
    call Multiply

    ld a, [hli]
    and $0f
    ldh [hPrintNumDivisor], a
    ld b, $04
    call Divide

    ldh a, [hQuotient]
    push af
    ldh a, [hQuotient + 1]
    push af
    ldh a, [hQuotient + 2]
    push af
    call Function50d77

    ld a, [hl]
    and $7f
    ldh [hPrintNumDivisor], a
    call Multiply

    ldh a, [hQuotient]
    push af
    ldh a, [hQuotient + 1]
    push af
    ldh a, [hQuotient + 2]
    push af

    ld a, [hli]
    push af
    xor a
    ldh [hQuotient], a
    ldh [hQuotient + 1], a
    ld a, d
    ldh [hQuotient + 2], a
    ld a, [hli]
    ldh [hPrintNumDivisor], a
    call Multiply

    ld b, [hl]
    ldh a, [hQuotient + 2]
    sub b
    ldh [hQuotient + 2], a
    ld b, $00
    ldh a, [hQuotient + 1]
    sbc a, b
    ldh [hQuotient + 1], a
    ldh a, [hQuotient]
    sbc a, b
    ldh [hQuotient], a
    pop af
    and $80
    jr nz, .asm_50d52
    pop bc
    ldh a, [hQuotient + 2]
    add b
    ldh [hQuotient + 2], a
    pop bc
    ldh a, [hQuotient + 1]
    adc b
    ldh [hQuotient + 1], a
    pop bc
    ldh a, [hQuotient]
    adc b
    ldh [hQuotient], a
    jr .asm_50d64

.asm_50d52
    pop bc
    ldh a, [hQuotient + 2]
    sub b
    ldh [hQuotient + 2], a

    pop bc
    ldh a, [hQuotient + 1]
    sbc b
    ldh [hQuotient + 1], a

    pop bc
    ldh a, [hQuotient]
    sbc b
    ldh [hQuotient], a
.asm_50d64
    pop bc
    ldh a, [hQuotient + 2]
    add b
    ldh [hQuotient + 2], a

    pop bc
    ldh a, [hQuotient + 1]
    adc b
    ldh [hQuotient + 1], a

    pop bc
    ldh a, [hQuotient]
    adc b
    ldh [hQuotient], a

    ret

Function50d77::
    xor a
    ldh [hQuotient], a
    ldh [hQuotient + 1], a
    ld a, d
    ldh [hQuotient + 2], a
    ldh [hPrintNumDivisor], a
    jp Multiply

Data50d84:
    ; Seems to have something to do with growth rates
    db $11, $00, $00, $00, $34, $0a, $00, $1e
    db $34, $14, $00, $46, $65, $8f, $64, $8c
    db $45, $00, $00, $00, $54, $00, $00, $00

Function50d9c::
    ; replace instances of wHPBarOldHP with wcdc5, perhaps?
    ld a, [wSelectedSwapPosition]
    dec a
    ld [wHPBarOldHP], a
    ld b, a
    ld a, [wMenuCursorY]
    dec a
    ld [wcdc4], a
    cp b
    jr z, .asm_50dbd
    call Function50dec
    ld a, [wcdc5]
    call Function50dbe
    ld a, [wcdc4]
    call Function50dbe
.asm_50dbd
    ret

Function50dbe::
    push af
    hlcoord 0, 0
    ld bc, SCREEN_WIDTH*2
    call AddNTimes
    ld bc, SCREEN_WIDTH*2
    ld a, "　"
    call ByteFill
    pop af
    ld hl, wShadowOAMSprite00
    ld bc, $0010
    call AddNTimes
    ld de, SPRITEOAMSTRUCT_LENGTH
    ld c, $04
.asm_50ddf
    ld [hl], $a0
    add hl, de
    dec c
    jr nz, .asm_50ddf
    ld de, $001b
    call WaitPlaySFX
    ret

Function50dec::
    push hl
    push de
    push bc
    ld bc, wPartySpecies
    ld a, [wcdc4]
    ld l, a
    ld h, $00
    add hl, bc
    ld d, h
    ld e, l
    ld a, [wcdc5]
    ld l, a
    ld h, $00
    add hl, bc
    ld a, [hl]
    push af
    ld a, [de]
    ld [hl], a
    pop af
    ld [de], a
    ; Copy first pokemon?
    ld a, [wcdc4]
    ld hl, wPartyMon1
    ld bc, (wPartyMon2 - wPartyMon1)
    call AddNTimes
    push hl
    ld de, wcc3a
    ld bc, (wPartyMon2 - wPartyMon1)
    call CopyBytes
    ; Copy second pokemon to first pokemon's slot?
    ld a, [wcdc5]
    ld hl, wPartyMon1
    ld bc, (wPartyMon2 - wPartyMon1)
    call AddNTimes
    pop de
    push hl
    ld bc, (wPartyMon2 - wPartyMon1)
    call CopyBytes
    ; Copy backed-up first pokemon to new slot?
    pop de
    ld hl, wcc3a
    ld bc, (wPartyMon2 - wPartyMon1)
    call CopyBytes

    ld a, [wcdc4]
    ld hl, wPartyMonOT
    call SkipNames
    push hl
    call .asm_50ec0

    ld a, [wcdc5]
    ld hl, wPartyMonOT
    call SkipNames
    pop de
    push hl
    call .asm_50ec3


    pop de
    ld hl, wcc3a
    call .asm_50ec3

    ld hl, wPartyMonNicknames
    ld a, [wcdc4]
    call SkipNames

    push hl
    call .asm_50ec0

    ld hl, wPartyMonNicknames
    ld a, [wcdc5]
    call SkipNames

    pop de
    push hl
    call .asm_50ec3

    pop de
    ld hl, wcc3a
    call .asm_50ec3

    ld hl, $ba68    ; Buffer somewhere in SRAM. Needs investigation
    ld a, [wcdc4]
    ld bc, $0028    ; todo: Constantify this
    call AddNTimes
    push hl
    ld de, wcc3a
    ld bc, $0028
    ld a, $02
    call OpenSRAM
    call CopyBytes
    ld hl, $ba68
    ld a, [wcdc5]
    ld bc, $0028
    call AddNTimes

    pop de
    push hl
    ld bc, $0028
    call CopyBytes
    pop de
    ld hl, wcc3a
    ld bc, $0028
    call CopyBytes
    call CloseSRAM
    pop bc
    pop de
    pop hl
    ret

.asm_50ec0
    ld de, wcc3a
    ; fallthrough
.asm_50ec3
    ld bc, $0006
    call CopyBytes
    ret

Function50eca::
    hlcoord 0, 1
    ld bc, $0028
    ld a, $06
.asm_50ed2
    ld [hl], $7f
    add hl, bc
    dec a
    jr nz, .asm_50ed2
    ret

Function50ed9::
    ld a, [hl]
    and $60
    sla a
    ld b, a
    ld a, [hli]
    and $06
    swap a
    srl a
    or b
    ld b, a
    ld a, [hl]
    and $60
    swap a
    sla a
    or b
    ld b, a
    ld a, [hl]
    and $06
    srl a
    or b
    ldh [hQuotient + 2], a
    xor a
    ldh [hProduct], a
    ldh [hQuotient], a
    ldh [hQuotient + 1], a
    ld a, $0a
    ldh [hPrintNumDivisor], a
    ld b, $04
    call Divide
    ldh a, [hQuotient + 2]
    inc a
    ld [wAnnonID], a    ; $d874
    ret
