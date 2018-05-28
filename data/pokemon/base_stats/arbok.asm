	db DEX_ARBOK ; 024

	db  60,  85,  69,  80,  85,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 90 ; catch rate
	db 147 ; base exp
	db ITEM_APPLE, ITEM_SNAKESKIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw $778b, $79e8 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 15, 20, 21, 26, 27, 28, 31, 32, 34, 40, 44, 48, 50, 54
	; end
