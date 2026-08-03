	ret

SilentHill_ScriptLoader::
	ld hl, SilentHillScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillNPCIDs1:
	npc_id SILENT_HILL_RIVAL
	npc_id SILENT_HILL_TEACHER
	npc_id SILENT_HILL_SUPER_NERD
	db -1

SilentHillNPCIDs2:
	npc_id SILENT_HILL_TEACHER
	npc_id SILENT_HILL_SUPER_NERD
	db -1

SilentHillNPCIDs3:
	npc_id SILENT_HILL_BLUE
	npc_id SILENT_HILL_TEACHER
	npc_id SILENT_HILL_SUPER_NERD
	db -1

SilentHillScriptPointers::
	def_script_pointers
	script_pointer SilentHillScript1, SilentHillNPCIDs1, SCRIPT_SILENT_HILL_DEFAULT
	script_pointer SilentHillScript2, SilentHillNPCIDs1, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE
	script_pointer SilentHillScript3, SilentHillNPCIDs1, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE_2
	script_pointer SilentHillScript4, SilentHillNPCIDs2, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE_END
	script_pointer SilentHillScript5, SilentHillNPCIDs3, SCRIPT_SILENT_HILL_BLUE_CUTSCENE
	script_pointer SilentHillScript6, SilentHillNPCIDs2, SCRIPT_SILENT_HILL_FOLLOW_BLUE
	script_pointer SilentHillScript7, SilentHillNPCIDs2, SCRIPT_SILENT_HILL_GOT_STARTER

SilentHillScript1:
	ld a, [wYCoord]
	cp 5
	ret nz
	ld a, [wXCoord]
	cp 5
	ret nz
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, SILENT_HILL_RIVAL
	call FreezeAllOtherObjects
	ld a, SILENT_HILL_RIVAL
	ld hl, SilentHillMovement1
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE
	ld [wMapScriptNumber], a
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillMovement1:
	big_step UP
	big_step UP
	big_step UP
	step UP
	slow_step UP
	turn_head LEFT
	step_end

SilentHillScript2:
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillTextRival1
	call OpenTextbox
	ld hl, SilentHillTextRival2
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, SILENT_HILL_RIVAL
	ld hl, SilentHillMovement2
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ld a, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE_2
	ld [wMapScriptNumber], a
	ret

SilentHillMovement2:
	turn_head DOWN
	slow_step DOWN
	step DOWN
	big_step DOWN
	big_step DOWN
	big_step DOWN
	remove_object

SilentHillScript3:
	call UnfreezeAllObjects
	ld a, SCRIPT_SILENT_HILL_RIVAL_CUTSCENE_END
	ld [wMapScriptNumber], a
	call InitObjectMasks
	ret

SilentHillScript4:
	ld a, [wXCoord]
	cp 0
	jr nz, .bigjump
	ld a, [wYCoord]
	cp 8
	jr z, .jump
	cp 9
	jr nz, .bigjump
.jump
	call .TalkedToBlue
	ld hl, SilentHillTextNorthExit
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, SILENT_HILL_BLUE
	call CopyMapObjectToReservedObjectStruct
	ld a, SILENT_HILL_BLUE
	call FreezeAllOtherObjects
	ld a, [wYCoord]
	cp 9
	jr z, .jump2
	ld hl, SilentHillMovement3
	jr .skip
.jump2
	ld hl, SilentHillMovement4
.skip
	ld a, SILENT_HILL_BLUE
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ld a, SCRIPT_SILENT_HILL_BLUE_CUTSCENE
	ld [wMapScriptNumber], a
	ret

.bigjump
	ld hl, SilentHillNPCIDs2
	ld de, SilentHillSignPointers
	call CallMapTextSubroutine
	ret

.TalkedToBlue:
	SetEvent SILENT_HILL_TALKED_TO_BLUE
	ld a, SCRIPT_SILENT_HILL_LAB_FRONT_START_BLUE_CUTSCENE
	ld hl, wSilentHillLabFrontSceneID
	ld [hl], a
	ret

SilentHillMovement3:
	step LEFT
	step LEFT
	step LEFT
	step UP
	step LEFT
	slow_step LEFT
	turn_head LEFT
	step_end

SilentHillMovement4:
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	slow_step LEFT
	turn_head LEFT
	step_end

SilentHillScript5:
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillTextPokemonInGrassString
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, SILENT_HILL_BLUE
	call FreezeAllOtherObjects
	ld a, 0
	call UnfreezeObject
	ld b, SILENT_HILL_BLUE
	ld c, 0
	call StartFollow
	ld a, [wYCoord]
	cp 9
	jr z, .jump
	ld hl, SilentHillMovement5
	jr .skip
.jump
	ld hl, SilentHillMovement6
.skip
	ld a, SILENT_HILL_BLUE
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ld a, SCRIPT_SILENT_HILL_FOLLOW_BLUE
	ld [wMapScriptNumber], a
	ret

SilentHillMovement5:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	slow_step UP
	remove_object

SilentHillMovement6:
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	step RIGHT
	slow_step UP
	remove_object

SilentHillScript6:
	ld hl, SilentHillNPCIDs2
	ld de, SilentHillSignPointers
	call CallMapTextSubroutine
	CheckEvent SILENT_HILL_LAB_BACK_CHOSE_STARTER
	ret z
	ld a, SCRIPT_SILENT_HILL_LAB_FRONT_FINISHED
	ld [wSilentHillLabFrontSceneID], a
	ld a, SCRIPT_SILENT_HILL_GOT_STARTER
	ld [wMapScriptNumber], a
	ret

