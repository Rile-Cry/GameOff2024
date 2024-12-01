extends ObjectButton
class_name DialogueButton

@export var dialogue : DialogueRes

func _pressed() -> void:
	super()
	GameManager.enable_input = false
	var dialogue_box : DialogueBox = GameManager.create_dialogue(dialogue.location_name + "/" + dialogue.dialogue[0], dialogue.initial_mood)
	if UIManager:
		UIManager.add_child(dialogue_box)
		if GlobalGameEvents:
			await GlobalGameEvents.dialogue_ended

	GameManager.enable_input = true
	
