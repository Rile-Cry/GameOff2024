class_name ChoiceButton
extends ObjectButton

signal _choice_selected(id)

var id : int = 0

func _ready() -> void:
	click_sfx = ""
	is_hidden = false
	hover_outline_thickness = 0

func _pressed() -> void:
	_choice_selected.emit(id)
	super()
