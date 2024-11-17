extends Control
class_name MissionBook

@export_category("Base")

@export var tab_container : TabContainer

@export_category("Buttons")

@export var close_b : Button

@export_category("Tabs")
@export var photo_container : GridContainer
@export var clues_container : GridContainer

var photo_list : Array[Photo]

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
		photo_list = GameManager.current_case.photos
		for photo in photo_list:
			var photo_node : PhotoNode = PhotoNode.new()
			photo_node.photo_res = photo
			photo_container.add_child(photo_node)

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
