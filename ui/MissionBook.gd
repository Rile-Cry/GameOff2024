extends Control

@export var open_b : Button
@export var anim : AnimationPlayer

var is_open = false

func _ready():
	open_b.button_down.connect(open)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		close()

func open():
	if not is_open:
		anim.play("open")
		is_open = true
		open_b.visible = false

func close():
	if is_open:
		anim.play("close")
		is_open = false
		await anim.animation_finished
		open_b.visible = true
