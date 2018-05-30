	db DEX_SPEAR ; 015

	db  65,  80,  40,  75,  45,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_POISON ; type
	db 45 ; catch rate
	db 159 ; base exp
	db ITEM_APPLE, ITEM_QUICK_NEEDLE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw SpearPicFront, SpearPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 15, 20, 21, 31, 32, 33, 34, 39, 40, 44, 50, 51
	; end

