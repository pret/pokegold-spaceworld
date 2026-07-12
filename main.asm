SECTION "bank1", ROMX

INCLUDE "engine/link/place_waiting_text.asm"
INCLUDE "engine/debug/debug_menu.asm"
INCLUDE "engine/gfx/oam_dma.asm"
INCLUDE "data/sprites/facings.asm"
INCLUDE "engine/overworld/minor_objects.asm"
INCLUDE "engine/overworld/map_objects.asm"
INCLUDE "engine/menu/main_menu.asm"
INCLUDE "engine/movie/oak_speech.asm"
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


SECTION "bank2", ROMX

INCLUDE "engine/overworld/player_object.asm"
INCLUDE "engine/gfx/load_minor_object_gfx.asm"
INCLUDE "engine/overworld/queue_follower.asm"
INCLUDE "engine/events/town_map.asm"
INCLUDE "data/maps/flypoints.asm"
INCLUDE "data/maps/landmarks.asm"
INCLUDE "engine/trainer_gear/trainer_gear.asm"
INCLUDE "engine/gfx/set_title_decoration.asm"
INCLUDE "engine/gfx/sgb_layouts.asm"


SECTION "bank3", ROMX

INCLUDE "engine/overworld/player_movement.asm"
INCLUDE "engine/overworld/spawn_points.asm"
INCLUDE "data/maps/spawn_points.asm"
INCLUDE "data/tilesets.asm"
INCLUDE "engine/overworld/check_trainer_battle.asm"
INCLUDE "engine/items/inventory.asm"
INCLUDE "engine/smallflag.asm"
INCLUDE "engine/pokemon/health.asm"
INCLUDE "engine/math/bcd.asm"
INCLUDE "engine/items/get_item_amount.asm"
INCLUDE "engine/pokemon/hp_bar.asm"
INCLUDE "engine/events/field_moves.asm"
INCLUDE "engine/items/check_tossable_item.asm"
INCLUDE "engine/overworld/player_step.asm"
INCLUDE "engine/pokemon/move_mon.asm"
INCLUDE "engine/pokemon/bills_pc.asm"
INCLUDE "engine/events/starter_dex.asm"
INCLUDE "engine/items/item_effects.asm"
INCLUDE "engine/events/breeder.asm"
INCLUDE "engine/battle_anims/pokeball_wobble.asm"
INCLUDE "engine/pokemon/knows_move.asm"


SECTION "Maps", ROMX

INCLUDE "data/maps/maps.asm"


SECTION "bank4", ROMX

INCLUDE "engine/items/tmhm.asm"
INCLUDE "data/moves/tmhm_moves.asm"
INCLUDE "engine/pokemon/add_mon.asm"
INCLUDE "engine/menu/text_entry.asm"
INCLUDE "engine/menu/start_menu.asm"


SECTION "bank5", ROMX

INCLUDE "engine/overworld/redraw_player_sprite.asm"
INCLUDE "engine/sprites/sprites.asm"
INCLUDE "data/maps/sprite_sets.asm"
INCLUDE "data/sprites/sprites.asm"
INCLUDE "engine/menu/empty_sram.asm"
INCLUDE "data/maps/scenes.asm"
INCLUDE "engine/overworld/return_from_battle.asm"
INCLUDE "engine/events/pokecenter_pc.asm"
INCLUDE "engine/events/std_scripts.asm"
INCLUDE "engine/events/check_inline_trainers.asm"


SECTION "Menu", ROMX

INCLUDE "engine/menu/menu.asm"
INCLUDE "engine/items/update_item_description.asm"
INCLUDE "engine/events/pokepic.asm"
INCLUDE "engine/menu/scrolling_menu.asm"
INCLUDE "engine/items/switch_items.asm"
INCLUDE "engine/menu/menu_2.asm"
INCLUDE "engine/pokemon/mon_submenu.asm"
INCLUDE "engine/battle/menu.asm"
INCLUDE "engine/items/buy_sell_toss.asm"


SECTION "Link Cable", ROMX

INCLUDE "engine/link/link.asm"
INCLUDE "data/pokemon/gen1_base_special.asm"
INCLUDE "engine/movie/trade_animation.asm"


SECTION "Link Cable 2", ROMX

INCLUDE "engine/link/link_2.asm"


SECTION "Item Descriptions", ROMX

INCLUDE "engine/items/print_item_description.asm"
INCLUDE "engine/items/tm_holder.asm"
INCLUDE "engine/pokemon/print_move_description.asm"


SECTION "Effect Commands", ROMX

INCLUDE "engine/battle/effect_commands.asm"


