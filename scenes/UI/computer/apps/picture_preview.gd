extends Window

var data := {
	"name": "",
	"address": ""
}

@onready var texture := $PanelContainer/ColorRect/MarginContainer/TextureRect


func _ready() -> void:
	connect("close_requested", _close)


func update() -> void:
	title = data["name"]
	var res : Clue = load("res://Case/" + data["address"]) as Clue
	if texture != null:
		texture.texture = res.texture
		size = res.texture.get_size() / 4


func _close() -> void:
	queue_free()
