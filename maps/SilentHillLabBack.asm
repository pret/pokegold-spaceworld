	map_attributes SilentHillLabBack, SILENT_HILL_LAB_BACK

	object_const_def
	const SILENT_HILL_LAB_BACK_OAK
	const SILENT_HILL_LAB_BACK_RIVAL
	const SILENT_HILL_LAB_BACK_STARTER_HONOGUMA
	const SILENT_HILL_LAB_BACK_STARTER_CRUISE
	const SILENT_HILL_LAB_BACK_STARTER_HAPPA
	
SilentHillLabBack_MapEvents::
	dw $4000 ; unknown

	def_warp_events
	warp_event  3,  7, SILENT_HILL_LAB_FRONT, 3, 42
	warp_event  4,  7, SILENT_HILL_LAB_FRONT, 3, 43

	def_bg_events
	bg_event  0,  1, 1
	bg_event  1,  1, 2
	bg_event  2,  1, 3
	bg_event  3,  1, 4
	bg_event  6,  0, 5

	def_object_events
	object_event  4,  2, SPRITE_OKIDO, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  3,  4, SPRITE_SILVER, SPRITEMOVEFN_TURN_UP, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  5,  2, SPRITE_POKE_BALL, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  6,  2, SPRITE_POKE_BALL, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0
	object_event  7,  2, SPRITE_POKE_BALL, SPRITEMOVEFN_TURN_DOWN, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0

SilentHillLabBack_Blocks::
INCBIN "maps/SilentHillLabBack.blk"

	map_generic_scriptloader

SilentHillLabBackScriptPointers::
	def_script_pointers
	script_pointer SilentHillLabBackScript1, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_DEFAULT
	script_pointer SilentHillLabBackScript2, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_OAK_INSTRUCTION
	script_pointer SilentHillLabBackScript3, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_CHOOSE_STARTER
	script_pointer SilentHillLabBackRivalChoosePokemon, SilentHillLabBackNPCIDs1,  SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER
	script_pointer SilentHillLabBackScript5, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER2
	script_pointer SilentHillLabBackScript6, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER3
	script_pointer SilentHillLabBackScript7, SilentHillLabBackNPCIDs1, SCENE_SILENT_HILL_LAB_BACK_CUTSCENE_OVER

SilentHillLabBackNPCIDs1:
	npc_id SILENT_HILL_LAB_BACK_OAK
	npc_id SILENT_HILL_LAB_BACK_RIVAL
	npc_id SILENT_HILL_LAB_BACK_STARTER_HONOGUMA
	npc_id SILENT_HILL_LAB_BACK_STARTER_CRUISE
	npc_id SILENT_HILL_LAB_BACK_STARTER_HAPPA
	db -1

SilentHillLabBackNPCIDs2:
	npc_id SILENT_HILL_LAB_BACK_OAK
	npc_id SILENT_HILL_LAB_BACK_RIVAL
	npc_id SILENT_HILL_LAB_BACK_STARTER_HAPPA
	db -1

SilentHillLabBackNPCIDs3:
	npc_id SILENT_HILL_LAB_BACK_OAK
	npc_id SILENT_HILL_LAB_BACK_RIVAL
	npc_id SILENT_HILL_LAB_BACK_STARTER_HONOGUMA
	db -1

SilentHillLabBackNPCIDs4:
	npc_id SILENT_HILL_LAB_BACK_OAK
	npc_id SILENT_HILL_LAB_BACK_RIVAL
	npc_id SILENT_HILL_LAB_BACK_STARTER_CRUISE
	db -1


SilentHillLabBack_TextPointers::
	dw SilentHillLabBackText1
	dw SilentHillLabBackFunc3
	dw SilentHillLabBackFunc4
	dw SilentHillLabBackFunc4
	dw SilentHillLabBackFunc4

SilentHillLabBackScript1:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call FreezeAllOtherObjects
	ld a, 0
	ld hl, SilentHillLabBackMovement1
	call LoadMovementDataPointer
	SetEvent SILENT_HILL_LAB_BACK_FOLLOWED_OAK
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_BACK_OAK_INSTRUCTION
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabBackMovement1:
	step UP
	step UP
	slow_step UP
	step_end

SilentHillLabBackScript2:
	ld hl, wOverworldFlags
	set OVERWORLD_DISABLE_MAP_CONNECTIONS_F, [hl]
	call UnfreezeEverything
	ld a, SILENT_HILL_LAB_BACK_RIVAL
	ld d, UP
	call SetObjectFacing
	ld hl, SilentHillLabBackTextString1
	call OpenTextbox
	ld hl, SilentHillLabBackTextString10
	call OpenTextbox
	ld hl, SilentHillLabBackTextString2
	call OpenTextbox
	ld a, SCENE_SILENT_HILL_LAB_BACK_CHOOSE_STARTER
	ld [wMapScriptNumber], a
	ret

SilentHillLabBackScript3:
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabBackRivalChoosePokemon:
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, SILENT_HILL_LAB_BACK_RIVAL
	call FreezeAllOtherObjects
	ld hl, SilentHillLabBackMovementPointers
	ld a, [wChosenStarter]
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, SILENT_HILL_LAB_BACK_RIVAL
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER2
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillLabBackMovementPointers:
	dw SilentHillLabBackMovement2+1
	dw SilentHillLabBackMovement2
	dw SilentHillLabBackMovement2+2

SilentHillLabBackMovement2:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	slow_step UP
	step_end

SilentHillLabBackScript5:
	ld hl, SilentHillLabBackTextString12
	call OpenTextbox
	ld a, [wRivalStarter]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, SilentHillLabBackTextString13
	call OpenTextbox
	ld a, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER3
	ld [wMapScriptNumber], a
	ret

