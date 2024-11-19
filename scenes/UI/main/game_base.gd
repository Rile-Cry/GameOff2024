extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase

const start_location_path : String = "res://Case/Locations/Shade's Office.tres"

func _ready() -> void:
	if LoadScreen:
		LoadScreen.show()
	
	if GameManager:
		GameManager.game_base = self
		if not GameManager.load_game():
			GameManager.unlock_location(load(start_location_path), false)
			GameManager.photos.append(load("res://Case/Photos/Evelyn’s Art Studio.tres"))
			GameManager.current_location_index = 0
	
	if UIManager:
		UIManager.refresh_mission_book()
		if not UIManager.get_mission_book_button().visible:
			UIManager.enable_disable_mission_book_button()

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)
