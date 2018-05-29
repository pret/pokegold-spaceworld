	db DEX_KARAKARA ; 104

	db  50,  50,  95,  35,  40,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GROUND, TYPE_GROUND ; type
	db 190 ; catch rate
	db 87 ; base exp
	db ITEM_BERRY, ITEM_THICK_CLUB ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw KarakaraPicFront, dw KarakaraPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 38, 40, 44, 50, 54
	; end

