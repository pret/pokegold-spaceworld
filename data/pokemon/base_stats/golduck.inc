	db DEX_GOLDUCK ; 055

	db  80,  82,  78,  85,  80,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 75 ; catch rate
	db 174 ; base exp
	db ITEM_APPLE, ITEM_MIGRAINE_SEED ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw GolduckPicFront, GolduckPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 28, 31, 32, 34, 39, 40, 44, 50, 53, 54
	; end

