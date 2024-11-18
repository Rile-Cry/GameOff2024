extends Node

var current_case : Case
var mission_book : MissionBook
var game_base : GameBase

var clues : Array[Clue]
var unlocked_locations : Array[Location]
var enable_input : bool = false

var outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")
var found_popup : PackedScene = preload("res://scenes/UI/found_popup.tscn")
var is_inside_photo : bool = false
var current_location : Location:
	set(value):
		current_location = value
		LoadScreen.load_scene(current_location.scene_path)

enum resource_type {
	CLUE,
	PHOTO,
	LOCATION
}

func _init() -> void:
	current_case = load("res://Case/case_1.tres")

func _ready():
	LoadScreen.scene_loading_finish.connect(change_scene)

func change_scene(scene : PackedScene):
	if game_base: game_base.change_level(scene)

func obtain_clue(clue : Clue, popup : bool = true):
	if not clues.has(clue):
		clues.append(clue)
	
		if popup and found_popup:
			var popup_node : FoundPopup = found_popup.instantiate()
			popup_node.obj_name = clue.name
			popup_node.obj_desc = clue.description
			popup_node.obj_icon = clue.texture
			popup_node.title = resource_type.CLUE
			UIManager.add_child(popup_node)
		
		if UIManager:
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
			UIManager.add_child(popup_node)
		
		if UIManager:
			UIManager.refresh_mission_book()
	else:
		push_warning("Clue already found!")
	
