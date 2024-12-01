class_name Actor extends Control

@export var dialogue_res : DialogueRes

@onready var _texture_rect : TextureRect = $TextureRect
@onready var _button : Button = $TextureRect/Button

var was_hovering : bool = false

const hover_sfx : String = "Object Hover"
const hover_outline_thickness : int = 6

func fade_in_actor():
	_texture_rect.material = null
	show()
	_button.disabled = true
	$AnimationPlayer.play("actor_fade_in")
	await $AnimationPlayer.animation_finished
	_button.disabled = false
	_texture_rect.material = GameManager.outline_material.duplicate()

func update_actor(texture : Texture2D) -> void:
	_texture_rect.texture = texture

func _dialogue_started() -> void:
	_button.disabled = true

func _dialogue_ended() -> void:
	GameGlobals.wait(1)
	_button.disabled = false

func _start_dialogue_actor():
	_start_dialogue(dialogue_res)

func _start_dialogue(dialogue : DialogueRes, idx : int = -1) -> void:
	var dialogue_next : String = ""
	_button.release_focus()
	
	if idx == -1:
		for title in dialogue.dialogue:
			var title_tweak := dialogue.location_name + "/" + title
			if not GameGlobals.dialogue_choices.has(title_tweak):
				dialogue_next = title_tweak
				break
			elif title.contains("END"):
				dialogue_next = title_tweak
				break
	else:
		dialogue_next = dialogue.location_name + "/" + dialogue.dialogue[idx]
	
	var variables : Dictionary = {}
	
	for global_variable : String in dialogue.global_variables:
		if GameManager.get_global_variable(global_variable) == null:
			GameManager.set_global_variable(global_variable, false)
		
		variables[global_variable] = GameManager.get_global_variable(global_variable)
	
	var dialogue_scene : DialogueBox = GameManager.create_dialogue(dialogue_next, dialogue.initial_mood, variables)
	UIManager.add_child(dialogue_scene)

func _process(_delta: float) -> void:
	if _button.is_hovered() and not _button.disabled:
		outline_enable()
	else:
		outline_disable()

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	_button.connect("pressed", _start_dialogue_actor)
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
