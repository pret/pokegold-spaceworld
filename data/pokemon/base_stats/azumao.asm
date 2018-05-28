	db DEX_AZUMAO ; 119

	db  80,  92,  65,  68,  65,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 60 ; catch rate
	db 170 ; base exp
	db ITEM_APPLE, ITEM_WET_HORN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $74ea, $76c0 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 9, 10, 11, 12, 13, 14, 15, 20, 31, 32, 34, 39, 40, 44, 50, 53
	; end
