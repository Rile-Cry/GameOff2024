extends Actor
class_name ActorFinale

@export var clue_invalid_dialogue : String
@export var clue_dialogue : LocationClueInteract
@export var verdict_reaction : String

var verdict_reaction_texture : Texture2D
var clue : Clue
var pressed : bool = false
var selected : bool = false

signal clue_selected
signal verdict_selected(name : String)

func _ready() -> void:
	super()
	_button.pressed.connect(select_actor)
	UIManager.get_mission_book().clue_selected.connect(_clue_selected)
	#verdict_reaction_texture = ResourceLoader.load(GameManager.actor_address[dialogue_res.actor_name] + verdict_reaction + ".png")
	GameManager.turnabout.connect(react_to_verdict)

func react_to_verdict():
	update_actor(verdict_reaction_texture)

func select_actor():
	if pressed:
		selected = not selected
		#verdict_selected.emit(dialogue_res.actor_name)

func _start_dialogue(dialogue : String, idx : int = 0) -> void:
	super(dialogue, idx)
	await GlobalGameEvents.dialogue_ended
	if GameManager:
		GameManager.enable_input = true
		if not GameManager.get_global_variable("is_pressing"):
			return
	
	if UIManager:
		UIManager.can_open_mission_book = true
		UIManager.mission_book_clue_lock()
	
	await clue_selected
	if GameManager:
		GameManager.enable_input = false
	
	if UIManager:
		UIManager.can_open_mission_book = false
	
	if clue_dialogue.clue == clue:
		super(clue_dialogue.dialogue_res, 0)
		await GlobalGameEvents.dialogue_ended
		pressed = true
	else:
		super(clue_invalid_dialogue, 0)
	GameManager.enable_input = true

func _process(delta: float) -> void:
	if selected:
		outline_enable()
		return
	super(delta)

func _start_dialogue_actor():
	if not pressed:
		super()

func _dialogue_ended():
	super()
	_button.disabled = pressed

func _clue_selected(_clue : Clue):
	clue = _clue
	clue_selected.emit()
