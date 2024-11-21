extends Control

func _ready():
	BgmAudio.play_audio("Title Screen")
	$PlayButton.pressed.connect(play)
	$MainMargin/Credits.pressed.connect(open_credits)
	$MainMargin/Credits.disabled = true

func enable_input():
	if GameManager:
		GameManager.enable_input = true
	
	$MainMargin/Credits.disabled = false

func _input(event: InputEvent) -> void:
	if GameManager.enable_input:
		if event.is_action_pressed("ui_focus_next"):
			$PlayButton.grab_focus()
		elif event.is_action_pressed("ui_focus_prev"):
			$OptionsButton.grab_focus()
			print("option focus")

func play():
	$MainMargin/Credits.disabled = true
	if GameManager:
		GameManager.enable_input = false
	
	$AnimationPlayer.play("play_game")
	
	await $AnimationPlayer.animation_finished
	var game_base : PackedScene = load("res://scenes/UI/main/GameBase.tscn")
	get_tree().change_scene_to_packed(game_base)

func open_credits():
	if UIManager and not UIManager.get_credits().visible:
		UIManager.open_close_credits()
