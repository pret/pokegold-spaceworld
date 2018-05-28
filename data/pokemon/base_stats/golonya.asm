	db DEX_GOLONYA ; 076

	db  80, 110, 130,  45,  55,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_GROUND ; type
	db 45 ; catch rate
	db 177 ; base exp
	db ITEM_APPLE, ITEM_HARD_STONE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $4000, $417e ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 26, 27, 28, 31, 32, 34, 35, 36, 38, 44, 47, 48, 50, 54
	; end
