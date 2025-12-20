MACRO? flag_array
	ds ((\1) + 7) / 8
ENDM

MACRO box_struct
\1Species::        db
\1Item::           db
\1Moves::          ds NUM_MOVES
\1ID::             dw
\1Exp::            ds 3
\1StatExp::
\1HPExp::          dw
\1AtkExp::         dw
\1DefExp::         dw
\1SpdExp::         dw
\1SpcExp::         dw
\1DVs::            ds 2
\1PP::             ds NUM_MOVES
\1Happiness::      db
\1PokerusStatus::  db
\1CaughtData::
\1CaughtTime::
\1CaughtLevel::    db
\1CaughtGender::
\1CaughtLocation:: db
\1Level::          db
\1End::
ENDM

MACRO party_struct
	box_struct \1
\1Status::         db
\1Unused4::        db
\1HP::             dw
\1MaxHP::          dw
\1Stats:: ; big endian
\1Attack::         dw
\1Defense::        dw
\1Speed::          dw
\1SpclAtk::        dw
\1SpclDef::        dw
\1StatsEnd::
ENDM

MACRO red_box_struct
\1Species::    db
\1HP::         dw
\1BoxLevel::   db
\1Status::     db
\1Type::
\1Type1::      db
\1Type2::      db
\1CatchRate::  db
\1Moves::      ds NUM_MOVES
\1OTID::       dw
\1Exp::        ds 3
\1HPExp::      dw
\1AttackExp::  dw
\1DefenseExp:: dw
\1SpeedExp::   dw
\1SpecialExp:: dw
\1DVs::        ds 2
\1PP::         ds NUM_MOVES
ENDM

MACRO red_party_struct
	red_box_struct \1
\1Level::      db
\1Stats::
\1MaxHP::      dw
\1Attack::     dw
\1Defense::    dw
\1Speed::      dw
\1Special::    dw
ENDM


MACRO battle_struct
\1Species::   db
\1Item::      db
\1Moves::     ds NUM_MOVES
\1MovesEnd::
\1DVs::       ds 2
\1PP::        ds NUM_MOVES
\1Happiness:: db
\1Level::     db
\1Status::    ds 2
\1HP::        dw
\1MaxHP::     dw
\1Stats:: ; big endian
\1Attack::    dw
\1Defense::   dw
\1Speed::     dw
\1SpclAtk::   dw
\1SpclDef::   dw
\1StatsEnd::
\1Type::
\1Type1::     db
\1Type2::     db
\1StructEnd::
ENDM

MACRO box
\1Count::   db
\1Species:: ds MONS_PER_BOX + 1
\1Mons::
	; \1Mon1 - \1Mon30
	for n, 1, MONS_PER_BOX + 1
	\1Mon{d:n}:: box_struct \1Mon{d:n}
	endr
\1MonOTs::
	; \1Mon1OT - \1Mon30OT
	for n, 1, MONS_PER_BOX + 1
	\1Mon{d:n}OT:: ds PLAYER_NAME_LENGTH
	endr
\1MonNicknames::
	; \1Mon1Nickname - \1Mon30Nickname
	for n, 1, MONS_PER_BOX + 1
	\1Mon{d:n}Nickname:: ds MON_NAME_LENGTH
	endr
\1MonNicknamesEnd::
\1End::
ENDM

MACRO map_connection_struct
\1ConnectedMapGroup::       db
\1ConnectedMapNumber::      db
\1ConnectionStripPointer::  dw
\1ConnectionStripLocation:: dw
\1ConnectionStripLength::   db
\1ConnectedMapWidth::       db
\1ConnectionStripYOffset::  db
\1ConnectionStripXOffset::  db
\1ConnectionWindow::        dw
ENDM


MACRO channel_struct
\1MusicID::           dw
\1MusicBank::         db
\1Flags1::            db ; 0:on/off 1:subroutine 3:sfx 4:noise 5:rest
\1Flags2::            db ; 0:vibrato on/off 2:duty 4:cry pitch
\1Flags3::            db ; 0:vibrato up/down
\1MusicAddress::      dw
\1LastMusicAddress::  dw
                      dw
