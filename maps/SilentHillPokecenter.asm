include "constants.asm"
INCLUDE "hack/text/SilentPokecenter.inc"

SECTION "maps/SilentHillPokecenter.asm", ROMX

SilentHillPokecenterScriptLoader:: ; 4682
	ld hl, SilentHillPokecenterScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHillPokecenterScriptPointers: ; 468C
	dw SilentHillPokecenterScript 
	dw SilentHillPokecenterNPCIDs 

SilentHillPokecenterScript: ; 4690
	ld hl, SilentHillPokecenterNPCIDs
	ld de, SilentHillPokecenterPCPointer
	call CallMapTextSubroutine
	ret
	
; 469A
	dw SilentHillPokecenterNPCIDs
	
SilentHillPokecenterNPCIDs: ; 469C
	db 0
	db 1
	db 2
	db 3
	db 4
	db $FF
	
SilentHillPokecenterPCPointer: ; 46A2
	dw SilentHillPokecenterPCText
	
SilentHillPokecenterPCText: ; 46A4
	ld hl, SilentHillPokecenterTextString1
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString1: ; 46AB
	text_SilentPokecenterTextString1
	
SilentHillPokecenterTextPointers:: ; 46BC
	dw SilentHillPokecenterNPCText1 
	dw SilentHillPokecenterNPCText2 
	dw SilentHillPokecenterNPCText3 
	dw SilentHillPokecenterNPCText4 
	dw SilentHillPokecenterNPCText5 
	
SilentHillPokecenterNPCText1: ; 46C6
	ld hl, SilentHillPokecenterTextString2
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString2: ; 46CD
	text_SilentPokecenterTextString2
	
SilentHillPokecenterNPCText2: ; 4714
	ld hl, SilentHillPokecenterTextString3
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString3: ; 471B
	text_SilentPokecenterTextString3
	
SilentHillPokecenterNPCText3: ; 4757
	ld hl, SilentHillPokecenterTextString4
	call OpenTextbox
	ret

SilentHillPokecenterTextString4: ; 475E
	text_SilentPokecenterTextString4
	
SilentHillPokecenterNPCText4: ; 479E
	ld hl, SilentHillPokecenterTextString5
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString5: ; 47A5
	text_SilentPokecenterTextString5
	
SilentHillPokecenterNPCText5: ; 47C2
	ld hl, SilentHillPokecenterTextString6
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString6: ; 47C9
	text_SilentPokecenterTextString6
	
; 47D5