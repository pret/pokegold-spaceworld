	db DEX_PTERA ; 142

	db  80, 105,  65, 130,  60,  85
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_FLYING ; type
	db 45 ; catch rate
	db 202 ; base exp
	db ITEM_BERRY, ITEM_FOSSIL_SHARD ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $74f3, $76ae ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 4, 6, 9, 10, 15, 20, 23, 31, 32, 33, 34, 38, 39, 43, 44, 50, 52
	; end
