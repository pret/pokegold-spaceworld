	db DEX_TAMATAMA ; 102

	db  60,  40,  80,  40,  60,  55
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GRASS, TYPE_PSYCHIC ; type
	db 90 ; catch rate
	db 98 ; base exp
	db ITEM_BERRY, ITEM_CALM_BERRY ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw TamatamaPicFront, TamatamaPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 9, 10, 20, 29, 30, 31, 32, 33, 34, 36, 37, 44, 46, 47, 50
	; end

