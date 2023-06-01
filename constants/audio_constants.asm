; pitch
	const_def 1
	const C_ ; 1
	const C# ; 2
	const D_ ; 3
	const D# ; 4
	const E_ ; 5
	const F_ ; 6
	const F# ; 7
	const G_ ; 8
	const G# ; 9
	const A_ ; a
	const A# ; b
	const B_ ; c

; channel
	const_def
	const CHAN1
	const CHAN2
	const CHAN3
	const CHAN4
DEF NUM_MUSIC_CHANS EQU const_value
	const CHAN5
	const CHAN6
	const CHAN7
	const CHAN8
DEF NUM_NOISE_CHANS EQU const_value - NUM_MUSIC_CHANS
DEF NUM_CHANNELS EQU const_value

; channel_struct members (see macros/wram.asm)
DEF CHANNEL_MUSIC_ID                    EQUS "(wChannel1MusicID - wChannel1)"
DEF CHANNEL_MUSIC_BANK                  EQUS "(wChannel1MusicBank - wChannel1)"
DEF CHANNEL_FLAGS1                      EQUS "(wChannel1Flags1 - wChannel1)"
DEF CHANNEL_FLAGS2                      EQUS "(wChannel1Flags2 - wChannel1)"
DEF CHANNEL_FLAGS3                      EQUS "(wChannel1Flags3 - wChannel1)"
DEF CHANNEL_MUSIC_ADDRESS               EQUS "(wChannel1MusicAddress - wChannel1)"
DEF CHANNEL_LAST_MUSIC_ADDRESS          EQUS "(wChannel1LastMusicAddress - wChannel1)"
DEF CHANNEL_NOTE_FLAGS                  EQUS "(wChannel1NoteFlags - wChannel1)"
DEF CHANNEL_CONDITION                   EQUS "(wChannel1Condition - wChannel1)"
DEF CHANNEL_DUTY_CYCLE                  EQUS "(wChannel1DutyCycle - wChannel1)"
DEF CHANNEL_INTENSITY                   EQUS "(wChannel1Intensity - wChannel1)"
DEF CHANNEL_FREQUENCY                   EQUS "(wChannel1Frequency - wChannel1)"
DEF CHANNEL_PITCH                       EQUS "(wChannel1Pitch - wChannel1)"
DEF CHANNEL_OCTAVE                      EQUS "(wChannel1Octave - wChannel1)"
DEF CHANNEL_PITCH_OFFSET                EQUS "(wChannel1StartingOctave - wChannel1)"
DEF CHANNEL_NOTE_DURATION               EQUS "(wChannel1NoteDuration - wChannel1)"
DEF CHANNEL_FIELD16                     EQUS "(wChannel1Field16 - wChannel1)"
DEF CHANNEL_LOOP_COUNT                  EQUS "(wChannel1LoopCount - wChannel1)"
DEF CHANNEL_TEMPO                       EQUS "(wChannel1Tempo - wChannel1)"
DEF CHANNEL_TRACKS                      EQUS "(wChannel1Tracks - wChannel1)"
DEF CHANNEL_SFX_DUTY_LOOP               EQUS "(wChannel1SFXDutyLoop - wChannel1)"
DEF CHANNEL_VIBRATO_DELAY_COUNT         EQUS "(wChannel1VibratoDelayCount - wChannel1)"
DEF CHANNEL_VIBRATO_DELAY               EQUS "(wChannel1VibratoDelay - wChannel1)"
DEF CHANNEL_VIBRATO_EXTENT              EQUS "(wChannel1VibratoExtent - wChannel1)"
DEF CHANNEL_VIBRATO_RATE                EQUS "(wChannel1VibratoRate - wChannel1)"
DEF CHANNEL_PITCH_WHEEL_TARGET          EQUS "(wChannel1PitchWheelTarget - wChannel1)"
DEF CHANNEL_PITCH_WHEEL_AMOUNT          EQUS "(wChannel1PitchWheelAmount - wChannel1)"
DEF CHANNEL_PITCH_WHEEL_AMOUNT_FRACTION EQUS "(wChannel1PitchWheelAmountFraction - wChannel1)"
DEF CHANNEL_FIELD25                     EQUS "(wChannel1Field25 - wChannel1)"
DEF CHANNEL_CRY_PITCH                   EQUS "(wChannel1CryPitch - wChannel1)"
DEF CHANNEL_FIELD29                     EQUS "(wChannel1Field29 - wChannel1)"
DEF CHANNEL_FIELD2A                     EQUS "(wChannel1Field2a - wChannel1)"
DEF CHANNEL_FIELD2C                     EQUS "(wChannel1Field2c - wChannel1)"
DEF CHANNEL_NOTE_LENGTH                 EQUS "(wChannel1NoteLength - wChannel1)"
DEF CHANNEL_FIELD2E                     EQUS "(wChannel1Field2e - wChannel1)"
DEF CHANNEL_FIELD2F                     EQUS "(wChannel1Field2f - wChannel1)"
DEF CHANNEL_FIELD30                     EQUS "(wChannel1Field30 - wChannel1)"
DEF CHANNEL_STRUCT_LENGTH               EQUS "(wChannel2 - wChannel1)"

DEF NOISE_CHAN_F EQU 2 ; bit set in CHAN5-CHAN7

; Flags1
	const_def
	const SOUND_CHANNEL_ON ; 0
	const SOUND_SUBROUTINE ; 1
	const SOUND_LOOPING    ; 2
	const SOUND_SFX        ; 3
	const SOUND_NOISE      ; 4
	const SOUND_REST       ; 5

; Flags2
	const_def
	const SOUND_VIBRATO     ; 0
	const SOUND_PITCH_WHEEL ; 1
	const SOUND_DUTY        ; 2
	const SOUND_UNKN_0B     ; 3
	const SOUND_CRY_PITCH   ; 4
	const SOUND_UNKN_0D     ; 5
	const SOUND_UNKN_0E     ; 6
	const SOUND_UNKN_0F     ; 7

; Flags3
	const_def
	const SOUND_VIBRATO_DIR     ; 0
	const SOUND_PITCH_WHEEL_DIR ; 1
	const SOUND_UNKN_12 ; 2

; NoteFlags
	const_def
	const NOTE_DUTY_OVERRIDE      ; 0
	const NOTE_FREQ_OVERRIDE      ; 1
	const NOTE_INTENSITY_OVERRIDE ; 2
	const NOTE_PITCH_SWEEP        ; 3
	const NOTE_NOISE_SAMPLING     ; 4
	const NOTE_REST               ; 5
	const NOTE_VIBRATO_OVERRIDE   ; 6

; wVolume
DEF VOLUME_SO1_F     EQU 3
DEF VOLUME_SO2_F     EQU 7
DEF VOLUME_SO1_LEVEL EQU %00000111
DEF VOLUME_SO2_LEVEL EQU %01110000
DEF MAX_VOLUME       EQU $77

; wLowHealthAlarm
DEF DANGER_PITCH_F EQU 4
DEF DANGER_ON_F    EQU 7

; wMusicFade
DEF MUSIC_FADE_IN_F EQU 7
