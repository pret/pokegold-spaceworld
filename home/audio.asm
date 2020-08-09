INCLUDE "constants.asm"

SECTION "home/audio.asm", ROM0

DisableAudio:: ; 3cbf
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

UpdateSound:: ; 3cdb
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

_LoadMusicByte:: ; 3cf7
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld a, [de]
	push af
	ld a, BANK(_UpdateSound)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	pop af
	ret

PlayMusic:: ; 3d07
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

PlayCryHeader:: ; 3d23
	push hl
	push de
	push bc
	push af
	ldh a, [hROMBank]
	push af

	ld a, BANK(CryHeaders)
	ld [MBC3RomBank], a ; Unsafe
	ldh [hROMBank], a
	ld hl, CryHeaders
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

PlaySFX:: ; 3d63
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

WaitPlaySFX:: ; 3d7f
	call WaitSFX
	call PlaySFX
	ret

WaitSFX:: ; 3d86
	push hl
.loop
	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .loop
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .loop
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .loop
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jr nz, .loop
	pop hl
	ret
	
MaxVolume:: ; 3DA5
	ld a, $77
	ld [wVolume], a
	ret

LowVolume:: ; 3DAB
	ld a, $33
	ld [wVolume], a
	ret

VolumeOff:: ; 3DB1
	xor a
	ld [wVolume], a
	ret

UpdateSoundNTimes:: ; 3DB6
.loop
	and a
	ret z
	dec a
	call UpdateSound
	jr .loop

FadeToMapMusic:: ; 3DBE
	push hl
	push de
	push bc
	push af
	call GetMapMusic
	ld a, [wMapMusic]
	cp e
	jr z, .jump
	ld a, $08
	ld [wMusicFade], a
	ld a, e
	ld [wMusicFadeID], a
	ld a, d
	ld [wMusicFadeID+1], a
	ld a, e
	ld [wMapMusic], a
.jump
	pop af
	pop bc
	pop de
	pop hl
	ret

PlayMapMusic:: ; 3DE1
	push hl
	push de
	push bc
	push af
	call GetMapMusic
	ld a, [wMapMusic]
	cp e
	jr z, .jump
	push de
	ld de, $0000
	call PlayMusic
	call DelayFrame
	pop de
	ld a, e
	ld [wMapMusic], a
	call PlayMusic
.jump
	pop af
	pop bc
	pop de
	pop hl
	ret

SpecialMapMusic:: ; 3E05
	ld a, [wPlayerState]
	and a
	jr z, .normal
	cp $02
	jr z, .state2
	ld de, $0009
	scf
	ret

.state2 ; 3E14
	ld de, $0000
	scf
	ret

.normal ; 3E19
	and a
	ret

GetMapMusic:: ; 3E1B
	call SpecialMapMusic
	ret c
	ld a, [wMapPermissions]
	cp $01
	jr z, .jump
	cp $03
	jr z, .jump
	ld de, $0002 
	ret
.jump ; 3E2E
	ld de, $0007
	ret

; 3E32, this is likely not a function.