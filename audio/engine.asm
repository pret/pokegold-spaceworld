INCLUDE "constants.asm"

SECTION "audio/engine.asm", ROMX

_DisableAudio::
	push hl
	push de
	push bc
	push af
	ld hl, rNR50
	xor a
	ld [hli], a
	ld [hli], a
	ld a, $80
	ld [hli], a
	ld hl, rNR10
	ld e, 4
.init_channel
	xor a
	ld [hli], a
	ld [hli], a
	ld a, 8
	ld [hli], a
	xor a
	ld [hli], a
	ld a, $80
	ld [hli], a
	dec e
	jr nz, .init_channel

	ld hl, wMusic
	ld de, wMusicInitEnd - wMusic
.clear
	xor a
	ld [hli], a
	dec de
	ld a, e
	or d
	jr nz, .clear

	ld a, MAX_VOLUME
	ld [wVolume], a

	pop af
	pop bc
	pop de
	pop hl
	ret

_UpdateSound::
; Called once per frame
	xor a
	ld [wCurChannel], a
	ld [wSoundOutput], a
	ld bc, wChannel1

.loop
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .nextchannel

	call UpdateChannel

.nextchannel
	; Next channel
	ld hl, CHANNEL_STRUCT_LENGTH
	add hl, bc
	ld c, l
	ld b, h
	ld a, [wCurChannel]
	inc a
	ld [wCurChannel], a
	cp NUM_CHANNELS
	jr nz, .loop

	call Functione82f0
	ret

UpdateChannel:
	; Get the note's duration
	ld hl, CHANNEL_NOTE_DURATION
	add hl, bc
	ld a, [hl]

	; Check if this is the last frame
	cp 1
	jr z, .noteover
	and a
	jr z, .noteover

	dec [hl]
	jr .continue_sound_update

.noteover
	call DisablePitchWheel
	call ParseMusic

.continue_sound_update
	call Functione80b6
	ret

DisablePitchWheel:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	res SOUND_PITCH_WHEEL, [hl]
	ret

Unreferenced_Functione8081:
	ld a, [wMapMusic]
	bit 0, a
	jr nz, .disable_music

	bit 1, a
	jr nz, .disable_sfx

.fail
	and a
	ret

.disable_music
	call _DisableAudio
	jr .done

.disable_sfx
	call IsChannelSFXOn
	jr c, .fail

	; Clear the registers of the channel
	call GetChannelRegisters
	ld e, rNR20 - rNR10
	xor a

.clear_loop
	ld [hli], a
	dec e
	jr nz, .clear_loop

.done
	scf
	ret

GetChannelRegisters:
	ld a, [wCurChannel]
	ld e, a
	ld d, $00
	ld hl, .registers
	add hl, de
	ld l, [hl]
	ld h, $ff ; HIGH(rNR10, rNR20, rNR30, rNR40)
	ret

.registers
	db LOW(rNR10), LOW(rNR20), LOW(rNR30), LOW(rNR40)

Functione80b6:
	ld hl, CHANNEL_DUTY_CYCLE
	add hl, bc
	ld a, [hl]
	ld [wCurTrackDuty], a

	ld hl, CHANNEL_INTENSITY
	add hl, bc
	ld a, [hl]
	ld [wCurTrackIntensity], a

	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld a, [hli]
	ld [wCurTrackFrequency], a
	ld a, [hl]
	ld [wCurTrackFrequency + 1], a
	ld a, $3F
	ld [wSoundLength], a
	call Functione85d8
	call ReadNoiseSample
	call HaltMusicWhileSFXPlaying
	call IsChannelSFXOn
	jr nc, .end

	call UpdateChannels
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld a, [wSoundOutput]
	or [hl]
	ld [wSoundOutput], a

.end
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	xor a
	ld [hl], a
	ret

UpdateChannels:
	ld hl, .jumptable
	ld a, [wCurChannel]
	maskbits NUM_CHANNELS
	add a
	ld e, a
	ld d, 0
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jumptable
; Music channels
	dw .Channel1
	dw .Channel2
	dw .Channel3
	dw .Channel4
; SFX channels
	dw .Channel5
	dw .Channel6
	dw .Channel7
	dw .Channel8

.Channel1:
	ld a, [wLowHealthAlarm]
	bit 7, a
	ret nz

.Channel5:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_PITCH_SWEEP, [hl]
	jr z, .ch1_no_sweep

	ld a, [wPitchSweep]
	ldh [rNR10], a

.ch1_no_sweep
	bit NOTE_REST, [hl]
	jr nz, .ch1_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch1_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch1_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch1_intensity_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	call nz, .ch1_duty_override
	ret

.ch1_rest
	ld a, %1000	; stop envelope
	ldh [rNR12], a
	ld a, [wCurTrackFrequency + 1]
	or $80		; restart ch1
	ldh [rNR14], a
	ret

.ch1_noise_sampling
	ld hl, wCurTrackDuty
	ld a, [wSoundLength]
	or [hl]
	ldh [rNR11], a
	ld a, [wCurTrackIntensity]
	ldh [rNR12], a
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR14], a
	ret

.ch1_duty_override
	ld a, [wCurTrackDuty]
	ldh a, [rNR11]
	and $3f
	or d
	ldh [rNR11], a
	ret

.ch1_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR12], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR14], a
	ret

.ch1_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR13], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR14], a
	ret

.Channel2:
.Channel6:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch2_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch2_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch2_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch2_intensity_override
	bit NOTE_DUTY_OVERRIDE, [hl]
	call nz, .ch2_duty_override
	ret

.ch2_rest
	ld a, $08
	ldh [rNR22], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_noise_sampling
	ld hl, wCurTrackDuty
	ld a, [wSoundLength]
	or [hl]
	ldh [rNR21], a
	ld a, [wCurTrackIntensity]
	ldh [rNR22], a
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_duty_override
	ld a, [wCurTrackDuty]
	ld d, a
	ldh a, [rNR21]
	and $3f
	or d
	ldh [rNR21], a
	ret

.ch2_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR22], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR24], a
	ret

