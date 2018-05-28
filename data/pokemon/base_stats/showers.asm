	db DEX_SHOWERS ; 134

	db 130,  65,  60,  65,  70, 110
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 45 ; catch rate
	db 196 ; base exp
	db ITEM_APPLE, ITEM_WATER_TAIL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $6110, $6274 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 15, 20, 31, 32, 33, 34, 39, 40, 44, 50, 53
	; end
