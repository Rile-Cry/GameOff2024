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
	
func anim_finished(name : String):
	if name == "show title":
		animation_player.play("credit_scroll")