.ch2_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR23], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR24], a
	ret

.Channel3:
.Channel7:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch3_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch3_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch3_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch3_intensity_override
	ret

.ch3_rest
	xor a
	ldh [rNR30], a
	ret

.ch3_noise_sampling
	ld a, [wSoundLength]
	ldh [rNR31], a
	xor a
	ldh [rNR30], a
	call .load_wave_pattern
	ld a, $80
	ldh [rNR30], a
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR34], a
	ret

.ch3_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	ldh [rNR34], a
	ret

.ch3_intensity_override
	xor a
	ldh [rNR30], a
	call .load_wave_pattern
	ld a, $80
	ldh [rNR30], a
	ld a, [wCurTrackFrequency]
	ldh [rNR33], a
	ld a, [wCurTrackFrequency + 1]
	or $80
	ldh [rNR34], a
	ret

.load_wave_pattern
	push hl
	ld a, [wCurTrackIntensity]
; only patterns 0 - 9 are valid
	and $f
	ld l, a
	ld h, 0
; hl << 4 (hl * $10), because each pattern is $f bytes
rept 4
	add hl, hl
endr
	ld de, WaveSamples
	add hl, de
	ld de, rWave_0
	push bc
	ld b, $10
.load_pattern
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .load_pattern

	pop bc
	pop hl
	ld a, [wCurTrackIntensity]
	and $f0
	sla a
	ldh [rNR32], a
	ret

.Channel4:
.Channel8:
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	bit NOTE_REST, [hl]
	jr nz, .ch4_rest
	bit NOTE_NOISE_SAMPLING, [hl]
	jr nz, .ch4_noise_sampling
	bit NOTE_FREQ_OVERRIDE, [hl]
	call nz, .ch4_freq_override
	bit NOTE_INTENSITY_OVERRIDE, [hl]
	call nz, .ch4_intensity_override
	ret

.ch4_rest
	ld a, $08
	ldh [rNR42], a
	ld a, $80
	ldh [rNR44], a
	ret

.ch4_noise_sampling
	ld a, [wSoundLength]
	ldh [rNR41], a
	ld a, [wCurTrackIntensity]
	ldh [rNR42], a
	ld a, [wCurTrackFrequency]
	ldh [rNR43], a
	ld a, $80
	ldh [rNR44], a
	ret

.ch4_freq_override
	ld a, [wCurTrackFrequency]
	ldh [rNR43], a
	ret

.ch4_intensity_override
	ld a, [wCurTrackIntensity]
	ldh [rNR42], a
	ld a, $80
	ldh [rNR44], a
	ret

IsChannelSFXOn:
	; If it's not a valid channel, return
	ld a, [wCurChannel]
	cp NUM_MUSIC_CHANS
	jr nc, .off

	; Check if the corresponding SFX channel is on
	ld hl, CHANNEL_STRUCT_LENGTH * NUM_MUSIC_CHANS + CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .off

	and a
	ret

.off
	scf
	ret

IsAnySFXOn:
	ld hl, wChannel5Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel6Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel7Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on
	ld hl, wChannel8Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr nz, .on

	and a
	ret

.on
	scf
	ret

Functione82f0:
	call IncrementTempo
	call PlayDanger
	call FadeMusic
	call DoSweepingFade
	ld a, [wVolume]
	ldh [rNR50], a
	ld a, [wSoundOutput]
	ldh [rNR51], a
	ret

PlayDanger:
	ld a, [wLowHealthAlarm]
	bit DANGER_ON_F, a
	ret z

	; Don't do anything if SFX is being played
	and $ff ^ (1 << DANGER_ON_F)
	ld d, a
	call IsAnySFXOn
	jr c, .increment

	; Play the high tone
	and a
	jr z, .begin

	; Play the low tone
	cp 16
	jr z, .halfway

	jr .increment

.halfway
	ld hl, DangerSoundLow
	jr .applychannel

.begin
	ld hl, DangerSoundHigh

.applychannel
	xor a
	ldh [rNR10], a
	ld a, [hli]
	ldh [rNR11], a
	ld a, [hli]
	ldh [rNR12], a
	ld a, [hli]
	ldh [rNR13], a
	ld a, [hli]
	ldh [rNR14], a

.increment
	ld a, d
	inc a
	cp 30 ; Ending frame
	jr c, .noreset
	xor a
.noreset
	; Make sure the danger sound is kept on
	or 1 << DANGER_ON_F
	ld [wLowHealthAlarm], a

	; Make sure channel 1 is on
	ld a, [wSoundOutput]
	or $11
	ld [wSoundOutput], a
	ret

DangerSoundHigh:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $50 ; frequency: $750
	db $87 ; restart sound

DangerSoundLow:
	db $80 ; duty 50%
	db $e2 ; volume 14, envelope decrease sweep 2
	db $ee ; frequency: $6ee
	db $86 ; restart sound

IncrementTempo:
	call IsAnyChannelOn
	ret c

	ld a, [wIncrementTempo]
	ld e, a
	ld a, [wIncrementTempo + 1]
	ld d, a
	or e
	ret z

	ld hl, wChannel1Tempo
	call .addtempo
	ld hl, wChannel2Tempo
	call .addtempo
	ld hl, wChannel3Tempo
	call .addtempo
	ld hl, wChannel4Tempo
	call .addtempo
	xor a
	ld [wIncrementTempo], a
	ld [wIncrementTempo + 1], a
	ret

.addtempo
	; (int16)[hl] += de
	push de
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ret

IsAnyChannelOn:
; Check if any music channel is on and isn't on the last frame

	ld hl, wChannel1Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel2

	ld hl, wChannel1NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel2
	ld hl, wChannel2Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel3

	ld hl, wChannel2NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel3
	ld hl, wChannel3Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .check_channel4

	ld hl, wChannel3NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.check_channel4
	ld hl, wChannel4Flags1
	bit SOUND_CHANNEL_ON, [hl]
	jr z, .off

	ld hl, wChannel4NoteDuration
	ld a, [hl]
	cp 1
	jr nz, .on

.off
	and a
	ret

.on
	scf
	ret

