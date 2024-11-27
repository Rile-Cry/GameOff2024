extends ObjectButton
class_name LockNumber

@export var correct_value : int
@onready var label : Label = $NumberLabel
var value : int  = 0

func _ready() -> void:
	super()
	label.text = str(value)

func _pressed() -> void:
	super()
	value += 1
	if value > 9:
		value = 0
	
	label.text = str(value)
