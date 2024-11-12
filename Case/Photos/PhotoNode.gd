extends Panel
class_name PhotoNode

@export var photo_res : Photo

var MouseOver : bool = false
var style_texture : StyleBoxTexture

func _input(event):
	if event is InputEventMouseButton and MouseOver:
		GameManager.change_scene(photo_res.scene)

func _ready() -> void:
	style_texture = StyleBoxTexture.new()
	style_texture.texture = photo_res.texture
	add_theme_stylebox_override("panel", style_texture)
	size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL
	custom_minimum_size.y = 120
	mouse_entered.connect(hover)
	mouse_exited.connect(un_hover)

func hover() -> void:
	MouseOver = true

func un_hover() -> void:
	MouseOver = false
