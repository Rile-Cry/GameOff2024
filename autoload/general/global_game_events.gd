extends Node

signal game_loaded(node)

#region Narrative
signal dialogue_started
signal dialogue_ended
signal dialogue_ended_
signal scene_loaded
signal res_obtain(res_path: String, type : GameManager.resource_type)
#endregion

var dialogue_ended_check_bool : bool = false

func _ready() -> void:
	res_obtain.connect(_res_obtain)
	dialogue_ended_.connect(dialogue_ended_check)
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func dialogue_ended_check():
	dialogue_ended_check_bool = true

func _process(_delta: float) -> void:
	if dialogue_ended_check_bool:
		if UIManager:
			for child in UIManager.get_children():
				if child is DialogueBox:
					return
		
		dialogue_ended_check_bool = false
		dialogue_ended.emit()

func _res_obtain(res_path: String, type : GameManager.resource_type):
	var res : Resource = load(res_path)
	if res and GameManager:
		GameManager.stack_resources(res, type)

func _on_timeline_ended() -> void:
	dialogue_ended.emit()
