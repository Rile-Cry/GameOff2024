extends PopupNode
class_name CluePopup

@export var texture : TextureRect

var clue : Clue

func _ready() -> void:
	if clue:
		texture.texture = clue.texture_icon
		$AnimationPlayer.play("open")
		await $AnimationPlayer.animation_finished
		popup_opened.emit()
	else:
		popup_opened.emit()
		popup_closed.emit()
		queue_free()

func _input(event: InputEvent) -> void:
	pass
