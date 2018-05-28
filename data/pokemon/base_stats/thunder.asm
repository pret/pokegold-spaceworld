	db DEX_THUNDER ; 145

	db  90,  90,  85, 100, 125,  90
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_FLYING ; type
	db 3 ; catch rate
	db 216 ; base exp
	db ITEM_BERRY, ITEM_THUNDER_WING ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $4000, $41e7 ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 24, 25, 31, 32, 33, 34, 39, 43, 44, 45, 50, 52, 55
	; end
