extends Control
class_name LocationScene

@export var opening_dialogue : DialogueRes
@export var clue_interact : Array[LocationClueInteract]
@export var bgm : String
@export var ambiance : String

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
	if opening_dialogue:
		if GameManager and not GameManager.get_global_variable("met_" + opening_dialogue.actor_name):
			GameManager.set_global_variable("met_" + opening_dialogue.actor_name, true)
			actor.next_line.connect(print_next)
			for idx : int in opening_dialogue.dialogue.size():
				actor._start_dialogue(opening_dialogue.dialogue[idx])
				await GlobalGameEvents.dialogue_ended
				await dialogue_start_action(idx)
		
	if BgmAudio and not bgm.is_empty():
		BgmAudio.play_audio(bgm)
	if AmbientAudio and not ambiance.is_empty():
		AmbientAudio.play_audio(ambiance)

func print_next(text : String, tags):
	print("text: ", text)
	print("tags: ", text)

func dialogue_start_action(idx : int):
	return
