extends Window

var picture_window := preload("res://scenes/UI/computer/apps/picture_preview.tscn")

var mails = []
var current_mail := 0

# TODO Add in checkpoints for when certain emails are sent to the player.

@onready var inbox := $PanelContainer/VBoxContainer/Mailbar/TextEdit/MarginContainer/MailItems
@onready var mail_address := $PanelContainer/VBoxContainer/Mailbar/VBoxContainer/Address
@onready var mail_content := $PanelContainer/VBoxContainer/Mailbar/VBoxContainer/ScrollContainer/Content
@onready var mail_subject := $PanelContainer/VBoxContainer/Mailbar/VBoxContainer/Subject
@onready var attachment_bar := $PanelContainer/VBoxContainer/Mailbar/VBoxContainer/HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("close_requested", _close_window)
	read_mails()
	set_inbox()


func _close_window() -> void:
	queue_free()


func read_mails() -> void:
	var file = FileAccess.open("res://scenes/UI/computer/data/emails.json", FileAccess.READ)
	var content = file.get_as_text()
	var result = JSON.parse_string(content)
	for mail in result["mail"]:
		mails.append(mail)


func set_inbox() -> void:
	var i = 0
	for mail in mails:
		var mail_item = EmailButton.new()
		inbox.add_child(mail_item)
		mail_item.text = mail["title"]
		mail_item.size.x = 100
		mail_item.id = i
		mail_item.connect("mail_selected", _update_textbox)
		i += 1


func _update_textbox(button: EmailButton) -> void:
	var i = 0
	for mail in mails:
		if mail["title"] == button.text:
			mail_address.text = mail["user"]
			mail_subject.text = mail["title"]
			mail_content.text = mail["message"]
			for child in attachment_bar.get_children():
				if child.name != "Send":
					attachment_bar.remove_child(child)
			var attachments = mail["attachments"]
			for attachment in attachments:
				var attach_button = EmailButton.new()
				attach_button.text = attachment["name"]
				attachment_bar.add_child(attach_button)
				attach_button.id = i
				attach_button.connect("mail_selected", _open_picture)
				i += 1


func _open_picture(button: EmailButton) -> void:
	var picture = picture_window.instantiate()
	picture.title = button.text
	picture.data = mails[current_mail]["attachments"][button.id]
	get_tree().root.add_child(picture)
	picture.update()
