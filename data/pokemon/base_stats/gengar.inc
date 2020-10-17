	db DEX_GENGAR ; 094

	db  60,  65,  60, 110, 130,  75
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GHOST, TYPE_POISON ; type
	db 45 ; catch rate
	db 190 ; base exp
	db ITEM_APPLE, ITEM_SPELL_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw GengarPicFront, GengarPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 1, 5, 6, 8, 9, 10, 15, 17, 18, 19, 20, 21, 24, 25, 29, 31, 32, 34, 35, 36, 40, 42, 44, 46, 47, 50, 54
	; end

