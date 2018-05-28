	db DEX_GOLBAT ; 042

	db  75,  80,  70,  90,  55,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_FLYING ; type
	db 90 ; catch rate
	db 171 ; base exp
	db ITEM_BERRY, ITEM_POISON_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $65c9, $6774 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 21, 31, 32, 34, 39, 44, 50
	; end
