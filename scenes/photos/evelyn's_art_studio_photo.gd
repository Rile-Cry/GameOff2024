extends PhotoScene

@onready var shader : ShaderMaterial = $VHS.material

func _ready() -> void:
	super()
	if BgmAudio:
		BgmAudio.play_audio("Evelyn Photo")
	GlobalGameEvents.connect("scene_loaded", _scene_loaded)

func clues_cleared():
	if not cleared:
		if GameManager:
			GameManager.set_global_variable("EvelynArtStudio_all_clues", true)
			GameManager.is_all_true("The Turnabout Case")
			super()

func _scene_loaded() -> void:
	if GameManager.global_variables["tossed_out"]:
		_set_shader_params(0.01, 1.8, 1, 0.1)

func _set_shader_params(wave: float = 0, crease: float = 0, 
		color: float = 0, lines: float = 0) -> void:
	shader.set_shader_parameter("tape_wave_amount", wave)
	shader.set_shader_parameter("tape_crease_amount", crease)
	shader.set_shader_parameter("color_displacement", color)
	shader.set_shader_parameter("lines_velocity", lines)
