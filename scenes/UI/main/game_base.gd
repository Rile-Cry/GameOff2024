extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase
const tutorial_popup_path : String = "res://scenes/UI/tutorial_popup.tscn"

const start_location_path : String = "res://Case/Locations/Shade's Office.tres"

func _ready() -> void:
	if LoadScreen:
		LoadScreen.show()
	
	if GameManager:
		GameManager.game_base = self
		if not GameManager.load_game():
			
			GameManager.set_global_variable("tutorial_pc", true)

			GameManager.unlock_location(load(start_location_path), false)
			GameManager.current_location_index = 0
			await LoadScreen.loading_finish
			if UIManager:
				var tutorial_popup : PackedScene = load(tutorial_popup_path)
				UIManager.add_child(tutorial_popup.instantiate())
	
	if UIManager:
		UIManager.refresh_mission_book()
		if not UIManager.get_mission_book_button().visible:
			UIManager.enable_disable_mission_book_button()

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)
