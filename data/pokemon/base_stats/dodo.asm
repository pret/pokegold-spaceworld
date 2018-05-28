	db DEX_DODO ; 084

	db  35,  85,  45,  75,  35,  35
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 190 ; catch rate
	db 96 ; base exp
	db ITEM_BERRY, ITEM_FLEE_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $53d1, $54da ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 4, 6, 8, 9, 10, 20, 31, 32, 33, 34, 40, 43, 44, 49, 50, 52
	; end
