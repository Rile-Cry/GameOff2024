extends Control

@onready var computer_button := $ComputerButton
@onready var options_button := $OptionsButton
@onready var exit_button := $ExitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	computer_button.connect("pressed", _open_computer)
	exit_button.connect("pressed", _exit_game)
	options_button.connect("pressed", _open_options)

func _open_computer() -> void:
	if GameManager.game_base:
		GameManager.game_base.open_close_computer()

func _open_options() -> void:
	if GameManager.game_base:
		GameManager.game_base.open_close_options()

func _exit_game() -> void:
	get_tree().quit()
