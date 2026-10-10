	map_attributes SilentHillLabBackUnused, SILENT_HILL_LAB_BACK_UNUSED

SilentHillLabBackUnused_MapEvents::
; BUG: MapEvent data is missing for this map, causing a crash upon load.

SilentHillLabBackUnused_Blocks::
INCBIN "maps/SilentHillLabBackUnused.blk"

	map_generic_scriptloader
	map_generic_script_pointers

SilentHillLabBackUnusedNPCIDs:
	db -1

SilentHillLabBackUnusedSignPointers:
	dw MapDefaultText

SilentHillLabBackUnused_TextPointers::
	dw MapDefaultText

	map_generic_script