FadeMusic:
; Fade music if applicable
; usage:
;	write to wMusicFade
;	song fades out at the given rate
;	load song id in wMusicFadeID
;	fade new song in
; notes:
;	max # frames per volume level is $7f

	; Exit early if not fading
	ld a, [wMusicFade]
	and a
	ret z

	; If it doesn't have a count, assign it
	ld a, [wMusicFadeCount]
	and a
	jr z, .update

	; Count down
	dec a
	ld [wMusicFadeCount], a
	ret

.update
	ld a, [wMusicFade]
	ld d, a

	; Get new count
	and $7f
	ld [wMusicFadeCount], a

	; Get SO1 volume
	ld a, [wVolume]
	and VOLUME_SO1_LEVEL

	; Which way are we fading?
	bit MUSIC_FADE_IN_F, d
	jr nz, .fadein

	; Decrement volume
	and a
	jr z, .novolume
	dec a
	jr .updatevolume

.novolume
	; Fade in new song
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID + 1]
	ld d, a
	push bc
	call _PlayMusic
	pop bc
	ld hl, wMusicFade
	set 7, [hl]
	ret

.fadein
	; Increment volume
	cp MAX_VOLUME & $f
	jr nc, .maxvolume
	inc a
	jr .updatevolume

.maxvolume
	; Clear wMusicFade
	xor a
	ld [wMusicFade], a
	ret

.updatevolume
	; Set the current volume for both speakers
	ld d, a
	swap a
	or d
	ld [wVolume], a
	ret

DoSweepingFade::
; performs a sweeping fade effect starting from the
; left channel, then the right, then repeats

	ld a, [wSweepingFadeIndex]
	and a
	ret z

; first nybble of wSweepingFadeIndex is the subroutine index
; second is the fade length

	swap a
	and 7
	ld e, a
	ld d, 0
	ld hl, .jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

.jumptable
	dw .DoFade1
	dw .DoFade2
	dw .DoFade3
	dw .DoFade4
	dw .DoFade5
	dw .DoFade6
	dw .DoFade1
	dw .DoFade1

.DoFade1:
	ld a, 1
	call .SetIndex
	xor a
	ld [wSweepingFadeCounter], a
	ld [wVolume], a

.DoFade2:
	call .LeftChannel
	call .DecrementCounter
	ret nc
	call .IncreaseVolume
	ret nc
	ld a, 2
	call .SetIndex

.DoFade3:
	call .LeftChannel
	call .DecrementCounter
	ret nc
	call .DecreaseVolume
	ret nc
	ld a, 3
	call .SetIndex

.DoFade4:
	call .RightChannel
	call .DecrementCounter
	ret nc
	call .IncreaseVolume
	ret nc
	ld a, 4
	call .SetIndex

.DoFade5:
	call .RightChannel
	call .DecrementCounter
	ret nc
	call .DecreaseVolume
	ret nc
	ld a, 0
	call .SetIndex
	ret

.DoFade6:
	xor a
	ld [wSweepingFadeIndex], a
	ld a, MAX_VOLUME
	ld [wVolume], a
	ret

.SetIndex:
	swap a
	ld d, a
	ld a, [wSweepingFadeIndex]
	and $f
	or d
	ld [wSweepingFadeIndex], a
	ret

.DecrementCounter:
	ld a, [wSweepingFadeCounter]
	and a
	jr z, .reset_counter
	dec a
	ld [wSweepingFadeCounter], a
	and a
	ret
 .reset_counter
	ld a, [wSweepingFadeIndex]
	and $f
	ld [wSweepingFadeCounter], a
	scf
	ret

.IncreaseVolume:
	ld a, [wVolume]
	and 7
	cp 7
	jr nc, .max_volume
	inc a
	ld d, a
	swap a
	or d
	ld [wVolume], a
	and a
	ret
.max_volume
	scf
	ret

.DecreaseVolume:
	ld a, [wVolume]
	and $f
	jr z, .min_volume
	dec a
	ld d, a
	swap a
	or d
	ld [wVolume], a
	and a
	ret
.min_volume
	scf
	ret

.LeftChannel:
	call IsAnySFXOn
	ret c
	ld a, [wSoundOutput]
	and $f0
	ld [wSoundOutput], a
	ret

.RightChannel:
	call IsAnySFXOn
	ret c
	ld a, [wSoundOutput]
	and $0f
	ld [wSoundOutput], a
	ret

LoadNote:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	bit SOUND_PITCH_WHEEL, [hl]
	call nz, .get_note
	bit SOUND_VIBRATO, [hl]
	call nz, .vibrato
	bit SOUND_UNKN_0E, [hl]
	call nz, .flag_0e
	bit SOUND_UNKN_0D, [hl]
	call nz, .flag_0d
	bit SOUND_UNKN_0B, [hl]
	call nz, .flag_0b
	ret

.get_note
	push hl
	ld hl, CHANNEL_NOTE_DURATION
	add hl, bc
	ld a, [hl]
	ld hl, wCurNoteDuration
	sub [hl]
	jr nc, .ok
	ld a, 1
.ok
	ld [hl], a
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	sub [hl]
	jr nc, .greater_than

	ld hl, CHANNEL_FLAGS3
	add hl, bc
	set SOUND_PITCH_WHEEL_DIR, [hl]
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld a, [hl]
	sub e
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	ld a, [hl]
	sub d
	ld d, a
	jr .resume

.greater_than
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res SOUND_PITCH_WHEEL_DIR, [hl]
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld a, e
	sub [hl]
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	sub [hl]
	ld d, a

.resume
	push bc
	ld hl, wCurNoteDuration
	ld b, 0

.loop
	inc b
	ld a, e
	sub [hl]
	ld e, a
	jr nc, .loop

	ld a, d
	and a
	jr z, .quit

	dec d
	jr .loop

.quit
	ld a, e
	add [hl]
	ld d, b
	pop bc
	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT
	add hl, bc
	ld [hl], d
	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT_FRACTION
	add hl, bc
	ld [hl], a
	ld hl, CHANNEL_FIELD25
	add hl, bc
	xor a
	ld [hl], a
	pop hl
	ret