\1NoteFlags::         db ; 5:rest
\1Condition::         db ; conditional jumps
\1DutyCycle::         db ; bits 6-7 (0:12.5% 1:25% 2:50% 3:75%)
\1Intensity::         db ; hi:pressure lo:velocity
\1Frequency::         dw ; 11 bits
\1Pitch::             db ; 0:rest 1-c:note
\1Octave::            db ; 7-0 (0 is highest)
\1StartingOctave::    db ; raises existing octaves (to repeat phrases)
\1NoteDuration::      db ; frames remaining for the current note
\1Field16::           ds 1
                      ds 1
\1LoopCount::         db
\1Tempo::             dw
\1Tracks::            db ; hi:left lo:right
\1SFXDutyLoop::       ds 1
\1VibratoDelayCount:: db ; initialized by \1VibratoDelay
\1VibratoDelay::      db ; number of frames a note plays until vibrato starts
\1VibratoExtent::     db
\1VibratoRate::       db ; hi:frames for each alt lo:frames to the next alt
\1PitchWheelTarget::  dw ; frequency endpoint for pitch wheel
\1PitchWheelAmount::  db
\1PitchWheelAmountFraction::   db
\1Field25::           ds 1
                      ds 1
\1CryPitch::          dw
\1Field29::           ds 1
\1Field2a::           ds 2
\1Field2c::           ds 1
\1NoteLength::        db ; frames per 16th note
\1Field2e::           ds 1
\1Field2f::           ds 1
\1Field30::           ds 1
                      ds 1
ENDM

MACRO mailmsg
\1Message:: ds MAIL_MSG_LENGTH
\1MessageEnd:: ds 1
\1Author:: ds PLAYER_NAME_LENGTH
\1AuthorNationality:: ds 2
\1AuthorID:: ds 2
\1Species:: ds 1
\1Type:: ds 1
\1End::
ENDM

MACRO hof_mon
\1Species:: ds 1
\1ID:: ds 2
\1DVs:: ds 2
\1Level:: ds 1
\1Nickname:: ds PKMN_NAME_LENGTH +- 1
\1End::
ENDM

MACRO roam_struct
\1Species::   db
\1Level::     db
\1MapGroup::  db
\1MapNumber:: db
\1HP::        ds 1
\1DVs::       ds 2
ENDM

MACRO bugcontestwinner
\1PersonID:: ds 1
\1Mon:: ds 1
\1Score:: ds 2
ENDM

MACRO hall_of_fame
\1::
\1WinCount:: ds 1
\1Mon1:: hof_mon \1Mon1
\1Mon2:: hof_mon \1Mon2
\1Mon3:: hof_mon \1Mon3
\1Mon4:: hof_mon \1Mon4
\1Mon5:: hof_mon \1Mon5
\1Mon6:: hof_mon \1Mon6
\1End:: ds 1
ENDM

MACRO trademon
\1Species:: ds 1 ; wc6d0 | wc702
\1SpeciesName:: ds PKMN_NAME_LENGTH ; wc6d1 | wc703
\1Nickname:: ds PKMN_NAME_LENGTH ; wc6dc | wc70e
\1SenderName:: ds NAME_LENGTH ; wc6e7 | wc719
\1OTName:: ds NAME_LENGTH ; wc6f2 | wc724
\1DVs:: ds 2 ; wc6fd | wc72f
\1ID:: ds 2 ; wc6ff | wc731
\1CaughtData:: ds 1 ; wc701 | wc733
\1End::
ENDM

MACRO move_struct
\1Animation:: ds 1
\1Effect:: ds 1
\1Power:: ds 1
\1Type:: ds 1
\1Accuracy:: ds 1
\1PP:: ds 1
\1EffectChance:: ds 1
ENDM

