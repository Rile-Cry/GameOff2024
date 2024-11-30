extends LocationScene

func _ready() -> void:
	if UIManager and GameManager:
		UIManager.add_child(GameManager.vignette.instantiate())
		
	super()

func dialogue_start_action(idx : int):
	if idx == 0:
		if BgmAudio and BgmAudio.playing:
			BgmAudio.stop()
		if AmbientAudio and AmbientAudio.playing:
			AmbientAudio.stop()
		
		if UIManager:
			UIManager.anim_player.play("hide_room")
			await UIManager.anim_player.animation_finished
		actor.show()
	elif idx == 1:
		if BgmAudio and not bgm.is_empty():
			BgmAudio.play_audio(bgm)
		if AmbientAudio and not ambiance.is_empty():
			AmbientAudio.play_audio(ambiance)
		
		if UIManager:
			UIManager.anim_player.play("reveal_room")
			await UIManager.anim_player.animation_finished
