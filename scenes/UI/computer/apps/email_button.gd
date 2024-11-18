class_name EmailButton
extends Button

signal mail_selected(subject)


func _pressed() -> void:
	SfxAudio.play_audio("Mouse Click")
	mail_selected.emit(text)
