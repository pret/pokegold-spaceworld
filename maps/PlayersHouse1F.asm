include "constants.asm"

SECTION "Player's House 1F", ROMX[$409C], BANK[$34]

PlayersHouse1FScriptLoader:: ; 409C
	ld hl, PlayersHouse1FScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
PlayersHouse1FScriptPointers: ; 40A6
	dw PlayersHouse1FScript1 
	dw PlayersHouse1FNPCIDs1 
	dw PlayersHouse1FScript2 
	dw PlayersHouse1FNPCIDs2 
	
PlayersHouse1FNPCIDs1: ; 40AE
	db $FF
	
PlayersHouse1FNPCIDs2: ; 40AF
	db 0
	db $FF
	
PlayersHouse1FScript1: ; 40B1
	ld hl, PlayersHouse1FNPCIDs1
	ld de, PlayersHouse1FTextPointers
	call CallMapTextSubroutine
	ret
	
PlayersHouse1FScript2: ; 40BB
	ld hl, PlayersHouse1FNPCIDs2
	ld de, PlayersHouse1FTextPointers
	call CallMapTextSubroutine
	ret
	
PlayersHouse1FTextPointers: ; 40C5
	dw Function38ab 
	dw Function38b4 
	dw Function38a2 
	dw Function38bd 
	dw Function3899 
	dw PlayersHouse1FNPCText1 
	
PlayersHouse1FNPCText1: ; 40D1
	ld hl, PlayersHouse1FTextString1
	call OpenTextbox
	ret
	
PlayersHouse1FTextString1: ; 40D8
	text "おかあさん『えっ　あなた"
	line "オーキドはかせに"
	cont "ポケモンずかんを　つくってくれって"
	cont "たのまれたの？"
	
	para "すごいじゃない！"
	line "わたしも　ポケモン　きらいって"
	cont "わけじゃないし　がんばるのよ！"
	done
	
; 4132