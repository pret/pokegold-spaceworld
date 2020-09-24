include "constants.asm"
INCLUDE "hack/text/SilentPokecenter.inc"

SECTION "scripts/SilentHillPokecenter.asm", ROMX

SilentHillPokecenter_ScriptLoader::
	ld hl, SilentHillPokecenterScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillPokecenterScriptPointers:
	dw SilentHillPokecenterScript
	dw SilentHillPokecenterNPCIDs

SilentHillPokecenterScript:
	ld hl, SilentHillPokecenterNPCIDs
	ld de, SilentHillPokecenterPCPointer
	call CallMapTextSubroutine
	ret

	dw SilentHillPokecenterNPCIDs

SilentHillPokecenterNPCIDs:
	db 0
	db 1
	db 2
	db 3
	db 4
	db $FF

SilentHillPokecenterPCPointer:
	dw SilentHillPokecenterPCText

SilentHillPokecenterPCText:
	ld hl, SilentHillPokecenterTextString1
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString1:
	text_SilentPokecenterTextString1
	
SilentHillPokecenter_TextPointers::
	dw SilentHillPokecenterNPCText1 
	dw SilentHillPokecenterNPCText2 
	dw SilentHillPokecenterNPCText3 
	dw SilentHillPokecenterNPCText4 
	dw SilentHillPokecenterNPCText5 
	
SilentHillPokecenterNPCText1:
	ld hl, SilentHillPokecenterTextString2
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString2:
	text_SilentPokecenterTextString2
	
SilentHillPokecenterNPCText2:
	ld hl, SilentHillPokecenterTextString3
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString3:
	text_SilentPokecenterTextString3
	
SilentHillPokecenterNPCText3:
	ld hl, SilentHillPokecenterTextString4
	call OpenTextbox
	ret

SilentHillPokecenterTextString4:
	text_SilentPokecenterTextString4
	
SilentHillPokecenterNPCText4:
	ld hl, SilentHillPokecenterTextString5
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString5:
	text_SilentPokecenterTextString5
	
SilentHillPokecenterNPCText5:
	ld hl, SilentHillPokecenterTextString6
	call OpenTextbox
	ret
	
SilentHillPokecenterTextString6:
	text_SilentPokecenterTextString6

SilentHillPokecenterPadding:
	textpad_SilentPokecenter
