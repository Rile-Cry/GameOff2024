extends Node
class_name GameBase

@onready var level_base : Node = $LevelBase
const tutorial_popup_path : String = "res://scenes/UI/popup/tutorial_popup.tscn"
const start_location_path : String = "res://Case/Locations/Shade's Office.tres"
var shake_power : float = 0.0
var node : Control
var all_clues : bool = false

func _ready() -> void:
	if LoadScreen:
		LoadScreen.show()
	
	if GameManager:
		GameManager.game_base = self
		if not GameManager.load_game():
			GameManager.unlock_location(load(start_location_path), false)
			GameManager.current_location_index = 0
			await LoadScreen.loading_finish
			if UIManager and GameManager.has_past_attempt():
				var tutorial_popup : PackedScene = load(tutorial_popup_path)
				UIManager.add_child(tutorial_popup.instantiate())
	
	if UIManager:
		UIManager.can_open_mission_book = true
		UIManager.refresh_mission_book()
		UIManager.get_mission_book().clue_selected.connect(clue_selected)
	
	GlobalGameEvents.shake.connect(screen_shake)

func clue_selected(clue : Clue):
	if UIManager and not UIManager.get_mission_book().clue_locked:
		for child in level_base.get_children():
			if child is LocationScene:
				child = child as LocationScene
				
				if await child._get_clue_location(clue):
					return
	
		var dialogue_scene : DialogueBox = GameManager.create_dialogue(GameManager.invalid_clue_dialogue_path)
		UIManager.add_child(dialogue_scene)

func _process(delta: float) -> void:
	if shake_power > 0 and is_instance_valid(node):
		shake_power = lerpf(shake_power, 0, 4 * delta)
		node.position = random_offset(Vector2.ZERO)
	else:
		shake_power = 0
	
	if LoadScreen and LoadScreen.is_loading:
		return
	
	if UIManager:
		for child in UIManager.get_children():
			if child is TutorialPopup or child.name == "FinalGuessPopup" or child.name == "AllCluesPopup":
				return
	
	if GameManager:
		if not all_clues and GameManager.get_global_variable("all_clues"):
			UIManager.add_child(GameManager.all_clues_popup.instantiate())
			all_clues = true
			
		GameManager.game_time += delta
		

func change_level(level : PackedScene) -> void:
	for child in level_base.get_children():
		child.queue_free()
	
	var level_instance := level.instantiate()
	level_base.add_child(level_instance)

func random_offset(origin : Vector2) -> Vector2:
	return origin + Vector2(randf_range(-shake_power, shake_power), randf_range(-shake_power, shake_power))

func screen_shake(type : int) -> void:
	node = level_base.get_child(0, false)
	var shake_sfx : String = "Screen Shake"
	match type:
		1: 
			shake_sfx = "Screen Shake Aggressive"
			shake_power = 20.0
		_:
			shake_power = 10.0
	if SfxAudio:
		SfxAudio.play_audio(shake_sfx)
	
