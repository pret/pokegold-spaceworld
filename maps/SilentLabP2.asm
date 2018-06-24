include "constants.asm"

SECTION "Silent Lab P2 Script", ROMX[$5C69], BANK[$34]

SilentLabP2ScriptLoader:: ; 5C69
	ld hl, SilentLabP2ScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentLabP2ScriptPointers: ; 5C73
	dw SilentLabP2Script1
	dw SilentLabP2NPCIDs1
	dw SilentLabP2Script2 
	dw SilentLabP2NPCIDs1
	dw SilentLabP2Script3
	dw SilentLabP2NPCIDs1
	dw SilentLabP2RivalChoosePokemon
	dw SilentLabP2NPCIDs1
	dw SilentLabP2Script5 
	dw SilentLabP2NPCIDs1 
	dw SilentLabP2Script6 
	dw SilentLabP2NPCIDs1 
	dw SilentLabP2Script7
	dw SilentLabP2NPCIDs1
	
SilentLabP2NPCIDs1: ; 5C8F
	db 00, 01, 02, 03, 04, $FF 
SilentLabP2NPCIDs2: ; 5C95
	db 00, 01, 04, $FF 
SilentLabP2NPCIDs3: ; 5C99
	db 00, 01, 02, $FF 
SilentLabP2NPCIDs4: ; 5C9D
	db 00, 01, 03, $FF
	
SilentLabP2TextPointers1: ; 5CA1 
	dw SilentLabP2Text1
	dw SilentLabP2Func3
	dw SilentLabP2Func4 
	dw SilentLabP2Func4
	dw SilentLabP2Func4
	
SilentLabP2Script1: ; 5CAB
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 0
	call Function17f9
	ld a, 0
	ld hl, SilentLabP2Movement1
	call LoadMovementDataPointer
	ld hl, wd41b
	set 1, [hl]
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP2Movement1: ; 5CD2
	db 09, 09, 05, $32
	
SilentLabP2Script2: ; 5CD6
	ld hl, wc5ed
	set 6, [hl]
	call Function20f8
	ld a, 3
	ld d, UP
	call SetObjectFacing
	ld hl, SilentLabP2TextString1
	call OpenTextbox
	ld hl, SilentLabP2TextString10
	call OpenTextbox
	ld hl, SilentLabP2TextString2
	call OpenTextbox
	ld a, 2
	ld [wMapScriptNumber], a
	ret
	
SilentLabP2Script3: ; 5CFD
	ld hl, SilentLabP2NPCIDs1
	ld de, SilentLabP2TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP2RivalChoosePokemon: ; 5D07
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call Function17f9
	ld hl, SilentLabP2MovementPointers
	ld a, [wChosenStarter]
	ld d, 0
	ld e, a
	add hl, de
	add hl, de
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	ld a, 3
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 4
	ld [wMapScriptNumber], a
	ld a, 1
	call WriteIntod637
	ret
	
SilentLabP2MovementPointers: ; 5D34
	dw SilentLabP2Movement2+1
	dw SilentLabP2Movement2
	dw SilentLabP2Movement2+2
	
SilentLabP2Movement2: ; 5D3A
	db $0B, $0B, $0B, $0B, $05, $32
	
SilentLabP2Script5: ; 5D40
	ld hl, SilentLabP2TextString12
	call OpenTextbox
	ld a, [wd266]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, SilentLabP2TextString13
	call OpenTextbox
	ld a, 5
	ld [wMapScriptNumber], a
	ret
	
SilentLabP2Script6: ; 5D5B
	call Function20f8
	ld hl, wc5ed
	res 6, [hl]
	ld a, 6
	ld[wMapScriptNumber], a
	ret
	
SilentLabP2Script7: ; 5D69
	ld hl, SilentLabP2NPCIDs1
	ld de, SilentLabP2TextPointers2
	call CallMapTextSubroutine
	ret
	
SilentLabP2Text1: ; 5D73
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentLabP2TextString3
	jr z, .skip
	ld hl, SilentLabP2TextString9
.skip
	call OpenTextbox
	ret
	
SilentLabP2TextString1: ; 5D84
	text "オーキド『ほれ　そこに　３びき"
	cont "ポケモンが　いる　じゃろう！"
	cont "ほっほ！"
	
	para "こいつらを　きみたちに"
	cont "いっぴき　づつ　やろう！"
	cont "……　さあ　えらべ！"
	done
	
SilentLabP2TextString2: ; 5DCD
	text "オーキド『まあ"
	line "あわてるな　<RIVAL>！"
	cont "おまえも　すきなものを　とれ！"
	done
	
SilentLabP2TextString3: ; 5DEF
	text "オーキド『さあ　<PLAYER>"
	line "どの　ポケモンに　するかね？"
	done
	
