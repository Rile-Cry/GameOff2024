extends Node

#region Narrative
signal dialogue_started
signal dialogue_ended
signal exclaim
signal shake(type : int)
signal scene_loaded
signal res_obtain(res_path: String, type : GameManager.resource_type)
#endregion

func _ready() -> void:
	res_obtain.connect(_res_obtain)
	exclaim.connect(_exclaim)

func _exclaim():
	if SfxAudio:
		SfxAudio.play_audio("Exclaim")
	
	if UIManager:
		UIManager.anim_player.play("Exclaim")

func _res_obtain(res_path: String, type : GameManager.resource_type):
	var res : Resource = load(res_path)
	if res and GameManager:
		GameManager.stack_resources(res, type)
