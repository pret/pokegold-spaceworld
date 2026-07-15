	map_id ROUTE_1_P1
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn only
if DEF(_GOLD)
	db 7, DEX_SUNNY
	db 3, DEX_SUNNY
	db 5, DEX_SUNNY
endc
if DEF(_SILVER)
	db 8, DEX_PIDGEY
	db 8, DEX_PIDGEY
	db 7, DEX_PIDGEY
endc
	; morn/day
	db 5, DEX_PIKACHU
	db 5, DEX_PIDGEY
	db 5, DEX_PIDGEY
	db 4, DEX_RATTATA
	; morn/day/nite
	db 6, DEX_KIRINRIKI
	db 4, DEX_KIRINRIKI
if DEF(_GOLD)
	db 4, DEX_HANEKO
endc
if DEF(_SILVER)
	db 4, DEX_MARIL
endc
	db 4, DEX_PIDGEY
	; day/nite
	db 8, DEX_RATTATA
	db 7, DEX_RATTATA
	; nite only
	db 5, DEX_RATTATA
	db 5, DEX_RATTATA
if DEF(_GOLD)
	db 7, DEX_RATTATA
	db 8, DEX_RATTATA
endc
if DEF(_SILVER)
	db 5, DEX_HOHO
	db 3, DEX_HOHO
endc
	db 5, DEX_PIKACHU
