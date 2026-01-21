; TODO: These aren't bespoke morning/day/night chunks. Find a way to indicate this.

GrassWildMons::

	map_id ROUTE_1_P1
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
if DEF(GOLD)
	db 7, DEX_SUNNY
	db 3, DEX_SUNNY
	db 5, DEX_SUNNY
else
	db 8, DEX_PIDGEY
	db 8, DEX_PIDGEY
	db 7, DEX_PIDGEY
endc
	db 5, DEX_PIKACHU
	db 5, DEX_PIDGEY
	db 5, DEX_PIDGEY
	; day
	db 4, DEX_RATTATA
	db 6, DEX_KIRINRIKI
	db 4, DEX_KIRINRIKI
if DEF(GOLD)
	db 4, DEX_HANEKO
else
	db 4, DEX_MARIL
endc
	db 4, DEX_PIDGEY
	db 8, DEX_RATTATA
	; nite
	db 7, DEX_RATTATA
	db 5, DEX_RATTATA
	db 5, DEX_RATTATA
if DEF(GOLD)
	db 7, DEX_RATTATA
	db 8, DEX_RATTATA
else
	db 5, DEX_HOHO
	db 3, DEX_HOHO
endc
	db 5, DEX_PIKACHU

	map_id ROUTE_1_P2
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
if DEF(GOLD)
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
	db 6, DEX_SUNNY
else
	db 8, DEX_PIDGEY
	db 8, DEX_PIDGEY
	db 6, DEX_PIDGEY
endc
	db 5, DEX_PIKACHU
	db 4, DEX_EKANS
	db 5, DEX_RATTATA
	; day
	db 5, DEX_PIDGEY
	db 7, DEX_YOROIDORI
	db 5, DEX_RATTATA
if DEF(GOLD)
	db 8, DEX_HANEKO
else
	db 8, DEX_MARIL
endc
	db 4, DEX_PIDGEY
	db 7, DEX_RATTATA
	; nite
	db 7, DEX_RATTATA
	db 6, DEX_EKANS
if DEF(GOLD)
	db 6, DEX_RATTATA
else
	db 6, DEX_HOHO
