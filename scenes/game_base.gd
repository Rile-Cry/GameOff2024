extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase

func _ready() -> void:
	GameManager.game_base = self
	%OptionMenu.visible = false
	%Computer.visible = false
	

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and not %MissionBook.visible:
		open_close_options()

func open_close_options() -> void:
	%OptionMenu.visible = not %OptionMenu.visible

func open_close_computer() -> void:
	%Computer.visible = not %Computer.visible
