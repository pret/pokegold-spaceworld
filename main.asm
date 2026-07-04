; ROMX $01
INCLUDE "engine/link/place_waiting_text.asm"
INCLUDE "engine/debug/debug_menu.asm"
INCLUDE "gfx/oam_dma.asm"
INCLUDE "data/sprites/facings.asm"
INCLUDE "engine/overworld/minor_objects.asm"
INCLUDE "engine/overworld/map_objects.asm"
INCLUDE "engine/menu/main_menu.asm"
INCLUDE "engine/movie/oak_speech.asm"
INCLUDE "data/player_names.asm"
INCLUDE "data/rival_names.asm"
INCLUDE "data/mom_names.asm"
INCLUDE "engine/movie/title.asm"
INCLUDE "engine/predef.asm"
INCLUDE "engine/overworld/init_map.asm"
INCLUDE "engine/pokemon/learn.asm"
INCLUDE "engine/items/item_prices_old.asm"
INCLUDE "engine/pokemon/nickname_unused.asm"
INCLUDE "engine/pokemon/correct_nick_errors.asm"
INCLUDE "engine/math/math.asm"
INCLUDE "data/items/attributes.asm"
INCLUDE "data/items/names.asm"
INCLUDE "engine/overworld/object_collision.asm"
INCLUDE "engine/menu/options_menu.asm"


;ROMX $02
INCLUDE "engine/overworld/player_object.asm"
INCLUDE "engine/gfx/load_minor_object_gfx.asm"
INCLUDE "engine/events/town_map.asm"

INCLUDE "data/maps/flypoints.asm"
INCLUDE "data/maps/landmarks.asm"

INCLUDE "engine/trainer_gear.asm"
INCLUDE "engine/gfx/set_title_decoration.asm"
INCLUDE "engine/gfx/sgb_layouts.asm"


;ROMX $03
INCLUDE "engine/overworld/player_movement.asm"
INCLUDE "data/collision/collision_type_table.asm"
INCLUDE "engine/overworld/spawn_points.asm"
INCLUDE "data/maps/spawn_points.asm"
INCLUDE "data/tilesets.asm"
INCLUDE "engine/overworld/check_trainer_battle.asm"
INCLUDE "engine/items/inventory.asm"
INCLUDE "engine/smallflag.asm"
INCLUDE "engine/pokemon/health.asm"
INCLUDE "engine/bcd.asm"
INCLUDE "engine/events/field_moves.asm"
INCLUDE "engine/overworld/player_step.asm"
INCLUDE "engine/pokemon/move_mon.asm"
INCLUDE "engine/pokemon/bills_pc.asm"
INCLUDE "engine/events/starter_dex.asm"
INCLUDE "engine/items/item_effects.asm"
INCLUDE "engine/events/breeder.asm"
INCLUDE "engine/battle_anims/pokeball_wobble.asm"
INCLUDE "engine/pokemon/knows_move.asm"


;ROMX $04
INCLUDE "data/maps/maps.asm"
INCLUDE "engine/items/tmhm.asm"
INCLUDE "data/moves/tmhm_moves.asm"
INCLUDE "engine/pokemon/add_mon.asm"
INCLUDE "engine/menu/text_entry.asm"
INCLUDE "data/text/text_input_chars.asm"
INCLUDE "engine/menu/start_menu.asm"


;ROMX $05
INCLUDE "engine/sprites/sprites.asm"
INCLUDE "data/maps/sprite_sets.asm"
INCLUDE "data/overworld_sprites.asm"
INCLUDE "engine/menu/empty_sram.asm"
INCLUDE "engine/events/pokecenter_pc.asm"
INCLUDE "engine/events/std_scripts.asm"
INCLUDE "engine/events/check_inline_trainers.asm"


;ROMX $09
INCLUDE "engine/menu/menu.asm"
INCLUDE "engine/items/update_item_description.asm"
INCLUDE "engine/events/pokepic.asm"
INCLUDE "engine/menu/scrolling_menu.asm"
INCLUDE "engine/items/switch_items.asm"
INCLUDE "engine/menu/menu_2.asm"
INCLUDE "engine/pokemon/mon_submenu.asm"
INCLUDE "engine/battle/menu.asm"
INCLUDE "engine/items/buy_sell_toss.asm"


