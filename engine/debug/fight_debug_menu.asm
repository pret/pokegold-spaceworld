INCLUDE "constants.asm"

SECTION "engine/debug/fight_debug_menu.asm", ROMX

FightDebugMenu:
	ld a, 1
	ldh [hInMenu], a

 ; Don't mess around with obedience.
	ld a, (1 << EARTHBADGE)
	ld [wBadges], a

	ld hl, wItems
	ld de, .ItemTable
.AddItemLoop:
	ld a, [de]
	cp a, -1
	jr z, .AddItemEnd
	inc de
	ld [wCurItem], a
	ld a, [de]
	inc de
	ld [wItemQuantity], a
	push de
	call ReceiveItem
	pop de
	jr .AddItemLoop

.AddItemEnd:
	call LoadFontsBattleExtra
	call ClearTileMap

	call ClearSprites
	ld hl, wTileMap
	ld b, 1
	ld c, SCREEN_HEIGHT
	call DrawTextBox

	hlcoord 6, 1
	ld de, .FightTestText ; "FIGHT TEST@"
	call PlaceString

	hlcoord 4, 4
	ld de, .NumNameLevelText ; "No.　　　　NAME　　　　LEVEL@"
	call PlaceString

	hlcoord 1, 6
	ld de, .LayoutText ; "１．▶０００　ーーーーー　　０００"
	call PlaceString

	xor a
	ld [wCurPartyMon], a
	ld [wEnemyMon], a ; monster number
	ld [wEnemyMonLevel], a ; level
	ld [wTrainerClass], a ; trainer number
	ld [wOTPlayerName + 2], a

	ld b, a ; monster number counter
	ld c, a ; level counter

	ld hl, wOTPartySpecies ; level tbl
	call .ClearMonsData
	ld hl, wPokemonData
	call .ClearMonsData

	ld de, wPartySpecies ; first monster pos
	hlcoord 4, 6

.MonsNumber:
	push hl ; monster number print position
	push bc ; b = monster number c = level
	dec hl
	ld a, '▶'
	ld [hl], a
	ld bc, NAME_LENGTH
	add hl, bc
	ld a, '　'
	ld [hl], a
	push de
	pop de
	pop bc ; b = monster number c = level
	pop hl ; monster number print position

.MonsNumberLoop:
	push bc ; b = monster number c = level
	push de ; wPokemonData
	call DelayFrame
	call GetJoypadDebounced
	pop de ; wPokemonData
	pop bc ; b = monster number c = level
	ldh a, [hJoySum]
	bit A_BUTTON_F, a ; "a" button
	jp nz, .CountUp
	bit B_BUTTON_F, a ; "b" button
	jp nz, .CountDown
	bit START_F, a ; start button
	jp nz, .EnemySet
	bit D_RIGHT_F, a ; right button
	jp nz, .MonsLevel
	bit D_UP_F, a ; up button
	jp nz, .BeforeMons
	bit D_DOWN_F, a ; down button
	jp nz, .NextMons
	bit SELECT_F, a ; select button
	predef_id DebugMenu
	jp nz, Predef
	jr .MonsNumberLoop

.ClearMonsData:
	xor	a
rept 6
	ld [hli], a
endr
	ld [hl], a
	ret

.ItemTable:
	db ITEM_MASTER_BALL,  99
	db ITEM_ULTRA_BALL,   99
	db ITEM_GREAT_BALL,   99
	db ITEM_POKE_BALL,    99
	db ITEM_FULL_RESTORE, 99
	db ITEM_MAX_REVIVE,   99
	db $FF

.CountUp:
	inc b ; monster number
	ld a, b
	cp NUM_POKEMON_OLD + 1 ; current monster count + 1 ; 252 and 253 were planned to be used?
	jr c, .CountUp_1
	xor a
	ld b, a

.CountUp_1:
	ld [de], a ; monster number -> wPartySpecies
	ld [wTempSpecies], a
	push bc
	push hl
	push de
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3

	call PrintNumber
	inc hl
	push hl
	ld de, .5SpacesText ; "5 spaces"
	call PlaceString
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld de, .5SpacesText ; "5 spaces"
	call PlaceString
	pop hl
	ld a, [wTempSpecies] ; monster number
	and a
	jr nz, .CountUp_2

	ld de, .5DashesText ; "-----"
	jr .CountUp_3

