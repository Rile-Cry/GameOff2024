extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase

const start_location_path : String = "res://Case/Locations/Shade's Office.tres"

func _ready() -> void:
	if GameManager:
		GameManager.game_base = self
		GameManager.current_location = load(start_location_path)
		GameManager.unlock_location(GameManager.current_location, false)
	
	if UIManager:
		UIManager.refresh_mission_book()
		if not UIManager.get_mission_book_button().visible:
			UIManager.enable_disable_mission_book_button()

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)