.vibrato
	push hl
	ld hl, CHANNEL_VIBRATO_DELAY
	add hl, bc
	ld a, [hl]
	ld hl, CHANNEL_VIBRATO_DELAY_COUNT
	add hl, bc
	ld [hl], a
	pop hl
	ret

.flag_0e
	push hl
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res NOTE_INTENSITY_OVERRIDE, [hl]
	pop hl
	ret

.flag_0d
	push hl
	ld hl, CHANNEL_FIELD2A + 1
	add hl, bc
	xor a
	ld [hl], a
	pop hl
	ret

.flag_0b
	push hl
	ld hl, CHANNEL_FIELD2C
	add hl, bc
	ld a, [hl]
	ld hl, CHANNEL_FIELD25 + 1
	add hl, bc
	ld [hl], a
	pop hl
	ret

Functione85d8::
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	bit SOUND_DUTY, [hl]
	call nz, HandleDuty
	bit SOUND_UNKN_0E, [hl]
	call nz, Handle_0e
	bit SOUND_CRY_PITCH, [hl]
	call nz, Handle_crypitch
	bit SOUND_PITCH_WHEEL, [hl]
	call nz, ApplyPitchSlide
	bit SOUND_VIBRATO, [hl]
	call nz, HandleVibrato
	bit SOUND_UNKN_0D, [hl]
	call nz, Handle_0d
	bit SOUND_UNKN_0B, [hl]
	call nz, Handle_0b
	bit SOUND_UNKN_0F, [hl]
	call nz, HandleNoise
	ret

HandleDuty:
	push hl
	ld hl, CHANNEL_SFX_DUTY_LOOP
	add hl, bc
	ld a, [hl]
	rlca
	rlca
	ld [hl], a
	and $c0
	ld [wCurTrackDuty], a
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set 0, [hl]
	pop hl
	ret

ApplyPitchSlide:
	push hl
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	bit SOUND_PITCH_WHEEL_DIR, [hl]
	jr z, .decreasing

	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT
	add hl, bc
	ld l, [hl]
	ld h, 0
	add hl, de
	ld d, h
	ld e, l
	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT_FRACTION
	add hl, bc
	ld a, [hl]
	ld hl, CHANNEL_FIELD25
	add hl, bc
	add [hl]
	ld [hl], a
	ld a, 0
	adc e
	ld e, a
	ld a, 0
	adc d
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	ld a, [hl]
	cp d
	jp c, .finished_pitch_slide
	jr nz, .continue_pitch_slide
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld a, [hl]
	cp e
	jp c, .finished_pitch_slide
	jr .continue_pitch_slide

.decreasing
	ld a, e
	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT
	add hl, bc
	ld e, [hl]
	sub e
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_AMOUNT_FRACTION
	add hl, bc
	ld a, [hl]
	add a
	ld [hl], a
	ld a, e
	sbc 0
	ld e, a
	ld a, d
	sbc 0
	ld d, a
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	ld a, d
	cp [hl]
	jr c, .finished_pitch_slide
	jr nz, .continue_pitch_slide
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld a, e
	cp [hl]
	jr nc, .continue_pitch_slide

.finished_pitch_slide
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	res 1, [hl]
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	res 1, [hl]
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]

.continue_pitch_slide
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set 1, [hl]
	pop hl
	ret


HandleVibrato:
	push hl
	ld hl, CHANNEL_VIBRATO_DELAY_COUNT
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .subexit

	ld hl, CHANNEL_VIBRATO_RATE
	add hl, bc
	ld a, [hl]
	and $0f
	jr z, .toggle

.subexit
	dec [hl]
	jr .quit

.toggle
	ld a, [hl]
	swap [hl]
	or [hl]
	ld [hl], a
	ld hl, CHANNEL_VIBRATO_EXTENT
	add hl, bc
	ld a, [hl]
	and a
	jr z, .quit

	ld hl, CHANNEL_FLAGS3
	add hl, bc
	bit SOUND_VIBRATO_DIR, [hl]
	jr z, .down

	res SOUND_VIBRATO_DIR, [hl]
	and $0f
	ld d, a
	ld a, [wCurTrackFrequency]
	sub d
	jr nc, .no_carry

	xor a
	jr .no_carry

.down
	set SOUND_VIBRATO_DIR, [hl]
	and $f0
	swap a
	ld d, a
	ld a, [wCurTrackFrequency]
	add d
	jr nc, .no_carry

	ld a, $ff

.no_carry
	ld [wCurTrackFrequency], a
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_FREQ_OVERRIDE, [hl]

.quit
	pop hl
	ret


Handle_0b:
	push hl
	ld hl, CHANNEL_FIELD25 + 1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .set_rest

	dec [hl]
	jr .done

.set_rest
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_REST, [hl]

.done
	pop hl
	ret


Handle_crypitch:
	push hl
	ld hl, CHANNEL_CRY_PITCH
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, wCurTrackFrequency
	push hl
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	pop hl
	ld [hl], e
	inc hl
	ld [hl], d
	pop hl
	ret


Handle_0e:
	push hl
	ld hl, CHANNEL_FLAGS3
	add hl, bc
	bit SOUND_UNKN_12, [hl]
	jr nz, .skip

	set SOUND_UNKN_12, [hl]
	jr .done

.skip
	res SOUND_UNKN_12, [hl]
	ld hl, CHANNEL_PITCH
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done

	ld hl, CHANNEL_FIELD29
	add hl, bc
	add [hl]
	ld e, a
	ld hl, CHANNEL_OCTAVE
	add hl, bc
	ld d, [hl]
	call GetFrequency
	ld hl, wCurTrackFrequency
	ld [hl], e
	inc hl
	ld [hl], d

.done
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set SOUND_PITCH_WHEEL_DIR, [hl]
	pop hl
	ret


Handle_0d:
	push hl
	ld hl, CHANNEL_FIELD2A
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN3
	jr nz, .not_ch3

	ld hl, WaveOverrides
	call GetFromTable
	jr c, .rest_done

	ld d, a
	ld a, [wCurTrackIntensity]
	and $c0
	or d
	jr .intensity_done

