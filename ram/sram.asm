SECTION "Sprite Buffers", SRAM

UNION
sScratch:: ds SCREEN_WIDTH * SCREEN_HEIGHT
NEXTU
sSpriteBuffer0:: ds SPRITEBUFFERSIZE
sSpriteBuffer1:: ds SPRITEBUFFERSIZE
sSpriteBuffer2:: ds SPRITEBUFFERSIZE
ENDU

SECTION "Save Game Data", SRAM

sOptions:: ds 7
	ds 1

sGameData:: ds wGameDataEnd - wGameData ; wGameDataEnd - wGameData
sGameDataEnd::

sGameData2:: ds wGameData2End - wGameData2
sGameData2End::

SECTION "Save Pokemon Data", SRAM
sPokemonData::  ds wPokemonDataEnd - wPokemonData


SECTION "SRAM Window Stack", SRAM

sWindowStackBottom::
	ds $800 - 1
sWindowStackTop::
	ds 1

; The PC boxes will not fit into one SRAM bank,
; so they use multiple SECTIONs
DEF box_n = 0
MACRO boxes
	rept \1
		DEF box_n += 1
	sBox{d:box_n}:: box sBox{d:box_n}
	endr
ENDM


SECTION "Boxes 1-5", SRAM

; sBox1 - sBox5
	boxes 5

sPartyMailBackup::
; sPartyMon1MailBackup - sPartyMon6MailBackup
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}MailBackup:: mailmsg sPartyMon{d:n}MailBackup
endr

SECTION "Boxes 6-10", SRAM

; sBox6 - sBox10
	boxes 5

; All 10 boxes fit exactly within 2 SRAM banks
	assert box_n == NUM_BOXES, \
		"boxes: Expected {d:NUM_BOXES} total boxes, got {d:box_n}"

sPartyMail::
; sPartyMon1Mail - sPartyMon6Mail
for n, 1, PARTY_LENGTH + 1
sPartyMon{d:n}Mail:: mailmsg sPartyMon{d:n}Mail
endr

SECTION "Checksum", SRAM
sChecksum:: ds 3
