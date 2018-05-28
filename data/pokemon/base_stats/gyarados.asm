	db DEX_GYARADOS ; 130

	db  95, 125,  79,  81,  85, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_FLYING ; type
	db 45 ; catch rate
	db 214 ; base exp
	db ITEM_APPLE, ITEM_DRAGON_SCALE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $56f5, $5946 ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 15, 20, 23, 24, 25, 31, 32, 33, 34, 38, 40, 44, 50, 53, 54
	; end
