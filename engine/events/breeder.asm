INCLUDE "constants.asm"

SECTION "engine/events/breeder.asm", ROMX

_Breeder::
	ld a, [wBreederStatus]
	cp BREEDER_TWO_BREEDMON
	jr c, .continue
	cp BREEDER_EGG_READY
	jp z, .AskGiveEgg
	cp BREEDER_GAVE_EGG
	jr z, .continue

	call .CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	and a
	jr z, .no_egg_yet
; Autogenerates an egg if the Pokémon are compatible.
	ld a, BREEDER_EGG_READY
	ld [wBreederStatus], a
.no_egg_yet
	ld hl, .NoEggYetText
	call PrintText

.continue
	ld hl, .IntroText
	call PrintText
	ld hl, .MenuHeader
	call LoadMenuHeader
	call VerticalMenu
	push af
	call CloseWindow
	pop af
	jp c, .Exit
	ld a, [wMenuCursorY]
	cp 3
	jp z, .Exit
	cp 1
	jr z, .Deposit

	ld a, [wBreederStatus]
	and a
	jr z, .no_breedmons
	cp BREEDER_TWO_BREEDMON
	jr nz, .Withdraw

	ld hl, .CheckOnPokemonText
	call PrintText
	call YesNoBox
	jp c, .Exit

	jr .Withdraw

.no_breedmons
	ld hl, .DoesntHavePokemonText
	call PrintText
	jp .Exit

.Withdraw:
	ld a, GET_BREED_MON
	ld [wPokemonWithdrawDepositParameter], a
	predef RetrieveBreedmonOrBuffermon
	jp c, .party_full

	ld a, [wBreederStatus]
	sub 1
	jr z, .last_mon
	ld a, BREEDER_ONE_BREEDMON
.last_mon
	ld [wBreederStatus], a
	ld a, [wBreedMonGenders]
	srl a
	ld [wBreedMonGenders], a
	ld hl, .WithdrawnText
	call PrintText
	jp .Exit

.Deposit:
	ld a, [wBreederStatus]
	cp BREEDER_TWO_BREEDMON
	jp nc, .empty

	add PARTYMENUACTION_GIVE_MON
	call UseItem_SelectMon
	jp c, .Exit

	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	call GetBaseData
	xor a
	ld [wMonType], a
	predef GetGender

	ld a, [wBreedMonGenders]
	rla
	ld [wBreedMonGenders], a

	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNick
	ld a, GET_BREED_MON
	ld [wPokemonWithdrawDepositParameter], a
	predef DepositBreedmonOrBuffermon
	
	xor a ; REMOVE_PARTY
	ld [wPokemonWithdrawDepositParameter], a
	callfar RemoveMonFromPartyOrBox ; in the same bank, no need to farcall!
	ld a, [wCurPartySpecies]
	call PlayCry

	ld hl, .DepositedText
	call PrintText
	ld a, [wBreederStatus]
	inc a
	ld [wBreederStatus], a
	cp BREEDER_TWO_BREEDMON
	jr nz, .Exit

	ld hl, .LetsMakeBabiesText
	call PrintText

	call .CheckBreedmonCompatibility
	ld a, [wBreedingCompatibility]
	cp 80
	ld hl, .SeemToGetAlongText
	call z, PrintText

	ld a, [wBreedingCompatibility]
	cp 20
	ld hl, .DontSeemToGetAlongText
	call z, PrintText

	ld a, [wBreedingCompatibility]
	and a
	ld hl, .GendersDontMatchText
	call z, PrintText
	jr .Exit
.empty
	ld hl, .AlreadyHasTwoPokemonText
	call PrintText
	jr .Exit

.Exit:
	call ClearBGPalettes
	call RestoreScreenAndReloadTiles
	call GetMemSGBLayout
	jp ReloadFontAndTileset

.party_full
	ld hl, .BoxAndPartyFullText
	jp PrintText

.CheckBreedmonCompatibility:
; Assumes that wBreedMonGenders has already been set from opening the Breeder menu with 1 or fewer Pokémon.
; If you open the breeder after saving and resetting the game while they have two Pokémon
; (assuming the BreedMons GET saved at this point in development),
; then this check will fail until you change out the BreedMons again.
	ld a, [wBreedMonGenders]
	ld b, a
	srl b
	xor b
	and $1
	jr z, .done

	ld a, [wBreedMon1ID]
	ld b, a
	ld a, [wBreedMon2ID]
	cp b
	jr nz, .different_id

	ld a, [wBreedMon1ID + 1]
	ld b, a
	ld a, [wBreedMon2ID + 1]
	cp b
	jr nz, .different_id
	ld a, 20
	jr .done
.different_id
	ld a, 80
.done
	ld [wBreedingCompatibility], a
	ret

.IntroText:
	text "わたしは　こずくりやさん"
	line "さて　どうする？"
	done

.MenuHeader:
	db MENU_BACKUP_TILES
	menu_coords 13, 4, 19, 11
	dw .MenuData
	db 1

.MenuData:
	db STATICMENU_CURSOR
	db 3
	db "あずける@"	; Deposit
	db "ひきとる@"	; Withdraw
	db "やめる@"	; Cancel

.DepositedText:
	text "あずけた！"
	prompt

.AlreadyHasTwoPokemonText:
	text "すでに　２ひきの#を"
	line "あずかっています"
	prompt

.CheckOnPokemonText:
	text "こずくりを　ちゅうししますか？"
	done

.DoesntHavePokemonText:
	text "#は　いっぴきも"
	line "あずかってませんが"
	prompt

.WithdrawnText:
	text "ひきとった！"
	prompt

.BoxAndPartyFullText:
	text "てもちも　マサキの　<PC>も"
	line "#で　いっぱいのようです"
	prompt

.LetsMakeBabiesText:
	text "それでは　こづくりします！"
	prompt

.SeemToGetAlongText:
	text "あいしょうが　いいようです"
	prompt

.DontSeemToGetAlongText:
	text "あいしょうが　わるいようです"
	prompt

.GendersDontMatchText:
	text "せいべつが　あわないようです"
	prompt

.NoEggYetText:
	text "ざんねんながら　まだ　うまれて"
	line "こないようです"
	prompt

.AskGiveEgg:
	ld hl, .EggLaidText
	call PrintText
	call YesNoBox
	jp c, .Exit

	ld a, BREEDER_GAVE_EGG
	ld [wBreederStatus], a
	ld a, [wBreedMon1Species]
	ld [wCurPartySpecies], a
	call PlayCry

	xor a
	ld [wMonType], a
	ld a, 5
	ld [wCurPartyLevel], a
	predef GiveEgg
	jp .Exit

.EggLaidText:
	text "タマゴが　うまれました！"
	line "ひきとりますか？"
	done

Stub_MailEffect::
	ret
