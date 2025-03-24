## Here lives the common translation keys to use across the scenes
#########
#This is the notification structure if we want to dynamically changed translations in runtime:

#func _notification(what: int) -> void:
	#if what == NOTIFICATION_TRANSLATION_CHANGED:
		#if not is_node_ready():
			#await ready
#
		#YOUR TRANSLATION HERE
#########


class_name TranslationKeys
	
static var NoTranslationKey: String = "GENERAL_NO"
static var YesTranslationKey: String = "GENERAL_YES"

static var AudioTabTranslationKey: String = "AUDIO_TAB"
static var ScreenTabTranslationKey: String = "SCREEN_TAB"
static var GraphicsTabTranslationKey: String = "GRAPHICS_TAB"
static var GeneralTabTranslationKey:= "GENERAL_TAB"
static var ControlsTabTranslationKey: String = "CONTROLS_TAB"

static var DeuteranopiaTranslationKey: String = "DALTONISM_DEUTERANOPIA"
static var ProtanopiaTranslationKey: String = "DALTONISM_PROTANOPIA"
static var TritanopiaTranslationKey: String = "DALTONISM_TRITANOPIA"
static var AchromatopsiaTranslationKey: String = "DALTONISM_ACHROMATOPSIA"

static var WindowModeWindowedTranslationKey: String = "SCREEN_MODE_WINDOWED"
static var WindowModeBorderlessTranslationKey: String = "SCREEN_MODE_BORDERLESS"
static var WindowModeFullScreenTranslationKey: String = "SCREEN_MODE_FULLSCREEN"
static var WindowModeExclusiveFullScreenTranslationKey: String = "SCREEN_MODE_EXCLUSIVE_FULLSCREEN"


static var DaltonismKeys: Dictionary = {
	WindowManager.DaltonismTypes.No: NoTranslationKey,
	WindowManager.DaltonismTypes.Protanopia: ProtanopiaTranslationKey,
	WindowManager.DaltonismTypes.Deuteranopia: DeuteranopiaTranslationKey,
	WindowManager.DaltonismTypes.Tritanopia: TritanopiaTranslationKey,
	WindowManager.DaltonismTypes.Achromatopsia: AchromatopsiaTranslationKey,
}
