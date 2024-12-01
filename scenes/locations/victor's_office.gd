extends LocationScene

@export var victor_kick_dialogue : DialogueRes
@export var opening_dialogue_victor : DialogueRes
@export var objects : Array[Button]

var kicking : bool = false

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
	elif idx == 2:
		await actor.fade_in_actor()

func _get_clue_location(clue : Clue) -> bool:
	if GameManager.get_global_variable("met_" + opening_dialogue.actor_name):
		if await super(clue):
			GameManager.set_global_variable("victor_clues", _check_if_all_clues_interacted())
			return true
	return false

func _process(_delta: float) -> void:
	if not GameManager.get_global_variable("met_" + opening_dialogue.actor_name):
		for object : ObjectResourceButton in objects:
			if not object.disabled:
				return
		
		clues_cleared()
	
	if not kicking:
		if GameManager.get_global_variable("victor_marina"):
			kicking = true
			await dialogue_ended
			for idx : int in victor_kick_dialogue.dialogue.size():
				GameManager.enable_input = false
				actor._start_dialogue(victor_kick_dialogue, idx)
				await GlobalGameEvents.dialogue_ended
			GameManager.current_location.disabled = true
			
			if UIManager: UIManager.refresh_mission_book()
			GameManager.current_location_index = 0
			GameManager.enable_input = true

func disable_all_buttons():
	for child in get_children():
		if child is Button:
			child as Button
			child.disabled = true

func clues_cleared():
	disable_all_buttons()
	if not GameManager.get_global_variable("met_" + opening_dialogue.actor_name):
		GameManager.set_global_variable("met_" + opening_dialogue.actor_name, true)
		for idx : int in opening_dialogue_victor.dialogue.size():
			GameManager.enable_input = false
			await dialogue_start_action(idx + 1)
			actor._start_dialogue(opening_dialogue_victor, idx)
			await GlobalGameEvents.dialogue_ended
		GameManager.enable_input = true
