MACRO sprite_anim_obj_gfx
; # tiles, gfx pointer
	db \1
	dbw \2, \3
ENDM

; entries correspond to SPRITE_ANIM_DICT_* constants
SpriteAnimGFX:
	; # tiles, gfx bank, gfx pointer
	; (good chunk of pointers were dummied out to either .DeletedGFX or MenuMonIconGFX)
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX 
	sprite_anim_obj_gfx   8, BANK(PoliwagIcon),    PoliwagIcon    ; SPRITE_ANIM_DICT_POLIWAG_ICON
	sprite_anim_obj_gfx   8, BANK(JigglypuffIcon), JigglypuffIcon ; SPRITE_ANIM_DICT_JIGGLYPUFF_ICON
	sprite_anim_obj_gfx   8, BANK(DiglettIcon),    DiglettIcon    ; SPRITE_ANIM_DICT_DIGLETT_ICON
	sprite_anim_obj_gfx   8, BANK(PikachuIcon),    PikachuIcon    ; SPRITE_ANIM_DICT_PIKACHU_ICON
	sprite_anim_obj_gfx   8, BANK(StaryuIcon),     StaryuIcon     ; SPRITE_ANIM_DICT_STARYU_ICON
	sprite_anim_obj_gfx   8, BANK(MagikarpIcon),   MagikarpIcon   ; SPRITE_ANIM_DICT_MAGIKARP_ICON
	sprite_anim_obj_gfx   8, BANK(PidgeyIcon),     PidgeyIcon     ; SPRITE_ANIM_DICT_PIDGEY_ICON
	sprite_anim_obj_gfx   8, BANK(RhydonIcon),     RhydonIcon     ; SPRITE_ANIM_DICT_RHYDON_ICON
	sprite_anim_obj_gfx   8, BANK(ClefairyIcon),   ClefairyIcon   ; SPRITE_ANIM_DICT_CLEFAIRY_ICON
	sprite_anim_obj_gfx   8, BANK(OddishIcon),     OddishIcon     ; SPRITE_ANIM_DICT_ODDISH_ICON
	sprite_anim_obj_gfx   8, BANK(MushiIcon),      MushiIcon      ; SPRITE_ANIM_DICT_MUSHI_ICON
	sprite_anim_obj_gfx   8, BANK(GengarIcon),     GengarIcon     ; SPRITE_ANIM_DICT_GENGAR_ICON
	sprite_anim_obj_gfx   8, BANK(LaprasIcon),     LaprasIcon     ; SPRITE_ANIM_DICT_LAPRAS_ICON
	sprite_anim_obj_gfx   8, BANK(MrMimeIcon),     MrMimeIcon     ; SPRITE_ANIM_DICT_MRMIME_ICON
	sprite_anim_obj_gfx   8, BANK(LokonIcon),      LokonIcon      ; SPRITE_ANIM_DICT_LOKON_ICON
	sprite_anim_obj_gfx   8, BANK(TaurosIcon),     TaurosIcon     ; SPRITE_ANIM_DICT_TAUROS_ICON
	sprite_anim_obj_gfx   8, BANK(ShellderIcon),   ShellderIcon   ; SPRITE_ANIM_DICT_SHELLDER_ICON
	sprite_anim_obj_gfx   8, BANK(DittoIcon),      DittoIcon      ; SPRITE_ANIM_DICT_DITTO_ICON
	sprite_anim_obj_gfx   8, BANK(OnixIcon),       OnixIcon       ; SPRITE_ANIM_DICT_ONIX_ICON
	sprite_anim_obj_gfx   8, BANK(VoltorbIcon),    VoltorbIcon    ; SPRITE_ANIM_DICT_VOLTORB_ICON
	sprite_anim_obj_gfx   8, BANK(SquirtleIcon),   SquirtleIcon   ; SPRITE_ANIM_DICT_SQUIRTLE_ICON
	sprite_anim_obj_gfx   8, BANK(BulbasaurIcon),  BulbasaurIcon  ; SPRITE_ANIM_DICT_BULBASAUR_ICON
	sprite_anim_obj_gfx   8, BANK(CharmanderIcon), CharmanderIcon ; SPRITE_ANIM_DICT_CHARMANDER_ICON
	sprite_anim_obj_gfx   8, BANK(WeedleIcon),     WeedleIcon     ; SPRITE_ANIM_DICT_WEEDLE_ICON
	sprite_anim_obj_gfx   8, BANK(AnnonIcon),      AnnonIcon      ; SPRITE_ANIM_DICT_ANNON_ICON
	sprite_anim_obj_gfx   8, BANK(GeodudeIcon),    GeodudeIcon    ; SPRITE_ANIM_DICT_GEODUDE_ICON
	sprite_anim_obj_gfx   8, BANK(MachopIcon),     MachopIcon     ; SPRITE_ANIM_DICT_MACHOP_ICON
	sprite_anim_obj_gfx   8, BANK(EggIcon),        EggIcon        ; SPRITE_ANIM_DICT_EGG_ICON
	sprite_anim_obj_gfx   8, BANK(TentacoolIcon),  TentacoolIcon  ; SPRITE_ANIM_DICT_TENTACOOL_ICON
	sprite_anim_obj_gfx   8, BANK(ButterfreeIcon), ButterfreeIcon ; SPRITE_ANIM_DICT_BUTTERFREE_ICON
	sprite_anim_obj_gfx   8, BANK(ZubatIcon),      ZubatIcon      ; SPRITE_ANIM_DICT_ZUBAT_ICON
	sprite_anim_obj_gfx   8, BANK(SnorlaxIcon),    SnorlaxIcon    ; SPRITE_ANIM_DICT_SNORLAX_ICON
	sprite_anim_obj_gfx 128, $01,                  .DeletedGFX    ; SPRITE_ANIM_DICT_GS_INTRO
	sprite_anim_obj_gfx 128, $01,                  .DeletedGFX    ; SPRITE_ANIM_DICT_GS_INTRO_2
	sprite_anim_obj_gfx 128, $01,                  .DeletedGFX    ; SPRITE_ANIM_DICT_GS_INTRO_3
	sprite_anim_obj_gfx 128, $01,                  .DeletedGFX    ; SPRITE_ANIM_DICT_TITLE_FLAME_NOTE
	sprite_anim_obj_gfx  16, $37,                  .DeletedGFX    ; SPRITE_ANIM_DICT_MINIGAME_PICROSS
	sprite_anim_obj_gfx  16, $11,                  .DeletedGFX    ; SPRITE_ANIM_DICT_TEXT_CURSOR
	sprite_anim_obj_gfx  16, $39,                  .DeletedGFX    ; SPRITE_ANIM_DICT_GS_SPLASH
	sprite_anim_obj_gfx  16, $24,                  .DeletedGFX    ; SPRITE_ANIM_DICT_SLOTS
	sprite_anim_obj_gfx  16, $21,                  .DeletedGFX    ; SPRITE_ANIM_DICT_ARROW_CURSOR

	; Unused placeholders
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX
	sprite_anim_obj_gfx  16, $31,                  MenuMonIconGFX

.DeletedGFX
