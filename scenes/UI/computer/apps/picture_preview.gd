extends Window

var data := {
	"type": "",
	"name": "",
	"filetype": "",
	"address": "",
}

@onready var texture := $PanelContainer/ColorRect/MarginContainer/TextureRect


func _ready() -> void:
	connect("close_requested", _close)


func update() -> void:
	title = data["name"]
	var res
	var texture_value : Texture2D
	res = ResourceLoader.load("res://Case/" + data["address"], "Photo")
	texture_value = res.texture
	
	if texture != null:
		texture.texture = texture_value
		size = texture_value.get_size() / 4


func _close() -> void:
	queue_free()
