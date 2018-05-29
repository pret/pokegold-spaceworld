	db DEX_HAKURYU ; 148

	db  61,  84,  65,  70,  70,  70
	;   hp  atk  def  spd  sat  sdf

	db TYPE_DRAGON, TYPE_DRAGON ; type
	db 45 ; catch rate
	db 144 ; base exp
	db ITEM_BERRY, ITEM_DRAGON_FANG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw HakuryuPicFront, HakuryuPicBack ; sprites
	db GROWTH_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 7, 8, 9, 10, 11, 12, 13, 14, 20, 23, 24, 25, 31, 32, 33, 34, 38, 39, 40, 44, 45, 50, 53
	; end

