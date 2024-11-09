extends Window


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("close_requested", _close_window)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _close_window() -> void:
	queue_free()
