extends AudioStreamPlayer

@export var overlap : bool = false

# Called when the node enters the scene tree for the first time.
func play_audio(audio_name : String, volume_db_ : float = 0.0):
	volume_db = volume_db_
	
	if overlap or self["parameters/switch_to_clip"] != audio_name:
		self["parameters/switch_to_clip"] = audio_name
		play()
	
