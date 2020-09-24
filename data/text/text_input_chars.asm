INCLUDE "constants.asm"

SECTION "data/text/text_input_chars.asm", ROMX

TextEntryChars:
	db "ABCDE　FGHIJ　KLMNO"
	db "PQRST　UVWXY　ZÄÖÜ　"
	db "abcde　fghij　klmno"
	db "pqrst　uvwxy　zäéöü"
	db "12345　67890　　　　　　"
	db "?!.,'　:;×-/　　　　　　"
	db "[]()&　<PK><MN>　　　　　　　　　"
	db "　　　　　　　　　　　　　　　　円"
	
TextEntryHiragana:
	db "あいうえお　かきくけこ　さしすせそ"
	db "たちつてと　なにぬねの　はひふへほ"
	db "まみむめも　やゆよわん　らりるれろ"
	db "ゃゅょっを　１２３４５　６７８９０"
	db "　ﾞﾟ　ー？！円"

TextEntryKatakana:
	db "アイウエオ　カキクケコ　サシスセソ"
	db "タチツテト　ナニヌネノ　ハヒフへホ"
	db "マミムメモ　ヤユヨワン　ラりルレロ"
	db "ャュョッヲ　１２３４５　６７８９０"
	db "　ﾞﾟ　ー？！円"
