	db DEX_TRANSEL ; 011

	db  50,  20,  55,  30,  25,  25
	;   hp  atk  def  spd  sat  sdf

	db TYPE_BUG, TYPE_BUG ; type
	db 120 ; catch rate
	db 72 ; base exp
	db ITEM_BERRY, ITEM_STRANGE_THREAD ; items
	db GENDER_50_50 ; gender ratio
	db 100, 4, 70 ; unknown
	dn 5, 5 ; sprite dimensions
	dw TranselPicFront, dw TranselPicBack ; sprites
	db GROWTH_MEDIUM_FAST ; growth rate

	; tm/hm learnset
	tmhm 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63
	; end

