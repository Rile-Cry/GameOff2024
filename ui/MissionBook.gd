extends Control

@export var open_b : Button
@export var close_b : Button
@export var tab_container : TabContainer

var is_open = false

func _ready():
	open_b.button_down.connect(open_close)
	close_b.button_down.connect(open_close)
	self.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		tab_container.current_tab = 0
		open_close()

func open_close():
	is_open = not is_open
	self.visible = is_open
	open_b.visible = not is_open
