	db DEX_SNORLAX ; 143

	db 160, 110,  65,  30,  65, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 25 ; catch rate
	db 154 ; base exp
	db ITEM_BERRY, ITEM_LEFTOVERS ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw SnorlaxPicFront, SnorlaxPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 22, 24, 25, 26, 27, 29, 31, 32, 33, 34, 35, 36, 38, 40, 44, 46, 48, 50, 53, 54
	; end

