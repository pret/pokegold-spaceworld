INCLUDE "constants.asm"

SECTION "home/unknown_3e32.asm", ROM0

; A collection of seemingly old functions that match up with the used functions in some areas,
; but have differing addresses in others.

; Completely unreferenced except among each other.

DEF Old_FarCallFunctionAddress EQU $2f91

Unreferenced_Function3e32:
	xor a
	dec a
	ldh [hConnectionStripLength], a
	jr nz, @ - 25 ; Unknown function
	ret

Unreferenced_GetPartyParamLocation_Old:
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld bc, PARTYMON_STRUCT_LENGTH
	ld a, [wCurPartyMon]
	call $3412 ; Early position for AddNTimes
	pop bc
	ret

Unreferenced_DoItemEffect_Old:
	ld a, BANK(_DoItemEffect)
	ld hl, $67C4 ; Early location for _DoItemEffect
	jp Old_FarCallFunctionAddress

Unreferenced_CheckTossableItem_Old:
	push hl
	push de
	push bc
	ld hl, $53E5 ; Early location for _CheckTossableItem
	ld a, BANK(_CheckTossableItem)
	call Old_FarCallFunctionAddress
	pop bc
	pop de
	pop hl
	ret

Unreferenced_GetBattleAnimPointer_Old:
	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld a, [hli]
	ld [wBattleAnimAddress], a
	ld a, [hl]
	ld [wBattleAnimAddress + 1], a

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a
	ret

Unreferenced_GetBattleAnimByte_Old:
	push hl
	push de

	ld hl, wBattleAnimAddress
	ld e, [hl]
	inc hl
	ld d, [hl]

	ld a, BANK(BattleAnimations)
	ld [MBC3RomBank], a 
	ldh [hROMBank], a

	ld a, [de]
	ld [wBattleAnimByte], a
	inc de

	ld a, BANK(PlayBattleAnim)
	ld [MBC3RomBank], a
	ldh [hROMBank], a

	ld [hl], d
	dec hl
	ld [hl], e

	pop de
	pop hl

	ld a, [wBattleAnimByte]
	ret

Unreferenced_InitSpriteAnimStruct_Old:
	ld [wCurSpriteOAMFlags], a
	ldh a, [hROMBank]
	push af
	ld a, BANK(_InitSpriteAnimStruct)
	call $32AB ; Old location of Bankswitch
	ld a, [wCurSpriteOAMFlags]
	call _InitSpriteAnimStruct
	pop af
	call $32AB ; Old location of Bankswitch
	ret

; Equivalent to EmptyFunction3cbe
EmptyFunction3eb4:
	ret

Unreferenced_DisableAudio_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_DisableAudio)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _DisableAudio
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unused_UpdateSound_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _UpdateSound
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_LoadMusicByte_Old:
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld a, [de]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	ret

Unreferenced_PlayMusic_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlayMusic
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_PlayCryHeader_Old:
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(PokemonCries)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld hl, PokemonCries
rept 6
	add hl, de
endr
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	ld a, BANK(_PlayCryHeader)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlayCryHeader

	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unused_PlaySFX_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlaySFX)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	call _PlaySFX
	pop af
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_WaitPlaySFX_Old:
	call Unused_WaitSFX_Old
	call Unused_PlaySFX_Old
	ret

Unused_WaitSFX_Old:
	push hl
.loop
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .loop
	pop hl
	ret

Unreferenced_MaxVolume_Old:
	ld a, $77
	ld [wVolume], a
	ret

Unreferenced_LowVolume_Old:
	ld a, $33
	ld [wVolume], a
	ret

Unreferenced_UpdateSoundNTimes_Old:
.loop
	and a
	ret z
	dec a
	call Unused_UpdateSound_Old
	jr .loop

Unreferenced_FadeToMapMusic_Old:
	push hl
	push de
	push bc
	push af
; The check appears to be backwards: the carry flag is set if the player is on a vehicle, and unset otherwise.
; If the player is on no vehicle, then it would've used the last value of 'de' as the music id, potentially playing a garbage track.
; The final game fixes this by instead checking if the vehicle track is already playing, but the final GetMapMusic still sets the carry flag.
	call Unused_SpecialMapMusic_Old
	jr c, .dont_change
	ld a, 8
	ld [wMusicFade], a
	call _DisableAudio
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID + 1], a
.dont_change
	pop af
	pop bc
	pop de
	pop hl
	ret

; Disables audio when the player is not on a bike or skateboard.
Unreferenced_PlayMapMusic_Old:
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call Unreferenced_PlayMusic_Old
	call DelayFrame
	call Unused_SpecialMapMusic_Old
	jr c, .play_music

; _DisableAudio is in a mapper bank, but the bank is not switched in this function.
; Either this function was supposed to be called when in the same bank,
; or this is an oversight, and they meant to call DisableAudio instead (note the lack of underscore).
	call _DisableAudio
.play_music
	call Unreferenced_PlayMusic_Old
	pop af
	pop bc
	pop de
	pop hl
	ret

; There was no GetMapMusic at this point in development.
Unused_SpecialMapMusic_Old:
	ld a, [wPlayerState]
	and a
	jr z, .normal
	cp PLAYER_SKATE
	jr z, .skateboard
	ld de, MUSIC_BICYCLE
	scf
	ret

.skateboard
	ld de, MUSIC_NONE
	scf
	ret

.normal
	and a
	ret
