extends Control

@onready var back_button : Button = %ExitButton

func _ready():
	back_button.pressed.connect(close)

func close():
	if GameManager.game_base:
		GameManager.game_base.open_close_options()
