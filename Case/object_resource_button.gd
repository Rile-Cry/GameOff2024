@tool
extends Button
class_name ObjectResourceButton

@export var resource : Resource
@export var type : GameManager.resource_type

func _pressed() -> void:
	match type:
		GameManager.resource_type.CLUE:
			GameManager.obtain_clue(resource)
		GameManager.resource_type.LOCATION:
			GameManager.unlock_location(resource)
