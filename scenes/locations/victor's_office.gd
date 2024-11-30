extends LocationScene

@export var opening_dialogue_victor : DialogueRes
@export var objects : Array[Button]

func dialogue_start_action(idx : int):
	if idx == 0:
		if BgmAudio and BgmAudio.playing:
			BgmAudio.stop()
		if AmbientAudio and AmbientAudio.playing:
			AmbientAudio.stop()
		
		if UIManager:
			UIManager.anim_player.play("hide_room")
			await UIManager.anim_player.animation_finished
			
			if SfxAudio:
				SfxAudio.play_audio("Door Open")
			UIManager.anim_player.play("reveal_room")
			await UIManager.anim_player.animation_finished

func _process(_delta: float) -> void:
	if not GameManager.get_global_variable("met_" + opening_dialogue.actor_name):
		for object : ObjectResourceButton in objects:
			if not object.disabled:
				return
		
		clues_cleared()

func clues_cleared():
	pass
