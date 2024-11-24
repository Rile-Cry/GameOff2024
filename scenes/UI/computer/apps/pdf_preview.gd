extends Window

var data := {
	"type": "",
	"name": "",
	"filetype": "",
	"content": "",
	"address": "",
	
}

@onready var text_label := $PanelContainer/TextEdit/MarginContainer/RichTextLabel

func _ready() -> void:
	connect("close_requested", _close)

func update() -> void:
	title = data["name"]
	
	if not data["content"].is_empty():
		text_label.text = data["content"]

func _close() -> void:
	queue_free()
