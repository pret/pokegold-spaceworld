	db DEX_ELEBOO ; 125

	db  65,  83,  57, 105,  85,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 45 ; catch rate
	db 156 ; base exp
	db ITEM_BERRY, ITEM_THUNDER_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $4863, $49eb ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 24, 25, 29, 30, 31, 32, 33, 34, 35, 39, 40, 44, 45, 46, 50, 54, 55
	; end
