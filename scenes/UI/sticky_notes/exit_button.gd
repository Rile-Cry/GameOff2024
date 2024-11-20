extends ObjectButton

func _pressed() -> void:
	if GameManager and GameManager.enable_input:
		if UIManager:
			UIManager.anim_player.play("close_anim")
			await UIManager.anim_player.animation_finished
		get_tree().quit()
