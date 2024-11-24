extends Control
class_name PhotoScene

var objects : Array[ObjectResourceButton]
var cleared : bool = false

func _ready() -> void:
	for child in get_children():
		if child is ObjectResourceButton:
			objects.append(child)

func _process(_delta: float) -> void:
	if not cleared:
		for object : ObjectResourceButton in objects:
			if not object.disabled:
				return
		
		clues_cleared()

func clues_cleared():
	cleared = true
