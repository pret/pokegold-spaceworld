INCLUDE "constants.asm"

SECTION "home/unknown_388f.asm", ROM0

Function388f::
	ret

Function3890::
	farcall Function14cac
	ret

Function3899::
	farcall Function14dac
	ret

Function38a2::
	farcall Function14dc4
	ret

Function38ab::
	farcall Function14ddd
	ret

Function38b4::
	farcall Function14e00
	ret

Function38bd::
	farcall Function14e5f
	ret

Function38c6::
	farcall Function14e27
	ret

Function38cf::
	farcall Function14e4a
	ret

Function38d8::
	ld hl, wc5ed
	set 7, [hl]
	ld a, $8
	ld [wd637], a
	ret

TestWildBattleStart::
	ldh a, [hJoyState]
	and D_PAD
	ret z ; if no directions are down, don't try and trigger a wild encounter
	call CheckBPressedDebug
	jp nz, ClearAccumulator ; if b button is down, clear acc
	callfar Function3ee3e
	ld a, [wBattleMode]
	and a
	ret z ; if no battle, return
	ld a, $3
	call WriteIntod637
	call SetFFInAccumulator
	ret

Function3904::
	predef Function3ef19
	ld a, $f3
	ldh [hMapEntryMethod], a
	ld hl, wd4a9
	set 5, [hl]
	ld hl, wJoypadFlags
	set 4, [hl]
	set 6, [hl]
	ld a, $b
	call WriteIntod637
	ret

Function391f::
	ret

Function3920::
	ld a, [wcd5d]
	cp $1
	jr z, .asm_392d
	ld a, $4
	call WriteIntod637
	ret

.asm_392d:
	ld hl, wJoypadFlags
	res 4, [hl]
	ld hl, .text
	call OpenTextbox
	call GBFadeOutToBlack
	jp Init

.text:
	text "つぎは　がんばるぞ！！"
	done
