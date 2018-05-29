; TODO: PIC_* constants?

MonSpriteBankList::
	; last mon in bank, bank #
	db DEX_RAICHU,     BANK(RaichuPicFront)
	db DEX_DUGTRIO,    BANK(DugtrioPicFront)
	db DEX_GOLONE,     BANK(GolonePicFront)
	db DEX_CRAB,       BANK(CrabPicFront)
	db DEX_STARMIE,    BANK(StarmiePicFront)
	db DEX_FREEZER,    BANK(FreezerPicFront)
	db DEX_JARANRA,    BANK(JaranraPicFront)
	db DEX_KOUNYA,     BANK(KounyaPicFront)
	db DEX_BOMBSEEKER, BANK(BombseekerPicFront)
	db DEX_NYULA,      BANK(NyulaPicFront)
	db $ff,            BANK(LeafyPicFront)
	db $ff,            BANK(LeafyPicFront) + 1
