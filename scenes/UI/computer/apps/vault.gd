extends Window


@onready var button := $PanelContainer/VBoxContainer/Button
@onready var text := $PanelContainer/VBoxContainer/LineEdit


func _ready() -> void:
	connect("close_requested", _close)
	button.connect("pressed", _check_code)


func _check_code() -> void:
	match text.text:
		"secretcode":
			print("Oh no, you found our secret . . . shame on you -_-")
		"allclues":
			GameManager.global_variables["all_clues"] = true
		_:
			print("That's not a correct code, now is it.")


func _close() -> void:
	queue_free()
