class_name Actor extends Control

@export_category("Variables")
@export var timeline : DialogicTimeline
@export var actor_name : Genum.Actors

@export_category("References")
@export var _texture_rect : TextureRect
@export var _button : Button

var was_hovering : bool = false

const hover_sfx : String = "Object Hover"
const hover_outline_thickness : int = 6

func _ready() -> void:
	Dialogic.timeline_started.connect(_dialogue_started)
	Dialogic.timeline_ended.connect(_dialogue_ended)
	_button.connect("pressed", _start_dialogue_actor)
	var texture : Texture2D = ResourceLoader.load(GameManager.actor_address[actor_name], "Texture2D")
	_texture_rect.texture = texture
	_texture_rect.material = GameManager.preloader.outline_material.duplicate()
	add_to_group("actors")

func _process(_delta: float) -> void:
	if _button.is_hovered() and not _button.disabled and GameManager.enable_input:
		outline_enable()
	else:
		outline_disable()

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

func fade_in_actor():
	_texture_rect.material = null
	show()
	_button.disabled = true
	$AnimationPlayer.play("actor_fade_in")
	await $AnimationPlayer.animation_finished
	_button.disabled = false
	_texture_rect.material = GameManager.preloader.outline_material.duplicate()

func update_actor(texture : Texture2D) -> void:
	_texture_rect.texture = texture

func _dialogue_started() -> void:
	_button.disabled = true

func _dialogue_ended() -> void:
	GameGlobals.wait(1)
	_button.disabled = false

func _start_dialogue_actor():
	if timeline:
		_start_dialogue(timeline)

func _start_dialogue(dialogue : DialogicTimeline) -> void:
	_button.release_focus()
	
	Dialogic.start(timeline)
