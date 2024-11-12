extends Control

@export_file(".tscn") var computer_scene := ""

@onready var computer_button := $ComputerButton
@onready var exit_button := $ExitButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	computer_button.connect("pressed", _open_computer)
	exit_button.connect("pressed", _exit_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _open_computer() -> void:
	if not computer_scene.is_empty():
		var transition := SceneTransitionManager.Transitions.NoTransition
		SceneTransitionManager.transition_to_scene(computer_scene, false, transition, transition)


func _exit_game() -> void:
	get_tree().quit()
