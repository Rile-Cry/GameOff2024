class_name DialogueBox extends Control

const USE_SIGNALS = false

@export var _ink_file : InkResource
@export var _title: String
@export var _externals: Dictionary = {
	"mood": "normal"
}

var _actors = {
	"Lucas": false,
	"Victor": false,
	"Marina": false,
}
var _actor_ref = {}
var _initialized = false
var _ink_player = InkPlayerFactory.create()
var _choice_container : VBoxContainer
var _typing := false

@onready var _actor_box := $ActorContainer
@onready var _dialogue := $PanelContainer/MarginContainer/VBoxContainer/Text
@onready var _name_box := $PanelContainer2/MarginContainer/Name


func setup(file_name: String, args: Dictionary) -> void:
	_ink_file = ResourceLoader.load("res://components/dialogue/" + file_name + ".ink.json", "InkResource")
	for arg in args:
		_externals[arg] = args[arg]
	_initialized = true


func _ready() -> void:
	if _initialized:
		_ink_player.loads_in_background = true
		add_child(_ink_player)
		
		_override_story()
		
		_ink_player.connect("loaded", Callable(self, "_loaded"))
		
		_ink_player.create_story()
	else:
		print("deferring call...")
		call_deferred("_ready")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		if _typing:
			_typing = false
		else:
			if _choice_container == null:
				_continue_story()


func _continue_story() -> void:
	if USE_SIGNALS:
		_ink_player.continue_story()
	else:
		if _ink_player.can_continue:
			var text = _ink_player.continue_story()
			_change_label(text)
		elif _ink_player.has_choices:
			_prompt_choices(_ink_player.current_choices)
		else:
			_ended()


func _grab_speaker(text: String) -> String:
	if text.contains(":"):
		var actor_name := text.get_slice(":", 0)
		_name_box.text = actor_name
		if _actors.has(actor_name):
			if not _actors[actor_name]:
				_generate_actor(actor_name)
				_actors[actor_name] = true
			else:
				_update_actor(actor_name)
		
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
	_typing = true
	for letter in text:
		if not _typing:
			break
		await GameGlobals.wait(1. / GameGlobals.typing_speed)
		temp_string += letter
		_dialogue.text = temp_string
	_dialogue.text = text


func _prompt_choices(choices):
	var i = 0
	_choice_container = VBoxContainer.new()
	for choice in choices:
		var button := ChoiceButton.new()
		button.text = _grab_speaker(choice.text)
		button.id = i
		_choice_container.add_child(button)
		button.connect("_choice_selected", _choice_selected)
		i += 1
	_choice_container.set_anchors_preset(Control.PRESET_CENTER)
	_choice_container.grow_horizontal = BoxContainer.GROW_DIRECTION_BOTH
	get_tree().root.add_child(_choice_container)

func _ended():
	print(GameGlobals.dialogue_choices[_title])
	queue_free()


func _choice_selected(index):
	_choice_container.queue_free()
	_choice_container = null
	
	_ink_player.choose_choice_index(index)
	if GameGlobals.dialogue_choices.has(_title):
		GameGlobals.dialogue_choices[_title].append(index)
	else:
		GameGlobals.dialogue_choices[_title] = [index]
	_continue_story()


func _override_story():
	if _ink_file != null:
		_ink_player.ink_file = _ink_file


func _observe_variables(variable_name, new_value) -> void:
	_externals[variable_name] = new_value


func _bind_externals():
	## This is where external variables that are within the ink_story should be
	## referenced.
	var externals := []
	for variable in _externals.keys():
		externals.append(variable)
	if externals.is_empty():
		return
	
	_ink_player.observe_variables(externals, self, "_observe_variables")


func _generate_actor(actor_name: String) -> void:
	var texture := TextureRect.new()
	_actor_box.add_child(texture)
	texture.expand_mode = TextureRect.EXPAND_FIT_WIDTH_PROPORTIONAL
	texture.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT
	texture.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
	texture.texture = ResourceLoader.load(GameManager.actor_address[actor_name] + _externals["mood"] + ".png", "Texture2D")
	_actor_ref[actor_name] = texture


func _update_actor(actor_name: String) -> void:
	_actor_ref[actor_name].texture = ResourceLoader.load(GameManager.actor_address[actor_name] + _externals["mood"] + ".png", "Texture2D")
