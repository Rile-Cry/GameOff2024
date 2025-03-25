extends Control

@export var credits_button : Button
@export var delete_save_button : Button

var game_base : PackedScene = preload("res://scenes/UI/main/GameBase.tscn")

func _ready():
	MusicManager.play_music("Title Screen")
	$PlayButton.pressed.connect(play)
	credits_button.disabled = true
	delete_save_button.visible = GameManager.get_save()
	delete_save_button.disabled = true

func _process(_delta: float) -> void:
	if UIManager:
		if UIManager.get_mission_book_button().visible:
			UIManager.enable_disable_mission_book_button()

func _input(event: InputEvent) -> void:
	if GameManager.enable_input:
		if event.is_action_pressed("ui_focus_next"):
			$PlayButton.grab_focus()
		elif event.is_action_pressed("ui_focus_prev"):
			$OptionsButton.grab_focus()

func enable_input():
	if GameManager:
		GameManager.enable_input = true
	
	credits_button.disabled = false
	delete_save_button.disabled = false

func delete_save():
	if UIManager and GameManager:
		var popup : PopupNode = GameManager.preloader.delete_save_popup.instantiate()
		UIManager.add_child(popup)
		await popup.popup_closed
		delete_save_button.visible = GameManager.get_save()

func play():
	credits_button.disabled = true
	if GameManager:
		GameManager.enable_input = false
	
	$AnimationPlayer.play("play_game")
	
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_packed(game_base)

func open_credits():
	if UIManager and not UIManager.get_credits().visible:
		UIManager.open_close_credits()
