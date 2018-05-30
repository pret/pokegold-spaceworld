	db DEX_GHOST ; 093

	db  45,  50,  45,  95, 115,  40
	;   hp  atk  def  spd  sat  sdf

	db TYPE_GHOST, TYPE_POISON ; type
	db 90 ; catch rate
	db 126 ; base exp
	db ITEM_BERRY, ITEM_TAG ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 6, 6 ; sprite dimensions
	dw GhostPicFront, GhostPicBack ; sprites
	db GROWTH_MEDIUM_SLOW ; growth rate

	; tm/hm learnset
	tmhm 6, 20, 21, 24, 25, 29, 31, 32, 34, 36, 42, 44, 46, 47, 50
	; end

