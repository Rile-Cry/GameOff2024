extends ObjectButton

func _ready() -> void:
	pressed.connect(open_close_options)
	super()

func open_close_options() -> void:
	if UIManager and GameManager and GameManager.enable_input:
		UIManager.open_close_options()
