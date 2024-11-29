class_name Actor extends Control

@export var dialogue_res : DialogueRes
@export var global_variables : Array[String]

@onready var _texture_rect : TextureRect = $TextureRect
@onready var _button : Button = $TextureRect/Button

var was_hovering : bool = false

const hover_sfx : String = "Object Hover"
const hover_outline_thickness : int = 6

signal next_line(text : String, tags)

func update_actor(texture : Texture2D) -> void:
	_texture_rect.texture = texture

func _dialogue_started() -> void:
	_button.disabled = true

func _dialogue_ended() -> void:
	GameGlobals.wait(1)
	_button.disabled = false

func _start_dialogue(dialogue_next : String = "") -> void:
	_button.release_focus()
	
	if dialogue_next.is_empty():
		for title in dialogue_res.dialogue:
			var title_tweak := dialogue_res.location_name + "/" + title
			if not GameGlobals.dialogue_choices.has(title_tweak):
				dialogue_next = title_tweak
				break
			elif title.contains("END"):
				dialogue_next = title_tweak
				break
	else:
		dialogue_next = dialogue_res.location_name + "/" + dialogue_next
	
	var variables : Dictionary = {}
	
	for global_variable : String in global_variables:
		if GameManager.get_global_variable(global_variable) == null:
			GameManager.set_global_variable(global_variable, false)
		
		variables[global_variable] = GameManager.get_global_variable(global_variable)
	
	var dialogue_scene : DialogueBox = GameManager.create_dialogue(dialogue_next, variables)
	dialogue_scene.next_line.connect(func(text : String, tags): next_line.emit(text, tags))
	get_parent().add_child(dialogue_scene)

func _process(_delta: float) -> void:
	if _button.is_hovered() and not _button.disabled:
		outline_enable()
	else:
		outline_disable()

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	_button.connect("pressed", _start_dialogue)
	var texture : Texture2D = ResourceLoader.load(GameManager.actor_address[dialogue_res.actor_name] + dialogue_res.initial_mood + ".png", "Texture2D")
	_texture_rect.texture = texture
	_texture_rect.material = GameManager.outline_material.duplicate()
	add_to_group("actors")

func outline_enable():
	if not (was_hovering or _button.disabled):
		if not hover_sfx.is_empty():
			SfxAudio.play_audio(hover_sfx)
		was_hovering = true
	
		if _texture_rect.material:
			_texture_rect.material.set_shader_parameter("outline_width", hover_outline_thickness)

func outline_disable():
	if was_hovering:
		was_hovering = false
	
		if _texture_rect.material:
			_texture_rect.material.set_shader_parameter("outline_width", 0)
