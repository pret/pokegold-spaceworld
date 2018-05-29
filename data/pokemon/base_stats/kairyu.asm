	db DEX_KAIRYU ; 149

	db  91, 134,  95,  80, 100, 100
	;   hp  atk  def  spd  sat  sdf

	db TYPE_DRAGON, TYPE_FLYING ; type
	db 45 ; catch rate
	db 218 ; base exp
	db ITEM_BERRY, ITEM_DRAGON_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 7, 7 ; sprite dimensions
	dw KairyuPicFront, dw KairyuPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 2, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 20, 23, 24, 25, 31, 32, 33, 34, 38, 39, 40, 44, 45, 50, 53, 54
	; end

