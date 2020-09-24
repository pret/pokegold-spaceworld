include "constants.asm"
INCLUDE "hack/text/ShizukanaOka.inc"

SECTION "scripts/ShizukanaOka.asm", ROMX

ShizukanaOka_ScriptLoader::
	ld hl, ShizukanaOkaScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

ShizukanaOkaScriptPointers:
	dw ShizukanaOkaScript
	dw ShizukanaOkaNPCIDs

ShizukanaOkaNPCIDs:
	db 0
	db 1
	db 2
	db 3
	db 4
	db 5
	db $FF

ShizukanaOkaSignPointers:
	dw ShizukanaOkaSignpost1
	dw ShizukanaOkaSignpost2

ShizukanaOka_TextPointers:
	dw ShizukanaOkaText1
	dw ShizukanaOkaTrainer2
	dw ShizukanaOkaTrainer3
	dw ShizukanaOkaTrainer4
	dw ShizukanaOkaTrainer5
	dw ShizukanaOkaTrainer6

ShizukanaOkaScript:
	ld hl, ShizukanaOkaNPCIDs
	ld de, ShizukanaOkaSignPointers
	call CallMapTextSubroutine
	ret

ShizukanaOkaText1:
	ld hl, ShizukanaOkaText1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer2:
	ld hl, $D3A5
	bit 1, [hl]
	jr nz, .Trainer2Won
	ld hl, ShizukanaOkaTrainer2EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 1, [hl]
	ld a, TRAINER_SCHOOLBOY
	ld [wce02], a
	ld a, SCHOOLBOY_TETSUYA
	ld [wce05], a
	call Function38d8
	ret
.Trainer2Won ;Already won
	ld hl, ShizukanaOkaTrainer2WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer3:
	ld hl, wd3a5
	bit 2, [hl]
	jr nz, .Trainer3Won
	ld hl, ShizukanaOkaTrainer3EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 2, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wce02], a
	ld a, BUG_CATCHER_BOY_JUNICHI
	ld [wce05], a
	call Function38d8
	ret
.Trainer3Won ;Already won
	ld hl, ShizukanaOkaTrainer3WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer4:
	ld hl, wd3a5
	bit 3, [hl]
	jr nz, .Trainer4Won
	ld hl, ShizukanaOkaTrainer4EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 3, [hl]
	ld a, TRAINER_FIREBREATHER
	ld [wce02], a
	ld a, FIREBREATHER_AKITO
	ld [wce05], a
	call Function38d8
	ret
.Trainer4Won ;Already won
	ld hl, ShizukanaOkaTrainer4WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer5:
	ld hl, wd3a5
	bit 4, [hl]
	jr nz, .Trainer5Won
	ld hl, ShizukanaOkaTrainer5EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 4, [hl]
	ld a, TRAINER_BEAUTY
	ld [wce02], a
	ld a, BEAUTY_MEGUMI
	ld [wce05], a
	call Function38d8
	ret
.Trainer5Won ;Already won
	ld hl, ShizukanaOkaTrainer5WonString
	call OpenTextbox
	ret

ShizukanaOkaTrainer6:
	ld hl, wd3a5
	bit 5, [hl]
	jr nz, .Trainer6Won
	ld hl, ShizukanaOkaTrainer6EncounterString
	call OpenTextbox
	ld hl, wd3a5
	set 5, [hl]
	ld a, TRAINER_BUG_CATCHER_BOY
	ld [wce02], a
	ld a, BUG_CATCHER_BOY_SOUSUKE
	ld [wce05], a
	call Function38d8
	ret
.Trainer6Won ;Already won
	ld hl, ShizukanaOkaTrainer6WonString
	call OpenTextbox
	ret

ShizukanaOkaSignpost2:
	ld hl, ShizukanaOkaSignpost2String
	call OpenTextbox
	ret

ShizukanaOkaSignpost1:
	ld hl, ShizukanaOkaSignpost1String
	call OpenTextbox
	ret

ShizukanaOkaTrainer6EncounterString:
	text_ShizukanaOkaTrainer6EncounterString

ShizukanaOkaTrainer6WonString:
	text_ShizukanaOkaTrainer6WonString

ShizukanaOkaTrainer5EncounterString:
	text_ShizukanaOkaTrainer5EncounterString

ShizukanaOkaTrainer5WonString:
	text_ShizukanaOkaTrainer5WonString

ShizukanaOkaTrainer4EncounterString:
	text_ShizukanaOkaTrainer4EncounterString

ShizukanaOkaTrainer4WonString:
	text_ShizukanaOkaTrainer4WonString

ShizukanaOkaTrainer3EncounterString:
	text_ShizukanaOkaTrainer3EncounterString

ShizukanaOkaTrainer3WonString:
	text_ShizukanaOkaTrainer3WonString

ShizukanaOkaTrainer2EncounterString:
	text_ShizukanaOkaTrainer2EncounterString

ShizukanaOkaTrainer2WonString:
	text_ShizukanaOkaTrainer2WonString

ShizukanaOkaText1String:
	text_ShizukanaOkaText1String

ShizukanaOkaSignpost2String:
	text_ShizukanaOkaSignpost2String

ShizukanaOkaSignpost1String:
	text_ShizukanaOkaSignpost1String

ShizukanaOkaPadding:
	textpad_ShizukanaOka
