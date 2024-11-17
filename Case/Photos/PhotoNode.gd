extends Button
class_name PhotoNode

@export var photo_res : Photo

var MouseOver : bool = false
var style_texture : StyleBoxTexture
var style_texture_hover : StyleBoxTexture
signal is_hovering(photo : Photo)
signal is_not_hovering(photo : Photo)

func _ready() -> void:
	style_texture = StyleBoxTexture.new()
	style_texture.texture = photo_res.photo_texture
	style_texture.set_texture_margin_all(2)
	add_theme_stylebox_override("normal", style_texture)
	
	style_texture_hover = style_texture.duplicate()
	style_texture_hover.set_texture_margin_all(0)
	add_theme_stylebox_override("hover", style_texture_hover)
	
	size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
	custom_minimum_size.y = 120
	
	mouse_entered.connect(hover)
	mouse_exited.connect(un_hover)
	pressed.connect(interact)

func interact():
	if photo_res.is_location and UIManager:
		UIManager.get_mission_book().photo_jump(photo_res.scene)

func hover() -> void:
	MouseOver = true
	is_hovering.emit(photo_res)

func un_hover() -> void:
	MouseOver = false
	is_not_hovering.emit(photo_res)