;ROMX $0a
INCLUDE "engine/link/link.asm"
INCLUDE "data/pokemon/gen1_base_special.asm"
INCLUDE "engine/movie/trade_animation.asm"
INCLUDE "scripts/UnusedGen1TradeCenter.asm"
INCLUDE "data/maps/objects/UnusedGen1TradeCenter.asm"
INCLUDE "scripts/UnusedGen1Colosseum.asm"
INCLUDE "data/maps/objects/UnusedGen1Colosseum.asm"
INCLUDE "engine/link/link_2.asm"


;ROMX $0b
INCLUDE "engine/items/print_item_description.asm"
INCLUDE "engine/items/tm_holder.asm"
INCLUDE "engine/pokemon/print_move_description.asm"


;ROMX $0d
INCLUDE "engine/battle/effect_commands.asm"


;ROMX $0e
INCLUDE "engine/battle/ai/items.asm"
INCLUDE "engine/battle/trainer_huds.asm"
INCLUDE "engine/battle/ai/move.asm"
INCLUDE "engine/battle/ai/scoring.asm"
INCLUDE "engine/battle/read_trainer_attributes.asm"
INCLUDE "engine/battle/read_trainer_party.asm"


;ROMX $0f
INCLUDE "engine/battle/core.asm"
INCLUDE "engine/overworld/wildmons.asm"


;ROMX $10
INCLUDE "engine/pokedex/pokedex.asm"
INCLUDE "engine/link/time_capsule_2.asm"
INCLUDE "engine/pokedex/pokedex_2.asm"
INCLUDE "data/moves/names.asm"
INCLUDE "data/moves/moves.asm"
INCLUDE "engine/pokemon/evolve.asm"
INCLUDE "data/pokemon/evos_attacks.asm"


;ROMX $11
INCLUDE "engine/pokedex/display_dex_entry.asm"
INCLUDE "data/pokemon/dex_entries.asm"


;ROMX $14
INCLUDE "engine/pokemon/tempmon.asm"
INCLUDE "engine/pokemon/types.asm"
INCLUDE "engine/battle/getgen1trainerclassname.asm"
INCLUDE "engine/pokemon/mon_stats.asm"
INCLUDE "engine/pokemon/party_menu.asm"
INCLUDE "engine/gfx/load_pics.asm"
INCLUDE "engine/link/init_list.asm"
INCLUDE "engine/pokemon/experience.asm"
INCLUDE "engine/pokemon/switchpartymons.asm"
INCLUDE "data/pokemon/base_stats.asm"
INCLUDE "data/pokemon/names.asm"


;ROMX $23
INCLUDE "engine/tileset_anims.asm"
INCLUDE "engine/overworld/healing_machine.asm"
INCLUDE "engine/palettes.asm"
INCLUDE "engine/battle/battle_transitions.asm"
INCLUDE "engine/overworld/player_animations_old.asm"
INCLUDE "engine/sprite_anims/core.asm"
INCLUDE "engine/gfx/mon_icons.asm"


;ROMX $24
INCLUDE "engine/menu/set_clock_dialog.asm"
INCLUDE "engine/games/slot_machine_game.asm"


;ROMX $32
INCLUDE "engine/battle_anims/bg_effects.asm"
INCLUDE "data/moves/animations.asm"
INCLUDE "engine/gfx/screen_effects.asm"


;ROMX $33
INCLUDE "engine/battle_anims/anim_commands.asm"
INCLUDE "engine/battle_anims/core.asm"
INCLUDE "engine/battle_anims/functions.asm"
INCLUDE "engine/battle_anims/helpers.asm"


;ROMX $38
INCLUDE "engine/games/pikachu_minigame.asm"
INCLUDE "engine/games/poker_minigame.asm"
INCLUDE "engine/games/fifteen_puzzle_minigame.asm"
INCLUDE "engine/games/memory_minigame.asm"
INCLUDE "engine/games/picross_minigame.asm"


;ROMX $39
INCLUDE "engine/movie/game_freak_intro.asm"
INCLUDE "engine/movie/opening_cutscene.asm"


;ROMX $3e
INCLUDE "engine/gfx/load_gfx.asm"


;ROMX $3f
INCLUDE "engine/debug/field_debug_menu.asm"
INCLUDE "engine/menu/frame_type_dialog.asm"
INCLUDE "engine/menu/reset_dialog.asm"
INCLUDE "engine/landmarks.asm"
INCLUDE "engine/debug/fight_debug_menu.asm"
INCLUDE "engine/debug/sound_debug_menu.asm"
INCLUDE "engine/debug/monster_debug_menu.asm"
INCLUDE "engine/debug/subgame_debug_menu.asm"
