	db DEX_METAMON ; 132

	db  48,  48,  48,  48,  48,  48
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 35 ; catch rate
	db 61 ; base exp
	db ITEM_BERRY, ITEM_METAL_COAT ; items
	db GENDER_UNKNOWN ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw MetamonPicFront, dw MetamonPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
	; end

