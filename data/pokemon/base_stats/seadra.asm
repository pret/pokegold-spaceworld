	db DEX_SEADRA ; 117

	db  55,  65,  95,  85,  95,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 75 ; catch rate
	db 155 ; base exp
	db ITEM_BERRY, ITEM_SMOKESCREEN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $703d, $71a4 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 11, 12, 13, 14, 15, 20, 31, 32, 34, 39, 40, 44, 50, 53
	; end
