include "constants.asm"

SECTION "maps/SilentHill.asm", ROMX

SilentHillScriptLoader:: ; 7669
	ld hl, SilentHillScriptPointers1
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHillNPCIDs1: ; 7673
	db 0
	db 2
	db 3
	db $FF
	
SilentHillNPCIDs2: ; 7677
	db 2
	db 3
	db $FF
	
SilentHillNPCIDs3: ; 767A
	db 1
	db 2
	db 3
	db $FF
	
SilentHillScriptPointers1: ; 767E
	dw SilentHillScript1
	dw SilentHillNPCIDs1 
	
SilentHillScriptPointers2: ; 7682
	dw SilentHillScript2 
	dw SilentHillNPCIDs1 
	
SilentHillScriptPointers3: ; 7686
	dw SilentHillScript3 
	dw SilentHillNPCIDs1 
	
SilentHillScriptPointers4: ; 768A
	dw SilentHillScript4 
	dw SilentHillNPCIDs2 
	
SilentHillScriptPointers5: ; 768E
	dw SilentHillScript5 
	dw SilentHillNPCIDs3 
	
SilentHillScriptPointers6: ; 7692
	dw SilentHillScript6 
	dw SilentHillNPCIDs2 
	
SilentHillScriptPointers7: ; 7696
	dw SilentHillScript7 
	dw SilentHillNPCIDs2 
	
SilentHillScript1: ; 769A
	ld a, [wYCoord]
	cp 5
	ret nz
	ld a, [wXCoord]
	cp 5
	ret nz
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 02
	call Function17f9
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
	
SilentHillMovement1: ; 76C8
	db $0D 
	db $0D 
	db $0D 
	db $09 
	db $05 
	db $02 
	db $32
	
SilentHillScript2: ; 76CF
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
	
SilentHillMovement2: ; 76FF
	db $00, $04, $08, $0C, $0C, $0C, $33
	
SilentHillScript3: ;7706
	call Function1848
	ld a, 3
	ld [wMapScriptNumber], a
	call InitUnknownBuffercc9e
	ret
	
SilentHillScript4: ; 7712
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
	call Function15ed
	ld a, 3
	call Function17f9
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
	
Function776a: ; 776A
	ld hl, wd41a
	set 7, [hl]
	ld a, 1
	ld hl, wd29d
	ld [hl], a
	ret
	
SilentHillMovement3: ; 7776
	db $0A, $0A, $0A, $09, $0A, $06, $02, $32
	
SilentHillMovement4: ; 777E
	db $0A, $0A, $0A, $0A, $06, $02, $32
	
SilentHillScript5: ; 7785
	ld a, 0
	ld d, RIGHT
	call SetObjectFacing
	ld hl, SilentHillTextPokemonInGrassString
	call OpenTextbox
	ld hl, wJoypadFlags
	set 4, [hl]
	ld a, 3
	call Function17f9
	ld a, 0
	call Function186a
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
	
SilentHillMovement5: ; 77CC
	db $0B, $0B, $0B, $0B, $0B, $0B, $08, $08, $08, $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $05, $33
	
SilentHillMovement6: ; 77E0
	db $0B, $0B, $0B, $0B, $0B, $0B, $08, $08, $08, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $0B, $05, $33
	
SilentHillScript6: ; 77F3
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
	
SilentHillScript7: ; 780D
	call CheckLabDoor 
	ret z
	ld hl, SilentHillNPCIDs2
	ld de, SilentHillSignPointers
	call CallMapTextSubroutine
	ret
	
CheckLabDoor: ; 781B
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
	call ClearAccumulator
	ret
	
LabClosed: ; 784C
	ld a, 0
	ld hl, SilentHillMovement7
	call LoadMovementDataPointer
	ld hl, wc5ed
	set 7, [hl]
	ld a, 1
	call WriteIntod637
	ret
	
SilentHillTextString1: ; 785F
	text "あれ？　カギが　かかっている"
	done
	
SilentHillMovement7: ; 786F
	db $04, $32

SilentHillSignPointers:: ; 7871
	dw SilentHillPlayerHouseText 
	dw Function38c6 
	dw SilentHillSignText1
	dw SilentHillLabText 
	dw SilentHillRivalHouseText
	
SilentHillLabText: ; 787B
	ld hl, SilentHillTextString2 
	call OpenTextbox
	ret
	
SilentHillTextString2: ; 7882
	text "にゅうきょしゃ　ぼしゅうちゅう！"
	done
	
SilentHillSignText1: ; 7894
	ld hl, SilentHillTextString3
	call OpenTextbox
	ret
	
SilentHillTextString3: ; 789B
	text "ここは　サイレント　ヒル"
	line "しずかな　おか"
	done
	
SilentHillPlayerHouseText: ; 78B1
	ld hl, SilentHillTextString4
	call OpenTextbox
	ret
	
SilentHillTextString4: ; 78B8
	text "ここは　<PLAYER>　のいえ"
	done
	
SilentHillRivalHouseText: ; 78C3
	ld hl, SilentHillTextString5
	call OpenTextbox
	ret
	
SilentHillTextString5: ; 78CA
	text "ここは　<RIVAL>　のいえ"
	done
	
SilentHillTextPointers:: ; 78d5
	dw SilentHillTextRival1 ; west
	dw SilentHillTextNorthExit ; north
	dw SilentHillTextBackpack ; npc1
	dw SilentHillTextPokemonHate ; npc2

SilentHillTextRival1: ; 78DD
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
	
	db $08
	
LoadMomNamePromptUnused: ; 796F
	call LoadStandardMenuHeader 
	callab MomNamePrompt
	call CloseWindow
	call GetMemSGBLayout
	call UpdateSprites
	call UpdateTimePals
	jp Function3036
	
MomNameMenuHeaderUnused: ; 7989
	db MENU_BACKUP_TILES ; flags
	menu_coords 00, 00, 10, 11
	dw .MomNameMenuDataUnused
	db 01 ; initial selection
	
.MomNameMenuDataUnused: ; 7991
	db STATICMENU_CURSOR
	db 04 ; items
	db "じぶんで　きめる@"
	db "おかあさん　@"
	db "ママ@"
	db "かあちゃん@"
	
SilentHillTextRival2: ; 79AC - BYTE OFF
	text "<RIVAL>『えー　かっこわりい！"
	line "そんな　こどもっぽい"
	cont "よびかた　してるなんて"
	cont "おわらいだぜ！"
	cont"あー　ちょっとだけ　すっきりした！"
	
	para "そんじゃあ"
	line "おれは　ひとあし　おさきに"
	cont "オーキドのところへ"
	cont "いくことに　するぜ！"
	done
	
SilentHillTextNorthExit: ; 7A14
	text "ちょいまち！"
	line "まってよ！　まてっ　てば！"
	done
	
SilentHillTextPokemonInGrassString: ; 7A2A
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
	
SilentHillTextBackpack: ; 7A99
	ld hl, SilentHillTextBackpackString
	call OpenTextbox 
	ret
	
SilentHillTextBackpackString: ; 7AA0
	text "あなたの　りュック　かっこいいわよ"
	line "どこで　てに　いれたの？"
	done
	
SilentHillTextPokemonHate: ; 7AC0
	ld hl, SilentHillTextPokemonHateString
	call OpenTextbox
	ret
	
SilentHillTextPokemonHateString: ; 7AC7
	text "よのなかに　ポケモンが　きらいな"
	line "ひとは　いるのかな？"
	done
	
; 7AE4