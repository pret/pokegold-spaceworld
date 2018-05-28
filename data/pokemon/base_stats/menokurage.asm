	db DEX_MENOKURAGE ; 072

	db  40,  40,  35,  70,  60, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_WATER, TYPE_POISON ; type
	db 190 ; catch rate
	db 105 ; base exp
	db ITEM_BERRY, ITEM_TOXIC_NEEDLE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $72b8, $73a2 ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 3, 6, 9, 10, 11, 12, 13, 14, 20, 21, 31, 32, 33, 34, 40, 44, 50, 51, 53
	; end
