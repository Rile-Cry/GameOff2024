extends ObjectButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(exit_game)
	super()

func exit_game() -> void:
	if GameManager and GameManager.enable_input:
		get_tree().quit()
