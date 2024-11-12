extends Control

var console_scene := preload("res://scenes/programs/command_prompt.tscn")
var email_scene := preload("res://scenes/programs/email.tscn")
var messenger_scene := preload("res://scenes/programs/msn.tscn")

@export_file(".tscn") var desk_scene : String = ""

var exit_button_popup : PopupMenu

@onready var hotbar := $PanelContainer
@onready var console_button := $Programs/Console
@onready var email_button := $Programs/Email
@onready var messenger_button := $Programs/Messenger
@onready var mysos_menu := $PanelContainer/HBoxContainer/MysOSButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hotbar.custom_minimum_size = Vector2(get_tree().root.get_size_with_decorations().x, 0)
	messenger_button.connect("pressed", _open_messenger)
	console_button.connect("pressed", _open_console)
	email_button.connect("pressed", _open_email)
	exit_button_popup = mysos_menu.get_popup()
	exit_button_popup.connect("id_pressed", _mysos_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _mysos_pressed(num: int) -> void:
	if num == 4:
		_transition()

func _transition() -> void:
	if not desk_scene.is_empty():
		var transition = SceneTransitionManager.Transitions.NoTransition
		SceneTransitionManager.transition_to_scene(desk_scene, false, transition, transition)


func _open_messenger() -> void:
	var messenger = messenger_scene.instantiate()
	add_child(messenger)


func _open_console() -> void:
	var console = console_scene.instantiate()
	add_child(console)


func _open_email() -> void:
	var email = email_scene.instantiate()
	add_child(email)
