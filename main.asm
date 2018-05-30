INCLUDE "constants.asm"

SECTION "PlaceWaitingText", ROMX[$4000],BANK[$01]
INCLUDE "engine/link/place_waiting_text.asm"

SECTION "Title screen", ROMX[$5D8C],BANK[$01]
INCLUDE "engine/title.asm"

SECTION "Title Screen Sprites", ROMX[$5EB8], BANK[$01]
TitleFlameNoteGfx::
	INCBIN "gfx/fire_notes.2bpp"

SECTION "Predef pointers", ROMX[$62B0],BANK[$01]
INCLUDE "engine/predef.asm"

SECTION "Main Menu Definition", ROMX[$5418], BANK[$01]
MainMenuHeader:
	db $40
	db 0, 0, 7, 13
	dw .data
	db 1 ; default option

.data
	db $80
	db 0 ; number of options

	dw $5461
	db $8a, $1f
	dw MainMenuStrings

MainMenuStrings: ; 01:5428
    db "つづきから　はじめる@"
    db "さいしょから　はじめる@"
    db "せっていを　かえる@"
    db "#を　あそぶ@"
    db "じかんセット@"
; 01:5457

SECTION "Nest Icon", ROMX[$4A0F], BANK[$02]
	INCBIN "gfx/mon_nest_icon.1bpp"

SECTION "Bank 2 Misc GFX", ROMX[$44bf], BANK[$02]
	INCBIN "gfx/gfx_84bf.2bpp"
	INCBIN "gfx/ledge_hopping_shadow.2bpp"
	INCBIN "gfx/emotion_bubbles.2bpp"

SECTION "Pokegear GFX", ROMX[$4F32], BANK[$02]
	INCBIN "gfx/pokegear.2bpp"

SECTION "Unused SGB Border GFX", ROMX[$62CC], BANK[$02]
	INCBIN "gfx/sgb_border_alt.2bpp"

SECTION "SGB Border GFX", ROMX[$6B1C], BANK[$02]
	INCBIN "gfx/sgb_border.2bpp"

SECTION "Title Screen GFX", ROMX[$47CF], BANK[$04]
	INCBIN "gfx/titlescreen.2bpp"

SECTION "Mail Icon GFX", ROMX[$5BB1], BANK[$04]
	INCBIN "gfx/mail.2bpp"

SECTION "TM/HM Moves", ROMX[$52D1],BANK[$04]
INCLUDE "data/moves/tmhm_moves.asm"

SECTION "Trainer Card GFX", ROMX[$7171], BANK[$04]
	INCBIN "gfx/trainer_card.2bpp"
	INCBIN "gfx/leader_faces_names.2bpp"
SECTION "Unused Leader", ROMX[$7BA3], BANK[$04]
	INCBIN "gfx/unused_leader_name.2bpp"

SECTION "Gameboy GFX", ROMX[$5641], BANK[$0A]
	INCBIN "gfx/gameboy.2bpp"

SECTION "Type Matchups", ROMX[$506D],BANK[$0D]
INCLUDE "data/types/type_matchups.asm"

INCLUDE "data/trainers/parties.asm"

SECTION "Alphabetical Pokedex Order", ROMX[$4943],BANK[$10]
INCLUDE "data/pokemon/dex_order_alpha.asm"

SECTION "Evolutions and Attacks", ROMX[$6493],BANK[$10]
INCLUDE "data/pokemon/evos_attacks.asm"

SECTION "Pokedex GFX", ROMX[$40D5], BANK[$11]
	INCBIN "gfx/pokedex_buttons.2bpp"
	INCBIN "gfx/pokedex_pokeball.2bpp"
	INCBIN "gfx/pokedex_cursors.2bpp"
	INCBIN "gfx/gfx_44745.2bpp"

SECTION "Base Data", ROMX[$4F10],BANK[$14]
INCLUDE "data/pokemon/base_stats.asm"

