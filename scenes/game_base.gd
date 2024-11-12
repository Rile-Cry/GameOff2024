extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase

func _ready() -> void:
	GameManager.game_base = self

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)
