include "constants.asm"

SECTION "maps/SilentHillPokecenter.asm", ROMX

SilentHillPokecenterScriptLoader:: ; 4682
	ld hl, SilentHillPokecenterScriptPointers
	call RunMapScript
	call WriteBackMapScriptNumber
	ret

SilentHillPokecenterScriptPointers: ; 468C
	dw SilentHillPokecenterScript
	dw SilentHillPokecenterNPCIDs

SilentHillPokecenterScript: ; 4690
	ld hl, SilentHillPokecenterNPCIDs
	ld de, SilentHillPokecenterPCPointer
	call CallMapTextSubroutine
	ret

; 469A
	dw SilentHillPokecenterNPCIDs

SilentHillPokecenterNPCIDs: ; 469C
	db 0
	db 1
	db 2
	db 3
	db 4
	db $FF

SilentHillPokecenterPCPointer: ; 46A2
	dw SilentHillPokecenterPCText

SilentHillPokecenterPCText: ; 46A4
	ld hl, SilentHillPokecenterTextString1
	call OpenTextbox
	ret

SilentHillPokecenterTextString1: ; 46AB
	text "げんざい　ちょうせいちゅうです"
	done

SilentHillPokecenterTextPointers:: ; 46BC
	dw SilentHillPokecenterNPCText1
	dw SilentHillPokecenterNPCText2
	dw SilentHillPokecenterNPCText3
	dw SilentHillPokecenterNPCText4
	dw SilentHillPokecenterNPCText5

SilentHillPokecenterNPCText1: ; 46C6
	ld hl, SilentHillPokecenterTextString2
	call OpenTextbox
	ret

SilentHillPokecenterTextString2: ; 46CD
	text "もうしわけありませんが"
	line "ただいま　しゅうりちゅう　でして"

	para "かいふくは　できません"

	para "まちから　でるときは"
	line "じゅうぶんに　おきをつけ　ください"
	done

SilentHillPokecenterNPCText2: ; 4714
	ld hl, SilentHillPokecenterTextString3
	call OpenTextbox
	ret

SilentHillPokecenterTextString3: ; 471B
	text "あそこに　ある　パソコンは"
	line "トレーナー　だったら"
	cont "いつでも　むりょうで"
	cont "つかうことが　できるよ"
	cont "きが　きいてるよな！"
	done

SilentHillPokecenterNPCText3: ; 4757
	ld hl, SilentHillPokecenterTextString4
	call OpenTextbox
	ret

SilentHillPokecenterTextString4: ; 475E
	text "いま　じゅんびちゅうの"
	line "きかいは　すごいらしいよ"

	para "なんでも　ときを　こえて"
	line "ポケモンが　こうかん　できるって！"

	para "ほんとかな？"
	done

SilentHillPokecenterNPCText4: ; 479E
	ld hl, SilentHillPokecenterTextString5
	call OpenTextbox
	ret

SilentHillPokecenterTextString5: ; 47A5
	text "こいつ　へルガー"
	line "いままでにない　タイプの　ポケモンさ"
	done

SilentHillPokecenterNPCText5: ; 47C2
	ld hl, SilentHillPokecenterTextString6
	call OpenTextbox
	ret

SilentHillPokecenterTextString6: ; 47C9
	text "へルガー『ぐるるうー"
	done

; 47D5
