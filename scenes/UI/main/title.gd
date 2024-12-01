extends Control

var game_base : PackedScene = preload("res://scenes/UI/main/GameBase.tscn")

func _ready():
	BgmAudio.play_audio("Title Screen")
	$PlayButton.pressed.connect(play)
	$MainMargin/HBoxContainer/Credits.pressed.connect(open_credits)
	$MainMargin/HBoxContainer/Credits.disabled = true
	$"MainMargin/HBoxContainer/Delete Save".visible = GameManager.get_save()
	$"MainMargin/HBoxContainer/Delete Save".disabled = true
	$"MainMargin/HBoxContainer/Delete Save".pressed.connect(delete_save)

func delete_save():
	if UIManager and GameManager:
		var popup : PopupNode = GameManager.delete_save_popup.instantiate()
		UIManager.add_child(popup)
		await popup.popup_closed
		$"MainMargin/HBoxContainer/Delete Save".visible = GameManager.get_save()

func enable_input():
	if GameManager:
		GameManager.enable_input = true
	
	$MainMargin/HBoxContainer/Credits.disabled = false
	$"MainMargin/HBoxContainer/Delete Save".disabled = false

func _input(event: InputEvent) -> void:
	if GameManager.enable_input:
		if event.is_action_pressed("ui_focus_next"):
			$PlayButton.grab_focus()
		elif event.is_action_pressed("ui_focus_prev"):
			$OptionsButton.grab_focus()

func play():
	$MainMargin/HBoxContainer/Credits.disabled = true
	if GameManager:
		GameManager.enable_input = false
	
	$AnimationPlayer.play("play_game")
	
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(game_base)

func open_credits():
	if UIManager and not UIManager.get_credits().visible:
		UIManager.open_close_credits()

func _process(_delta: float) -> void:
	if UIManager:
		if UIManager.get_mission_book_button().visible:
			UIManager.enable_disable_mission_book_button()
