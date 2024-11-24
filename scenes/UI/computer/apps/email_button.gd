class_name EmailButton
extends Button

signal mail_selected(button)

var id := 0

func _ready() -> void:
	text_overrun_behavior = TextServer.OverrunBehavior.OVERRUN_NO_TRIMMING
	size_flags_horizontal = SizeFlags.SIZE_EXPAND_FILL


func _pressed() -> void:
	SfxAudio.play_audio("Mouse Click")
	mail_selected.emit(self)
