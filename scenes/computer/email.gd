extends Window

var mails = []

# TODO Add in checkpoints for when certain emails are sent to the player.

@onready var inbox := $PanelContainer/VBoxContainer/Mailbar/TextEdit/MailItems
@onready var mail_content := $PanelContainer/VBoxContainer/Mailbar/VBoxContainer/TextEdit
@onready var mail_vbox := $PanelContainer/VBoxContainer/Mailbar/TextEdit/MailItems

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("close_requested", _close_window)
	read_mails()
	set_inbox()


func _close_window() -> void:
	queue_free()


func read_mails() -> void:
	var file = FileAccess.open("res://scenes/computer/emails.json", FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	for mail in result["mail"]:
		mails.append(mail)


func set_inbox() -> void:
	for mail in mails:
		var mail_item = EmailButton.new()
		inbox.add_child(mail_item)
		mail_item.text = mail["title"]
		mail_item.connect("mail_selected", _update_textbox)


func _update_textbox(mail_title: String) -> void:
	for mail in mails:
		if mail["title"] == mail_title:
			mail_content.text = mail["message"]
