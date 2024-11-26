class_name Actor extends Control

@export var actor_name : String
@export var dialogue : Array[String]
@export var initial_mood : String = "normal"

@onready var _texture_rect := $TextureRect
@onready var _button := $TextureRect/Button


func update_actor(texture : Texture2D) -> void:
	_texture_rect.texture = texture

func _dialogue_started() -> void:
	_button.disabled = true


func _dialogue_ended() -> void:
	GameGlobals.wait(1)
	_button.disabled = false

func _start_dialogue() -> void:
	var dialogue_next := ""
	_button.release_focus()
	for title in dialogue:
		if not GameGlobals.dialogue_choices.has(title):
			dialogue_next = title
			break
		elif title.contains("END"):
			dialogue_next = title
			break
		
	var dialogue_scene : DialogueBox = GameManager.create_dialogue(dialogue_next)
	get_parent().add_child(dialogue_scene)


func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	_button.connect("pressed", _start_dialogue)
	var texture : Texture2D = ResourceLoader.load(GameManager.actor_address[actor_name] + initial_mood + ".png", "Texture2D")
	_texture_rect.texture = texture
	add_to_group("actors")