.CountUp_2:
	call GetPokemonName

.CountUp_3:
	call PlaceString
	pop de
	pop hl
	pop bc

	jp .MonsNumberLoop

.CountDown
	dec b ; monster number
	ld a, b
	cp NUM_POKEMON_OLD + 1
	jp c, .CountUp_1
	ld a, NUM_POKEMON_OLD ; current monster count
	                      ; 252 and 253 were planned to be used?
	ld b, a
	jp .CountUp_1

.BeforeMons
	ld a, [wCurPartyMon]
	dec a
	cp -1
	jp z, .MonsNumberLoop
	ld [wCurPartyMon], a
	dec de ; wPokemonData
	dec hl
	ld a, '　'
	ld [hl], a
	push bc
	ld bc, hSerialReceive
	add hl, bc
	pop bc
	ld a, '▶'
	ld [hl], a
	inc hl
	push hl
	call .PositionMove
	pop hl
	jp .MonsNumberLoop

.NextMons
	ld a, [wCurPartyMon]
	inc a
	cp PARTY_LENGTH
	jp nc, .MonsNumberLoop
	ld [wCurPartyMon], a
	inc de ; wPokemonData
	dec hl
	ld a, '　'
	ld [hl], a
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	ld a, '▶'
	ld [hl], a
	inc hl
	push hl
	call .PositionMove
	pop hl
	jp .MonsNumberLoop

.MonsLevel
	push hl ; monster number print position
	push bc ; b = monster number c = level
	dec hl
	ld a, '　'
	ld [hl], a
	ld bc, NAME_LENGTH
	add hl, bc
	ld a, '▶'
	ld [hl], a
	pop bc ; b = monster number c = level
	pop hl ; monster number print position
	; fallthrough
.MonsLevelLoop
	push bc ; b = monster number c = level
	push de ; wPokemonData
	call DelayFrame
	call GetJoypadDebounced
	pop de ; wPokemonData
	pop bc ; b = monster number c = level
	ldh a, [hJoySum]
	bit A_BUTTON_F, a ; "a" button
	jp nz, .LevelCountUp
	bit B_BUTTON_F, a ; "b" button
	jp nz, .LevelCountDown
	bit START_F, a ; start button
	jp nz, .EnemySet
	bit D_LEFT_F, a ; left button
	jp nz, .MonsNumber
	bit D_UP_F, a ; up button
	jp nz, .LevelBeforeMons
	bit D_DOWN_F, a ; down button
	jp nz, .LevelNextMons
	jr .MonsLevelLoop

.LevelCountUp:
	inc c ; monster level
	ld a, c
	cp MAX_LEVEL + 1 ; max level + 1
	jr c, .LevelCountUp_1
	ld a, 1
	ld c, a
.LevelCountUp_1:
	ld a, [wCurPartyMon]
	push de ; wPokemonData
	ld de, wOTPartySpecies ; level tbl
	add a, e
	ld e, a
	jr nc, .LevelCountUp_2
	inc d

.LevelCountUp_2:
	ld a, c
	ld [de], a ; monster level -> wOTPartyCount
	push bc ; b = monster No.  c = level
	push hl ; monster number print posision
	ld bc, NAME_LENGTH
	add hl, bc ; level print position
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber

	pop	hl ; monster number print position
	pop	bc ; b = monster No.  c = level
	pop	de ; wPokemonData
	jp	.MonsLevelLoop
.LevelCountDown:
	dec c ; monster level
	ld a, c
	cp MAX_LEVEL + 1
	jr nc, .LevelCountDown_1
	and a
	jp nz, .LevelCountUp_1
.LevelCountDown_1:
	ld a, MAX_LEVEL
	ld c, a
	jp .LevelCountUp_1

.LevelBeforeMons:
	ld a, [wCurPartyMon]
	dec a
	cp -1
	jp z, .MonsLevelLoop
	ld [wCurPartyMon], a
	dec de
	push hl ; monster number print posision
	ld bc, NAME_LENGTH - 1
	add hl, bc
	ld a, '　'
	ld [hl], a
	pop hl
	ld bc, hSerialReceive
	add hl, bc
	push hl
	ld bc, NAME_LENGTH -1
	add hl, bc
	ld a, '▶'
	ld [hl], a
	call .PositionMove
	pop hl ; monster number print posision
	jp .MonsLevelLoop

