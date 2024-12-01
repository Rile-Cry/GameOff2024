extends MissionBookNode
class_name LocationNode

var style_texture_disable : StyleBoxTexture
var index : int

func _ready() -> void:
	super()
	index = GameManager.unlocked_locations.find(resource)
	style_texture_disable = style_texture.duplicate()
	style_texture_disable.modulate_color = Color.from_hsv(0, 0, .5)
	add_theme_stylebox_override("disabled", style_texture_disable)

func _process(_delta: float) -> void:
	if GameManager:
		if GameManager.current_location_index == index and not disabled:
			disabled = true
		if GameManager.current_location_index != index and disabled != resource.disabled:
			disabled = resource.disabled
