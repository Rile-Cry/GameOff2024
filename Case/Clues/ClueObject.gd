extends Button

@export var clue_object : Clue

func _ready() -> void:
	pressed.connect(obtain_clue)


func obtain_clue() -> void:
	GameManager.obtain_clue(clue_object)
