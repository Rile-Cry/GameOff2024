extends Node

#region Narrative
signal dialogue_started
signal dialogue_ended
signal dialogue_ended_
signal exclaim
signal shake(type : int)
signal scene_loaded
signal res_obtain(res_path: String, type : GameManager.resource_type)
#endregion

var dialogue_ended_check_bool : bool = false

func _ready() -> void:
	res_obtain.connect(_res_obtain)
	exclaim.connect(_exclaim)
	dialogue_ended_.connect(dialogue_ended_check)

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

func _exclaim():
	if SfxAudio:
		SfxAudio.play_audio("Exclaim")
	
	if UIManager:
		UIManager.anim_player.play("Exclaim")

func _res_obtain(res_path: String, type : GameManager.resource_type):
	var res : Resource = load(res_path)
	if res and GameManager:
		GameManager.stack_resources(res, type)
