extends Window

var im_scene = preload("res://scenes/programs/im.tscn")

@onready var offline_label := $PanelContainer/VBoxContainer/UserBox/MarginContainer/VBoxContainer/ScrollContainer/UserContainer/OfflineLabel
@onready var user_list := $PanelContainer/VBoxContainer/UserBox/MarginContainer/VBoxContainer/ScrollContainer/UserContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("close_requested", close_requested)
	
	init_online()


func init_online() -> void:
	var ims_file = FileAccess.open("res://scenes/programs/ims.json", FileAccess.READ)
	var ims_content = ims_file.get_as_text()
	var ims_string = JSON.parse_string(ims_content)
	var users = ims_string["users"]
	for user in users:
		var user_button = EmailButton.new()
		user_button.text = user
		if users[user]["status"] == "online":
			var i = offline_label.get_index()
			user_list.add_child(user_button)
			user_list.move_child(offline_label, i + 1)
		else:
			user_list.add_child(user_button)
		user_button.connect("mail_selected", _create_im)

func _create_im(text: String) -> void:
	var im = im_scene.instantiate()
	im.title = text
	get_tree().root.add_child(im)

func check_online() -> void:
	pass

func close_requested() -> void:
	queue_free()
