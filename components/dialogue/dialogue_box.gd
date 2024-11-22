extends Control

const USE_SIGNALS = false

@export var ink_file : Resource
@export var title: String
@export var bind_externals: Dictionary = {}

var ink_player = InkPlayerFactory.create()
var choice_container : VBoxContainer
var tick := 0
var typing := false

@onready var dialogue := $PanelContainer/MarginContainer/VBoxContainer/Text
@onready var name_box := $PanelContainer2/MarginContainer/Name
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
		if typing:
			typing = false
		else:
			_continue_story()


func _continue_story():
	if USE_SIGNALS:
		ink_player.continue_story()
	else:
		if ink_player.can_continue:
			var text = ink_player.continue_story()
			_change_label(text)
		elif ink_player.has_choices:
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
	
	_bind_externals()
	_continue_story()


func _change_label(text):
	text = _grab_speaker(text)
	
	_type_out_text(text)


func _type_out_text(text: String) -> void:
	var temp_string = ""
	typing = true
	for letter in text:
		if not typing:
			break
		await GameGlobals.wait(1. / GameGlobals.typing_speed)
		temp_string += letter
		dialogue.text = temp_string
	dialogue.text = text


func _prompt_choices(choices):
	var i = 0
	choice_container = VBoxContainer.new()
	for choice in choices:
		var button := ChoiceButton.new()
		button.text = _grab_speaker(choice.text)
		button.id = i
		choice_container.add_child(button)
		button.connect("_choice_selected", _choice_selected)
		i += 1
	choice_container.set_anchors_preset(Control.PRESET_CENTER)
	choice_container.grow_horizontal = BoxContainer.GROW_DIRECTION_BOTH
	get_tree().root.add_child(choice_container)

func _ended():
	# End of story
	queue_free()


func _choice_selected(index):
	choice_container.queue_free()
	choice_container = null
	
	ink_player.choose_choice_index(index)
	_continue_story()


func _override_story():
	if ink_file != null:
		ink_player.ink_file = ink_file


func _observe_variables(variable_name, new_value) -> void:
	bind_externals[variable_name] = new_value


func _bind_externals():
	## This is where external variables that are within the ink_story should be
	## referenced.
	var externals := []
	for variable in bind_externals.keys():
		externals.append(variable)
	if externals.is_empty():
		return
	
	ink_player.observe_variables(externals, self, "_observe_variables")