SilentHillScript7:
	call CheckLabDoor
	ret z
	ld hl, SilentHillNPCIDs2
	ld de, SilentHillSignPointers
	call CallMapTextSubroutine
	ret

CheckLabDoor:
	ld a, [wYCoord]
	cp $C
	ret nz
	ld a, [wXCoord]
	cp $E
	jr z, .jump
	ld a, [wXCoord]
	cp $F
	ret nz
.jump
	ldh a, [hJoyState]
	bit 6, a
	ret z
	ld a, 0
	ld d, UP
	call SetObjectFacing
	ld hl, wJoypadFlags
	set 6, [hl]
	ld hl, SilentHillTextString1
	call OpenTextbox
	call LabClosed
	call xor_a
	ret

LabClosed:
	ld a, 0
	ld hl, SilentHillMovement7
	call LoadMovementDataPointer
	ld hl, wOverworldFlags
	set OVERWORLD_PAUSE_MAP_PROCESSES_F, [hl]
	ld a, MAPSTATUS_EVENT_RUNNING
	call SetMapStatus
	ret

SilentHillTextString1:
	text "あれ？　カギが　かかっている"
	done

SilentHillMovement7:
	slow_step DOWN
	step_end

SilentHillSignPointers::
	dw SilentHillPlayerHouseText
	dw PokecenterSignScript
	dw SilentHillSignText1
	dw SilentHillLabText
	dw SilentHillRivalHouseText

SilentHillLabText:
	ld hl, SilentHillTextString2
	call OpenTextbox
	ret

SilentHillTextString2:
	text "にゅうきょしゃ　ぼしゅうちゅう！"
	done

SilentHillSignText1:
	ld hl, SilentHillTextString3
	call OpenTextbox
	ret

SilentHillTextString3:
	text "ここは　サイレント　ヒル"
	line "しずかな　おか"
	done

SilentHillPlayerHouseText:
	ld hl, SilentHillTextString4
	call OpenTextbox
	ret

SilentHillTextString4:
	text "ここは　<PLAYER>　のいえ"
	done

SilentHillRivalHouseText:
	ld hl, SilentHillTextString5
	call OpenTextbox
	ret

SilentHillTextString5:
	text "ここは　<RIVAL>　のいえ"
	done

SilentHill_TextPointers::
	dw SilentHillTextRival1 ; west
	dw SilentHillTextNorthExit ; north
	dw SilentHillTextBackpack ; npc1
	dw SilentHillTextPokemonHate ; npc2

SilentHillTextRival1:
	text "<RIVAL>『よう　ちょっと　おまえに"
	cont "じまん　したいことが"
	cont "あってきたんだよ"

	para "おれ　あの　ゆうめいなオーキドから"
	line "メール　もらっちゃった！"
	cont "え？　おまえにも　きたの？"
	cont "ちぇっ！　つまんねーの！"

	para "⋯⋯ふん！"
	line "じゃあさ　じゃあさー　おまえさー"
	cont "じぶんの　ははおや　のこと"
	cont "いつも　なんて　よんでる？@"

	start_asm
	call LoadStandardMenuHeader
	callfar MomNamePrompt
	call CloseWindow
	call GetMemSGBLayout
	call UpdateSprites
	call UpdateTimePals
	jp TextAsmEnd

MomNameMenuHeaderUnused:
	db MENU_BACKUP_TILES ; flags
	menu_coords 0, 0, 10, 11
	dw .MomNameMenuDataUnused
	db 1 ; initial selection

.MomNameMenuDataUnused:
	db STATICMENU_CURSOR
	db 4 ; items
	db "じぶんで　きめる@"
	db "おかあさん　@"
	db "ママ@"
	db "かあちゃん@"

SilentHillTextRival2: ; BYTE OFF
	text "<RIVAL>『えー　かっこわりい！"
	line "そんな　こどもっぽい"
	cont "よびかた　してるなんて"
	cont "おわらいだぜ！"
	cont "あー　ちょっとだけ　すっきりした！"

	para "そんじゃあ"
	line "おれは　ひとあし　おさきに"
	cont "オーキドのところへ"
	cont "いくことに　するぜ！"
	done

SilentHillTextNorthExit:
	text "ちょいまち！"
	line "まってよ！　まてっ　てば！"
	done

SilentHillTextPokemonInGrassString:
	text "きみは　まったく"
	line "なんにも　しらないんだね！"
	cont "くさむらでは"
	cont "やせいの　ポケモンが　とびだす！"

	para "じぶんも　ポケモンを"
	line "もって　いれば"
	cont "たたかえるんだ⋯⋯"

	para "あっ！　ひょっとして　きみは"
	line "⋯⋯ちょっと"
	cont "ぼくに　ついて　きて！"
	done

SilentHillTextBackpack:
	ld hl, SilentHillTextBackpackString
	call OpenTextbox
	ret

SilentHillTextBackpackString:
if DEF(_GOLD)
	text "あなたの　リュック　かっこいいわよ"
	line "どこで　てに　いれたの？"
	done
endc
if DEF(_SILVER)
	text "その　とけい　かっこいいわね"
	line "えっ　トレーナーギアって　いうの？"
	done
endc

SilentHillTextPokemonHate:
	ld hl, SilentHillTextPokemonHateString
	call OpenTextbox
	ret

SilentHillTextPokemonHateString:
if DEF(_GOLD)
	text "よのなかに　ポケモンが　きらいな"
	line "ひとは　いるのかな？"
	done
endc
if DEF(_SILVER)
	text "なに？　きみは"
	line "ポケモンを　あつめてるのか！"

	para "それは　すばらしいことだ"
	done
endc
