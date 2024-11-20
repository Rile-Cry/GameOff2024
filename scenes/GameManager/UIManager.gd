extends CanvasLayer
var is_hovering_mission_book : bool = false
@onready var anim_player : AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%MissionBook.hide()
	%OptionMenu.hide()
	%Computer.hide()
	%Credits.hide()
	
	%MissionBookButton.pressed.connect(open_close_mission_book)
	%CreditCloseButton.pressed.connect(open_close_credits)

func refresh_mission_book():
	%MissionBook.refresh_photos()
	%MissionBook.refresh_clues()
	%MissionBook.refresh_locations()

func _process(_delta: float) -> void:
	if %MissionBookButton.is_hovered() and %MissionBookButton.is_hovered() != is_hovering_mission_book:
		SfxAudio.play_audio("Object Hover")
	
	is_hovering_mission_book = %MissionBookButton.is_hovered()

func _input(event: InputEvent) -> void:
	if GameManager.enable_input and event.is_action_pressed("ui_cancel"):
		if %MissionBook.visible:
			open_close_mission_book()
		elif %Credits.visible:
			open_close_credits()
		elif not %Computer.visible:
			open_close_options()

func enable_disable_mission_book_button():
	%MissionBookButton.visible = not %MissionBookButton.visible

func open_close_options() -> void:
	%OptionMenu.visible = not %OptionMenu.visible
	SfxAudio.play_audio("UI Open Close")

func open_close_credits() -> void:
	%Credits.visible = not %Credits.visible
	SfxAudio.play_audio("UI Open Close")

func open_close_computer() -> void:
	%Computer.visible = not %Computer.visible
	if %Computer.visible:
		AmbientAudio.play_audio("OS Boot")

func open_close_mission_book():
	enable_disable_mission_book_button()
	%MissionBook.visible = not %MissionBook.visible
	if %MissionBook.visible:
		SfxAudio.play_audio("Book Open")
	else:
		SfxAudio.play_audio("Book Close")

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
