extends Control


@onready var _vignette := $Vignette


func _dialogue_started() -> void:
	_vignette.visible = true

func _dialogue_ended() -> void:
	_vignette.visible = false

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
