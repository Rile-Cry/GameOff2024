extends Node

var mission_book : MissionBook
var game_base : GameBase
var final_verdict : Array[String] = []
const real_suspects : Array[String] = ["Victor", "Marina"]

var clues : Array[Clue]
var unlocked_locations : Array[Location]
var enable_input : bool = false
var photos : Array[Photo]
var global_variables : Dictionary = {
	"t_notes" : [],
	"p_notes" : "",
	"email_locations" : {
		"Urgent Update on the Evelyn Blake Case" : [
			"res://Case/Locations/Interrogation Room.tres",
			"res://Case/Locations/Victor's Office.tres"
		]
	},
	"all_clues": false,
	"tossed_out": false,
	"lucas_victor": false,
}
var actor_address := {
	"Lucas": "res://assets/imports/graphics/characters/Lucas Rivers/lucas_",
	"Victor": "res://assets/imports/graphics/characters/Victor Thorne/victor_",
	"Marina": "res://assets/imports/graphics/characters/Marina Thorne/marina_"
}

var game_time : float = 0.0

const behind_bars_scene : PackedScene = preload("res://scenes/ending/BehindBarsScene.tscn")
const good_ending_scene : PackedScene =  preload("res://scenes/ending/GoodEnding.tscn")
const bad_ending_scene : PackedScene =  preload("res://scenes/ending/BadEnding.tscn")

const glitch_obj_material : ShaderMaterial = preload("res://scenes/UI/main/GlitchObjtres.tres")
const outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")
const found_popup : PackedScene = preload("res://scenes/UI/popup/found_popup.tscn")
const delete_save_popup : PackedScene = preload("res://scenes/UI/popup/delete_save_popup.tscn")
const save_popup : PackedScene = preload("res://scenes/UI/popup/save_popup.tscn")
const clue_popup : PackedScene = preload("res://scenes/UI/popup/clue_popup.tscn")
const time_popup : PackedScene = preload("res://scenes/UI/popup/time_popup.tscn")
const all_clues_popup : PackedScene = preload("res://scenes/UI/popup/all_clues_popup.tscn")
const final_guess_popup : PackedScene = preload("res://scenes/UI/popup/final_guess_popup.tscn")
const interactable_indicator_popup : PackedScene = preload("res://scenes/interactable_indicator.tscn")
const _dialogue_scene : PackedScene = preload("res://components/dialogue/dialogue_box.tscn")
const title_scene : PackedScene = preload("res://scenes/UI/main/Title.tscn")
const invalid_clue_dialogue_path : String = "base/InvalidClue"
const credits_scene : PackedScene = preload("res://scenes/UI/credits.tscn")
const finale_actors : PackedScene = preload("res://scenes/finale_actors.tscn")

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

const final_variable_name : Dictionary = {
	"The Turnabout Case" : [
		"EvelynArtStudio_all_clues",
		"LucasInterrogationFinish",
		"MarinaApartment_all_clues"
	]
}

signal popup_closed
signal turnabout

func _ready():
	LoadScreen.scene_loading_finish.connect(change_scene)

func change_scene(scene : PackedScene):
	if game_base: game_base.change_level(scene)
	GlobalGameEvents.scene_loaded.emit()

func create_dialogue(file_name: String, mood : String = "", args: Dictionary = {}) -> DialogueBox:
	var dialogue_box : DialogueBox = _dialogue_scene.instantiate() as DialogueBox
	dialogue_box.setup(file_name, mood, args)
	return dialogue_box

func stack_resources(res : Resource, type : resource_type):
	var stack_res : Dictionary = {
		"path": res.resource_path,
		"type": type
	}
	set_global_variable("stacked_resource", stack_res, -2)

func is_all_true(case : String) -> void:
	print("is_all_true: ", case)
	for var_name : String in final_variable_name[case]:
		if not get_global_variable(var_name):
			return
	
	set_global_variable("all_clues", true)

func get_global_variable(key : String, idx : int = -1):
	if global_variables.has(key):
		if idx == -1:
			return global_variables[key]
		elif global_variables[key] is Array:
			var length : int = global_variables[key].size()
			if idx == -2:
				return global_variables[key][length - 1]
			elif idx < length:
				return global_variables[key][idx]
			else:
				push_warning(key + " has no index: " + str(idx))
				return null
	
	push_warning("No variable with key: " + key)
	return null

func set_global_variable(key : String, value, idx : int = -1):
	if idx == -1:
		global_variables[key] = value
	else:
		if global_variables.has(key) and global_variables[key] is Array:
			if idx == -2:
				global_variables[key].append(value)
			elif idx < global_variables[key].size():
				global_variables[key][idx] = value
		elif idx == -2:
			global_variables[key] = [value]
		else:
			push_warning("Invalid index: " + str(idx))

func remove_global_variable(key : String, idx : int = -1):
	if global_variables.has(key):
		if idx == -1:
			global_variables.erase(key)
		elif global_variables[key] is Array:
			var length : int = global_variables[key].size()
			if idx == -2:
				global_variables[key].remove_at(length - 1)
			elif idx < length:
				global_variables[key].remove_at(idx)
			else:
				push_warning(key + " has no index: " + str(idx))
	else:
		push_warning("No variable with key: " + key)

