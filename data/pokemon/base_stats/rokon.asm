	db DEX_ROKON ; 037

	db  38,  41,  40,  65,  65,  45
	;   hp  atk  def  spd  sat  sdf

	db TYPE_FIRE, TYPE_FIRE ; type
	db 190 ; catch rate
	db 63 ; base exp
	db ITEM_BERRY, ITEM_LIFE_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw RokonPicFront, dw RokonPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 20, 28, 31, 32, 33, 34, 38, 39, 40, 44, 50
	; end