.not_ch3
	ld hl, IntensityOverrides
	call GetFromTable
	jr nc, .intensity_done

.rest_done
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_REST, [hl]
	pop hl
	ret


.intensity_done
	ld [wCurTrackIntensity], a
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_INTENSITY_OVERRIDE, [hl]
	pop hl
	ret


GetFromTable:
	add hl, de
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_FIELD2A + 1
	add hl, bc
	push hl
	ld l, [hl]
	ld h, 0
	add hl, de
	ld a, [hl]
	pop hl
	cp $ff
	jr z, .carry

	cp $fe
	jr nz, .done_nocarry

	xor a
	ld [hl], a
	ld a, [de]

.done_nocarry
	inc [hl]
	and a
	ret
.carry
	scf
	ret


HandleNoise:
	ld hl, CHANNEL_FIELD2E
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip

	dec [hl]
	ld hl, CHANNEL_FIELD30
	add hl, bc
	ld a, [hl]
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a
	ret

.skip
	ld hl, CHANNEL_FIELD2F
	add hl, bc
	ld a, [hl]
	and a
	jr z, .skip2

	dec [hl]
	ld hl, CHANNEL_FIELD30
	add hl, bc
	ld a, [hl]
	swap a
	or [hl]
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a
	ret

.skip2
	ld hl, CHANNEL_FIELD30
	add hl, bc
	ld a, [hl]
	swap a
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	res SOUND_UNKN_0F, [hl]
	ret


ReadNoiseSample::
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_NOISE, [hl]
	ret z

	ld a, [wNoiseSampleDelay]
	and a
	jr z, .get_new_sample

	dec a
	ld [wNoiseSampleDelay], a
	ret

.get_new_sample
	ld hl, wNoiseSampleAddress
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld a, [de]
	inc de
	cp $ff
	jr z, .done

	and $0f
	inc a
	ld [wNoiseSampleDelay], a
	ld a, [de]
	inc de
	ld [wCurTrackIntensity], a
	ld a, [de]
	inc de
	ld [wCurTrackFrequency], a
	xor a
	ld [wCurTrackFrequency + 1], a
	ld hl, wNoiseSampleAddress
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	ret

.done
	ret


HaltMusicWhileSFXPlaying::
	ld a, [wSFXPriority]
	and a
	ret z

	ld a, [wCurChannel]
	cp CHAN5
	ret nc

	call IsAnySFXOn
	ret nc

	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_REST, [hl]
	ret


ParseMusic::
	call GetMusicByte
	cp sound_ret_cmd
	jr z, .end_music

	cp FIRST_MUSIC_CMD
	jr nc, .parse_commands

	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_SFX, [hl]
	jr nz, .parse_sfx_or_rest

	bit SOUND_REST, [hl]
	jr nz, .parse_sfx_or_rest

	bit SOUND_NOISE, [hl]
	jr nz, .parse_noise

	call _ParseMusic
	ret

.parse_sfx_or_rest
	call ParseSFXOrRest
	ret

.parse_noise
	call GetNoiseSample
	ret

.end_music
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_SUBROUTINE, [hl]
	jr nz, .parse_commands

	call IsChannelSFXOn
	jr nc, .ok

	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_REST, [hl]
	call nz, RestoreVolume
	ld a, [wCurChannel]
	cp CHAN5
	jr nz, .ok

	xor a
	ldh [rNR10], a

.ok
	call StopChannel
	ret

.parse_commands
	call ParseMusicCommand
	jr ParseMusic

RestoreVolume:
	ld a, [wCurChannel]
	cp CHAN5
	ret nz

	xor a
	ld hl, wChannel6CryPitch
	ld [hli], a
	ld [hl], a
	ld hl, wChannel8CryPitch
	ld [hli], a
	ld [hl], a
	ld a, [wLastVolume]
	ld [wVolume], a
	xor a
	ld [wLastVolume], a
	ld [wSFXPriority], a
	ret


_ParseMusic:
	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration
	ld a, [wCurMusicByte]
	swap a
	and $f
	jr z, .rest

	ld hl, CHANNEL_PITCH
	add hl, bc
	ld [hl], a
	ld e, a
	ld hl, CHANNEL_OCTAVE
	add hl, bc
	ld d, [hl]
	call GetFrequency
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	call LoadNote
	ret


.rest
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_REST, [hl]
	ret


ParseSFXOrRest:
; turn noise sampling on
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set NOTE_NOISE_SAMPLING, [hl]
	ld a, [wCurMusicByte]
	call SetNoteDuration

; update volume envelope from next param
	call GetMusicByte
	ld hl, CHANNEL_INTENSITY
	add hl, bc
	ld [hl], a

; update lo frequence from next param
	call GetMusicByte
	ld hl, CHANNEL_FREQUENCY
	add hl, bc
	ld [hl], a

; on noise channel?
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	ret z

; update hi frequency from next param
	call GetMusicByte
	ld hl, CHANNEL_FREQUENCY + 1
	add hl, bc
	ld [hl], a
	ret


GetNoiseSample:
	ld a, [wCurChannel]
	cp CHAN4
	ret nz

	ld a, [wCurMusicByte]
	and $f
	call SetNoteDuration

	ld a, [wNoiseSampleSet]
	ld e, a
	ld d, 0
	ld hl, Drumkits
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wCurMusicByte]
	swap a
	and $f
	ret z

	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wNoiseSampleAddress], a
	ld a, [hl]
	ld [wNoiseSampleAddress + 1], a
	xor a
	ld [wNoiseSampleDelay], a
	ret


ParseMusicCommand:
	ld a, [wCurMusicByte]
	sub FIRST_MUSIC_CMD
	ld e, a
	ld d, 0
	ld hl, MusicCommands
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

