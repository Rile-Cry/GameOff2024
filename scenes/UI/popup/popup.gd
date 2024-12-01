extends Control
class_name PopupNode

signal popup_opened
signal popup_closed

@export_category("Control Nodes")
@export var close_b : Button
@export var close_b_bottom : Button

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager:
		GameManager.enable_input = false
	if SfxAudio:
		SfxAudio.play_audio("Popup")
	
	if close_b:
		close_b.pressed.connect(close)
		close_b.disabled = true
	
	if close_b_bottom:
		close_b_bottom.pressed.connect(close)
		close_b_bottom.disabled = true
	
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	popup_opened.emit()
	if close_b:
		close_b.disabled = false
	if close_b_bottom:
		close_b_bottom.disabled = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		close()

func close():
	if close_b:
		close_b.disabled = true
	if close_b_bottom:
		close_b_bottom.disabled = true
	
	$AnimationPlayer.play_backwards("open")
	await $AnimationPlayer.animation_finished
	popup_closed.emit()
	if GameManager:
		GameManager.enable_input = true
	queue_free()
