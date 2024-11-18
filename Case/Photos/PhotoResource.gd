extends Resource
class_name Photo

@export var name : String
@export var time : String
@export var description : String

@export var texture_icon : Texture2D
@export var texture_location : Texture2D
@export var glitched : bool = false
@export var is_location : bool = true
@export_file("*.tscn") var scene_path : String