SilentHillLabBackScript6:
	call UnfreezeEverything
	ld hl, wOverworldFlags
	res 6, [hl]
	ld a, SCENE_SILENT_HILL_LAB_BACK_CUTSCENE_OVER
	ld [wMapScriptNumber], a
	ret

SilentHillLabBackScript7:
	ld hl, SilentHillLabBackNPCIDs1
	ld de, SilentHillLabBackTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillLabBackText1:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ld hl, SilentHillLabBackTextString3
	jr z, .skip
	ld hl, SilentHillLabBackTextString9
.skip
	call OpenTextbox
	ret

SilentHillLabBackTextString1:
	text "オーキド『ほれ　そこに　３びき"
	cont "ポケモンが　いる　じゃろう！"
	cont "ほっほ！"

	para "こいつらを　きみたちに"
	cont "いっぴき　づつ　やろう！"
	cont "⋯⋯　さあ　えらべ！"
	done

SilentHillLabBackTextString2:
	text "オーキド『まあ"
	line "あわてるな　<RIVAL>！"
	cont "おまえも　すきなものを　とれ！"
	done

SilentHillLabBackTextString3:
	text "オーキド『さあ　<PLAYER>"
	line "どの　ポケモンに　するかね？"
	done

SilentHillLabBackTextString4:
	text "オーキド『ほう！　ほのおのポケモン"
	line "@"
	text_from_ram wStringBuffer1
	text "に　するんじゃな？@"

	start_asm
	call ConfirmPokemonSelection
	call TextAsmEnd
	ret

SilentHillLabBackTextString5:
	text "オーキド『ふむ　みずのポケモン"
	line "@"
	text_from_ram wStringBuffer1
	text "に　きめるのじゃな？@"

	start_asm
	call ConfirmPokemonSelection
	call TextAsmEnd
	ret

SilentHillLabBackTextString6:
	text "オーキド『おお！　くさのポケモン"
	line "@"
	text_from_ram wStringBuffer1
	text "が　いいんじゃな？@"

	start_asm
	call ConfirmPokemonSelection
	call TextAsmEnd
	ret

ConfirmPokemonSelection:
	call YesNoBox
	jr c, .bigJump
	SetEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ld a, SCENE_PLAYER_HOUSE_1F_MOM_BACK
	ld [wPlayerHouse1FSceneID], a
	ld a, SCENE_PLAYER_HOUSE_2F_KEN_LEFT
	ld [wPlayerHouse2FSceneID], a
	ld a, SCENE_RIVAL_HOUSE_KEN_HERE
	ld [wRivalHouseSceneID], a
	ld hl, SilentHillLabBackTextString8
	call PrintText
	ld hl, wJoypadFlags
	set 5, [hl]
	ld a, [wPlayerStarter]
	ld [wCurPartySpecies], a
	ld a, 5
	ld [wCurPartyLevel], a
	callfar GivePoke
	xor a
	ld [wPartyMon1 + 1], a
	ld a, SCENE_SILENT_HILL_LAB_BACK_RIVAL_CHOOSING_STARTER
	ld [wMapScriptNumber], a
	ret
.bigJump
	ld hl, SilentHillLabBackTextString7
	call PrintText
	ret

SilentHillLabBackTextString7:
	text "では"
	line "どれに　するのじゃ？"
	done

SilentHillLabBackTextString8:
	text "オーキド『この　ポケモンは"
	line "ほんとに　げんきが　いいぞ！"

	para "<PLAYER>は　オーキドはかせから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	prompt

SilentHillLabBackTextString9:
	text "オーキド『そうじゃ！"
	line "やせいの　ポケモンが　でて　きても"
	cont "そいつを　たたかわせて　いけば"
	cont "となりまちへ　いける！"
	done

SilentHillLabBackFunc3:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ld hl, SilentHillLabBackTextString11
	jr z, .skip
	ld hl, SilentHillLabBackTextString14
.skip
	call OpenTextbox
	ret

SilentHillLabBackTextString10:
	text "<RIVAL>『あッ！　おれにも！"
	line "じいさん　おれにもくれよう！"
	done

SilentHillLabBackTextString11:
	text "<RIVAL>『いいぜ　<PLAYER>！"
	line "さきに　えらんで！"
	cont "おれは　こころが　ひろいからな"
	done

SilentHillLabBackTextString12:
	text "<RIVAL>『じゃ　おれは　これ！"
	done

SilentHillLabBackTextString13:
	text "<RIVAL>は　オーキドから"
	line "@"
	text_from_ram wStringBuffer1
	text "を　もらった！"
	done

SilentHillLabBackTextString14:
	text "<RIVAL>『<PLAYER>の#"
	line "いいなあ！"
	cont "でも　おれのポケモンも"
	cont "ちょっと　いいだろ？"
	done

SilentHillLabBackFunc4:
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	jr nz, .bigjump
	ldh a, [hLastTalked]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, SilentHillLabBackStarterData
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wPlayerStarter], a
	push hl
	ld [wNamedObjectIndexBuffer], a
	farcall StarterDex
	ld a, [wPlayerStarter]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	call OpenTextbox
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wRivalStarter], a
	ret
.bigjump
	ld hl, SilentHillLabBackTextString15
	call OpenTextbox
	ret

SilentHillLabBackStarterData:
	db DEX_HONOGUMA
	dw SilentHillLabBackTextString4
	db DEX_CRUISE

	db DEX_CRUISE
	dw SilentHillLabBackTextString5
	db DEX_HAPPA

	db DEX_HAPPA
	dw SilentHillLabBackTextString6
	db DEX_HONOGUMA

SilentHillLabBackTextString15:
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done

SilentHillLabBackTextPointers2:
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw PokemonBooksScript
	dw MapDefaultText
