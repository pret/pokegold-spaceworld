	db DEX_KODUCK ; 054

	db  50,  52,  48,  55,  50,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 190 ; catch rate
	db 80 ; base exp
	db ITEM_BERRY, ITEM_MIGRAINE_SEED ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw KoduckPicFront, KoduckPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 16, 17, 18, 19, 20, 28, 31, 32, 34, 39, 40, 44, 50, 53, 54
	; end

