	db DEX_MAGNETON ; 082

	db  50,  60,  95,  70,  75, 120
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 60 ; catch rate
	db 161 ; base exp
	db ITEM_APPLE, ITEM_EARTH ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw MagnetonPicFront, MagnetonPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 15, 20, 24, 25, 30, 31, 32, 33, 34, 39, 44, 45, 50, 55
	; end

