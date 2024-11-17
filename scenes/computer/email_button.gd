class_name EmailButton
extends Button

signal mail_selected(subject)


func _pressed() -> void:
	SfxAudio.play_sfx("Mouse Click")
	mail_selected.emit(text)
