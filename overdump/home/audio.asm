if DEF(_DEBUG)
Unreferenced_Corrupt_DisableAudio_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_DisableAudio)
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	call _DisableAudio
	pop af
	ld [rROMB], a ; Unsafe
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
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	call _UpdateSound
	pop af
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_LoadMusicByte_Old:
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	ld a, [de]
	push af
	ld a, BANK(_UpdateSound)
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	pop af
	ret

Unreferenced_Corrupt_PlayMusic_Old:
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayMusic)
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	call _PlayMusic
	pop af
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_PlayCryHeader_Old:
	push hl
	push de
	push bc
	push af

	ldh a, [hROMBank]
	push af
	ld a, BANK(PokemonCries)
	ld [rROMB], a ; Unsafe
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
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	call _PlayCryHeader

	pop af
	ld [rROMB], a ; Unsafe
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
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	call _PlaySFX
	pop af
	ld [rROMB], a ; Unsafe
	ldh [hROMBank], a
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_WaitPlaySFX_Old:
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

Unreferenced_Corrupt_MaxVolume_Old:
	ld a, $77
	ld [wVolume], a
	ret

Unreferenced_Corrupt_LowVolume_Old:
	ld a, $33
	ld [wVolume], a
	ret

Unreferenced_Corrupt_UpdateSoundNTimes_Old:
.loop
	and a
	ret z
	dec a
	call Unused_UpdateSound_Old
	jr .loop

Unreferenced_Corrupt_FadeToMapMusic_Old:
	push hl
	push de
	push bc
	push af
; The check appears to be backwards: the carry flag is set if the player is on a vehicle, and unset otherwise.
; If the player is on no vehicle, then it would've used the last value of 'de' as the music id, potentially playing a overdump track.
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
Unreferenced_Corrupt_PlayMapMusic_Old:
	push hl
	push de
	push bc
	push af
	ld de, MUSIC_NONE
	call Unreferenced_Corrupt_PlayMusic_Old
	call DelayFrame
	call Unused_SpecialMapMusic_Old
	jr c, .play_music

; _DisableAudio is in a mapper bank, but the bank is not switched in this function.
; Either this function was supposed to be called when in the same bank,
; or this is an oversight, and they meant to call DisableAudio instead (note the lack of underscore).
	call _DisableAudio
.play_music
	call Unreferenced_Corrupt_PlayMusic_Old
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

else

Unreferenced_Corrupt_PlayMapMusic::
	dw $0317
	pop de
	ld a, e
	ld [wMapMusic], a
	call @ - $F6
.jump
	pop af
	pop bc
	pop de
	pop hl
	ret

Unreferenced_Corrupt_SpecialMapMusic::
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

Unreferenced_Corrupt_GetMapMusic::
	call Unreferenced_Corrupt_SpecialMapMusic
	ret c
	ld a, [wMapPermissions]
	cp TOWN
	jr z, .not_route
	cp INDOOR
	jr z, .not_route
	ld de, MUSIC_ROUTE_1
	ret

.not_route
	ld de, MUSIC_VIRIDIAN_CITY
	ret
endc
