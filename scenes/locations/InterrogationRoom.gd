extends LocationScene

func _ready() -> void:
	if UIManager:
		UIManager.show_shader("vignette")
	
	$FinaleActors.hide()
	
	GlobalGameEvents.connect("scene_loaded", _scene_loaded)
	if GameManager.global_variables["all_clues"]:
		actor.show()
	else:
		super()

func _get_clue_location(clue : Clue) -> bool:
	if await super(clue):
		GameManager.set_global_variable("LucasInterrogationFinish", _check_if_all_clues_interacted())
		GameManager.is_all_true("The Turnabout Case")
		return true
	return false

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		if UIManager:
			UIManager.hide_shader("vignette")

func dialogue_start_action(idx : int):
	if GameManager.global_variables["all_clues"]:
		if idx == 0:
			
			
			if UIManager:
				if BgmAudio and not bgm.is_empty():
					BgmAudio.play_audio(bgm)
				if AmbientAudio and not ambiance.is_empty():
					AmbientAudio.play_audio(ambiance)
				UIManager.anim_player.play("reveal_room")
				await UIManager.anim_player.animation_finished
	else:
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

func _scene_loaded() -> void:
	if GameManager.global_variables["all_clues"]:
		$FinaleActors.show()
