class_name NoteWindow
extends Window

@export var ink_file : InkResource
var ink_player = InkPlayerFactory.create()
var running := true

@onready var container := $PanelContainer/MarginContainer/ScrollContainer/VBoxContainer

func _ready() -> void:
	ink_player.loads_in_background = true
	add_child(ink_player)
	ink_player.ink_file = ink_file
	ink_player.connect("loaded", Callable(self, "update"))
	ink_player.create_story()

func update(successfully: bool) -> void:
	var i = 0
	while running:
		if ink_player.can_continue:
			var text = ink_player.continue_story()
			_add_button(text)
		elif ink_player.has_choices:
			#var choice = GameGlobals.dialogue_choices[title][i]
			ink_player.choose_choice_index([0, 1, 3][i])
			i += 1
		else:
			running = false


func _add_button(text: String) -> void:
	var button = Button.new()
	container.add_child(button)
	button.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	button.autowrap_mode = TextServer.AUTOWRAP_WORD
	button.text_overrun_behavior = 3
	button.text = text
