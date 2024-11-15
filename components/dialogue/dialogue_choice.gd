class_name ChoiceButton
extends Button

signal _choice_selected(id)

var id : int = 0

func _pressed() -> void:
	_choice_selected.emit(id)
