extends Control

@onready var arrow := $ArrowPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ComputerButton.connect("pressed", _open_computer)
	$SaveButton.connect("pressed", _save_game)
	BgmAudio.play_audio("Shade's Office")
	GameManager.unlock_location(ResourceLoader.load("res://Case/Locations/Evelyn's Art Studio.tres", "Location"))

func _process(_delta: float) -> void:
	if not GameManager.get_global_variable("tutorial_pc") and is_instance_valid(arrow):
		arrow.queue_free()

func _open_computer() -> void:
	if UIManager:
		UIManager.open_close_computer()

func _save_game() -> void:
	if GameManager:
		GameManager.save_game()