MusicCommands:
	dw Music_Octave8
	dw Music_Octave7
	dw Music_Octave6
	dw Music_Octave5
	dw Music_Octave4
	dw Music_Octave3
	dw Music_Octave2
	dw Music_Octave1
	dw Music_NoteType
	dw Music_Transpose
	dw Music_Tempo
	dw Music_DutyCycle
	dw Music_VolumeEnvelope
	dw Music_PitchSweep
	dw Music_DutyCyclePattern
	dw Music_ToggleSFX
	dw Music_PitchSlide
	dw Music_Vibrato
	dw MusicE2
	dw Music_ToggleNoise
	dw Music_ForceStereoPanning
	dw Music_Volume
	dw Music_PitchOffset
	dw MusicE7
	dw MusicE8
	dw Music_TempoRelative
	dw Music_RestartChannel
	dw Music_NewSong
	dw Music_SFXPriorityOn
	dw Music_SFXPriorityOff
	dw MusicEE
	dw Music_StereoPanning
	dw MusicF0
	dw MusicF1
	dw MusicF2
	dw MusicF3
	dw MusicF4
	dw MusicF5
	dw MusicF6
	dw MusicF7
	dw MusicF8
	dw MusicF9
	dw Music_SetCondition
	dw Music_JumpIf
	dw Music_Jump
	dw Music_Loop
	dw Music_Call
	dw Music_Ret

MusicF0:
MusicF1:
MusicF2:
MusicF3:
MusicF4:
MusicF5:
MusicF6:
MusicF7:
MusicF8:
	ret

Music_Ret:
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	res SOUND_SUBROUTINE, [hl]
	ld hl, CHANNEL_LAST_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Music_Call:
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	push de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_LAST_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_SUBROUTINE, [hl]
	ret

Music_Jump:
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

Music_Loop:
	call GetMusicByte
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_LOOPING, [hl]
	jr nz, .checkloop

	and a
	jr z, .loop

	dec a
	set SOUND_LOOPING, [hl]
	ld hl, CHANNEL_LOOP_COUNT
	add hl, bc
	ld [hl], a

.checkloop
	ld hl, CHANNEL_LOOP_COUNT
	add hl, bc
	ld a, [hl]
	and a
	jr z, .endloop
	dec [hl]

.loop
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

.endloop
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	res SOUND_LOOPING, [hl]
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

Music_SetCondition:
	call GetMusicByte
	ld hl, CHANNEL_CONDITION
	add hl, bc
	ld [hl], a
	ret

Music_JumpIf:
	call GetMusicByte
	ld hl, CHANNEL_CONDITION
	add hl, bc
	cp [hl]
	jr z, .jump
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

MusicEE:
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	ld e, a
	ld d, 0
	ld hl, wChannel1JumpCondition
	add hl, de
	ld a, [hl]
	and a
	jr nz, .jump

	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	inc de
	inc de
	ld [hl], d
	dec hl
	ld [hl], e
	ret

.jump
	ld [hl], 0
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	ret

MusicF9:
	ld a, 1
	ld [wc1b3], a
	ret

MusicE2:
	call GetMusicByte
	ld hl, CHANNEL_FIELD2C
	add hl, bc
	ld [hl], a
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_UNKN_0B, [hl]
	ret

Music_Vibrato:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_VIBRATO, [hl]
	res SOUND_VIBRATO, [hl]
	call GetMusicByte
	ld hl, CHANNEL_VIBRATO_DELAY
	add hl, bc
	ld [hl], a
	call GetMusicByte
	ld hl, CHANNEL_VIBRATO_EXTENT
	add hl, bc
	ld d, a
	and $f0
	swap a
	srl a
	ld e, a
	adc 0
	swap a
	or e
	ld [hl], a
	ld hl, CHANNEL_VIBRATO_RATE
	add hl, bc
	ld a, d
	and $0f
	ld d, a
	swap a
	or d
	ld [hl], a
	ret

Music_PitchSlide:
	call GetMusicByte
	ld [wCurNoteDuration], a
	call GetMusicByte
	ld d, a
	and $f
	ld e, a
	ld a, d
	swap a
	and $f
	ld d, a
	call GetFrequency
	ld hl, CHANNEL_PITCH_WHEEL_TARGET
	add hl, bc
	ld [hl], e
	ld hl, CHANNEL_PITCH_WHEEL_TARGET + 1
	add hl, bc
	ld [hl], d
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_PITCH_WHEEL, [hl]
	ret

Music_PitchOffset:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_CRY_PITCH, [hl]
	ld hl, CHANNEL_CRY_PITCH + 1
	add hl, bc
	call GetMusicByte
	ld [hld], a
	call GetMusicByte
	ld [hl], a
	ret

MusicE7:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_UNKN_0E, [hl]
	call GetMusicByte
	ld hl, CHANNEL_FIELD29
	add hl, bc
	ld [hl], a
	ret

Music_DutyCyclePattern:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_DUTY, [hl]
	call GetMusicByte
	rrca
	rrca
	ld hl, CHANNEL_SFX_DUTY_LOOP
	add hl, bc
	ld [hl], a
	and $c0
	ld hl, CHANNEL_DUTY_CYCLE
	add hl, bc
	ld [hl], a
	ret

MusicE8:
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_UNKN_0D, [hl]
	call GetMusicByte
	ld hl, CHANNEL_FIELD2A
	add hl, bc
	ld [hl], a
	ret

Music_ToggleSFX:
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_SFX, [hl]
	jr z, .on
	res SOUND_SFX, [hl]
	ret
.on
	set SOUND_SFX, [hl]
	ret

Music_ToggleNoise:
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	bit SOUND_NOISE, [hl]
	jr z, .on
	res SOUND_NOISE, [hl]
	ret
.on
	set SOUND_NOISE, [hl]
	call GetMusicByte
	ld [wNoiseSampleSet], a
	ret

Music_NoteType:
	call GetMusicByte
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld [hl], a
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp CHAN4
	ret z
	call Music_VolumeEnvelope
	ret

Music_PitchSweep:
	call GetMusicByte
	ld [wPitchSweep], a
	ld hl, CHANNEL_NOTE_FLAGS
	add hl, bc
	set 3, [hl]
	ret

Music_DutyCycle:
	call GetMusicByte
	rrca
	rrca
	and $c0
	ld hl, CHANNEL_DUTY_CYCLE
	add hl, bc
	ld [hl], a
	ret


