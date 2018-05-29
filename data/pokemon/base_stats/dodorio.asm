	db DEX_DODORIO ; 085

	db  60, 110,  70, 100,  60,  65
	;   hp  atk  def  spd  sat  sdf

	db TYPE_NORMAL, TYPE_FLYING ; type
	db 45 ; catch rate
	db 158 ; base exp
	db ITEM_APPLE, ITEM_FLEE_FEATHER ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw DodorioPicFront, dw DodorioPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 4, 6, 8, 9, 10, 15, 20, 31, 32, 33, 34, 40, 43, 44, 49, 50, 52
	; end

