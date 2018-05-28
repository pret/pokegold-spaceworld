	db DEX_GARAGARA ; 105

	db  60,  80, 110,  45,  50,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 75 ; catch rate
	db 124 ; base exp
	db ITEM_APPLE, ITEM_THICK_CLUB ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $4eaf, $5021 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 38, 40, 44, 50, 54
	; end
