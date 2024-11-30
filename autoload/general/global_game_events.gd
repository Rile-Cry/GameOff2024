extends Node

#region Narrative
signal dialogue_started
signal dialogue_ended
signal shake(type : int)
signal exclaim
signal res_obtain(res_path: String, type : GameManager.resource_type)
#endregion

func _ready() -> void:
	res_obtain.connect(_res_obtain)

func _res_obtain(res_path: String, type : GameManager.resource_type):
	var res : Resource = load(res_path)
	if res and GameManager:
		GameManager.stack_resources(res, type)
