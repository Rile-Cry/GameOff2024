extends Control
class_name LocationScene

@export var clue_interact : Array[LocationClueInteract]

@onready var actor : Actor = $Actor
@onready var dialogue_interact : DialogueRes = actor.dialogue_res

func _dialogue_started() -> void:
	if GameManager:
		GameManager.enable_input = false
	
	if UIManager and UIManager.get_mission_book_button().visible:
		UIManager.enable_disable_mission_book_button()

func _dialogue_ended() -> void:
	if GameManager:
		GameManager.enable_input = false
	
	if UIManager and not UIManager.get_mission_book_button().visible:
		UIManager.enable_disable_mission_book_button()
	
	if actor.dialogue_res != dialogue_interact:
		actor.dialogue_res = dialogue_interact

func _get_clue_location(clue : Clue) -> void:
	for location_clue : LocationClueInteract in clue_interact:
		if location_clue.clue == clue:
			actor.dialogue_res = location_clue.dialogue_res
			actor._start_dialogue()

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	UIManager.get_mission_book().connect("clue_selected", _get_clue_location)