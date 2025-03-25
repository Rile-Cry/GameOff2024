class_name Actor extends Control

@export_category("Variables")
@export var timeline : DialogicTimeline
@export var actor_name : Genum.Actors

@export_category("References")
@export var texture_rect : TextureRect
@export var button : Button

var was_hovering : bool = false

const hover_sfx : String = "Object Hover"
const hover_outline_thickness : int = 6

func _ready() -> void:
	button.pressed.connect(_start_dialogue_actor)
	button.mouse_entered.connect(_on_mouse_entered)
	button.mouse_exited.connect(_on_mouse_exited)
	
	var texture : Texture2D = ResourceLoader.load(GameGlobals.actor_address[actor_name], "Texture2D")
	texture_rect.texture = texture
	texture_rect.material = GameManager.preloader.outline_material.duplicate()
	add_to_group("actors")

func outline_enable():
	if not (was_hovering or button.disabled):
		if not hover_sfx.is_empty():
			SoundPool.play(hover_sfx)
		was_hovering = true
		if texture_rect.material:
			texture_rect.material.set_shader_parameter("outline_width", hover_outline_thickness)

func outline_disable():
	if was_hovering:
		was_hovering = false
		if texture_rect.material:
			texture_rect.material.set_shader_parameter("outline_width", 0)

func fade_in_actor():
	texture_rect.material = null
	show()
	button.disabled = true
	$AnimationPlayer.play("actor_fade_in")
	await $AnimationPlayer.animation_finished
	button.disabled = false
	texture_rect.material = GameManager.preloader.outline_material.duplicate()

func update_actor(texture : Texture2D) -> void:
	texture_rect.texture = texture

func _on_mouse_entered() -> void:
	if GameManager.enable_input:
		outline_enable()

func _on_mouse_exited() -> void:
	outline_disable()

func _start_dialogue_actor():
	if timeline:
		_start_dialogue(timeline)

func _start_dialogue(dialogue : DialogicTimeline) -> void:
	button.release_focus()
	Dialogic.start(timeline)
