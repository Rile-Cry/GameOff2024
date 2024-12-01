extends Control

var email_scene := preload("res://scenes/UI/computer/apps/email.tscn")
var messenger_scene := preload("res://scenes/UI/computer/apps/MSN.tscn")
var note_scene := preload("res://scenes/UI/computer/apps/note.tscn")
var vault_scene := preload("res://scenes/UI/computer/apps/vault.tscn")

var exit_button_popup : PopupMenu

@onready var vault_button := $Programs/Vault
@onready var email_button := $Programs/Email
@onready var messenger_button := $Programs/Messenger
@onready var mysos_menu := $Hotbar/HBoxContainer/MysOSButton
@onready var programs := $Programs

signal close_computer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	messenger_button.connect("pressed", _open_messenger)
	email_button.connect("pressed", _open_email)
	vault_button.connect("pressed", _open_vault)
	exit_button_popup = mysos_menu.get_popup()
	mysos_menu.connect("pressed", mouse_click_sfx)
	exit_button_popup.connect("id_pressed", _mysos_pressed)

func _process(_delta: float) -> void:
	if $Programs/Email/Notification.visible and GameManager:
		var email_loc : Dictionary = GameManager.get_global_variable("email_locations")
		$Programs/Email/Notification.visible = not email_loc.is_empty()

func mouse_click_sfx():
	SfxAudio.play_audio("Mouse Click")

func _mysos_pressed(num: int) -> void:
	mouse_click_sfx()
	if num == 4 and UIManager:
		UIManager.open_close_computer()
		close_computer.emit()
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

#func update_notes() -> void:
#	for note in GameGlobals.dialogue_choices.keys():
#		var button := EmailButton.new()
#		programs.add_child(button)
#		button.text = note
#		button.connect("mail_selected", _open_note)

func _open_note(button: EmailButton) -> void:
	var note : NoteWindow = note_scene.instantiate()
	note.file_name = button.text
	add_child(note)
