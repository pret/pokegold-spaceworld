	db DEX_THUNDERS ; 135

	db  65,  65,  60, 130,  70, 110
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ELECTRIC, TYPE_ELECTRIC ; type
	db 45 ; catch rate
	db 197 ; base exp
	db ITEM_APPLE, ITEM_THUNDER_TAIL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $638c, $64ec ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 24, 25, 31, 32, 33, 34, 39, 40, 44, 45, 50, 55
	; end
