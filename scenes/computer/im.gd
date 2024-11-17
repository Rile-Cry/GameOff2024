extends Window

# TODO Implement Messaging system, prolly will use a json to read from and a number to keep track.

var user_data = {}

@onready var address := $PanelContainer/VBoxContainer/Address
@onready var label := $PanelContainer/VBoxContainer/Label
@onready var text_box := $PanelContainer/VBoxContainer/TextEdit

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	setup()
	connect("close_requested", _close_window)


func setup() -> void:
	grab_user()
	
	var long_string = ""
	for message in user_data["messages"]:
		long_string += (message["message"] + "\n")
	
	address.text = user_data["address"]
	label.text = user_data["messages"][user_data["messages"].size() - 1]["date"]
	text_box.text = long_string


func grab_user() -> void:
	var file = FileAccess.open("res://scenes/computer/ims.json", FileAccess.READ)
	var file_content = file.get_as_text()
	var json_string = JSON.parse_string(file_content)
	
	user_data = json_string["users"][title]


func _close_window() -> void:
	queue_free()
