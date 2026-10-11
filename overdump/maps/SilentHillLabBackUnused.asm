	ret
Unreferenced_Corrupt_SilentHillLabBackUnused_ScriptLoader:
	if DEF(_GOLD)
		db $20
		call WriteBackMapScriptNumber + Bank34NonDebugOffset
	endc
	ret
Unreferenced_Corrupt_SilentHillLabBackUnusedScriptPointers:
	dw Unreferenced_Corrupt_SilentHillLabBackUnusedScript
	dw Unreferenced_Corrupt_SilentHillLabBackUnusedNPCIDs

Unreferenced_Corrupt_SilentHillLabBackUnusedNPCIDs:
	db -1

Unreferenced_Corrupt_SilentHillLabBackUnusedSignPointers:
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Unreferenced_Corrupt_SilentHillLabBackUnused_TextPointers::
	dw MapDefaultText + Bank34NonDebugOffset - Bank34CorruptOffset

Unreferenced_Corrupt_SilentHillLabBackUnusedScript:
	ld hl, Unreferenced_Corrupt_SilentHillLabBackUnusedNPCIDs
	ld de, Unreferenced_Corrupt_SilentHillLabBackUnusedSignPointers
	call CallMapTextSubroutine + Bank34NonDebugOffset - Bank34CorruptOffset
	ret
