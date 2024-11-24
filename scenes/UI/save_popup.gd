extends Control
class_name SavePopup

@export_category("Control Nodes")
@export var close_b : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SfxAudio.play_audio("Popup")
	close_b.pressed.connect(close)
	close_b.disabled = true
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	close_b.disabled = false

func close():
	close_b.disabled = true
	$AnimationPlayer.play_backwards("open")
	await $AnimationPlayer.animation_finished
	queue_free()
