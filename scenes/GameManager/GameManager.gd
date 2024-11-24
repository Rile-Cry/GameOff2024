extends Node

var mission_book : MissionBook
var game_base : GameBase

var clues : Array[Clue]
var unlocked_locations : Array[Location]
var enable_input : bool = false
var photos : Array[Photo]
var global_variables : Dictionary

var outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")
var found_popup : PackedScene = preload("res://scenes/UI/found_popup.tscn")
var save_popup : PackedScene = preload("res://scenes/UI/save_popup.tscn")
var interactable_indicator_popup : PackedScene = preload("res://scenes/interactable_indicator.tscn")

var is_inside_photo : bool = false
var current_location_index : int = -1:
	set(val):
		if current_location_index == val:
			push_warning("Player already in location")
			return
		
		if val < 0 or val > unlocked_locations.size():
			push_warning("Location Index is out of bounds")
			return
		
		LoadScreen.load_scene(unlocked_locations[val].scene_path)
		current_location_index = val

var current_location : Location:
	set(val):
		current_location_index = unlocked_locations.find(val)
	get():
		return unlocked_locations[current_location_index]

enum resource_type {
	CLUE,
	PHOTO,
	LOCATION
}

func _ready():
	LoadScreen.scene_loading_finish.connect(change_scene)

func change_scene(scene : PackedScene):
	if game_base: game_base.change_level(scene)

func obtain_clue(clue : Clue, popup : bool = true):
	if not clues.has(clue):
		clues.append(clue)
	
		if UIManager:
			if popup and found_popup:
				var popup_node : FoundPopup = found_popup.instantiate()
				popup_node.obj_name = clue.name
				popup_node.obj_desc = clue.description
				popup_node.obj_icon = clue.texture
				popup_node.title = resource_type.CLUE
				UIManager.add_child(popup_node)
			
			UIManager.refresh_mission_book()
	else:
		push_warning("Clue already found!")

func unlock_location(location : Location, popup : bool = true):
	if not unlocked_locations.has(location):
		unlocked_locations.append(location)
	
		if popup and found_popup:
			var popup_node : FoundPopup = found_popup.instantiate()
			popup_node.obj_name = location.name
			popup_node.obj_desc = location.description
			popup_node.obj_icon = location.texture_location
			popup_node.title = resource_type.LOCATION
			
			if UIManager:
				UIManager.add_child(popup_node)
		
		if UIManager:
			UIManager.refresh_mission_book()
	else:
		push_warning("Clue already found!")

func save_game() -> void:
	var save_file : FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var location_path : Array[String]
	var photo_path : Array[String]
	var clue_path : Array[String]
	
	for location : Location in unlocked_locations: location_path.append(location.resource_path)
	for photo : Photo in photos: photo_path.append(photo.resource_path)
	for clue : Clue in clues: clue_path.append(clue.resource_path)
	
	var save_dict : Dictionary = {
		"CurrentLocation" : current_location_index,
		"UnlockedLocations" : location_path,
		"Photos" : photo_path,
		"Clues" : clue_path,
		"GlobalVariables" : global_variables
	}
	var json_string : String = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	
	if UIManager and save_popup:
		var popup_node : SavePopup = save_popup.instantiate()
		UIManager.add_child(popup_node)

func load_game() -> bool:
	if not FileAccess.file_exists("user://savegame.save"): return false
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var json_string = save_file.get_line()
	
	var json := JSON.new()
	var parse_result := json.parse(json_string)
	if not parse_result == OK:
		push_warning("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
		return false
	
	var save_data : Dictionary = json.data
	
	print(save_data["Photos"])
	
	var location_path : Array = save_data["UnlockedLocations"]
	var photo_path : Array = save_data["Photos"]
	var clue_path : Array = save_data["Clues"]
	
	for location : String in location_path: unlocked_locations.append(load(location))
	for photo : String in photo_path: photos.append(load(photo))
	for clue : String in clue_path: clues.append(load(clue))
	
	global_variables = save_data["GlobalVariables"]
	current_location_index = save_data["CurrentLocation"]
	print("loaded_game")
	return true
	
