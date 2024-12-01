extends PhotoScene

func _ready() -> void:
	super()
	if BgmAudio:
		BgmAudio.play_audio("Evelyn Photo")

func clues_cleared():
	if not cleared:
		if GameManager:
			GameManager.set_global_variable("EvelynArtStudio_all_clues", true)
			GameManager.is_all_true("The Turnabout Case")
			super()
