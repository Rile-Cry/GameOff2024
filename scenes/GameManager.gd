extends Node

var current_case : Case
var mission_book : MissionBook
var game_base : GameBase
var clues : Array[Clue]

func _init() -> void:
	current_case = load("res://Case/case_1.tres")

func set_mission_book(node : MissionBook):
	mission_book = node
	mission_book.refresh_photos()
	mission_book.refresh_clues()

func change_scene(scene : PackedScene):
	if mission_book.is_open: mission_book.open_close()
	
	if game_base: game_base.change_level(scene)

func obtain_clue(clue : Clue):
	clues.append(clue)
	if mission_book:
		mission_book.refresh_clues()
