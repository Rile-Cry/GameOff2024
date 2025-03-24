class_name HardwareDetector

#region Information classes
class GraphicQualityPreset:
	var description: String = ""
	var quality: Array[GraphicQualityDisplay]
	
	func _init(_description:String, _quality: Array[GraphicQualityDisplay] = []) -> void:
		description = _description
		quality = _quality


class GraphicQualityDisplay:
	var project_setting: String = ""
	var property_name: String = ""
	var enabled: int = 0
	var available_text: String = ""
	
	func _init(_project_setting:  String, _property_name: String, _enabled: int, _available_text: String) -> void:
		project_setting = _project_setting
		property_name = _property_name
		enabled = _enabled
		available_text = _available_text
#endregion

static var engine_version: String = "Godot %s" % Engine.get_version_info().string
static var device: String = OS.get_model_name()
static var platform: String = OS.get_name()
static var distribution_name: String = OS.get_distribution_name()
static var video_adapter_name: String = RenderingServer.get_video_adapter_name()
static var processor_name: String = OS.get_processor_name()
static var processor_count: int = OS.get_processor_count() 
static var usable_threads: int = processor_count * 2 # I assume that each core has 2 threads
static var computer_screen_size: Vector2i = DisplayServer.screen_get_size()


static func is_multithreading_enabled() -> bool:
	return ProjectSettings.get_setting("rendering/driver/threads/thread_model") == 2


static func is_exported_release() -> bool:
	return OS.has_feature("template")


static func is_mobile() -> bool:
	if not OS.has_feature("web"):
		return false
	
	return OS.get_name() == "Android" or OS.get_name() == "iOS" \
		or (is_web() and OS.has_feature("web_android")) or (is_web() and OS.has_feature("web_ios")) \
		or JavaScriptBridge.eval("/Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent)", true)
		

static func is_windows() -> bool:
	return OS.get_name() == "Windows" or (is_web() and OS.has_feature("web_windows"))


static func is_linux() -> bool:
	return OS.get_name() in ["Linux", "FreeBSD", "NetBSD", "OpenBSD", "BSD"] or (is_web() and OS.has_feature("web_linuxbsd"))
	
		
static func is_mac() -> bool:
	return OS.get_name() == "macOS" or (is_web() and OS.has_feature("web_macos"))


static func is_web() -> bool:
	return OS.has_feature("Web")
