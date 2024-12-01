class_name DialogueBox extends Control

#region Variables
var _actors := { # For holding onto who's currently in the scene
	"Lucas": false,
	"Victor": false,
	"Marina": false,
}
var _actor_ref := {} # Referencing the actor nodes
var _choice_container : VBoxContainer # Holds onto the choices for dialogue
var _externals: Dictionary = { # The variables within the dialogue files
	"mood": "normal",
	"speaker": "Shade"
}
var _variables: Dictionary = {}
var _initialized := false # Determines if the scene is initialized or not
var _ink_file : InkResource # The dialogue file to read from
var _ink_player : InkPlayer = InkPlayerFactory.create() # The ink_player to actually run dialogue
var _title: String # The name of the dialogue
var _typing := false # If the dialogue is still typing or not

#endregion

# Node References
@onready var _dialogue := $TextContainer/MarginContainer/ScrollContainer/Text
@onready var _name_box := $SpeakerContainer/MarginContainer/Name

#region Public Functions
## Sets up the dialogue box for the scene, making sure the values are initialized
## before actually declaring _ready.
## @param file_name: The name of the Dialogue found in components/dialogue/..
## @param args: Any additional arguments found within a specific Dialogue file.
func setup(file_name: String, mood: String, args: Dictionary) -> void:
	_ink_file = ResourceLoader.load(
		"res://components/dialogue/" + file_name + ".ink.json",
		"InkResource")
	_title = file_name
	for arg in args:
		_variables[arg] = args[arg]
	_initialized = true
	_externals["mood"] = mood
#endregion

#region Private Functions
func _get_tags():
	var tags : Array = _ink_player.get_current_tags()
	for idx : int in tags.size():
		var tag : String = tags[idx - 1]
		match tag:
			"shake": GlobalGameEvents.shake.emit(0)
			"shake_aggressive": GlobalGameEvents.shake.emit(1)
			"exclaim": GlobalGameEvents.exclaim.emit()
			"Photo":
				get_resource(tags[idx], GameManager.resource_type.PHOTO)
			"Location":
				get_resource(tags[idx], GameManager.resource_type.LOCATION)

func get_resource(path : String, res_type : GameManager.resource_type):
	if not path.contains("res://"):
		path = "res://" + path
	
	GlobalGameEvents.res_obtain.emit(path, res_type)


func _override_story():
	if _ink_file != null:
		_ink_player.ink_file = _ink_file

## Called when the ink_player has loaded in successfully
func _loaded(successfully: bool):
	if !successfully:
		return
	
	# Set variables
	print(_variables)
	for key in _variables:
		_ink_player.set_variable(key, _variables[key])
	
	_bind_externals()
	_bind_variables()
	_continue_story()

func _bind_externals():
	## This is where external variables that are within the ink_story should be
	## referenced.
	var externals := []
	for variable in _externals.keys():
		externals.append(variable)
	if externals.is_empty():
		return
	
	_ink_player.observe_variables(externals, self, "_observe_variables")

func _bind_variables():
	## This is where external variables that are within the ink_story should be
	## referenced.
	var variables := []
	for variable in _variables.keys():
		variables.append(variable)
	if variables.is_empty():
		return
	
	_ink_player.observe_variables(variables, self, "_observe_variables")

func _observe_variables(variable_name, new_value) -> void:
	if _externals.has(variable_name):
		_externals[variable_name] = new_value
	elif _variables.has(variable_name):
		_variables[variable_name] = new_value
		if GameManager.get_global_variable(variable_name) != null:
			GameManager.set_global_variable(variable_name, new_value)

## Continues the [member _ink_player] so that it moves to the next line of dialogue
func _continue_story() -> void:
	if _ink_player.can_continue:
		var text : String = _ink_player.continue_story()
		_change_label(text)
		_get_tags()
	elif _ink_player.has_choices:
		_prompt_choices(_ink_player.current_choices)
	else:
		_ended()

## Both sends the text to be seperated from speaker and then changes the text
## in the actual text box.
func _change_label(text):
	#_name_box.text = _externals["speaker"]
	#if _actors.has(_name_box.text):
	#	_update_actor(_name_box.text)
	text = _grab_speaker(text)
	
	_type_out_text(text)

func _grab_speaker(text: String) -> String:
	_name_box.text = _externals["speaker"]
	
	if _actors.has(_name_box.text):
		_update_actor(_name_box.text)
		
	#if text.contains(":"):
	#	var actor_name := text.get_slice(":", 0)
	#	_name_box.text = actor_name
	#	if _actors.has(actor_name):
	#		_update_actor(actor_name)
	#	
	#	return text.get_slice(":", 1)
	
	return text

func _update_actor(actor_name: String) -> void:
	var tex_address : String = GameManager.actor_address[actor_name] + _externals["mood"] + ".png"
	var texture : Texture2D
	if ResourceLoader.exists(tex_address):
		texture = ResourceLoader.load(tex_address, "Texture2D")
	else:
		texture = ResourceLoader.load(GameManager.actor_address[actor_name] + "normal.png", "Texture2D")
	_actor_ref[actor_name].update_actor(texture)
	
func _type_out_text(text: String) -> void:
	visible = true
	var temp_string := ""
	_typing = true
	for letter in text:
		if not _typing:
			break
		await GameGlobals.wait(1. / GameGlobals.typing_speed)
		temp_string += letter
		_dialogue.text = temp_string
	_dialogue.text = text

## The choice system used with the dialogue box, grabs all the choices one-by-one
## and then procedurally generates the buttons and associates them with the 
func _prompt_choices(choices):
	var i := 0
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

func _choice_selected(index):
	_choice_container.queue_free()
	_choice_container = null
	
	_ink_player.choose_choice_index(index)
	if GameGlobals.dialogue_choices.has(_title):
		GameGlobals.dialogue_choices[_title].append(index)
	else:
		GameGlobals.dialogue_choices[_title] = [index]
	_continue_story()

func _ended():
	queue_free()
#endregion

func _notification(what: int) -> void:
	if what == NOTIFICATION_PREDELETE:
		GlobalGameEvents.dialogue_ended_.emit()

#region Node Functions
func _ready() -> void:
	visible = false
	if _initialized:
		_ink_player.loads_in_background = true
		add_child(_ink_player)
		
		_override_story()
		_ink_player.connect("loaded", Callable(self, "_loaded"))
		
		_ink_player.create_story()
		
		GlobalGameEvents.dialogue_started.emit()
		
		for actor in get_tree().get_nodes_in_group("actors"):
			if actor.visible:
				_actor_ref[actor.dialogue_res.actor_name] = actor
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
#endregion