Music_VolumeEnvelope:
	call GetMusicByte
	ld hl, CHANNEL_INTENSITY
	add hl, bc
	ld [hl], a
	ret

Music_Tempo:
	call GetMusicByte
	ld d, a
	call GetMusicByte
	ld e, a
	call SetGlobalTempo
	ret

Music_Octave8:
Music_Octave7:
Music_Octave6:
Music_Octave5:
Music_Octave4:
Music_Octave3:
Music_Octave2:
Music_Octave1:
	ld hl, CHANNEL_OCTAVE
	add hl, bc
	ld a, [wCurMusicByte]
	and 7
	ld [hl], a
	ret

Music_Transpose:
	call GetMusicByte
	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld [hl], a
	ret

Music_StereoPanning:
	ld a, [wOptions]
	bit STEREO_F, a
	ret z
	; fallthrough

Music_ForceStereoPanning:
	call SetLRTracks
	call GetMusicByte
	ld hl, CHANNEL_TRACKS
	add hl, bc
	and [hl]
	ld [hl], a
	ret

Music_Volume:
	call GetMusicByte
	ld a, [wMusicFade]
	and a
	ret nz
	ld a, [wCurMusicByte]
	ld [wVolume], a
	ret

Music_TempoRelative:
	call GetMusicByte
	ld e, a
; check sign
	cp $80
	jr nc, .negative
; positive
	ld d, 0
	jr .ok
.negative
	ld d, -1
.ok
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	call SetGlobalTempo
	ret

Music_SFXPriorityOn:
	ld a, 1
	ld [wSFXPriority], a
	ret

Music_SFXPriorityOff:
	xor a
	ld [wSFXPriority], a
	ret

Music_RestartChannel:
	ld hl, CHANNEL_MUSIC_ID
	add hl, bc
	ld a, [hli]
	ld [wMusicID], a
	ld a, [hl]
	ld [wMusicID + 1], a
	ld hl, CHANNEL_MUSIC_BANK
	add hl, bc
	ld a, [hl]
	ld [wMusicBank], a
	call GetMusicByte
	ld l, a
	call GetMusicByte
	ld h, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	push bc
	call LoadChannel
	call StartChannel
	pop bc
	ret

Music_NewSong:
	call GetMusicByte
	ld e, a
	call GetMusicByte
	ld d, a
	push bc
	call _PlayMusic
	pop bc
	ret

GetMusicByte:
	push hl
	push de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_MUSIC_BANK
	add hl, bc
	ld a, [hl]
	call _LoadMusicByte
	ld [wCurMusicByte], a
	inc de
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	pop de
	pop hl
	ret


GetFrequency:
; generate frequency
; input:
; 	d: octave
;	e: pitch
; output:
; 	de: frequency

; get octave
	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	add d

	push af

	ld hl, CHANNEL_PITCH_OFFSET
	add hl, bc
	ld a, [hl]
	and $f
	ld l, a
	ld d, 0
	ld h, d
	add hl, de
	add hl, hl

	ld de, FrequencyTable
	add hl, de
	ld e, [hl]
	inc hl
	ld d, [hl]

	pop af

.loop
; [7 - octave] loops
	cp 7
	jr nc, .ok

	sra d
	rr e
	inc a
	jr .loop

.ok
	ld a, d
	and $07
	ld d, a
	ret


SetNoteDuration:
; input: a = note duration in 16ths

	inc a
	ld e, a
	ld d, 0
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld a, [hl]
	ld l, 0
	call .Multiply
	ld a, l
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld hl, CHANNEL_FIELD16
	add hl, bc
	ld l, [hl]
	call .Multiply
	ld e, l
	ld d, h
	ld hl, CHANNEL_FIELD16
	add hl, bc
	ld [hl], e
	ld hl, CHANNEL_NOTE_DURATION
	add hl, bc
	ld [hl], d
	ret


.Multiply:
; multiplies a and de
; adds the result to l
; stores the result in hl
	ld h, 0

.loop
; halve a
	srl a
	jr nc, .skip

; add the remainder to the result
	add hl, de

.skip
; de * 2
	sla e
	rl d

; done multiplying?
	and a
	jr nz, .loop
	ret

SetGlobalTempo:
	push bc
	ld a, [wCurChannel]
	cp CHAN5
	jr nc, .sfxchannels
	ld bc, wChannel1
	call Tempo
	ld bc, wChannel2
	call Tempo
	ld bc, wChannel3
	call Tempo
	ld bc, wChannel4
	call Tempo
	jr .end

.sfxchannels
	ld bc, wChannel5
	call Tempo
	ld bc, wChannel6
	call Tempo
	ld bc, wChannel7
	call Tempo
	ld bc, wChannel8
	call Tempo

.end
	pop bc
	ret

Tempo:
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld [hl], e
	inc hl
	ld [hl], d
	xor a
	ld hl, CHANNEL_FIELD16
	add hl, bc
	ld [hl], a
	ret


StartChannel:
	call SetLRTracks
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_CHANNEL_ON, [hl]
	ret


StopChannel:
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	res SOUND_CHANNEL_ON, [hl]
	ld hl, CHANNEL_MUSIC_ID
	add hl, bc
	xor a
	ld [hli], a
	ld [hli], a
	ld [hli], a
	ret


SetLRTracks:
	push de
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	ld e, a
	ld d, 0
	ld hl, LRTracks
	add hl, de
	ld a, [hl]
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a
	pop de
	ret


_PlayMusic::
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, SongHeaderPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wMusicBank], a
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadMusicByte
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a
.loop
	push af
	call LoadChannel
	call StartChannel
	pop af
	dec a
	jr nz, .loop
	xor a
	ld [wc1b3], a
	ld [wChannel1JumpCondition], a
	ld [wChannel2JumpCondition], a
	ld [wChannel3JumpCondition], a
	ld [wChannel4JumpCondition], a
	ret


_PlayCryHeader::
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, Cries
	add hl, de
	add hl, de
	add hl, de

	ld a, [hli]
	ld [wMusicBank], a

	ld e, [hl]
	inc hl
	ld d, [hl]

	call LoadMusicByte
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a

