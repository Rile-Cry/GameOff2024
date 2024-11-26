extends ObjectButton
class_name ObjectResourceButton

@export var resource : Resource
@export var type : GameManager.resource_type

func _process(delta: float) -> void:
	super(delta)
	
	if not disabled:
		if GameManager:
			match type:
				GameManager.resource_type.CLUE:
					if GameManager.clues.has(resource):
						disable()
				GameManager.resource_type.LOCATION:
					if GameManager.unlocked_locations.has(resource):
						disable()

func _pressed() -> void:
	match type:
		GameManager.resource_type.CLUE:
			GameManager.obtain_clue(resource)
		GameManager.resource_type.PHOTO:
			GameManager.obtain_photo(resource)
		GameManager.resource_type.LOCATION:
			GameManager.unlock_location(resource)