SECTION "PKMN Sprite Bank List", ROMX[$725C], BANK[$14]
INCLUDE "gfx/pokemon/pkmn_pic_banks.asm"

INCLUDE "gfx/pokemon/pkmn_pics.asm"

SECTION "Annon Pic Ptrs and Pics", ROMX[$4d6a], BANK[$1f]
INCLUDE "gfx/pokemon/annon_pic_ptrs.asm"
INCLUDE "gfx/pokemon/annon_pics.asm"

SECTION "Attack Animation GFX", ROMX[$4000], BANK[$21]
	INCBIN "gfx/attack_animations.2bpp"

SECTION "Pokemon Party Sprites", ROMX[$60CC], BANK[$23]
	INCBIN "gfx/mon_party_sprites.2bpp"

SECTION "Slot Machine GFX", ROMX[$4FDB], BANK[$24]
	INCBIN "gfx/slot_machine.2bpp"
	INCBIN "gfx/slot_machine_2.2bpp"

SECTION "Poker GFX", ROMX[$5403], BANK[$38]
	INCBIN "gfx/poker.2bpp"

SECTION "15 Puzzle GFX", ROMX[$5F93], BANK[$38]
	INCBIN "gfx/15_puzzle.2bpp"

SECTION "Matches GFX", ROMX[$6606], BANK[$38]
	INCBIN "gfx/matches.2bpp"

SECTION "Picross GFX", ROMX[$75B7], BANK[$38]
	INCBIN "gfx/picross.2bpp"
	INCBIN "gfx/picross_cursor.2bpp"

SECTION "Gamefreak Logo GFX", ROMX[$41FF], BANK[$39]
	INCBIN "gfx/gamefreak_logo.1bpp"
	INCBIN "gfx/gamefreak_logo_oam.2bpp"

SECTION "Intro Underwater GFX", ROMX[$4ADF], BANK[$39]
	INCBIN "gfx/intro_underwater.2bpp"

SECTION "Intro Water Mon and Forest GFX", ROMX[$55EF], BANK[$39]
	INCBIN "gfx/intro_water_pokemon.2bpp"
	INCBIN "gfx/intro_forest.2bpp"

SECTION "Intro Mon", ROMX[$626F], BANK[$39]
	INCBIN "gfx/intro_purin_pika.2bpp"
	INCBIN "gfx/intro_rizado_1.2bpp"
	INCBIN "gfx/intro_rizado_2.2bpp"
	INCBIN "gfx/intro_rizado_3.2bpp"
	INCBIN "gfx/intro_rizado_flames.2bpp"
	INCBIN "gfx/intro_kamekkusu.2bpp"
	INCBIN "gfx/intro_fushigibana.2bpp"

SECTION "Misc GFX", ROMX[$4162], BANK[$3E]
FontExtraGfx::
	INCBIN "gfx/font_extra.2bpp"
	INCBIN "gfx/font.1bpp"
FontBattleExtraGfx::
	INCBIN "gfx/battle_hud_1.2bpp"
BorderGfx::
	INCBIN "gfx/text_box_borders.1bpp"
	INCBIN "gfx/status_screen_separator.2bpp"
	INCBIN "gfx/status_screen.2bpp"
	INCBIN "gfx/battle_hud_2.1bpp"
	INCBIN "gfx/exp_bar.2bpp"
	INCBIN "gfx/m_kg.2bpp"
	INCBIN "gfx/pokedex.2bpp"
	INCBIN "gfx/town_map.2bpp"
	INCBIN "gfx/gfx_f8fc2.2bpp"
BoldFontGfx::
	INCBIN "gfx/alphabet.1bpp"
	INCBIN "gfx/annon_alphabet.1bpp"
	INCBIN "gfx/gfx_f9322.1bpp"
PackIconGfx::
	INCBIN "gfx/pack_icons.2bpp"

SECTION "Town Map Cursor", ROMX[$506F], BANK[$3F]
	INCBIN "gfx/town_map_cursor.2bpp"