SECTION "Enemy Trainers", ROMX

INCLUDE "engine/battle/ai/items.asm"
INCLUDE "engine/battle/trainer_huds.asm"
INCLUDE "engine/battle/ai/move.asm"
INCLUDE "engine/battle/ai/scoring.asm"
INCLUDE "engine/battle/read_trainer_attributes.asm"
INCLUDE "engine/battle/read_trainer_party.asm"


SECTION "Battle Core", ROMX

INCLUDE "engine/battle/core.asm"
INCLUDE "engine/overworld/wildmons.asm"
INCLUDE "engine/battle/start_battle.asm"


SECTION "bank10", ROMX

INCLUDE "engine/pokedex/pokedex.asm"
INCLUDE "engine/link/time_capsule_2.asm"
INCLUDE "engine/pokedex/pokedex_2.asm"
INCLUDE "data/moves/names.asm"
INCLUDE "data/moves/moves.asm"
INCLUDE "engine/pokemon/evolve.asm"
INCLUDE "data/pokemon/evos_attacks.asm"


SECTION "bank11", ROMX

INCLUDE "engine/pokedex/display_dex_entry.asm"
INCLUDE "data/pokemon/dex_entries.asm"


SECTION "bank14", ROMX

INCLUDE "engine/pokemon/tempmon.asm"
INCLUDE "engine/pokemon/types.asm"
INCLUDE "engine/battle/getgen1trainerclassname.asm"
INCLUDE "engine/pokemon/mon_stats.asm"
INCLUDE "engine/pokemon/party_menu.asm"
INCLUDE "engine/gfx/load_pics.asm"
INCLUDE "engine/pokemon/list_moves.asm"
INCLUDE "engine/link/init_list.asm"
INCLUDE "engine/pokemon/experience.asm"
INCLUDE "engine/pokemon/switchpartymons.asm"
INCLUDE "engine/pokemon/clear_menu_cursor.asm"
INCLUDE "engine/gfx/get_unown_letter.asm"
INCLUDE "data/pokemon/base_stats.asm"
INCLUDE "data/pokemon/names.asm"


SECTION "bank23", ROMX

INCLUDE "engine/tilesets/tileset_anims.asm"
INCLUDE "engine/overworld/healing_machine.asm"
INCLUDE "engine/tilesets/timeofday_pals.asm"
INCLUDE "engine/battle/battle_transitions.asm"
INCLUDE "engine/overworld/player_animations_old.asm"
INCLUDE "engine/sprite_anims/core.asm"


SECTION "bank23_2", ROMX

INCLUDE "engine/gfx/mon_icons.asm"


SECTION "Subgames 1", ROMX

INCLUDE "engine/games/set_clock_dialog.asm"
INCLUDE "engine/games/slot_machine_game.asm"


SECTION "bank32", ROMX

INCLUDE "engine/battle_anims/bg_effects.asm"
INCLUDE "data/moves/animations.asm"
INCLUDE "engine/gfx/screen_effects.asm"


SECTION "Move Animations", ROMX

INCLUDE "engine/battle_anims/anim_commands.asm"
INCLUDE "engine/battle_anims/core.asm"
INCLUDE "engine/battle_anims/functions.asm"
INCLUDE "engine/battle_anims/helpers.asm"


SECTION "bank36", ROMX

INCLUDE "engine/menu/set_time.asm"


SECTION "Subgames 2", ROMX

INCLUDE "engine/games/pikachu_minigame.asm"
INCLUDE "engine/games/poker_minigame.asm"
INCLUDE "engine/games/fifteen_puzzle_minigame.asm"
INCLUDE "engine/games/memory_minigame.asm"
INCLUDE "engine/games/picross_minigame.asm"


SECTION "Intro", ROMX

INCLUDE "engine/movie/game_freak_intro.asm"
INCLUDE "engine/movie/opening_cutscene.asm"


SECTION "bank3E", ROMX

INCLUDE "engine/gfx/load_gfx.asm"


SECTION "Debug", ROMX

INCLUDE "engine/debug/field_debug_menu.asm"
INCLUDE "engine/menu/frame_type_dialog.asm"
INCLUDE "engine/menu/reset_dialog.asm"
INCLUDE "engine/debug/field/change_tileset.asm"
INCLUDE "engine/debug/field_debug_menu_2.asm"
INCLUDE "engine/debug/fight_debug_menu.asm"
INCLUDE "engine/debug/sound_debug_menu.asm"
INCLUDE "engine/debug/monster_debug_menu.asm"
INCLUDE "engine/debug/subgame_debug_menu.asm"
