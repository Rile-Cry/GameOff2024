extends Control
class_name LocationScene

@export var opening_dialogue : DialogueRes
@export var clue_interact : Array[LocationClueInteract]
@export var bgm : String
@export var ambiance : String
@export var instant_meet : bool = true

@onready var actor : Actor = $Actor
@onready var dialogue_interact : DialogueRes = actor.dialogue_res

func _dialogue_started() -> void:
	if GameManager:
		GameManager.enable_input = false

func _dialogue_ended() -> void:
	if GameManager:
		GameManager.enable_input = true
	
	if actor.dialogue_res != dialogue_interact:
		actor.dialogue_res = dialogue_interact

func _get_clue_location(clue : Clue) -> bool:
	for location_clue : LocationClueInteract in clue_interact:
		if location_clue.clue == clue:
			if location_clue.conditional_variable and GameManager.get_global_variable(location_clue.variable_name):
				return false

			actor._start_dialogue(location_clue.dialogue_res, 0)
			return true
	
	return false

func _ready() -> void:
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)
	
	actor.hide()
	
	if opening_dialogue:
		if GameManager and GameManager.get_global_variable("met_" + opening_dialogue.actor_name) == null:
			GameManager.set_global_variable("met_" + opening_dialogue.actor_name, instant_meet)
			for idx : int in opening_dialogue.dialogue.size():
				GameManager.enable_input = false
				await dialogue_start_action(idx)
				actor._start_dialogue(opening_dialogue, idx)
				await GlobalGameEvents.dialogue_ended
			GameManager.enable_input = true
	actor.show()
	if BgmAudio and not bgm.is_empty():
		BgmAudio.play_audio(bgm)
	if AmbientAudio and not ambiance.is_empty():
		AmbientAudio.play_audio(ambiance)

func dialogue_start_action(_idx : int):
	return
