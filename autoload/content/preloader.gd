class_name Preloader

#region Scene Preloads
const bad_ending_scene : PackedScene = preload("res://scenes/ending/BadEnding.tscn")
const behind_bars_scene : PackedScene = preload("res://scenes/ending/BehindBarsScene.tscn")
const credits_scene : PackedScene = preload("res://scenes/UI/credits.tscn")
#const finale_actors : PackedScene = preload("res://scenes/finale_actors.tscn")
const good_ending_scene : PackedScene = preload("res://scenes/ending/GoodEnding.tscn")
const title_scene : PackedScene = preload("res://scenes/UI/main/Title.tscn")

const all_clues_popup : PackedScene = preload("res://scenes/UI/popup/all_clues_popup.tscn")
const clue_popup : PackedScene = preload("res://scenes/UI/popup/clue_popup.tscn")
const delete_save_popup : PackedScene = preload("res://scenes/UI/popup/delete_save_popup.tscn")
const final_guess_popup : PackedScene = preload("res://scenes/UI/popup/final_guess_popup.tscn")
const found_popup : PackedScene = preload("res://scenes/UI/popup/clue_popup.tscn")
const interactable_indicator_popup : PackedScene = preload("res://scenes/interactable_indicator.tscn")
const save_popup : PackedScene = preload("res://scenes/UI/popup/save_popup.tscn")
const time_popup : PackedScene = preload("res://scenes/UI/popup/time_popup.tscn")
#endregion

#region Material Preloads
const glitch_obj_material : ShaderMaterial = preload("res://scenes/UI/main/GlitchObjtres.tres")
const outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")
#endregion

#region Other Preloads
const invalid_clue_dialogue_path : String = "base/InvalidClue"
#endregion
