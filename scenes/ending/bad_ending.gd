extends Control

@onready var tween : Tween = create_tween()
var volume_db : float = -80.0
var tweening : bool = false

func _ready() -> void:
	if UIManager:
		UIManager.get_mission_book().tab_container.current_tab = 1
		UIManager.get_mission_book().glitch_mission_book()
		
	if SfxAudio and SfxAudio.playing:
		SfxAudio.stop()
	if BgmAudio and BgmAudio.playing:
		BgmAudio.stop()
	if AmbientAudio and AmbientAudio.playing:
		AmbientAudio.stop()
	
	GameManager.enable_input = false
	tween.finished.connect(tweening_complete)
	
	tween.tween_property(self, "volume_db", 0.0, 2)
	tween.set_trans(Tween.TRANS_LINEAR)
	if UIManager:
		UIManager.anim_player.play("hide_room")
		await UIManager.anim_player.animation_finished
		UIManager.show_shader("vignette")
		tween.play()
		tweening = true
		UIManager.anim_player.play("fail")
		await UIManager.anim_player.animation_finished
		UIManager.anim_player.play("reveal_room")
		await UIManager.anim_player.animation_finished
		UIManager.can_open_mission_book = true
	GameManager.enable_input = true

func tweening_complete():
	tweening = false

func _process(_delta: float) -> void:
	if AmbientAudio and tweening:
		AmbientAudio.play_audio("Shade's Office", volume_db)
		
