extends LocationScene

const unfinished_painting_path : String = "res://Case/Clues/Evelyn's Art Studio/Unfinished Painting.tres"

var unfinished_painting : Clue
var clue_popup : CluePopup
var music_volume_db : float = 0.0

func _ready() -> void:
	if UIManager:
		UIManager.show_shader("vignette")
	
	unfinished_painting = load(unfinished_painting_path)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	
	actor.hide()
	
	if opening_dialogue != "":
		Dialogic.start(opening_dialogue)
		#for idx : int in opening_dialogue.dialogue.size():
		#	GameManager.enable_input = false
		#	await dialogue_start_action(idx)
		#	actor._start_dialogue(opening_dialogue, idx)
		#	await GlobalGameEvents.dialogue_ended
		#GameManager.enable_input = true
		
	if UIManager:
		UIManager.anim_player.play("white_out")
		await UIManager.anim_player.animation_finished
		clue_popup.close()
		var tween : Tween = create_tween()
		tween.tween_property(self, "music_volume_db", -80, 2)
		tween.set_trans(Tween.TRANS_LINEAR)
		tween.play()
		await tween.finished
		get_tree().change_scene_to_packed(GameManager.credits_scene)

func _process(delta: float) -> void:
	if BgmAudio and not bgm.is_empty():
		BgmAudio.play_audio(bgm, music_volume_db)
	if AmbientAudio and not ambiance.is_empty():
		AmbientAudio.play_audio(ambiance, music_volume_db)

func _notification(what):
	if (what == NOTIFICATION_PREDELETE):
		if UIManager:
			UIManager.hide_shader("vignette")
	
func dialogue_start_action(idx : int):
	if idx == 0:
		if UIManager:
			UIManager.anim_player.play("hide_room")
			await UIManager.anim_player.animation_finished
			actor.show()
			
			UIManager.anim_player.play("reveal_room")
			await UIManager.anim_player.animation_finished
	elif idx == 1:
		if UIManager:
			clue_popup = GameManager.clue_popup.instantiate()
			clue_popup.clue = unfinished_painting
			UIManager.add_child(clue_popup)
			await clue_popup.popup_opened
