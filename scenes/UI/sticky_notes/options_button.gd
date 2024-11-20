extends ObjectButton

func _pressed() -> void:
	if UIManager and GameManager and GameManager.enable_input:
		UIManager.open_close_options()
