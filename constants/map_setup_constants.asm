; hMapEntryMethod values
; MapSetupScripts indexes (see data/maps/setup_scripts.asm)
	const_def $f1
	const MAPSETUP_NEW_GAME   ; f1
	const MAPSETUP_CONTINUE   ; f2
	const MAPSETUP_RELOADMAP  ; f3
	const MAPSETUP_TELEPORT   ; f4
	const_skip
	const MAPSETUP_WARP       ; f6
	const MAPSETUP_CONNECTION ; f7
	const MAPSETUP_EXIT_LINK  ; f8
