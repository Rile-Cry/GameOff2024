extends AudioStreamPlayer


# Called when the node enters the scene tree for the first time.
func play_sfx(sfx : String):
	self["parameters/switch_to_clip"] = sfx
	play()
	
