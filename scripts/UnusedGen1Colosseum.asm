INCLUDE "constants.asm"

SECTION "scripts/UnusedGen1Colosseum.asm", ROMX

	map_attributes UnusedGen1Colosseum, OLD_CITY_POKECENTER_BATTLE, OFFICE, 0

UnusedGen1Colosseum_ScriptLoader:
	jp UnusedGen1TradeCenter_ScriptLoader

UnusedGen1Colosseum_TextPointers:
	dw UnusedGen1ColosseumText1

UnusedGen1ColosseumText1:
	text "！"
	done
