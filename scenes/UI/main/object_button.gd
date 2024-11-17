extends Button
class_name ObjectButton

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
	
	if GameManager and not GameManager.enable_input:
		material.set_shader_parameter("line_thickness", 0)

func outline_enable():
	if GameManager and GameManager.enable_input:
		material.set_shader_parameter("line_thickness", 3)

func outline_disable():
	if GameManager and GameManager.enable_input:
		material.set_shader_parameter("line_thickness", 0)
