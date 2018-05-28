	db DEX_JUGON ; 087

	db  90,  70,  80,  70,  80,  95
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_ICE ; type
	db 75 ; catch rate
	db 176 ; base exp
	db ITEM_APPLE, ITEM_ICE_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $5b9b, $5d51 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 20, 31, 32, 34, 40, 44, 50, 53, 54
	; end
