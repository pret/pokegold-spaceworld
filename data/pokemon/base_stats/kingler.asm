	db DEX_KINGLER ; 099

	db  55, 130, 115,  75,  65,  50
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_WATER ; type
	db 60 ; catch rate
	db 206 ; base exp
	db ITEM_APPLE, ITEM_STEEL_SHELL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $4000, $41f2 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 11, 12, 13, 14, 15, 20, 31, 32, 34, 44, 50, 51, 53, 54
	; end
