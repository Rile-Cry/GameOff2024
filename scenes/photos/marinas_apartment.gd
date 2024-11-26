extends PhotoScene

@export var popup_container : Control

@export_category("desk")
@export var desk : ObjectButton
@export var desk_popup : Control
@export var calender : ObjectButton

@export_category("lock")
@export var lock : ObjectButton
@export var lock_popup : Control

func _ready() -> void:
	super()
	
	desk.pressed.connect(desk_popup_show)
	lock.pressed.connect(lock_popup_show)
	calender.pressed.connect(flip_calender)
	close_popup()
	
	if BgmAudio:
		BgmAudio.play_audio("Marina Photo")

func _unhandled_input(event: InputEvent) -> void:
	if not (UIManager and UIManager.get_mission_book().visible):
		if GameManager and GameManager.enable_input and event.is_action_pressed("ui_cancel"):
			close_popup_sfx()

func flip_calender():
	var stylebox : StyleBoxTexture = calender.get_theme_stylebox("normal")
	stylebox.region_rect.position.x += stylebox.region_rect.size.x
	
	if stylebox.region_rect.position.x >= stylebox.texture.get_width():
		stylebox.region_rect.position.x = 0

func clues_cleared():
	print("Cleared")
	super()

func desk_popup_show():
	popup_container.show()
	desk_popup.show()
	lock_popup.hide()
	if UIManager:
		UIManager.can_open_option = false

func lock_popup_show():
	popup_container.show()
	desk_popup.hide()
	lock_popup.show()
	if UIManager:
		UIManager.can_open_option = false

func close_popup_sfx():
	if SfxAudio:
		SfxAudio.play_audio("UI Open Close")
	
	close_popup()

func close_popup():
	popup_container.hide()
	desk_popup.hide()
	lock_popup.hide()
	if UIManager:
		UIManager.can_open_option = true
