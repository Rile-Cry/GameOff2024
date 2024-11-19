extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func play_audio(audio_name : String):
	self["parameters/switch_to_clip"] = audio_name
	play()
	
