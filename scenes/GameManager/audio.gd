extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func play_audio(play_audio : String):
	self["parameters/switch_to_clip"] = play_audio
	play()
	
