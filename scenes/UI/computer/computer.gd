extends Control

var console_scene := preload("res://scenes/UI/computer/apps/command_prompt.tscn")
var email_scene := preload("res://scenes/UI/computer/apps/email.tscn")
var messenger_scene := preload("res://scenes/UI/computer/apps/MSN.tscn")

var exit_button_popup : PopupMenu

@onready var hotbar := $PanelContainer
@onready var console_button := $Programs/Console
@onready var notepad_button := $Programs/Notepad
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
	mysos_menu.connect("pressed", mouse_click_sfx)
	exit_button_popup.connect("id_pressed", _mysos_pressed)

func mouse_click_sfx():
	SfxAudio.play_sfx("Mouse Click")

func _mysos_pressed(num: int) -> void:
	if num == 4 and UIManager:
		mouse_click_sfx()
		UIManager.open_close_computer()
	else:
		SfxAudio.play_sfx("Mouse Click Fail")

func _open_messenger() -> void:
	var messenger = messenger_scene.instantiate()
	mouse_click_sfx()
	add_child(messenger)


func _open_console() -> void:
	var console = console_scene.instantiate()
	mouse_click_sfx()
	add_child(console)


func _open_email() -> void:
	var email = email_scene.instantiate()
	mouse_click_sfx()
	add_child(email)