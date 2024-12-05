extends LocationScene

@export var finale_opening_dialogue : DialogueRes
@export var final_verdict_dialogue : DialogueRes
var finale_initiate : bool = false
var finale_actors : Control

func _process(_delta: float) -> void:
	if is_instance_valid(finale_actors):
		if not finale_initiate:
			for actor_ in finale_actors.get_children():
				if actor_ is ActorFinale:
					actor_ as ActorFinale
					if not actor_.pressed:
						return
			
			finale_initiate = true
			final_verdict_play()

func final_verdict_play():
	if GameManager:
		GameManager.enable_input = false
	
	if UIManager:
		UIManager.confirm_final_verdict.connect(confirm_final_verdict)
		UIManager.anim_player.play("black_bar")
		await UIManager.anim_player.animation_finished
		actor._start_dialogue(final_verdict_dialogue, 0)
		await GlobalGameEvents.dialogue_ended
		if GameManager and GameManager.has_past_attempt():
			UIManager.add_child(GameManager.final_guess_popup.instantiate())
		
	for actor_ in finale_actors.get_children():
		if actor_ is ActorFinale:
			actor_ as ActorFinale
			actor_._button.disabled = false
			actor_.verdict_selected.connect(_select_final_verdict)
	
	if GameManager:
		GameManager.enable_input = true

func confirm_final_verdict():
	if GameManager:
		if UIManager:
			UIManager.mission_book_clue_lock()
		if GameManager.get_verdict():
			if BgmAudio:
				BgmAudio.play_audio("Ending")
			if AmbientAudio:
				AmbientAudio.stop()
			GameManager.enable_input = false
			actor._start_dialogue(final_verdict_dialogue, 1)
			await GlobalGameEvents.dialogue_ended
		GameManager.get_ending()

func _select_final_verdict(name : String):
	if GameManager:
		if GameManager.final_verdict.has(name):
			GameManager.final_verdict.erase(name)
		else:
			GameManager.final_verdict.append(name)
	
	if UIManager:
		UIManager.update_final_verdict_button()

func _ready() -> void:
	if UIManager:
		UIManager.show_shader("vignette")
	
	GlobalGameEvents.connect("scene_loaded", _scene_loaded)
	Dialogic.start("lucas_interrogation")
	if GameManager.global_variables["all_clues"]:
		for idx : int in finale_opening_dialogue.dialogue.size():
			GameManager.enable_input = false
			await dialogue_start_action(idx)
			actor._start_dialogue(finale_opening_dialogue, idx)
			await GlobalGameEvents.dialogue_ended
		GameManager.enable_input = true
		UIManager.can_open_mission_book = false
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
				if BgmAudio and BgmAudio.playing:
					BgmAudio.stop()
				if AmbientAudio and AmbientAudio.playing:
					AmbientAudio.stop()
					
				UIManager.anim_player.play("hide_room")
				finale_actors = GameManager.finale_actors.instantiate()
				add_child(finale_actors)
				await UIManager.anim_player.animation_finished
				
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
