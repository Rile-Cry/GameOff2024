extends Button
class_name MissionBookNode

@export var resource : Resource

var MouseOver : bool = false
var style_texture : StyleBoxTexture
var style_texture_hover : StyleBoxTexture
signal is_hovering(res : Resource)
signal is_not_hovering(res : Resource)

func _ready() -> void:
	focus_mode = FOCUS_NONE
	style_texture = StyleBoxTexture.new()
	style_texture.texture = resource.texture_icon
	style_texture.set_texture_margin_all(2)
	add_theme_stylebox_override("normal", style_texture)
	add_theme_stylebox_override("pressed", style_texture)
	
	style_texture_hover = style_texture.duplicate()
	style_texture_hover.set_texture_margin_all(0)
	add_theme_stylebox_override("hover", style_texture_hover)
	add_theme_stylebox_override("focus", style_texture_hover)
	
	size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
	custom_minimum_size.y = 76
	
	mouse_entered.connect(hover)
	mouse_exited.connect(un_hover)

func hover() -> void:
	MouseOver = true
	is_hovering.emit(resource)
	var volume_db := 0.0
	if disabled:
		volume_db = -10.0
	SfxAudio.play_audio("Object Hover", volume_db)

func un_hover() -> void:
	MouseOver = false
	is_not_hovering.emit(resource)
