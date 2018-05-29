	db DEX_UTSUBOT ; 071

	db  80, 105,  65,  70,  65, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_POISON ; type
	db 45 ; catch rate
	db 191 ; base exp
	db ITEM_APPLE, ITEM_BIG_LEAF ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw UtsubotPicFront, UtsubotPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 15, 20, 21, 22, 31, 32, 33, 34, 44, 50, 51
	; end

