extends PhotoScene

func _ready() -> void:
	super()
	if BgmAudio:
		BgmAudio.play_audio("Evelyn Photo")

func clues_cleared():
	print("Cleared")
	super()
