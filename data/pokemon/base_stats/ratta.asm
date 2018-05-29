	db DEX_RATTA ; 020

	db  55,  81,  60,  97,  50,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_NORMAL ; type
	db 90 ; catch rate
	db 116 ; base exp
	db ITEM_APPLE, ITEM_SHARP_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw RattaPicFront, RattaPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 11, 12, 13, 14, 15, 20, 24, 25, 28, 31, 32, 34, 39, 40, 44, 50
	; end

