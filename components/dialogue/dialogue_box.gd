extends Control

const USE_SIGNALS = false

@export var ink_file : Resource
@export var title: String
@export var bind_externals: bool = false

var ink_player = InkPlayerFactory.create()

@onready var choice_container := $PanelContainer/MarginContainer/HBoxContainer/Dialogue/ChoiceContainer
@onready var dialogue := $PanelContainer/MarginContainer/HBoxContainer/Dialogue/Text
@onready var name_box := $PanelContainer/MarginContainer/HBoxContainer/Profile/Label
@onready var panel := $PanelContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ink_player.loads_in_background = true
	add_child(ink_player)
	
	_override_story()
	
	ink_player.connect("loaded", Callable(self, "_loaded"))
	
	ink_player.create_story()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_continue_story()


func _continue_story():
	if USE_SIGNALS:
		ink_player.continue_story()
	else:
		if ink_player.can_continue:
			var text = ink_player.continue_story()
			_change_label(text)

		if ink_player.has_choices:
			_prompt_choices(ink_player.current_choices)
		else:
			_ended()


func _grab_speaker(text: String) -> String:
	if text.contains(":"):
		name_box.text = text.get_slice(":", 0)
		return text.get_slice(":", 1)
	return text


func _loaded(successfully: bool):
	if !successfully:
		return
	
	_continue_story()


func _change_label(text):
	text = _grab_speaker(text)
	
	dialogue.text = text


func _prompt_choices(choices):
	var i = 0
	for choice in choices:
		var button := ChoiceButton.new()
		button.text = choice.text
		button.id = i
		choice_container.add_child(button)
		button.connect("_choice_selected", _choice_selected)
		i += 1


func _ended():
	# End of story
	pass


func _choice_selected(index):
	for child in choice_container.get_children():
		choice_container.remove_child(child)
	
	ink_player.choose_choice_index(index)
	_continue_story()


func _override_story():
	if ink_file != null:
		ink_player.ink_file = ink_file


func _bind_externals():
	## This is where external variables that are within the ink_story should be
	## referenced.
	if !bind_externals:
		return
