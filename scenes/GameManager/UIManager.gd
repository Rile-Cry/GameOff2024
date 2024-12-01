extends CanvasLayer
var is_hovering_mission_book : bool = false
var can_open_option : bool = true
var can_open_mission_book : bool = false
var bad_ending : bool = false

@onready var anim_player : AnimationPlayer = $AnimationPlayer

signal confirm_final_verdict

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%MissionBook.hide()
	%OptionMenu.hide()
	%Computer.hide()
	%Credits.hide()
	%MissionBookButton.hide()
	%Vignette.hide()
	%FinalVerdict.hide()
	$DisableInputRect.hide()
	
	%MissionBookButton.pressed.connect(open_close_mission_book)
	%CreditCloseButton.pressed.connect(open_close_credits)
	%FinalVerdict.pressed.connect(_confirm_final_verdict)
	GlobalGameEvents.connect("dialogue_started", _dialogue_started)
	GlobalGameEvents.connect("dialogue_ended", _dialogue_ended)

func _confirm_final_verdict():
	confirm_final_verdict.emit()

func mission_book_clue_lock():
	%MissionBook.clue_locked = not %MissionBook.clue_locked
	if not %MissionBook.visible:
		open_close_mission_book()

func refresh_mission_book():
	%MissionBook.refresh_photos()
	%MissionBook.refresh_clues()
	%MissionBook.refresh_locations()

func _process(_delta: float) -> void:
	if not bad_ending:
		if %MissionBook.visible and %MissionBook.glitched:
			$DisableInputRect.show()
			bad_ending = true
			GameManager.enable_input = false
			anim_player.play("black_bar", -1, 0.5)
			await anim_player.animation_finished
			anim_player.play("Glitch Screen")
			$DisableInputRect.hide()
			%MissionBook.unglitch_mission_book()
			GameManager.record_attempt(false)
	if bad_ending:
		return
	
	if GameManager:
		var mission_book_bool : bool = can_open_mission_book and GameManager.enable_input
		
		%MissionBookButton.visible = mission_book_bool
		
		if GameManager.enable_input:
			if %MissionBook.visible and not can_open_mission_book:
				open_close_mission_book()
			
			if %MissionBookButton.is_hovered() and %MissionBookButton.is_hovered() != is_hovering_mission_book:
				SfxAudio.play_audio("Book Hover")
		else:
			if %MissionBook.visible:
				open_close_mission_book()
			if %Credits.visible:
				open_close_credits()
			if %Computer.visible:
				open_close_computer()
			if %OptionMenu.visible:
				open_close_options()
			
	
	is_hovering_mission_book = %MissionBookButton.is_hovered()

func _input(event: InputEvent) -> void:
	if anim_player.is_playing() and event.is_action_pressed("ui_accept"):
		anim_player.speed_scale = 2
	elif event.is_action_released("ui_accept"):
		anim_player.speed_scale = 1
	
	if GameManager.enable_input and event.is_action_pressed("ui_cancel"):
		if %MissionBook.visible:
			open_close_mission_book()
		elif %Credits.visible:
			open_close_credits()
		elif can_open_option:
			open_close_options()

func enable_disable_mission_book_button():
	%MissionBookButton.visible = not %MissionBookButton.visible

func show_shader(shader_name : String):
	match shader_name:
		"vignette": %Vignette.show()

func hide_shader(shader_name : String):
	match shader_name:
		"vignette": %Vignette.hide()

func open_close_options() -> void:
	%OptionMenu.visible = not %OptionMenu.visible
	SfxAudio.play_audio("UI Open Close")

func open_close_credits() -> void:
	can_open_option = %Credits.visible
	%Credits.visible = not %Credits.visible
	SfxAudio.play_audio("UI Open Close")

func open_close_computer() -> void:
	for child in %Computer.get_children():
		if child is Window:
			child.queue_free()
	can_open_option = %Computer.visible
	%Computer.visible = not %Computer.visible
	if %Computer.visible:
		#%Computer.update_notes()
		AmbientAudio.play_audio("OS Boot")
	else:
		AmbientAudio.play_audio(GameManager.current_location.name)

func open_close_mission_book():
	enable_disable_mission_book_button()
	can_open_option = %MissionBook.visible
	%MissionBook.visible = not %MissionBook.visible
	if %MissionBook.visible:
		SfxAudio.play_audio("Book Open")
		%MissionBook.update_notes()
	else:
		SfxAudio.play_audio("Book Close")

func update_final_verdict_button():
	if GameManager:
		%FinalVerdict.visible = not GameManager.final_verdict.is_empty()

func get_mission_book_button() -> Button:
	return %MissionBookButton

func get_options() -> Control:
	return %OptionMenu

func get_credits() -> Control:
	return %Credits

func get_computer() -> Control:
	return %Computer

func get_mission_book() -> MissionBook:
	return %MissionBook

func _dialogue_started() -> void:
	%MissionBookButton.visible = false
	%MissionBook.visible = false

func _dialogue_ended() -> void:
	%MissionBookButton.visible = true
