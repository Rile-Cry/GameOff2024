extends Window

# TODO Move user statuses to Globals
var users:= {
	"Marcus": [true, null],
	"Paula": [true, null],
	"Jingo": [false, null],
}

@onready var offline_label := $PanelContainer/VBoxContainer/UserBox/MarginContainer/VBoxContainer/ScrollContainer/UserContainer/OfflineLabel
@onready var user_list := $PanelContainer/VBoxContainer/UserBox/MarginContainer/VBoxContainer/ScrollContainer/UserContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("close_requested", close_requested)
	
	init_online()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func init_online() -> void:
	for user in users:
		var user_label = Label.new()
		user_label.text = user
		users[user][1] = user_label
		if users[user][0]:
			var i = offline_label.get_index()
			user_list.add_child(user_label)
			user_list.move_child(offline_label, i + 1)
		else:
			user_list.add_child(user_label)


func check_online() -> void:
	pass

func close_requested() -> void:
	queue_free()
