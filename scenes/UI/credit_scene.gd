extends Control

@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation_player.animation_finished.connect(anim_finished)
	if BgmAudio:
		BgmAudio.play_audio("Title Screen")
	
	if AmbientAudio:
		AmbientAudio.stop()
	
	if SfxAudio:
		SfxAudio.stop()
	if UIManager:
		UIManager.anim_player.play_backwards("white_out")
		await UIManager.anim_player.animation_finished
	$AnimationPlayer.play("show title")

func _input(event: InputEvent) -> void:
	if $AnimationPlayer.is_playing() and event.is_action_pressed("ui_accept"):
		$AnimationPlayer.speed_scale = 3
	elif event.is_action_released("ui_accept"):
		$AnimationPlayer.speed_scale = 1
	
func anim_finished(name : String):
	if name == "show title":
		animation_player.play("credit_scroll")
	if name == "credit_scroll":
		GameManager.record_attempt(true)
