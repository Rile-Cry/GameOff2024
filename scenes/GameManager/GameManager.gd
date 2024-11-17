extends Node

var current_case : Case
var mission_book : MissionBook
var game_base : GameBase:
	get:
		return game_base
	set(value):
		game_base = value
		change_scene(office)
		
var clues : Array[Clue]
var scenes_to_preload : Array[String] = [
	"res://scenes/locations/Shade's Office.tscn",
	"res://scenes/UI/found_popup.tscn"
]
var enable_input : bool = false
var office : PackedScene = preload("res://scenes/locations/Shade's Office.tscn")
var outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")
var found_popup : PackedScene = preload("res://scenes/UI/found_popup.tscn")

func _init() -> void:
	current_case = load("res://Case/case_1.tres")

func change_scene(scene : PackedScene):
	if game_base: game_base.change_level(scene)

func obtain_clue(clue : Clue, popup : bool = true):
	if not clues.has(clue):
		clues.append(clue)
	
		if popup and found_popup:
			var popup_node : FoundPopup = found_popup.instantiate()
			popup_node.obj_name = clue.name
			popup_node.obj_desc = clue.description
			popup_node.obj_icon = clue.icon
			UIManager.add_child(popup_node)
		
		if UIManager:
			UIManager.refresh_mission_book()
	else:
		push_warning("Clue already found!")
