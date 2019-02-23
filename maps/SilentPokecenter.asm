include "constants.asm"
INCLUDE "hack/text/SilentPokecenter.inc"

SECTION "Silent Hills Pokecenter", ROMX[$4682], BANK[$34]

SilentPokecenterScriptLoader:: ; 4682
	ld hl, SilentPokecenterScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentPokecenterScriptPointers: ; 468C
	dw SilentPokecenterScript 
	dw SilentPokecenterNPCIDs 

SilentPokecenterScript: ; 4690
	ld hl, SilentPokecenterNPCIDs
	ld de, SilentPokecenterPCPointer
	call CallMapTextSubroutine
	ret
	
; 469A
	dw SilentPokecenterNPCIDs
	
SilentPokecenterNPCIDs: ; 469C
	db 0
	db 1
	db 2
	db 3
	db 4
	db $FF
	
SilentPokecenterPCPointer: ; 46A2
	dw SilentPokecenterPCText
	
SilentPokecenterPCText: ; 46A4
	ld hl, SilentPokecenterTextString1
	call OpenTextbox
	ret
	
SilentPokecenterTextString1: ; 46AB
	text_SilentPokecenterTextString1
	
SilentPokecenterTextPointers:: ; 46BC
	dw SilentPokecenterNPCText1 
	dw SilentPokecenterNPCText2 
	dw SilentPokecenterNPCText3 
	dw SilentPokecenterNPCText4 
	dw SilentPokecenterNPCText5 
	
SilentPokecenterNPCText1: ; 46C6
	ld hl, SilentPokecenterTextString2
	call OpenTextbox
	ret
	
SilentPokecenterTextString2: ; 46CD
	text_SilentPokecenterTextString2
	
SilentPokecenterNPCText2: ; 4714
	ld hl, SilentPokecenterTextString3
	call OpenTextbox
	ret
	
SilentPokecenterTextString3: ; 471B
	text_SilentPokecenterTextString3
	
SilentPokecenterNPCText3: ; 4757
	ld hl, SilentPokecenterTextString4
	call OpenTextbox
	ret

SilentPokecenterTextString4: ; 475E
	text_SilentPokecenterTextString4
	
SilentPokecenterNPCText4: ; 479E
	ld hl, SilentPokecenterTextString5
	call OpenTextbox
	ret
	
SilentPokecenterTextString5: ; 47A5
	text_SilentPokecenterTextString5
	
SilentPokecenterNPCText5: ; 47C2
	ld hl, SilentPokecenterTextString6
	call OpenTextbox
	ret
	
SilentPokecenterTextString6: ; 47C9
	text_SilentPokecenterTextString6
	
; 47D5