endc
	db 7, DEX_EKANS
	db 8, DEX_RATTATA
	db 5, DEX_PIKACHU

	map_id ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 9, DEX_CATERPIE
	db 9, DEX_METAPOD
	db 8, DEX_CATERPIE
	db 7, DEX_METAPOD
	db 10, DEX_PIDGEY
	db 7, DEX_CATERPIE
	; day
	db 8, DEX_CATERPIE
	db 9, DEX_PIDGEY
	db 11, DEX_RATTATA
	db 9, DEX_RATTATA
	db 10, DEX_RATTATA
	db 8, DEX_CATERPIE
	; nite
	db 9, DEX_RATTATA
	db 10, DEX_HOHO
	db 11, DEX_ODDISH
	db 12, DEX_HOHO
	db 11, DEX_ODDISH
	db 13, DEX_ODDISH

	map_id BAADON_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 19, DEX_DITTO
	db 20, DEX_FEAROW
	db 18, DEX_DITTO
	db 17, DEX_METAPOD
	db 21, DEX_FEAROW
	db 17, DEX_DITTO
	; day
	db 17, DEX_SPEAROW
	db 18, DEX_SPEAROW
	db 21, DEX_DODUO
	db 19, DEX_DODUO
	db 20, DEX_DODUO
	db 18, DEX_DITTO
	; nite
	db 19, DEX_DROWZEE
	db 20, DEX_DROWZEE
	db 21, DEX_DROWZEE
	db 22, DEX_DROWZEE
	db 23, DEX_DROWZEE
	db 23, DEX_DROWZEE

	map_id HAITEKU_WEST_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 12, DEX_EXEGGCUTE
	db 12, DEX_VENONAT
	db 11, DEX_EXEGGCUTE
	db 10, DEX_VENONAT
	db 13, DEX_SPEAROW
	db 10, DEX_EXEGGCUTE
	; day
	db 11, DEX_SPEAROW
	db 12, DEX_SPEAROW
	db 14, DEX_GEODUDE
	db 12, DEX_GEODUDE
	db 13, DEX_GEODUDE
	db 11, DEX_EXEGGCUTE
	; nite
	db 12, DEX_EKANS
	db 13, DEX_EKANS
	db 14, DEX_EKANS
	db 15, DEX_EKANS
	db 16, DEX_EKANS
	db 16, DEX_EKANS

	map_id HAITEKU_WEST_ROUTE_OCEAN
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONTO_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONTO_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONTO_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 16, DEX_MACHOP
	db 16, DEX_MACHOP
	db 15, DEX_MACHOP
	db 14, DEX_MACHOP
	db 17, DEX_SPEAROW
	db 14, DEX_MACHOP
	; day
	db 15, DEX_SPEAROW
	db 16, DEX_SPEAROW
	db 18, DEX_RATTATA
	db 16, DEX_RATTATA
	db 17, DEX_RATTATA
	db 15, DEX_SPEAROW
	; nite
	db 16, DEX_DROWZEE
	db 17, DEX_DROWZEE
	db 18, DEX_DROWZEE
	db 19, DEX_DROWZEE
	db 20, DEX_DROWZEE
	db 20, DEX_DROWZEE

	map_id FONTO_ROUTE_4
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 17, DEX_SPEAROW
	db 17, DEX_SPEAROW
	db 16, DEX_SPEAROW
	db 15, DEX_SPEAROW
	db 18, DEX_DODUO
	db 15, DEX_SPEAROW
	; day
	db 16, DEX_DODUO
	db 17, DEX_DONPHAN
	db 19, DEX_SANDSHREW
	db 17, DEX_SANDSHREW
	db 18, DEX_SANDSHREW
	db 16, DEX_DODUO
	; nite
	db 17, DEX_DODUO
	db 18, DEX_DODUO
	db 19, DEX_DODUO
	db 20, DEX_DODUO
	db 21, DEX_BULU
	db 21, DEX_BULU

	map_id BAADON_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 21, DEX_SPEAROW
	db 21, DEX_SPEAROW
	db 20, DEX_FEAROW
	db 19, DEX_FEAROW
	db 22, DEX_FEAROW
	db 19, DEX_SPEAROW
	; day
	db 20, DEX_DODUO
	db 22, DEX_SANDSLASH
	db 21, DEX_DONPHAN
	db 21, DEX_SANDSHREW
	db 23, DEX_SANDSHREW
	db 20, DEX_DODUO
	; nite
	db 21, DEX_DODUO
	db 22, DEX_DODUO
	db 23, DEX_DODUO
	db 24, DEX_DODUO
	db 25, DEX_BULU
	db 25, DEX_BULU

	map_id BAADON_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 23, DEX_HANEKO
	db 23, DEX_POPONEKO
	db 22, DEX_HANEKO
	db 25, DEX_POPONEKO
	db 24, DEX_SANDSHREW
	db 21, DEX_HANEKO
	; day
	db 22, DEX_SANDSHREW
	db 23, DEX_SANDSLASH
	db 25, DEX_VULPIX
	db 23, DEX_VULPIX
	db 21, DEX_MIKON
	db 22, DEX_HANEKO
	; nite
	db 23, DEX_HOHO
	db 24, DEX_HOHO
	db 25, DEX_HOHO
	db 26, DEX_HOHO
	db 27, DEX_BULU
	db 27, DEX_BULU

	map_id ROUTE_15
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 24, DEX_HANEKO
	db 24, DEX_POPONEKO
	db 23, DEX_HANEKO
	db 22, DEX_POPONEKO
	db 25, DEX_POPONEKO
	db 22, DEX_HANEKO
	; day
	db 23, DEX_PIDGEY
	db 24, DEX_PIDGEOTTO
	db 26, DEX_VULPIX
	db 24, DEX_VULPIX
	db 25, DEX_VULPIX
	db 23, DEX_HANEKO
	; nite
	db 24, DEX_HOHO
	db 25, DEX_HOHO
	db 26, DEX_DROWZEE
	db 27, DEX_DROWZEE
	db 28, DEX_HYPNO
	db 28, DEX_HYPNO

	map_id SUGAR_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_IKARI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_IKARI
	db 45, DEX_TENTACOOL

	map_id NEWTYPE_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_HANEKO
	db 28, DEX_POPONEKO
	db 27, DEX_HANEKO
	db 27, DEX_POPONEKO
	db 30, DEX_POPONEKO
	db 27, DEX_HANEKO
	; day
	db 28, DEX_PIDGEY
	db 29, DEX_PIDGEOTTO
	db 31, DEX_VULPIX
	db 29, DEX_VULPIX
	db 30, DEX_VULPIX
	db 28, DEX_HANEKO
	; nite
	db 29, DEX_HOHO
	db 31, DEX_HOHO
	db 32, DEX_DROWZEE
	db 33, DEX_DROWZEE
	db 34, DEX_HYPNO
	db 34, DEX_HYPNO

	map_id ROUTE_18
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_REDIBA
	db 28, DEX_MANKEY
	db 27, DEX_REDIBA
	db 28, DEX_MANKEY
	db 31, DEX_MANKEY
	db 28, DEX_PIDGEY
	; day
	db 29, DEX_MANKEY
	db 30, DEX_PIDGEOTTO
	db 32, DEX_VULPIX
	db 30, DEX_WOLFMAN
	db 31, DEX_WOLFMAN
	db 29, DEX_REDIBA
	; nite
	db 30, DEX_WOLFMAN
	db 33, DEX_WOLFMAN
	db 34, DEX_DROWZEE
	db 35, DEX_WOLFMAN
	db 36, DEX_HYPNO
	db 36, DEX_WOLFMAN

	map_id BULL_FOREST_ROUTE_1
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_REDIBA
	db 29, DEX_MILTANK
	db 28, DEX_REDIBA
	db 29, DEX_MILTANK
	db 32, DEX_MANKEY
	db 29, DEX_REDIBA
	; day
	db 30, DEX_MANKEY
	db 31, DEX_PRIMEAPE
	db 33, DEX_POLIWAG
	db 31, DEX_POLIWHIRL
	db 32, DEX_POLIWAG
	db 30, DEX_REDIBA
	; nite
	db 31, DEX_WOLFMAN
	db 34, DEX_WOLFMAN
	db 35, DEX_WOLFMAN
	db 36, DEX_WOLFMAN
	db 37, DEX_WOLFMAN
	db 37, DEX_WOLFMAN

	map_id BULL_FOREST_ROUTE_2
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 32, DEX_MILTANK
	db 32, DEX_MILTANK
	db 31, DEX_MILTANK
	db 32, DEX_MILTANK
	db 35, DEX_PRIMEAPE
	db 32, DEX_REDIBA
	; day
	db 33, DEX_MANKEY
	db 34, DEX_PRIMEAPE
	db 36, DEX_POLIWAG
	db 34, DEX_POLIWHIRL
	db 35, DEX_POLIWHIRL
	db 33, DEX_REDIBA
	; nite
	db 34, DEX_WOLFMAN
	db 37, DEX_WOLFMAN
	db 38, DEX_WOLFMAN
	db 39, DEX_WOLFMAN
	db 40, DEX_WARWOLF
	db 40, DEX_WARWOLF

	map_id STAND_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_CUBONE
	db 29, DEX_MAROWAK
	db 28, DEX_CUBONE
	db 29, DEX_MAROWAK
	db 32, DEX_RHYHORN
	db 29, DEX_CUBONE
	; day
	db 30, DEX_RHYHORN
	db 31, DEX_RHYHORN
	db 33, DEX_YOROIDORI
	db 31, DEX_YOROIDORI
	db 32, DEX_YOROIDORI
	db 30, DEX_CUBONE
	; nite
	db 31, DEX_EKANS
	db 34, DEX_EKANS
	db 35, DEX_ARBOK
	db 36, DEX_ARBOK
	db 37, DEX_EKANS
	db 37, DEX_ARBOK

	map_id KANTO_EAST_ROUTE
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 28, DEX_PICHU
	db 28, DEX_PICHU
	db 27, DEX_PIKACHU
	db 28, DEX_ODDISH
	db 31, DEX_GLOOM
	db 28, DEX_PIKACHU
	; day
	db 29, DEX_ODDISH
	db 30, DEX_PAINTER
	db 32, DEX_MEOWTH
	db 32, DEX_RATICATE
	db 31, DEX_MEOWTH
	db 29, DEX_ODDISH
	; nite
	db 31, DEX_RATICATE
	db 33, DEX_EKANS
	db 34, DEX_ARBOK
	db 35, DEX_ARBOK
	db 36, DEX_EKANS
	db 36, DEX_ARBOK

	map_id ROUTE_SILENT_EAST
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 29, DEX_PICHU
	db 29, DEX_PICHU
	db 28, DEX_PIKACHU
	db 29, DEX_ODDISH
	db 32, DEX_GLOOM
	db 27, DEX_PIKACHU
	; day
	db 28, DEX_ODDISH
	db 29, DEX_PAINTER
	db 32, DEX_MEOWTH
	db 32, DEX_RATICATE
	db 30, DEX_MEOWTH
	db 28, DEX_ODDISH
	; nite
	db 30, DEX_RATICATE
	db 32, DEX_HOHO
	db 33, DEX_EKANS
	db 34, DEX_HOHO
	db 35, DEX_ARBOK
	db 35, DEX_HOHO

	map_id FONTO_ROUTE_5
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id FONTO_ROUTE_6
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_HANEEI
	db 45, DEX_TENTACOOL

	map_id BULL_FOREST_ROUTE_3
	db 6 percent, 10 percent, 14 percent ; encounter rates: morn/day/nite
	; morn
	db 25, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 20, DEX_TENTACOOL
	db 15, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 15, DEX_TENTACOOL
	; day
	db 20, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 35, DEX_TENTACOOL
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	; nite
	db 25, DEX_TENTACOOL
	db 30, DEX_TENTACOOL
	db 35, DEX_TENTACOOL
	db 40, DEX_TENTACOOL
	db 35, DEX_TENTACRUEL
	db 45, DEX_TENTACOOL

	map_id SHIZUKANA_OKA
	db 8 percent, 8 percent, 8 percent ; encounter rates: morn/day/nite
	; morn
	db 7, DEX_REDIBA
	db 7, DEX_REDIBA
	db 5, DEX_METAPOD
	db 5, DEX_PIKACHU
	db 7, DEX_PIDGEY
	db 5, DEX_PIDGEY
	; day
	db 6, DEX_PIDGEY
	db 4, DEX_CATERPIE
	db 6, DEX_CATERPIE
if DEF(GOLD)
	db 6, DEX_HANEKO
else
	db 6, DEX_MARIL
endc
	db 5, DEX_CATERPIE
	db 8, DEX_REDIBA
	; nite
	db 4, DEX_METAPOD
	db 6, DEX_RATTATA
if DEF(GOLD)
	db 6, DEX_CATERPIE
else
	db 5, DEX_HOHO
endc
	db 6, DEX_REDIBA
	db 5, DEX_METAPOD
	db 5, DEX_PIKACHU

	db -1 ; end
