extends Control
class_name MissionBook

@export_category("Base")

@export var tab_container : TabContainer

@export_category("Buttons")

@export var close_b : Button

@export_category("Photos")
@export var photo_locked : bool = false :
	set(val):
		photo_locked = val
		photo_lock_container.visible = photo_locked
		photo_unlock_container.visible = not photo_locked

@export var photo_lock_container : MarginContainer
@export var photo_unlock_container : MarginContainer

@export var photo_container : GridContainer
@export var photo_texture : TextureRect
@export var photo_label : RichTextLabel

@export var photo_locked_button : Button

const photo_label_text : String = "[b]<photo_name>[/b]

Time Taken: [i]<photo_time>[/i]

<photo_desc>"
var current_photo : Photo

@export_category("Clues")
@export var clue_container : GridContainer
@export var clue_texture : TextureRect
@export var clue_label : RichTextLabel
var current_clue : Clue
const clue_label_text : String = "[b]<clue_name>[/b]

Found in <clue_location>

<clue_desc>"

func _ready():
	close_b.button_down.connect(close)
	tab_container.tab_selected.connect(page_change)
	self.hide()
	
	photo_lock_container.visible = photo_locked
	photo_unlock_container.visible = not photo_locked
	photo_locked_button.pressed.connect(exit_photo)
	
func page_change(_tab : int):
	SfxAudio.play_audio("Book Turn")

func refresh_photos():
	for node in photo_container.get_children():
		node.queue_free()
	
	if GameManager.current_case:
		for photo in GameManager.current_case.photos:
			var photo_node : MissionBookNode = MissionBookNode.new()
			photo_node.is_hovering.connect(update_photo_info)
			photo_node.is_not_hovering.connect(refresh_photo_info)
			photo_node.pressed.connect(photo_jump)
			photo_node.resource = photo
			photo_container.add_child(photo_node)

func update_photo_info(photo : Photo):
	current_photo = photo
	var text : String = photo_label_text
	text = text.replace("<photo_name>", current_photo.name)
	text = text.replace("<photo_time>", current_photo.time)
	text = text.replace("<photo_desc>", current_photo.description)

	photo_label.text = text
	photo_texture.texture = current_photo.texture_location

func refresh_photo_info(photo : Photo):
	if current_photo == photo:
		photo_label.text = ""
		photo_texture.texture = null
		current_photo = null

func refresh_clues():
	for node in clue_container.get_children():
		node.queue_free()
	
	if GameManager.clues:
		for clue in GameManager.clues:
			var clue_node : MissionBookNode = MissionBookNode.new()
			clue_node.is_hovering.connect(update_clue_info)
			clue_node.is_not_hovering.connect(refresh_clue_info)
			clue_node.resource = clue
			clue_container.add_child(clue_node)

func update_clue_info(clue : Clue):
	current_clue = clue
	var text : String = clue_label_text
	text = text.replace("<clue_name>", current_clue.name)
	text = text.replace("<clue_location>", current_clue.location)
	text = text.replace("<clue_desc>", current_clue.description)
	
	clue_label.text = text
	clue_texture.texture = current_clue.texture

func refresh_clue_info(clue : Clue):
	if current_clue == clue:
		clue_label.text = ""
		clue_texture.texture = null
		current_clue = null

func close():
	if UIManager:
		UIManager.open_close_mission_book()

func photo_jump():
	if GameManager and not GameManager.is_inside_photo:
		var path : String = current_photo.scene_path
		enter_exit_photo(path)

func exit_photo():
	if GameManager and GameManager.is_inside_photo:
		var path : String = GameManager.current_location_path
		enter_exit_photo(path)

func enter_exit_photo(path : String):
	if self.visible: UIManager.open_close_mission_book()
	if GameManager:
		GameManager.is_inside_photo = not GameManager.is_inside_photo
		photo_locked = GameManager.is_inside_photo
	
	if LoadScreen:
		LoadScreen.load_scene(path)
	