.LevelNextMons:
	ld a, [wCurPartyMon]
	inc a
	cp PARTY_LENGTH
	jp nc, .MonsLevelLoop
	ld [wCurPartyMon], a
	inc de

	push hl ; monster number print posision
	ld bc, NAME_LENGTH - 1
	add hl, bc
	ld a, '　'
	ld [hl], a
	pop hl
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	push hl
	ld bc, NAME_LENGTH - 1
	add hl, bc
	ld a, '▶'
	ld [hl], a
	call .PositionMove
	pop hl ; monster number print posision
	jp .MonsLevelLoop

.PositionMove:
	ld hl, wPartySpecies
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .PositionMove_1
	inc h
.PositionMove_1:
	ld a, [hl] ; monster number
	ld b, a
	ld hl, wOTPartySpecies
	ld a, [wCurPartyMon]
	add l
	ld l, a
	jr nc, .PositionMove_2
	inc h
.PositionMove_2:
	ld a, [hl] ; monster level
	ld c, a
	ret

.EnemySet:
	ld hl, wPartyCount
	ld de, wOTPartyCount ; level saved
	xor a
	ld [hl], a
	inc hl
	ld a, [hli] ; first monster number
	ld b, a
	ld c, PARTY_LENGTH
	xor a
	ld [wBattleMode], a

.EnemySet_1:
	ld a, b ; monster number
	ld [wCurPartySpecies], a
	ld a, [hl] ; next monster number
	ld b, a
	inc de
	ld a, [de] ; level
	and a
	jr z, .EnemySet_2

	ld [wCurPartyLevel], a
	xor a
	ld [wMonType], a ; 0 = none
	ld a, [wCurPartySpecies]
	and a
	jr z, .EnemySet_2

	push hl
	push de
	push bc
	predef TryAddMonToParty
	pop	bc
	pop	de
	pop	hl

.EnemySet_2:
	inc hl
	dec c
	jr nz, .EnemySet_1

	ld b, PARTY_LENGTH + 1
	ld hl, wPartySpecies
	ld de, wOTPartyCount

.EnemySet_2_0:
	inc de
	dec b
	jp z, FightDebugMenu
	ld a, [hli]
	and a
	jr z, .EnemySet_2_0
	ld a, [de]
	and a
	jr z, .EnemySet_2_0

	hlcoord 0, 3
	ld b, 15
	ld c, 20
	call ClearBox
	hlcoord 0, 3
	ld b, 15
	ld c, 20
	call ClearBox
	hlcoord 0, 3
	ld b, 15
	ld c, 20
	call ClearBox

	ld c, 20
	call DelayFrames

	ld a, WILD_BATTLE
	ld [wBattleMode], a
	ld de, .WildPokemonText ; "WILD #MON@"
	ld a, [wOTPlayerName + 2] ; differs from pokeyellow
	cp MAX_LEVEL + 1
	jr c, .EnemySet_2_1
	ld a, TRAINER_BATTLE
	ld [wBattleMode], a
	ld de, .TrainerText ; "TRAINER　　　　　@"

.EnemySet_2_1:
	hlcoord 1, 4
	call PlaceString
	hlcoord 1, 6
	ld de, .EnemyNumNameLevelText ; "number name level"
	                              ; "000 ---------- 000"
	call PlaceString

	ld a, [wEnemyMon] ; enemy number
	ld b, a
	ld a, [wBattleMode]
	dec a
	jr z, .EnemySet_3

	ld a, [wTrainerClass]
	ld [wTempByteValue], a
	ld b, a
	ld de, wTempByteValue
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	hlcoord 5, 8
	ld de, .10SpacesText
	call PlaceString
	callfar GetOTName
	hlcoord 5, 8
	ld de, wOTClassName
	call PlaceString
	pop bc
	jr .EnemySet_4

.EnemySet_3:
	ld a, b
	and a
	jr z, .EnemySet_4

	ld de, wTempByteValue
	ld [de], a
	hlcoord 1, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber

	hlcoord 5, 8
	ld de, .10SpacesText
	call PlaceString

	call GetPokemonName
	hlcoord 5, 8
	call PlaceString
	pop bc

