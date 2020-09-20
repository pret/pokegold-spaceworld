include "constants.asm"

SECTION "maps/PlayerHouse1F.asm", ROMX

PlayerHouse1FScriptLoader:: ; 409C
	ld hl, PlayerHouse1FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

PlayerHouse1FScriptPointers: ; 40A6
	dw PlayerHouse1FScript1
	dw PlayerHouse1FNPCIDs1
	dw PlayerHouse1FScript2
	dw PlayerHouse1FNPCIDs2

PlayerHouse1FNPCIDs1: ; 40AE
	db $FF

PlayerHouse1FNPCIDs2: ; 40AF
	db 0
	db $FF

PlayerHouse1FScript1: ; 40B1
	ld hl, PlayerHouse1FNPCIDs1
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FScript2: ; 40BB
	ld hl, PlayerHouse1FNPCIDs2
	ld de, PlayerHouse1FSignPointers
	call CallMapTextSubroutine
	ret

PlayerHouse1FSignPointers: ; 40C5
	dw Function38ab
	dw Function38b4
	dw Function38a2
	dw Function38bd
	dw Function3899
PlayerHouse1FTextPointers::
	dw PlayerHouse1FNPCText1

PlayerHouse1FNPCText1: ; 40D1
	ld hl, PlayerHouse1FTextString1
	call OpenTextbox
	ret

PlayerHouse1FTextString1: ; 40D8
	text "おかあさん『えっ　あなた"
	line "オーキドはかせに"
	cont "ポケモンずかんを　つくってくれって"
	cont "たのまれたの？"

	para "すごいじゃない！"
	line "わたしも　ポケモン　きらいって"
	cont "わけじゃないし　がんばるのよ！"
	done

; 4132
