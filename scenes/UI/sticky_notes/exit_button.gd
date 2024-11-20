extends ObjectButton

func _pressed() -> void:
	if GameManager and GameManager.enable_input:
		get_tree().quit()
