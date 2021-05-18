sgb_pal_set: MACRO
	db (SGB_PAL_SET << 3) + 1
	dw PAL_\1, PAL_\2, PAL_\3, PAL_\4
	ds 7
ENDM

PalPacket_Poker:
	sgb_pal_set POKER_1, POKER_2, POKER_3, POKER_4

PalPacket_995c:
	sgb_pal_set ROUTE, ROUTE, ROUTE, ROUTE

PalPacket_GSIntroShellderLapras:
	sgb_pal_set INTRO_WATER, ROUTE, ROUTE, ROUTE

PalPacket_MagikarpIntro:
	sgb_pal_set INTRO_LAPRAS, ROUTE, ROUTE, ROUTE

PalPacket_GSIntroJigglypuffPikachu:
	sgb_pal_set INTRO_FOREST, INTRO_JIGGLYPUFF_PIKACHU, ROUTE, ROUTE

PalPacket_GSIntroBlastoise:
	sgb_pal_set INTRO_BLASTOISE, ROUTE, ROUTE, ROUTE

PalPacket_GSIntroVenusaur:
	sgb_pal_set INTRO_VENUSAUR, ROUTE, ROUTE, ROUTE

PalPacket_GSIntroCharizard:
	sgb_pal_set INTRO_CHARIZARD, ROUTE, ROUTE, ROUTE

PalPacket_PikachuMinigame:
	sgb_pal_set INTRO_JIGGLYPUFF_PIKACHU, ROUTE, ROUTE, ROUTE

PalPacket_PartyMenu:
	sgb_pal_set SHINY_GRAYMON, GREEN_BAR, YELLOW_BAR, RED_BAR

PalPacket_BattleGrayscale:
	sgb_pal_set BLACK, BLACK, BLACK, BLACK

PalPacket_TownMap:
	sgb_pal_set TOWN_MAP, ROUTE, ROUTE, ROUTE

PalPacket_Pokedex:
	sgb_pal_set INTRO_CHARIZARD, ROUTE, ROUTE, ROUTE

PalPacket_SlotMachine:
	sgb_pal_set SLOTS_1, SLOTS_2, SLOTS_3, SLOTS_4

PalPacket_TitleScreen:
	sgb_pal_set LOGO_1, LOGO_2, MEWMON, PURPLEMON

PalPacket_9a3c:
	sgb_pal_set MEWMON, ROUTE, ROUTE, ROUTE

PalPacket_GFIntro:
	sgb_pal_set GAME_FREAK, ROUTE, ROUTE, ROUTE

