; GetSGBLayout arguments (see engine/gfx/cgb_layouts.asm and engine/gfx/sgb_layouts.asm)
	const_def
	const SGB_BATTLE_GRAYSCALE
	const SGB_BATTLE_COLORS
	const SGB_TOWN_MAP
	const SGB_STATS_SCREEN_HP_PALS
	const SGB_POKEDEX
	const SGB_SLOT_MACHINE
	const SGB_TITLE_SCREEN
	const SGB_GS_INTRO
	const SGB_DIPLOMA
	const SGB_MAP_PALS
	const SGB_PARTY_MENU
	const SGB_EVOLUTION
	const SGB_GF_INTRO
	const SGB_TRAINER_CARD
	const SGB_MOVE_LIST
	const SGB_PIKACHU_MINIGAME
	const SGB_POKEDEX_SELECTION
	const SGB_POKER
	const SGB_POKEPIC
	const SGB_TRAINERGEAR
	const SGB_TRAINERGEAR_MAP
	const SGB_TRAINERGEAR_RADIO

DEF SGB_PARTY_MENU_HP_PALS  EQU -4
DEF SGB_RAM EQU -1

; SGB system command codes
; http://gbdev.gg8.se/wiki/articles/SGB_Functions#SGB_System_Command_Table
	const_def
	const SGB_PAL01
	const SGB_PAL23
	const SGB_PAL03
	const SGB_PAL12
	const SGB_ATTR_BLK
	const SGB_ATTR_LIN
	const SGB_ATTR_DIV
	const SGB_ATTR_CHR
	const SGB_SOUND
	const SGB_SOU_TRN
	const SGB_PAL_SET
	const SGB_PAL_TRN
	const SGB_ATRC_EN
	const SGB_TEST_EN
	const SGB_ICON_EN
	const SGB_DATA_SND
	const SGB_DATA_TRN
	const SGB_MLT_REG
	const SGB_JUMP
	const SGB_CHR_TRN
	const SGB_PCT_TRN
	const SGB_ATTR_TRN
	const SGB_ATTR_SET
	const SGB_MASK_EN
	const SGB_OBJ_TRN

DEF PALPACKET_LENGTH EQU $10
