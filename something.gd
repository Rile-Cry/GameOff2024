extends Control

var view : Vector2

@onready var rect := $ColorRect

func _ready() -> void:
	view = get_tree().root.get_size_with_decorations()

func _input(event) -> void:
	if event is InputEventMouseMotion:
		var i : Vector2 = Vector2(event.position.x / view.x, event.position.y / view.y)
		rect.material.set_shader_parameter("u_pivot", i)
