include "constants.asm"
INCLUDE "hack/text/SilentHouse.inc"

SECTION "scripts/SilentHillHouse.asm", ROMX

SilentHillHouse_ScriptLoader::
	ld hl, SilentHillHouseScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillHouseScriptPointers:
	dw SilentHillHouseScript1
	dw SilentHillHouseNPCIDs1
	dw SilentHillHouseScript2
	dw SilentHillHouseNPCIDs2
	dw SilentHillHouseScript3
	dw SilentHillHouseNPCIDs1

SilentHillHouseScript1:
	ld hl, SilentHillHouseNPCIDs1
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillHouseScript2:
	ld hl, SilentHillHouseNPCIDs2
	ld de, SilentHillHouseTextPointers2
	call CallMapTextSubroutine
	ret

SilentHillHouseScript3:
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

SilentHillHouseTextPointers2::
	dw SilentHillHouseNPCText1
	dw Function38bd
	dw Function3899
	dw Function38b4
	dw Function38ab
	dw Function38cf

SilentHillHouseNPCText1:
	ld hl, wd41a
	bit 6, [hl]
	jr nz, .jump
	ld hl, SilentHillHouseTextString1
	call OpenTextbox
	ret

.jump
	call RefreshScreen
	callab Function1477D
	call Function1fea
	ret
	
SilentHillHouseTextString1:
	text_SilentHouseTextString1
	db $08

SilentHillHouseNPCText2: ; (unused due to typo in the text pointers?)
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
	
SilentHillHouseTextString2:
	text_SilentHouseTextString2
	
SilentHillHouseTextString3:
	text_SilentHouseTextString3
	
SilentHillHouse_TextPointers::
	dw SilentHillHouseNPCText3 
	dw SilentHillHouseNPCText4

SilentHillHouseNPCText3:
	ld hl, SilentHillHouseTextString4
	call OpenTextbox
	ret
	
SilentHillHouseTextString4:
	text_SilentHouseTextString4
	
SilentHillHouseNPCText4:
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
	
SilentHillHouseTextString5:
	text_SilentHouseTextString5
	
SilentHillHouseTextString6:
	text_SilentHouseTextString6
	
SilentHillHouseTextString7:
	text_SilentHouseTextString7

SilentHillHousePadding:
	textpad_SilentHouse
