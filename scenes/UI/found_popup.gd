extends Control
class_name FoundPopup

@export_category("Control Nodes")
@export var title_label : RichTextLabel
@export var icon_texture : TextureRect
@export var name_label : RichTextLabel
@export var description_label : RichTextLabel
@export var close_b : Button

@export_category("Object Variables")
@export var title : title_type
@export var obj_name : String = "name"
@export var obj_desc : String = "description"
@export var obj_icon : Texture2D

enum title_type {
	CLUE,
	PHOTO,
	LOCATION
}

const title_text : Array[String] = [
	"Clue Found",
	"Obtained a Photo",
	"New Location Unlocked"
]

const center : String = "[center]"
const bold : String = "[b]"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	title_label.text = center + bold + title_text[title]
	name_label.text = center + obj_name
	description_label.text = obj_desc
	icon_texture.texture = obj_icon
	
	close_b.pressed.connect(close)
	close_b.disabled = true
	$AnimationPlayer.play("open")
	await $AnimationPlayer.animation_finished
	close_b.disabled = false

func close():
	close_b.disabled = true
	$AnimationPlayer.play_backwards("open")
	await $AnimationPlayer.animation_finished
	queue_free()
