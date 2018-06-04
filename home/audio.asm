INCLUDE "constants.asm"

if DEBUG
SECTION "Audio interface", ROM0[$3CBF]
else
SECTION "Audio interface", ROM0[$3C83]
endc

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
