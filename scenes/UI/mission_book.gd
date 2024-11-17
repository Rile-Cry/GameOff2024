extends Control
class_name MissionBook

@export_category("Base")

@export var tab_container : TabContainer

@export_category("Buttons")

@export var close_b : Button

@export_category("Photos")
@export var photo_container : GridContainer
@export var photo_texture : TextureRect
@export var photo_label : RichTextLabel
const photo_label_text : String = "[b]<photo_name>[/b]

Time Taken: [i]<photo_time>[/i]

<photo_desc>"
var current_photo : Photo

@export_category("Clues")
@export var clues_container : GridContainer

func _ready():
	close_b.button_down.connect(close)
	tab_container.tab_selected.connect(page_change)
	self.visible = false
	
func page_change(_tab : int):
	SfxAudio.play_sfx("Book Turn")

func refresh_photos():
	for node in photo_container.get_children():
		node.queue_free()
	
	if GameManager.current_case:
		for photo in GameManager.current_case.photos:
			var photo_node : PhotoNode = PhotoNode.new()
			photo_node.is_hovering.connect(update_photo_info)
			photo_node.is_not_hovering.connect(refresh_photo_info)
			photo_node.photo_res = photo
			photo_container.add_child(photo_node)

func update_photo_info(photo : Photo):
	current_photo = photo
	var text : String = photo_label_text
	text = text.replace("<photo_name>", current_photo.name)
	text = text.replace("<photo_time>", current_photo.time)
	text = text.replace("<photo_desc>", current_photo.description)
	
	photo_label.text = text
	photo_texture.texture = photo.location_texture

func refresh_photo_info(photo : Photo):
	if current_photo == photo:
		photo_label.text = ""
		photo_texture.texture = null
		current_photo = null

func refresh_clues():
	for node in clues_container.get_children():
		node.queue_free()
	
	if GameManager.clues:
		for clue in GameManager.clues:
			pass

func close():
	if UIManager:
		UIManager.open_close_mission_book()

func photo_jump(scene : PackedScene):
	if self.visible: UIManager.open_close_mission_book()
	
	GameManager.change_scene(scene)
