extends Window


@onready var button := $PanelContainer/VBoxContainer/Button
@onready var text := $PanelContainer/VBoxContainer/LineEdit


func _ready() -> void:
	connect("close_requested", _close)
	button.connect("pressed", _check_code)


func _check_code() -> void:
	match text.text:
		"allcodes":
			print("Sorry, that code hasn't been implemented yet.")
		"secretcode":
			print("Oh no, you found our secret . . . shame on you -_-")
		_:
			print("That's not a correct code, now is it.")


func _close() -> void:
	queue_free()
