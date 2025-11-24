INCLUDE "constants.asm"

SECTION "scripts/SilentHill.asm", ROMX

SilentHill_ScriptLoader::
	ld hl, SilentHillScriptPointers1
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillNPCIDs1:
	db 0
	db 2
	db 3
	db $FF

SilentHillNPCIDs2:
	db 2
	db 3
	db $FF

SilentHillNPCIDs3:
	db 1
	db 2
	db 3
	db $FF

SilentHillScriptPointers1:
	dw SilentHillScript1
	dw SilentHillNPCIDs1

SilentHillScriptPointers2:
	dw SilentHillScript2
	dw SilentHillNPCIDs1

SilentHillScriptPointers3:
	dw SilentHillScript3
	dw SilentHillNPCIDs1

SilentHillScriptPointers4:
	dw SilentHillScript4
	dw SilentHillNPCIDs2

SilentHillScriptPointers5:
	dw SilentHillScript5
	dw SilentHillNPCIDs3

SilentHillScriptPointers6:
	dw SilentHillScript6
	dw SilentHillNPCIDs2

SilentHillScriptPointers7:
	dw SilentHillScript7
	dw SilentHillNPCIDs2

SilentHillScript1:
	ld a, [wYCoord]
	cp 5
	ret nz
	ld a, [wXCoord]
	cp 5
	ret nz
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 02
	call FreezeAllOtherObjects
	ld a, 02
	ld hl, SilentHillMovement1
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
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
	ld a, 2
	ld hl, SilentHillMovement2
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 2
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
	ld a, 3
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
	cp 09
	jr nz, .bigjump
.jump
	call Function776a
	ld hl, SilentHillTextNorthExit
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call CopyMapObjectToReservedObjectStruct
	ld a, 3
	call FreezeAllOtherObjects
	ld a, [wYCoord]
	cp 9
	jr z, .jump2
	ld hl, SilentHillMovement3
	jr .skip
.jump2
	ld hl, SilentHillMovement4
.skip
	ld a, 03
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 4
	ld [wMapScriptNumber], a
	ret

.bigjump
	ld hl, SilentHillNPCIDs2
	ld de, SilentHillSignPointers
	call CallMapTextSubroutine
	ret

Function776a:
	ld hl, wd41a
	set 7, [hl]
	ld a, 1
	ld hl, wd29d
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
	ld a, 3
	call FreezeAllOtherObjects
	ld a, 0
	call UnfreezeObject
	ld b, 3
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
	ld a, 3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ld a, 5
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
	ld hl, wd41b
	bit 2, [hl]
	ret z
	ld a, $12
	ld [wd29d], a
	ld a, 6
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
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ret

SilentHillTextString1:
	text "あれ？　カギが　かかっている"
	done

SilentHillMovement7:
	slow_step DOWN
	step_end

SilentHillSignPointers::
	dw SilentHillPlayerHouseText
	dw Function38c6
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
	jp Text_asmReturn

MomNameMenuHeaderUnused:
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .MomNameMenuDataUnused
	db 01 ; initial selection

.MomNameMenuDataUnused:
	db STATICMENU_CURSOR
	db 04 ; items
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
	text "あなたの　リュック　かっこいいわよ"
	line "どこで　てに　いれたの？"
	done

SilentHillTextPokemonHate:
	ld hl, SilentHillTextPokemonHateString
	call OpenTextbox
	ret

SilentHillTextPokemonHateString:
	text "よのなかに　ポケモンが　きらいな"
	line "ひとは　いるのかな？"
	done