.EnemySet_4:
	ld a, [wEnemyMonLevel]
	ld c, a ; level
	ld de, wTempByteValue
	ld [de], a
	hlcoord 16, 8
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	pop bc
 ; fallthrough
.EnemyType:
	ld a, '　'
	ldcoord_a 0, 8
	ldcoord_a 15, 8
	ld a, '▶'
	ldcoord_a 0, 4
 ; fallthrough
.EnemyTypeLoop:
	push bc ; b = monster number c = level
	call DelayFrame
	call GetJoypadDebounced
	pop bc ; b = monster number c = level
	ldh a, [hJoySum]
	bit A_BUTTON_F, a ; "a" button
	jp nz, .TypeChange
	bit START_F, a ; start button
	jp nz, .GoFight
	bit D_DOWN_F, a ; down button
	jp nz, .EnemyMons
	jr .EnemyTypeLoop

.TypeChange:
	hlcoord 1, 8
	ld de, .EnemyLayoutText ; "０００　ーーーーーーーーーー　０００@"
	call PlaceString
	hlcoord 5, 7
	ld de, .10SpacesText ; "10 spaces"
	call PlaceString

	xor a
	ld b, a ; monster or trainer number
	ld c, a ; monster or trainer level
	ld a, [wBattleMode]
	dec a
	jr nz, .TypeChange_1

	ld a, TRAINER_BATTLE ; trainer
	ld [wBattleMode], a
	ld a, '　'
	ldcoord_a 4, 3
	hlcoord 1, 4
	ld de, .TrainerText ; "TRAINER　　　　　@"
	call PlaceString

	jp .EnemyTypeLoop

.TypeChange_1:
	ld a, WILD_BATTLE ; wild monster
	ld [wBattleMode], a
	ld a, '　'
	ldcoord_a 1, 3
	hlcoord 1, 4
	ld de, .WildPokemonText ; "WILD #MON@"
	call PlaceString

	jp .EnemyTypeLoop

.EnemyMons:
	ld a, '▶'
	ldcoord_a 0, 8
	ld a, '　'
	ldcoord_a 15, 8
	ldcoord_a 0, 4
 ; fallthrough
.EnemyMonsLoop:
	push bc ; b = monster number c = level
	call DelayFrame
	call GetJoypadDebounced
	pop bc ; b = monster number c = level
	ldh a, [hJoySum]
	bit A_BUTTON_F, a ; "a" button
	jp nz, .EnemyMonsCountUp
	bit B_BUTTON_F , a ; "b" button
	jp nz, .EnemyMonsCountDown
	bit START_F, a ; start button
	jp nz, .GoFight
	bit D_RIGHT_F, a ; right button
	jp nz, .EnemyLevel
	bit D_UP_F, a ; up button
	jp nz, .EnemyType
	jr .EnemyMonsLoop

.EnemyMonsCountUp:
	push bc ; b = monster number c = level
	hlcoord 5, 7
	ld de, .10SpacesText ; "10 spaces"
	call PlaceString
	hlcoord 5, 8
	ld de, .10SpacesText ; "10 spaces"
	call PlaceString
	pop bc

	ld a, [wBattleMode]
	dec a
	jr z, .MonsCountUp

	inc b ; trainer number
	ld a, b
	cp NUM_TRAINER_CLASSES_OLD
	jr c, .TrainerCountUp

	ld b, 1
 ; fallthrough
.TrainerCountUp:
	ld a, b
	ld [wTempByteValue], a ; trainer number
	ld de, wTempByteValue
	hlcoord 1, 8
	push bc ; b = monster number c = level
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	ld a, [wTempByteValue] ; trainer number
	ld [wTrainerClass], a
	callfar GetOTName
	hlcoord 5, 8
	ld de, wOTClassName
	call PlaceString

	pop bc ; b = monster number c = level
	jp .EnemyMonsLoop

.MonsCountUp
	inc b ; monster number
	ld a, b
	cp NUM_POKEMON_OLD + 1 ; current monster count + 1
	                       ; 252 and 253 were planned to be used?
	jr c, .MonsCountUp_1

	ld b, 1
 ; fallthrough
