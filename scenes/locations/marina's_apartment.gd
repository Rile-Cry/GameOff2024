extends LocationScene

@export var opening_dialogue_photo : DialogueRes
@export var opening_dialogue_end : DialogueRes

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	
	actor.hide()
	
	if opening_dialogue:
		if GameManager:
			GameManager.enable_input = false
			if GameManager.get_global_variable("met_" + opening_dialogue.actor_name) != null:
				actor.show()
				play_bgm_ambiance()
				print(GameManager.get_global_variable("marina_photo"))
				if GameManager.get_global_variable("marina_photo"):
					for idx : int in opening_dialogue_end.dialogue.size():
						GameManager.enable_input = false
						actor._start_dialogue(opening_dialogue_end, idx)
						await GlobalGameEvents.dialogue_ended
				else:
					for idx : int in opening_dialogue_photo.dialogue.size():
						GameManager.enable_input = false
						actor._start_dialogue(opening_dialogue_photo, idx)
						await GlobalGameEvents.dialogue_ended
			else:
				GameManager.set_global_variable("met_" + opening_dialogue.actor_name, instant_meet)
				for idx : int in opening_dialogue.dialogue.size():
					GameManager.enable_input = false
					await dialogue_start_action(idx)
					actor._start_dialogue(opening_dialogue, idx)
					await GlobalGameEvents.dialogue_ended
		await dialogue_ended
		GameManager.enable_input = true
		GameManager.current_location_index = 0

func play_bgm_ambiance():
	if BgmAudio and not bgm.is_empty():
		BgmAudio.play_audio(bgm)
	if AmbientAudio and not ambiance.is_empty():
		AmbientAudio.play_audio(ambiance)

func dialogue_start_action(idx : int):
	if idx == 0:
		if BgmAudio and BgmAudio.playing:
			BgmAudio.stop()
		if AmbientAudio and AmbientAudio.playing:
			AmbientAudio.stop()
		
		$AnimationPlayer.play("hide_room")
		await $AnimationPlayer.animation_finished
		
		if SfxAudio:
			SfxAudio.play_audio("Door Knock")
			await get_tree().create_timer(2.1).timeout
	elif idx == 1:
		if SfxAudio:
			SfxAudio.play_audio("Door Open")
		$AnimationPlayer.play("open_door")
		await $AnimationPlayer.animation_finished
	elif idx == 2:
		actor.show()
