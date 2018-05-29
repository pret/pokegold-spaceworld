	db DEX_PURIN ; 039

	db 115,  45,  20,  20,  25,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 170 ; catch rate
	db 76 ; base exp
	db ITEM_BERRY, ITEM_STRANGE_POWER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw PurinPicFront, PurinPicBack ; sprites
	db GROWTH_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 22, 24, 25, 29, 30, 31, 32, 33, 34, 38, 40, 44, 45, 46, 49, 50, 54, 55
	; end

