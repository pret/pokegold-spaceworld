	db DEX_BOOSTER ; 136

	db  65, 130,  60,  65,  70, 110
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 45 ; catch rate
	db 198 ; base exp
	db ITEM_APPLE, ITEM_FIRE_TAIL ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $65d8, $6784 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end
