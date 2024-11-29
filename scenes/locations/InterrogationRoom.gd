extends LocationScene

func dialogue_start_action(idx : int):
	if idx == 0:
		if BgmAudio and BgmAudio.playing:
			BgmAudio.stop()
		if AmbientAudio and AmbientAudio.playing:
			AmbientAudio.stop()
		
		$AnimationPlayer.play("hide_room")
		await $AnimationPlayer.animation_finished
	elif idx == 1:
		if BgmAudio and not bgm.is_empty():
			BgmAudio.play_audio(bgm)
		if AmbientAudio and not ambiance.is_empty():
			AmbientAudio.play_audio(ambiance)
		
		$AnimationPlayer.play("reveal_room")
		await $AnimationPlayer.animation_finished
