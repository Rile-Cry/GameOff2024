extends Button
class_name ObjectButton

@export var hover_sfx : String = "Object Hover"
@export var click_sfx : String = "Object Select"
@export var is_hidden : bool = true
@export var hover_outline_thickness : int = 3

var was_hovering : bool = false

func _ready():
	mouse_default_cursor_shape = CursorShape.CURSOR_POINTING_HAND
	
	if is_hidden:
		if GameManager:
			var particles : GPUParticles2D = GameManager.interactable_indicator_popup.instantiate()
			var process_material : ParticleProcessMaterial = particles.process_material
			var box_size_vec3 : Vector3 = Vector3(size.x, size.y, 1)
			process_material.set_emission_box_extents(box_size_vec3)
			particles.process_material = process_material
			particles.position = size / 2
			add_child(particles)
	else:
		focus_entered.connect(outline_enable)
		focus_exited.connect(outline_disable)
		if GameManager:
			material = GameManager.outline_material.duplicate()

func _process(_delta: float) -> void:
	if not is_hidden:
		if is_hovered():
			outline_enable()
		else:
			outline_disable()

func outline_enable():
	if not (was_hovering or disabled):
		if not hover_sfx.is_empty():
			SfxAudio.play_audio(hover_sfx)
		was_hovering = true
	
		if GameManager and GameManager.enable_input and material:
			material.set_shader_parameter("outline_width", hover_outline_thickness)

func disable():
	disabled = true
	mouse_default_cursor_shape = CursorShape.CURSOR_ARROW
	for child in get_children():
		remove_child(child)

func outline_disable():
	if was_hovering:
		was_hovering = false
	
		if GameManager and GameManager.enable_input and material:
			material.set_shader_parameter("outline_width", 0)

func _pressed() -> void:
	if not click_sfx.is_empty():
		SfxAudio.play_audio(click_sfx)
