extends Control

@onready var back_button : Button = %ExitButton

func _ready():
	back_button.pressed.connect(close)

func close():
	if UIManager:
		UIManager.open_close_options()