func add_resource_from_stack():
	var obtained : bool
	if not get_global_variable("stacked_resource"): return
	var stacked_resource : Array = get_global_variable("stacked_resource")
	
	for res : Dictionary in stacked_resource:
		match res["type"]:
			resource_type.CLUE:
				obtained = await obtain_clue(load(res["path"]))
			resource_type.PHOTO:
				obtained = await obtain_photo(load(res["path"]))
			resource_type.LOCATION:
				obtained = await unlock_location(load(res["path"]))
			
	global_variables["stacked_resource"].clear()

func resource_popup(res : Resource, type : resource_type):
	if UIManager:
		var popup_node : FoundPopup = found_popup.instantiate()
		popup_node.obj_name = res.name
		popup_node.obj_desc = res.description
		popup_node.obj_icon = res.texture
		popup_node.title = type
		UIManager.add_child(popup_node)
		await popup_node.popup_closed
		popup_closed.emit()

func obtain_photo(photo : Photo, popup : bool = true) -> bool:
	if not photos.has(photo):
		if popup and found_popup:
			resource_popup(photo, resource_type.PHOTO)
			await popup_closed
		
		photos.append(photo)
		if UIManager: UIManager.refresh_mission_book()
		
		return true
	
	push_warning("Photo already obtained!")
	return false

func obtain_clue(clue : Clue, popup : bool = true) -> bool:
	if not clues.has(clue):
		if popup and found_popup:
			resource_popup(clue, resource_type.CLUE)
			await popup_closed
		
		clues.append(clue)
		if UIManager: UIManager.refresh_mission_book()
		
		return true
	
	push_warning("Clue already found!")
	return false

func unlock_location(location : Location, popup : bool = true):
	if not unlocked_locations.has(location):
		
		if popup and found_popup:
			resource_popup(location, resource_type.LOCATION)
			await popup_closed
		
		unlocked_locations.append(location)
		if UIManager: UIManager.refresh_mission_book()
		
		return true
	
	push_warning("Location already unlocked!")
	return false

func save_game() -> void:
	var save_file : FileAccess = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	
	var location_path : Array[String]
	var location_lock : Array[bool]
	var photo_path : Array[String]
	var clue_path : Array[String]
	
	for location : Location in unlocked_locations:
		location_path.append(location.resource_path)
		location_lock.append(location.disabled)
	for photo : Photo in photos: photo_path.append(photo.resource_path)
	for clue : Clue in clues: clue_path.append(clue.resource_path)
	
	var save_dict : Dictionary = {
		"CurrentLocation" : current_location_index,
		"UnlockedLocations" : location_path,
		"LocationLock" : location_lock,
		"Photos" : photo_path,
		"Clues" : clue_path,
		"GlobalVariables" : global_variables,
		"Time" : game_time
	}
	var json_string : String = JSON.stringify(save_dict)
	save_file.store_line(json_string)
	if UIManager and save_popup:
		var popup_node : PopupNode = save_popup.instantiate()
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
	
	var location_path : Array = save_data["UnlockedLocations"]
	var location_lock : Array = save_data["LocationLock"]
	var photo_path : Array = save_data["Photos"]
	var clue_path : Array = save_data["Clues"]
	
	for idx : int in location_path.size():
		var loc_res : Location = load(location_path[idx])
		loc_res.disabled = location_lock[idx]
		unlocked_locations.append(loc_res)
	
	for photo : String in photo_path: photos.append(load(photo))
	for clue : String in clue_path: clues.append(load(clue))
	
	global_variables = save_data["GlobalVariables"]
	game_time = save_data["Time"]
	current_location_index = save_data["CurrentLocation"]
	return true

func get_verdict() -> bool:
	for real_suspect : String in GameManager.real_suspects:
		if not GameManager.final_verdict.has(real_suspect):
			return false
	
	for suspect : String in GameManager.final_verdict:
		if not GameManager.real_suspects.has(suspect):
			return false
	return true

func get_ending():
	if UIManager:
		UIManager.anim_player.play_backwards("black_bar")
	get_tree().change_scene_to_packed(behind_bars_scene)

func get_save():
	return FileAccess.file_exists("user://savegame.save")

func delete_save():
	DirAccess.remove_absolute("user://savegame.save")

func has_past_attempt() -> bool:
	if not DirAccess.dir_exists_absolute("user://attempts"):
		DirAccess.make_dir_absolute("user://attempts")
	var dir : DirAccess = DirAccess.open("user://attempts")
	return true

func record_attempt(succeed : bool):
	var time_popup_scene : PopupNode = time_popup.instantiate()
	time_popup_scene.succeed = succeed
	await get_tree().change_scene_to_packed(title_scene)
	if UIManager:
		UIManager.add_child(time_popup_scene)
	
	if not DirAccess.dir_exists_absolute("user://attempts"):
		DirAccess.make_dir_absolute("user://attempts")
	var dir : DirAccess = DirAccess.open("user://attempts")

	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		if dir.current_is_dir():
			print("Found directory: " + file_name)
		else:
			print("Found file: " + file_name)
		file_name = dir.get_next()
	
	if not FileAccess.file_exists("user://attempts/savegame.save"): return false
