INCLUDE "constants.asm"

SECTION "scripts/UnusedGen1TradeCenter.asm", ROMX

	map_attributes UnusedGen1TradeCenter, OLD_CITY_POKECENTER_TRADE, OFFICE, 0	; OFFICE occupies the id that CLUB used to be in.

	UnusedGen1TradeCenter_ScriptLoader:
	ret

	UnusedGen1TradeCenter_TextPointers:
	dw UnusedGen1TradeCenterText1

	UnusedGen1TradeCenterText1:
	text "！"
	done