MACRO slot_reel
\1ReelAction::   db
\1TilemapAddr::  dw
\1Position::     db
\1SpinDistance:: db
\1SpinRate::     db
\1OAMAddr::      dw
\1XCoord::       db
\1ManipCounter:: db
\1ManipDelay::   db
\1Field0b::      db
\1Field0c::      db
\1Field0d::      db
\1Field0e::      db
\1StopDelay::    db
ENDM

MACRO object_struct
\1Sprite::         db
\1MapObjectIndex:: db
\1SpriteTile::     db
\1MovementType::   db
\1Flags::          dw
\1Walking::        db
\1Direction::      db
\1StepType::       db
\1StepDuration::   db
\1Action::         db
\1StepFrame::      db
\1Object12::       db
\1Facing::         db
\1Tile::           db ; collision
\1LastTile::       db ; collision
\1MapX::           db
\1MapY::           db
\1LastMapX::       db
\1LastMapY::       db
\1InitX::          db
\1InitY::          db
\1RadiusX::        db
\1RadiusY::        db
\1SpriteX::        db
\1SpriteY::        db
\1SpriteXOffset::  db
\1SpriteYOffset::  db
\1MovementIndex::  db
\1Object29::       db
\1Object30::       db
\1Object31::       db
\1Range::          db
	ds 7
\1StructEnd::
ENDM

MACRO map_object
\1ObjectStructID::   db
\1ObjectSprite::     db
\1ObjectYCoord::     db
\1ObjectXCoord::     db
\1ObjectMovement::   db
\1ObjectRadius::     db
\1ObjectHour::       db
\1ObjectTimeOfDay::  db
\1ObjectType::       db
	ds 2
\1ObjectSightRange:: db
	ds 4
ENDM

MACRO minor_object
\1ParentObject:: db
\1Type:: db
\1Animation:: db
\1SpriteTile:: db
\1XCoord:: db
\1YCoord:: db
\1XOffset:: db
\1YOffset:: db
\1_08:: db
\1_09:: db
\1JumptableIndex:: db
\1Timer:: db
\1Frame:: db
\1Var1:: db
\1Var2:: db
\1Var3:: db
ENDM

MACRO sprite_anim_struct
\1Index:: ds 1          ; 0
\1FramesetID:: ds 1     ; 1
\1AnimSeqID:: ds 1      ; 2
\1TileID:: ds 1         ; 3
\1XCoord:: ds 1         ; 4
\1YCoord:: ds 1         ; 5
\1XOffset:: ds 1        ; 6
\1YOffset:: ds 1        ; 7
\1Duration:: ds 1       ; 8
\1DurationOffset:: ds 1 ; 9
\1FrameIndex:: ds 1     ; a
\1Sprite0b:: ds 1
\1Sprite0c:: ds 1
\1Sprite0d:: ds 1
\1Sprite0e:: ds 1
\1Sprite0f:: ds 1
ENDM

MACRO battle_anim_struct
\1Index::          db
\1OAMFlags::       db
\1FixY::           db
\1FramesetID::     db
\1Function::       db
\1TileID::         db
\1XCoord::         db
\1YCoord::         db
\1XOffset::        db
\1YOffset::        db
\1Param::          db
\1Duration::       db
\1Frame::          db
\1JumptableIndex:: db
\1Var1::           db
\1Var2::           db
ENDM

MACRO battle_bg_effect
\1Function::       db
\1JumptableIndex:: db
\1BattleTurn::     db
\1Param::          db
ENDM

MACRO sprite_oam_struct
\1YCoord::     db
\1XCoord::     db
\1TileID::     db
\1Attributes:: db
ENDM

MACRO warp_struct
\1WarpNumber:: ds 1
\1MapGroup:: ds 1
\1MapNumber:: ds 1
ENDM

MACRO ptrba
\1Bank:: db
\1Addr:: dw
ENDM

MACRO ptrab
\1Addr:: dw
\1Bank:: db
ENDM