.MonsCountUp_1:
	ld a, b
	ld [wTempByteValue], a ; monster number
	ld de, wTempByteValue
	hlcoord 1, 8
	push bc ; b = monster number c = level
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	call GetPokemonName
	hlcoord 5, 8
	call PlaceString

	pop bc ; b = monster number c = level
	jp .EnemyMonsLoop

.EnemyMonsCountDown
	push bc ; b = monster number c = level
	hlcoord 5, 7
	ld de, .10SpacesText ; "10 spaces"
	call PlaceString
	hlcoord 5, 8
	ld de, .10SpacesText ; "10 spaces"
	call PlaceString
	pop bc ; b = monster number c = level

	ld a, [wBattleMode]
	dec a
	jr z, .MonsCountDown

	dec b ; trainer number
	ld a, b
	cp NUM_TRAINER_CLASSES_OLD
	jr nc, .TrainerCountDown
	and a
	jp nz, .TrainerCountUp

.TrainerCountDown
	ld b, NUM_TRAINER_CLASSES_OLD - 1
	jp .TrainerCountUp

.MonsCountDown
	dec b ; monster number
	ld a, b
	cp NUM_POKEMON_OLD + 1
	jr nc, .MonsCountDown_1
	and a
	jp nz, .MonsCountUp_1
.MonsCountDown_1
	ld b, NUM_POKEMON_OLD ; monster number
	jp .MonsCountUp_1

.EnemyLevel:
	ld a, '　'
	ldcoord_a 0, 8
	ld a, '▶'
	ldcoord_a 15, 8
 ; fallthrough
.EnemyLevelLoop:
	push bc ; b = monster number c = level
	call DelayFrame
	call GetJoypadDebounced
	pop bc ; b = monster number c = level
	ldh a, [hJoySum]
	bit A_BUTTON_F, a ; "a" button
	jp nz, .EnemyLevelCountUp
	bit B_BUTTON_F, a ; "b" button
	jp nz, .EnemyLevelCountDown
	bit START_F, a ; start button
	jp nz, .GoFight
	bit D_LEFT_F, a ; left button
	jp nz, .EnemyMons
	bit D_UP_F, a ; up button
	jp nz, .EnemyType
	jr .EnemyLevelLoop

.EnemyLevelCountUp:
	inc c ; level
	ld a, c
	cp MAX_LEVEL + 1
	jr c, .EnemyLevelCountUp_1

	ld c, 1

.EnemyLevelCountUp_1
	hlcoord 16, 8
	ld a, c
	ld de, wCurPartyLevel
	ld [de], a
	push bc
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	pop bc
	jp .EnemyLevelLoop

.EnemyLevelCountDown:
	dec c ; level
	ld a, c
	cp MAX_LEVEL + 1
	jr nc, .EnemyLevelCountDown_1
	and a
	jp nz, .EnemyLevelCountUp_1

.EnemyLevelCountDown_1:
	ld c, MAX_LEVEL
	jp .EnemyLevelCountUp_1

.GoFight:
	ld a, b
	and a
	jp z, .EnemyType
	ld a, c
	and a
	jp z, .EnemyType

	ld a, [wBattleMode]
	dec a
	jr z, .GoFight_1

	ld a, b ; trainer number
	ld [wOtherTrainerClass], a
	ld a, c
	ld [wOtherTrainerID], a
	jr .MonsterSet

.GoFight_1:
	ld a, c
	ld [wCurPartyLevel], a
	ld a, b
	ld [wTempWildMonSpecies], a
 ;fallthrough
