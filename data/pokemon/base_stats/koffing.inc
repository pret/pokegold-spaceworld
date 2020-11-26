	db DEX_KOFFING ; 109

	db  40,  65,  95,  35,  60,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 190 ; catch rate
	db 114 ; base exp
	db ITEM_BERRY, ITEM_GROSS_GARBAGE ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw KoffingPicFront, KoffingPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 20, 24, 25, 31, 32, 34, 36, 38, 44, 47, 50
	; end

