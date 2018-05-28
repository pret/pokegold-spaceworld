	db DEX_GHOS ; 092

	db  30,  35,  30,  80, 100,  25
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GHOST, TYPE_POISON ; type
	db 190 ; catch rate
	db 95 ; base exp
	db ITEM_BERRY, ITEM_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $6928, $6a76 ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 20, 21, 24, 25, 29, 31, 32, 34, 36, 42, 44, 46, 47, 50
	; end
