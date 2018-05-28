	db DEX_ARBO ; 023

	db  35,  60,  44,  55,  50,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_POISON, TYPE_POISON ; type
	db 255 ; catch rate
	db 62 ; base exp
	db ITEM_BERRY, ITEM_SNAKESKIN ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw $7550, $7651 ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 6, 8, 9, 10, 20, 21, 26, 27, 28, 31, 32, 34, 40, 44, 48, 50, 54
	; end
