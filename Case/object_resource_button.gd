extends ObjectButton
class_name ObjectResourceButton

@export var resource : Resource
@export var type : Genum.ResourceType

func _process(delta: float) -> void:
	super(delta)
	
	if not disabled:
		if GameManager:
			match type:
				Genum.ResourceType.CLUE:
					if GameManager.clues.has(resource):
						disable()
				Genum.ResourceType.LOCATION:
					if GameManager.unlocked_locations.has(resource):
						disable()

func _pressed() -> void:
	match type:
		Genum.ResourceType.CLUE:
			GameManager.obtain_clue(resource)
		Genum.ResourceType.PHOTO:
			GameManager.obtain_photo(resource)
		Genum.ResourceType.LOCATION:
			GameManager.unlock_location(resource)
