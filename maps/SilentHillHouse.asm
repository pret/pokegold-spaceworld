include "constants.asm"
INCLUDE "hack/text/SilentHouse.inc"

SECTION "maps/SilentHillHouse.asm", ROMX

SilentHillHouseScriptLoader:: ; 4839
	ld hl, SilentHillHouseScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret
	
SilentHillHouseScriptPointers: ; 4843
	dw SilentHillHouseScript1
	dw SilentHillHouseNPCIDs1 
	dw SilentHillHouseScript2 
	dw SilentHillHouseNPCIDs2 
	dw SilentHillHouseScript3 
	dw SilentHillHouseNPCIDs1 
	
SilentHillHouseScript1: ; 484F
	ld hl, SilentHillHouseNPCIDs1
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret
	
SilentHillHouseScript2: ; 4859
	ld hl, SilentHillHouseNPCIDs2
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret
	
SilentHillHouseScript3: ; 4863
	ld hl, SilentHillHouseNPCIDs1
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret
	
SilentHillHouseNPCIDs1: 
	db 0
	db $FF
	
SilentHillHouseNPCIDs2: 
	db 0
	db 1
	db $FF
	
SilentHillHouseTextPointers2:: ; 4872
	dw SilentHillHouseNPCText1 
	dw Function38bd 
	dw Function3899 
	dw Function38b4 
	dw Function38ab 
	dw Function38cf 
	
SilentHillHouseNPCText1: ; 487E
	ld hl, wd41a
	bit 6, [hl]
	jr nz, .jump
	ld hl, SilentHillHouseTextString1
	call OpenTextbox
	ret

.jump
; 488C
	call RefreshScreen
	callab Function1477D
	call Function1fea
	ret
	
SilentHillHouseTextString1: ; 489B
	text_SilentHouseTextString1
	db $08
	
SilentHillHouseNPCText2: ; 48BD (unused due to typo in the text pointers?)
	call YesNoBox
	jr c, .jump
	ld hl, wd41a
	set 6, [hl]
	ld hl, SilentHillHouseTextString2
	call PrintText
	call Function3036
	ret
.jump
	ld hl, SilentHillHouseTextString3
	call PrintText
	call Function3036
	ret
	
SilentHillHouseTextString2: ; 48DB
	text_SilentHouseTextString2
	
SilentHillHouseTextString3: ; 4937
	text_SilentHouseTextString3
	
SilentHillHouseTextPointers:: ; 494C
	dw SilentHillHouseNPCText3 
	dw SilentHillHouseNPCText4
	
SilentHillHouseNPCText3: ; 4950
	ld hl, SilentHillHouseTextString4
	call OpenTextbox
	ret
	
SilentHillHouseTextString4: ; 4957
	text_SilentHouseTextString4
	
SilentHillHouseNPCText4: ; 4970
	ld hl, wd41e
	bit 2, [hl]
	jr nz, .jump
	ld hl, wd41e
	set 2, [hl]
	ld hl, SilentHillHouseTextString5
	call OpenTextbox
	call WaitBGMap
	ld hl, SilentHillHouseTextString6
	jr .skip
.jump
	ld hl, SilentHillHouseTextString7
.skip
	call OpenTextbox
	ret
	
SilentHillHouseTextString5: ; 4991
	text_SilentHouseTextString5
	
SilentHillHouseTextString6: ; 4A29
	text_SilentHouseTextString6
	
SilentHillHouseTextString7: ; 4A76
	text_SilentHouseTextString7
	
; 4AAC