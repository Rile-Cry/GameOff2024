extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%MissionBook.visible = false
	%OptionMenu.visible = false
	%Computer.visible = false
	
	%MissionBookButton.pressed.connect(open_close_mission_book)

func refresh_mission_book():
	%MissionBook.refresh_photos()
	%MissionBook.refresh_clues()

func _input(event: InputEvent) -> void:
	if GameManager.enable_input and event.is_action_pressed("ui_cancel"):
		if %MissionBook.visible:
			%MissionBook.tab_container.current_tab = 0
			open_close_mission_book()
		elif not %Computer.visible:
			open_close_options()

func enable_disable_mission_book_button():
	%MissionBookButton.visible = not %MissionBookButton.visible

func open_close_options() -> void:
	%OptionMenu.visible = not %OptionMenu.visible

func open_close_computer() -> void:
	%Computer.visible = not %Computer.visible

func open_close_mission_book():
	enable_disable_mission_book_button()
	%MissionBook.visible = not %MissionBook.visible

func get_mission_book_button() -> Button:
	return %MissionBookButton

func get_options() -> Control:
	return %OptionMenu

func get_computer() -> Control:
	return %Computer

func get_mission_book() -> MissionBook:
	return %MissionBook
