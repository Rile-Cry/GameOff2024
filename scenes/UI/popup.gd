extends Control
class_name PopupNode

signal popup_closed

@export_category("Control Nodes")
@export var close_b : Button
@export var close_b_bottom : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager:
		GameManager.enable_input = false
	SfxAudio.play_audio("Popup")
	close_b.pressed.connect(close)
	close_b_bottom.pressed.connect(close)
	
	close_b.disabled = true
	close_b_bottom.disabled = true
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	close_b.disabled = false
	close_b_bottom.disabled = false

func close():
	close_b.disabled = true
	close_b_bottom.disabled = true
	$AnimationPlayer.play_backwards("open")
	await $AnimationPlayer.animation_finished
	if GameManager:
		GameManager.enable_input = true
	popup_closed.emit()
	queue_free()
