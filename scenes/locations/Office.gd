extends Control

@export_file(".tscn") var computer_scene := ""

@onready var computer_button := $ComputerButton
@onready var options_button := $OptionsButton
@onready var exit_button := $ExitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	computer_button.connect("pressed", _open_computer)
	exit_button.connect("pressed", _exit_game)
	options_button.connect("pressed", _open_options)

func _open_computer() -> void:
	if not computer_scene.is_empty():
		SceneTransitionManager.transition_to_scene(computer_scene)

func _open_options() -> void:
	if GameManager.game_base:
		GameManager.game_base.open_close_options()

func _exit_game() -> void:
	get_tree().quit()
