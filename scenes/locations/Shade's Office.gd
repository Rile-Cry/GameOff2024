extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ComputerButton.connect("pressed", _open_computer)
	$SaveButton.connect("pressed", _save_game)
	BgmAudio.play_audio("Shade's Office")
	
	if GameManager.get_global_variable("tutorial_pc"):
		pass
	else:
		$ArrowPC.queue_free()

func _open_computer() -> void:
	if UIManager:
		UIManager.open_close_computer()
	
	if GameManager.get_global_variable("tutorial_pc"):
		GameManager.set_global_variable("tutorial_pc", false)
		$ArrowPC.queue_free()

func _save_game() -> void:
	if GameManager:
		GameManager.save_game()
