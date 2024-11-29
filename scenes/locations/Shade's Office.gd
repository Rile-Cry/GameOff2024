extends Control

@onready var arrow := $ArrowPC

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ComputerButton.connect("pressed", _open_computer)
	$SaveButton.connect("pressed", _save_game)
	BgmAudio.play_audio("Shade's Office")
	AmbientAudio.play_audio("Shade's Office")

func _process(_delta: float) -> void:
	if arrow.visible and GameManager:
		var email_loc : Dictionary = GameManager.get_global_variable("email_locations")
		arrow.visible = not email_loc.is_empty()

func _open_computer() -> void:
	if UIManager:
		UIManager.open_close_computer()

func _save_game() -> void:
	if GameManager:
		GameManager.save_game()
