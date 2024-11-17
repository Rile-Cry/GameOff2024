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
var office : PackedScene = preload("res://scenes/locations/Office.tscn")
var enable_input : bool = false
var outline_material : ShaderMaterial = preload("res://scenes/UI/main/Outline.tres")

func _init() -> void:
	current_case = load("res://Case/case_1.tres")

func change_scene(scene : PackedScene):
	if game_base: game_base.change_level(scene)

func obtain_clue(clue : Clue):
	clues.append(clue)
	if mission_book:
		mission_book.refresh_clues()
