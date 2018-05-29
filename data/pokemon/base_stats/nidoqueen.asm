	db DEX_NIDOQUEEN ; 031

	db  90,  82,  87,  76,  55,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_GROUND ; type
	db 45 ; catch rate
	db 194 ; base exp
	db ITEM_APPLE, ITEM_KINGS_ROCK ; items
	db GENDER_FEMALE ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw NidoqueenPicFront, NidoqueenPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 24, 25, 26, 27, 31, 32, 33, 34, 38, 40, 44, 48, 50, 53, 54
	; end

