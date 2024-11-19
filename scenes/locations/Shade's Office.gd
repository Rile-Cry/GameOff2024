extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ComputerButton.connect("pressed", _open_computer)
	$SaveButton.connect("pressed", _save_game)
	BgmAudio.play_audio("Shade's Office")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _open_computer() -> void:
	if UIManager:
		UIManager.open_close_computer()

func _save_game() -> void:
	pass