.MonsterSet:
	call SetPalettes
 ; Don't mess around with obedience.
	ld a, (1 << EARTHBADGE)
	ld [wBadges], a

	ld hl, .PlayerNameText
	ld de, wPlayerName
	ld bc, PLAYER_NAME_LENGTH
	call CopyBytes
	predef StartBattle

	ld a, 1
	ldh [hBGMapMode], a

	xor a
	ld [wNumFleeAttempts], a

	ld hl, wPlayerSubStatus1
	ld bc, 5 ; wPlayerSubStatus1 - wPlayerSubStatus5
	call ByteFill

	ld hl, wEnemySubStatus1
	ld bc, 5 ; wEnemySubStatus1 - wEnemySubStatus5
	call ByteFill

	call LoadFont
	call LoadFontsBattleExtra

	call ClearTileMap
	call ClearSprites

	ld a, %11100100
	ldh [rBGP], a
	ldh [rOBP0], a
	ldh [rOBP1], a

	hlcoord 0, 0
	ld b, 1
	ld c, 18
	call DrawTextBox

	hlcoord 6, 1
	ld de, .FightTestText ; "FIGHT TEST@"
	call PlaceString

	hlcoord 4, 4
	ld de, .NumNameLevelText ; "No.　　　　NAME　　　　LEVEL@"
	call PlaceString

	hlcoord 1, 6
	ld de, .LayoutText ; "１．▶０００　ーーーーー　　０００"
	call PlaceString

	ld de, wPartyCount
	xor a
	ld [de], a
	ld [wCurPartyMon], a
	inc de
	hlcoord 4, 6

	push de
	push hl
 ;fallthrough
.GoFight_2:
	ld a, [wCurPartyMon]
	ld de, wPartySpecies
	add e
	ld e, a
	jr nc, .GoFight_3
	inc d

.GoFight_3
	ld a, [de]
	cp -1
	jp z, .GoFight_5

	ld [wTempByteValue], a
	push hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	inc hl
	ld de, .5SpacesText ; "5 spaces"
	call PlaceString
	call GetPokemonName
	call PlaceString
	pop hl
	push hl
	ld bc, NAME_LENGTH
	add hl, bc
	push hl

	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Level ; level
	ld bc, wPartyMon2 - wPartyMon1
	call AddNTimes
	ld d, h
	ld e, l
	ld a, [de]
	ld [wCurPartyLevel], a
	pop hl
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNumber
	ld a, [wCurPartyMon]
	ld de, wOTPartySpecies
	add e
	ld e, a
	jr nc, .GoFight_4
	inc d
.GoFight_4:
	ld a, [wCurPartyLevel]
	ld [de], a
	pop hl
	ld a, [wCurPartyMon]
	inc a
	ld [wCurPartyMon], a
	ld bc, SCREEN_WIDTH * 2
	add hl, bc
	jp .GoFight_2

.GoFight_5:
	pop hl
	pop de
	ld a, [wPartyMon1]
	ld b, a
	ld a, [wPartyMon1Level]
	ld c, a
	xor a
	ld [wCurPartyMon], a
	jp .MonsNumber

.FightTestText:
	db   "テスト　ファイト@" ; "FIGHT TEST@"
.NumNameLevelText:
	db   "・．　　なまえ　　　　レべル@" ; "No.　　　　NAME　　　　LEVEL@"
.LayoutText:
	db   "１．▶０００　ーーーーー　　０００"
	next "２．　０００　ーーーーー　　０００"
	next "３．　０００　ーーーーー　　０００"
	next "４．　０００　ーーーーー　　０００"
	next "５．　０００　ーーーーー　　０００"
	next "６．　０００　ーーーーー　　０００@"
.5SpacesText:
	db   "　　　　　@"
.5DashesText:
	db   "ーーーーー@"
.WildPokemonText:
	db   "ワイルドモンスター@" ; "WILD #MON@"
.TrainerText:
	db   "ディーラー　　　　@" ; "TRAINER　　　　　@"
.EnemyNumNameLevelText:
	db   "・．　　なまえ　　　　　　　　レべル" ; "No.　　　　NAME　　　　　　　　LEVEL@"
	next ""
.EnemyLayoutText
	db   "０００　ーーーーーーーーーー　０００@"
.10SpacesText:
	db   "　　　　　　　　　　@"
.PlayerNameText:
	db   "ゴールド@@" ; "GOLD@@"

.ItemTable_Old: ; unreferenced, used in pokeyellow but hasn't been updated to fit the new item constants
	db ITEM_03,           99
	db ITEM_GREAT_BALL,   99
	db ITEM_ICE_HEAL,     99
	db ITEM_HYPER_POTION, 99
	db ITEM_SUPER_POTION, 99
	db ITEM_POTION,       99
	db ITEM_ESCAPE_ROPE,  99
	db ITEM_REPEL,        99
	db $FF
