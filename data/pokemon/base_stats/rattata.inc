	db DEX_RATTATA ; 019

	db  30,  56,  35,  72,  25,  35
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 255 ; catch rate
	db 57 ; base exp
	db ITEM_BERRY, ITEM_SHARP_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw RattataPicFront, RattataPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 14, 20, 24, 25, 28, 31, 32, 34, 39, 40, 44, 50
	; end

