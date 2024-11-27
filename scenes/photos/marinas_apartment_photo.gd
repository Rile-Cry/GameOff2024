extends PhotoScene

@export var popup_container : Control

@export_category("desk")
@export var desk : ObjectButton
@export var desk_popup : Control
@export var calender : ObjectButton

@export_category("drawer")
@export var drawer : ObjectButton
@export var drawer_closed_popup : Control
@export var drawer_opened_popup : Control

@export_category("lock")
@export var lock : ObjectButton
@export var lock_popup : Control
@export var lock_button : ObjectButton
@export var lock_numbers : Array[LockNumber]

var lock_number_sequence : Array[int] = []

func _ready() -> void:
	super()
	
	desk.pressed.connect(desk_popup_show)
	drawer.pressed.connect(drawer_popup_show)
	calender.pressed.connect(flip_calender)
	lock.pressed.connect(lock_popup_show)
	lock_button.pressed.connect(unlock_drawer)
	
	for lock_number : LockNumber in lock_numbers:
		lock_number_sequence.append(lock_number.correct_value)
	
	close_popup()
	
	if BgmAudio:
		BgmAudio.play_audio("Marina Photo")

func _process(_delta: float) -> void:
	desk.visible = not popup_container.visible
	drawer.visible = not popup_container.visible

func _unhandled_input(event: InputEvent) -> void:
	if not (UIManager and UIManager.get_mission_book().visible):
		if GameManager and GameManager.enable_input:
			if event.is_action_pressed("ui_cancel"):
				close_popup_sfx()
		
func flip_calender():
	var stylebox : StyleBoxTexture = calender.get_theme_stylebox("normal")
	stylebox.region_rect.position.x += stylebox.region_rect.size.x
	
	if stylebox.region_rect.position.x >= stylebox.texture.get_width():
		stylebox.region_rect.position.x = 0

func clues_cleared():
	print("Cleared")
	super()

func lock_popup_show():
	close_popup()
	popup_container.show()
	lock_popup.show()
	if UIManager:
		UIManager.can_open_option = false

func unlock_drawer():
	for idx : int in lock_number_sequence.size():
		if lock_numbers[idx].value != lock_number_sequence[idx]:
			return
	
	GameManager.set_global_variable("drawer_open", true)
	drawer_popup_show()

func desk_popup_show():
	await close_popup()
	popup_container.show()
	desk_popup.show()
	if UIManager:
		UIManager.can_open_option = false
		print(desk_popup.visible)

func drawer_popup_show():
	await close_popup()
	popup_container.show()
	if GameManager and GameManager.get_global_variable("drawer_open"):
		drawer_opened_popup.show()
	else:
		drawer_closed_popup.show()
	if UIManager:
		UIManager.can_open_option = false

func close_popup_sfx():
	if SfxAudio:
		SfxAudio.play_audio("UI Open Close")
	
	close_popup()

func close_popup():
	popup_container.hide()
	desk_popup.hide()
	drawer_opened_popup.hide()
	drawer_closed_popup.hide()
	lock_popup.hide()
	if UIManager:
		UIManager.can_open_option = true
