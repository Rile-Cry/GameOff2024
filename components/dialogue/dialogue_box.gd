extends Control

@onready var panel := $PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	panel.size.x = get_tree().root.get_size_with_decorations().x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