SilentLabP2TextString4: ; 5E1C
	text "オーキド『ほう！　ほのおのポケモン"
	line "@"
	ld bc, wStringBuffer1
	text "に　するんじゃな？@"
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
SilentLabP2TextString5: ; 5E32
	text "オーキド『ふむ　みずのポケモン"
	line "@"
	ld bc, wStringBuffer1
	text "に　きめるのじゃな？@"
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
SilentLabP2TextString6: ; 5E6E
	text "オーキド『おお！　くさのポケモン"
	line "@"
	ld bc, wStringBuffer1
	text "が　いいんじゃな？@"
	db 08
	call ConfirmPokemonSelection 
	call Function3036
	ret
	
ConfirmPokemonSelection: ; 5E85
	call YesNoBox
	jr c, .bigJump
	ld hl, wd41b
	set 2, [hl]
	ld a, 1
	ld [wd29b], a
	ld a, 1
	ld [wd29a], a
	ld a, 1
	ld [wd2a0], a
	ld hl, SilentLabP2TextString8
	call PrintText
	ld hl, wJoypadFlags
	set 5, [hl]
	ld a, [wd265]
	ld [wMonDexIndex], a
	ld a, 5
	ld [wCurPartyLevel], a
	callab Function60a0
	xor a
	ld [wPartyMon1 + 1], a
	ld a, 3
	ld [wMapScriptNumber], a
	ret
.bigJump ; 5EC6
	ld hl, SilentLabP2TextString7
	call PrintText 
	ret
	
SilentLabP2TextString7: ; 5ECD
	text "では"
	line "どれに　するのじゃ？"
	done
	
SilentLabP2TextString8: ; 5EDC
	text "オーキド『この　ポケモンは"
	line "ほんとに　げんきが　いいぞ！"
	
	para "<PLAYER>は　オーキドはかせから"
	line "@"
	ld bc, wStringBuffer1
	text "を　もらった！<PROMPT>"
	
SilentLabP2TextString9: ; 5F14
	text "オーキド『そうじゃ！"
	line "やせいの　ポケモンが　でて　きても"
	cont "そいつを　たたかわせて　いけば"
	cont "となりまちへ　いける！"
	done
	
SilentLabP2Func3: ; 5F4E
	ld hl, wd41b
	bit 2, [hl]
	ld hl, SilentLabP2TextString11
	jr z, .skip
	ld hl, SilentLabP2TextString14
.skip
	call OpenTextbox
	ret
	
SilentLabP2TextString10: ; 5F5F
	text "<RIVAL>『あッ！　おれにも！"
	line "じいさん　おれにもくれよう！"
	done
	
SilentLabP2TextString11: ; 5F7B
	text "<RIVAL>『いいぜ　<PLAYER>！"
	line "さきに　えらんで！"
	cont "おれは　こころが　ひろいからな"
	done
	
SilentLabP2TextString12: ; 5F9F
	text "<RIVAL>『じゃ　おれは　これ！"
	done
	
SilentLabP2TextString13: ; 5FAD
	text "<RIVAL>は　オーキドから"
	line "@"
	ld bc, wStringBuffer1
	text "を　もらった！"
	done
	
SilentLabP2TextString14: ; 5FC5
	text "<RIVAL>『<PLAYER>の#"
	line "いいなあ！"
	cont "でも　おれのポケモンも"
	cont "ちょっと　いいだろ？"
	done
	
SilentLabP2Func4: ; 5FE9
	ld hl, wd41b
	bit 2, [hl]
	jr nz, .bigjump
	ldh a, [hFFEA]
	sub 2
	ld [wChosenStarter], a
	ld d, 0
	ld e, a
	ld hl, SilentLabP2StarterData
	add hl, de
	add hl, de
	add hl, de
	add hl, de
	ld a, [hl+]
	ld [wd265], a
	push hl
	ld [wNamedObjectIndexBuffer], a
	callba Function6734
	ld a, [wd265]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	pop hl
	push hl
	ld a, [hl+]
	ld h, [hl]
	ld l, a
	call OpenTextbox
	pop hl
	inc hl
	inc hl
	ld a, [hl]
	ld [wd266], a
	ret
.bigjump
	ld hl, SilentLabP2TextString15
	call OpenTextbox
	ret
	
SilentLabP2StarterData: ; 6031
	db DEX_HONOGUMA 
	dw $5E09 
	db DEX_KURUSU 
	
	db DEX_KURUSU 
	dw $5E33 
	db DEX_HAPPA

	db DEX_HAPPA 
	dw $5E5C 
	db DEX_HONOGUMA
	
SilentLabP2TextString15: ; 603D
	text "オーキド『これ！"
	line "よくばっちゃ　いかん！"
	done
	
SilentLabP2TextPointers2: ; 6053
	dw Function3899 
	dw Function3899
	dw Function3899
	dw Function3899
	dw MapDefaultText
	
; 605D