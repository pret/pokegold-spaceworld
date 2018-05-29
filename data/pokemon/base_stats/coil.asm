	db DEX_COIL ; 081

	db  25,  35,  70,  45,  60,  95
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 190 ; catch rate
	db 89 ; base exp
	db ITEM_BERRY, ITEM_EARTH ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw CoilPicFront, CoilPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 20, 24, 25, 30, 31, 32, 33, 34, 39, 44, 45, 50, 55
	; end