.loop
	push af
	call LoadChannel

	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_REST, [hl]

	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_CRY_PITCH, [hl]

	ld hl, CHANNEL_CRY_PITCH
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a

	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp 3
	jr nc, .start

; no tempo for ch4
	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength + 1]
	ld [hl], a

.start
	call StartChannel
	ld a, [wStereoPanningMask]
	and a
	jr z, .next

	ld a, [wOptions]
	bit STEREO_F, a
	jr z, .next

	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld a, [hl]
	ld hl, wCryTracks
	and [hl]
	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a

.next
	pop af
	dec a
	jr nz, .loop

	ld a, [wLastVolume]
	and a
	jr nz, .end

	ld a, [wVolume]
	ld [wLastVolume], a
	ld a, MAX_VOLUME
	ld [wVolume], a

.end
; stop playing music
	ld a, 1
	ld [wSFXPriority], a
	ret


_PlaySFX::
	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, SFX
; three byte pointers
	add hl, de
	add hl, de
	add hl, de
; get bank
	ld a, [hli]
	ld [wMusicBank], a
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadMusicByte
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a

.start_channels
	push af
	call LoadChannel
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_SFX, [hl]
	call StartChannel
	pop af
	dec a
	jr nz, .start_channels
	ret

PlayStereoSFX::
	ld a, [wOptions]
	bit STEREO_F, a
	jr z, _PlaySFX

	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d

	ld hl, SFX
	add hl, de
	add hl, de
	add hl, de

	ld a, [hli]
	ld [wMusicBank], a
	ld e, [hl]
	inc hl
	ld d, [hl]

	call LoadMusicByte
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a

.loop
	push af
	call LoadChannel
	ld hl, CHANNEL_FLAGS1

	add hl, bc
	set SOUND_SFX, [hl]
	push de

	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	ld e, a
	ld d, 0
	ld hl, LRTracks
	add hl, de
	ld a, [hl]
	ld hl, wStereoPanningMask
	and [hl]

	ld hl, CHANNEL_TRACKS
	add hl, bc
	ld [hl], a

	ld hl, CHANNEL_FIELD30
	add hl, bc
	ld [hl], a
	ld a, [wCryTracks]

	cp 2
	jr c, .skip

	ld a, [wSFXDuration]

	ld hl, CHANNEL_FIELD2E
	add hl, bc
	ld [hl], a

	ld hl, CHANNEL_FIELD2F
	add hl, bc
	ld [hl], a

	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_UNKN_0F, [hl]

.skip
	pop de

	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_CHANNEL_ON, [hl]

	pop af
	dec a
	jr nz, .loop

	ret

	ld hl, wMusicID
	ld [hl], e
	inc hl
	ld [hl], d
	ld hl, SFX
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	ld [wMusicBank], a
	ld e, [hl]
	inc hl
	ld d, [hl]
	call LoadMusicByte
	rlca
	rlca
	maskbits NUM_MUSIC_CHANS
	inc a

.cry_channels
	push af
	call LoadChannel
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	set SOUND_SFX, [hl]
	ld hl, CHANNEL_FLAGS2
	add hl, bc
	set SOUND_CRY_PITCH, [hl]
	ld hl, CHANNEL_CRY_PITCH
	add hl, bc
	ld a, [wCryPitch]
	ld [hli], a
	ld a, [wCryPitch + 1]
	ld [hl], a
	ld a, [wCurChannel]
	maskbits NUM_MUSIC_CHANS
	cp 3
	jr nc, .cry_ok

	ld hl, CHANNEL_TEMPO
	add hl, bc
	ld a, [wCryLength]
	ld [hli], a
	ld a, [wCryLength + 1]
	ld [hl], a

.cry_ok
	call StartChannel
	pop af
	dec a
	jr nz, .cry_channels

	ret


LoadChannel::
	call LoadMusicByte
	inc de
	and 7
	ld [wCurChannel], a
	ld c, a
	ld b, 0
	ld hl, ChannelPointers
	add hl, bc
	add hl, bc
	ld c, [hl]
	inc hl
	ld b, [hl]
	ld hl, CHANNEL_FLAGS1
	add hl, bc
	res SOUND_CHANNEL_ON, [hl]
	call ChannelInit
	ld hl, CHANNEL_MUSIC_ADDRESS
	add hl, bc
	call LoadMusicByte
	ld [hli], a
	inc de
	call LoadMusicByte
	ld [hl], a
	inc de
	ld hl, CHANNEL_MUSIC_ID
	add hl, bc
	ld a, [wMusicID]
	ld [hli], a
	ld a, [wMusicID + 1]
	ld [hl], a
	ld hl, CHANNEL_MUSIC_BANK
	add hl, bc
	ld a, [wMusicBank]
	ld [hl], a
	ret


ChannelInit:
	push de
	xor a
	ld hl, CHANNEL_MUSIC_ID
	add hl, bc
	ld e, CHANNEL_STRUCT_LENGTH

.loop
	ld [hli], a
	dec e
	jr nz, .loop

	ld hl, CHANNEL_TEMPO
	add hl, bc
	xor a
	ld [hli], a
	inc a
	ld [hl], a
	ld hl, CHANNEL_NOTE_LENGTH
	add hl, bc
	ld [hl], a
	pop de
	ret


LoadMusicByte::
	ld a, [wMusicBank]
	call _LoadMusicByte
	ret

INCLUDE "audio/notes.inc"

INCLUDE "audio/wave_samples.inc"

INCLUDE "audio/wave_overrides.inc"

INCLUDE "audio/intensity_overrides.inc"

INCLUDE "audio/drumkits.inc"

LRTracks:
; bit corresponds to track #
; hi: left channel
; lo: right channel
	db $11, $22, $44, $88

ChannelPointers:
; music channels
	dw wChannel1
	dw wChannel2
	dw wChannel3
	dw wChannel4
; sfx channels
	dw wChannel5
	dw wChannel6
	dw wChannel7
	dw wChannel8

INCLUDE "audio/song_header_pointers.inc"
