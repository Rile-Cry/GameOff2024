extends CanvasLayer

var is_loading : bool = false
var path : String

signal scene_loading_finish(scene : PackedScene)

func _ready() -> void:
	hide()

func _process(_delta: float) -> void:
	if is_loading:
		show()
		var progress : Array = []
		var status = ResourceLoader.load_threaded_get_status(path, progress)
		$ColorRect/MarginContainer/ProgressBar.value = progress[0] * 100
		
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var scene : PackedScene = ResourceLoader.load_threaded_get(path)
			is_loading = false
			scene_loading_finish.emit(scene)
			hide()

func load_scene(path_: String):
	path = path_
	ResourceLoader.load_threaded_request(path)
	is_loading = true
