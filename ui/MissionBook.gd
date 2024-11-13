extends Control
class_name MissionBook

@export_category("Base")

@export var tab_container : TabContainer

@export_category("Buttons")

@export var open_b : Button
@export var close_b : Button

@export_category("Tabs")
@export var photo_container : GridContainer
@export var clues_container : GridContainer

var is_open = false
var photo_list : Array[Photo]

func _ready():
	open_b.button_down.connect(open_close)
	close_b.button_down.connect(open_close)
	self.visible = false
	GameManager.set_mission_book(self)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		tab_container.current_tab = 0
		open_close()

func refresh():
	# Photos
	for node in photo_container.get_children():
		node.queue_free()
	
	# Clues
	for node in clues_container.get_children():
		node.queue_free()
	
	
	if GameManager.current_case:
		# Photos
		photo_list = GameManager.current_case.photos
		for photo in photo_list:
			var photo_node : PhotoNode = PhotoNode.new()
			photo_node.photo_res = photo
			photo_container.add_child(photo_node)
		
		for photo in photo_list:
			var photo_node : PhotoNode = PhotoNode.new()
			photo_node.photo_res = photo
			clues_container.add_child(photo_node)

func open_close():
	is_open = not is_open
	self.visible = is_open
	open_b.visible = not is_open
