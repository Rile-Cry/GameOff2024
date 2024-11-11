extends Resource
class_name Case

@export var name : String
@export var photos : Array[Photo] = []
@export var suspects : Array[String] = []

func get_photo(idx : int) -> Photo:
	return photos[idx]

func get_photo_scene(idx : int) -> PackedScene:
	var location : Photo = get_photo(idx)
	if location.is_location:
		return location.scene
	return null

func set_case_name(name_new : String) -> void:
	name = name_new
	
func get_case_name() -> String:
	return name
