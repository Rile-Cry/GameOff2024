class_name EmailButton
extends Button

signal mail_selected(subject)


func _pressed() -> void:
	mail_selected.emit(text)
