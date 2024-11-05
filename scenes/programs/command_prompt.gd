extends Window

var current_line : String = ""
var lines : Array[String] = [
	"Microsoft Windows XP [Version 5.1.2600]",
	"(C) Copyright 1985-2001 Microsoft Corp.",
	"",
	"C:> ",
]

# TODO Change up the console to be more like MNS

@onready var _text_box := $"PanelContainer/MarginContainer/VBoxContainer/TextEdit"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_text_box.connect("caret_changed", caret_changed)
	_text_box.connect("text_changed", text_changed)
	_text_box.caret_blink = true


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("return"):
		lines.append("C:> ")
		current_line = lines[lines.size() - 1]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	update_console()


func update_console() -> void:
	var long_string = ""
	var i = 0
	for line in lines:
		long_string += line
		if i < (lines.size() - 1):
			long_string += "\n"
		i += 1
	_text_box.text = long_string

# Signal Handlers
func caret_changed() -> void:
	_text_box.set_caret_line(lines.size() - 1)
	_text_box.set_caret_column(lines[lines.size() - 1].length() - 1)


func text_changed() -> void:
	current_line = _text_box.get_line(lines.size() - 1)
	lines[lines.size() - 1] = current_line
