extends Control

@export var dialogue : String
@export var texture : Texture2D

@onready var _texture_rect := $TextureRect
@onready var _button := $TextureRect/Button


func _dialogue_started() -> void:
	visible = false


func _dialogue_ended() -> void:
	visible = true

func _start_dialogue() -> void:
	var dialogue_scene : DialogueBox = GameManager.create_dialogue(dialogue)
	get_parent().add_child(dialogue_scene)


func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	_button.connect("pressed", _start_dialogue)
	_texture_rect.texture = texture
