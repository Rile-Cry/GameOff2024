extends Window


@onready var button := $PanelContainer/VBoxContainer/Button
@onready var text := $PanelContainer/VBoxContainer/LineEdit

const all_resources : Dictionary = {
	"res://Case/Clues/Evelyn's Art Studio/Personal Diary.tres" : "Clue",
	"res://Case/Clues/Marina’s Apartment/Receipt.tres" : "Clue",
	"res://Case/Clues/Victor's Office/Shredded Paper.tres" : "Clue",
	"res://Case/Locations/Interrogation Room.tres" : "Location"
}



func _ready() -> void:
	connect("close_requested", _close)
	button.connect("pressed", _check_code)


func _check_code() -> void:
	match text.text:
		"secretcode":
			print("Oh no, you found our secret . . . shame on you -_-")
		"allclues":
			for resource : String in all_resources:
				match all_resources[resource]:
					"Clue": await GameManager.obtain_clue(load(resource), false)
					"Location": await GameManager.unlock_location(load(resource), false)
					"Photo": await GameManager.obtain_photo(load(resource), false)
			
			var email_loc : Dictionary = GameManager.get_global_variable("email_locations")
			
			if email_loc["Urgent Update on the Evelyn Blake Case"]:
				email_loc.erase("Urgent Update on the Evelyn Blake Case")
				GameManager.set_global_variable("email_locations", email_loc)
			
			UIManager.open_close_computer()
			GameManager.set_global_variable("all_clues", true)
		_:
			print("That's not a correct code, now is it.")


func _close() -> void:
	queue_free()
