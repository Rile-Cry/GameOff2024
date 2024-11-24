extends Control

var email_scene := preload("res://scenes/UI/computer/apps/email.tscn")
var messenger_scene := preload("res://scenes/UI/computer/apps/MSN.tscn")
var vault_scene := preload("res://scenes/UI/computer/apps/vault.tscn")

var exit_button_popup : PopupMenu

@onready var hotbar := $PanelContainer
@onready var vault_button := $Programs/Vault
@onready var notepad_button := $Programs/Notepad
@onready var email_button := $Programs/Email
@onready var email_notif := $Programs/Email/Notification
@onready var messenger_button := $Programs/Messenger
@onready var messenger_notif := $Programs/Messenger/Notification
@onready var mysos_menu := $PanelContainer/HBoxContainer/MysOSButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hotbar.custom_minimum_size = Vector2(get_tree().root.get_size_with_decorations().x, 0)
	messenger_button.connect("pressed", _open_messenger)
	email_button.connect("pressed", _open_email)
	vault_button.connect("pressed", _open_vault)
	exit_button_popup = mysos_menu.get_popup()
	mysos_menu.connect("pressed", mouse_click_sfx)
	exit_button_popup.connect("id_pressed", _mysos_pressed)

func mouse_click_sfx():
	SfxAudio.play_audio("Mouse Click")

func _mysos_pressed(num: int) -> void:
	mouse_click_sfx()
	if num == 4 and UIManager:
		for child in self.get_children():
			if child is Window:
				child.queue_free()
		UIManager.open_close_computer()
		GameManager.add_resource_from_stack()

func _open_messenger() -> void:
	var messenger = messenger_scene.instantiate()
	mouse_click_sfx()
	add_child(messenger)

func _open_email() -> void:
	var email = email_scene.instantiate()
	mouse_click_sfx()
	add_child(email)

func _open_vault() -> void:
	var vault = vault_scene.instantiate()
	mouse_click_sfx()
	add_child(vault)
