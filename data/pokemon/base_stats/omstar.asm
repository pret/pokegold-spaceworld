	db DEX_OMSTAR ; 139

	db  70,  60, 125,  55, 115,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_ROCK, TYPE_WATER ; type
	db 45 ; catch rate
	db 199 ; base exp
	db ITEM_APPLE, ITEM_FOSSIL_SHARD ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw $6ce4, $6e9c ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 17, 19, 20, 31, 32, 33, 34, 40, 44, 50, 53
	; end
