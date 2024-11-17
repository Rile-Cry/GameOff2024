extends Control

var game_base : PackedScene  = preload("res://scenes/GameBase.tscn")

func _ready():
	$PlayButton.pressed.connect(play)

func enable_input():
	if GameManager:
		GameManager.enable_input = true

func _input(event: InputEvent) -> void:
	if GameManager.enable_input:
		if event.is_action_pressed("ui_focus_next"):
			$PlayButton.grab_focus()
		elif event.is_action_pressed("ui_focus_prev"):
			$OptionsButton.grab_focus()
			print("option focus")

func play():
	if GameManager:
		GameManager.enable_input = false
	
	$AnimationPlayer.play("play_game")
	
	await $AnimationPlayer.animation_finished
	
	get_tree().change_scene_to_packed(game_base)
