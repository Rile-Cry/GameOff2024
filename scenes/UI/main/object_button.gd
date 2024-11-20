extends Button
class_name ObjectButton

@export var hover_sfx : String = "Object Hover"
@export var click_sfx : String = "Object Select"
@export var hover_outline_thickness : int = 3

var was_hovering : bool = false

func _ready():
	focus_entered.connect(outline_enable)
	focus_exited.connect(outline_disable)
	if GameManager:
		material = GameManager.outline_material.duplicate()

func _process(_delta: float) -> void:
	if is_hovered():
		outline_enable()
	else:
		outline_disable()

func outline_enable():
	if not was_hovering:
		if not hover_sfx.is_empty():
			SfxAudio.play_audio(hover_sfx)
		was_hovering = true
	
	if GameManager and GameManager.enable_input and material:
		material.set_shader_parameter("line_thickness", hover_outline_thickness)

func outline_disable():
	if was_hovering:
		was_hovering = false
	
	if GameManager and GameManager.enable_input and material:
		material.set_shader_parameter("line_thickness", 0)

func _pressed() -> void:
	if not click_sfx.is_empty():
		SfxAudio.play_audio(click_sfx)
