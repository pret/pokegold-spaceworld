	db DEX_PARASECT ; 047

	db  60,  95,  80,  30,  60,  80
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_GRASS ; type
	db 75 ; catch rate
	db 128 ; base exp
	db ITEM_APPLE, ITEM_CORDYCEPS ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $703c, $71b3 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 8, 9, 10, 15, 20, 21, 22, 28, 31, 32, 33, 34, 40, 44, 50, 51
	; end
