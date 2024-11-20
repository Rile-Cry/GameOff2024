extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func play_audio(audio_name : String, volume_db_ : float = 0.0):
	self["parameters/switch_to_clip"] = audio_name
	volume_db = volume_db_
	play()
	
