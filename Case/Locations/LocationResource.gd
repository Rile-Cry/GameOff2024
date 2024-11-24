extends Resource
class_name Location

@export var name : String
@export var characters : Array[String]
@export var description : String

@export var texture : Texture2D
@export var texture_icon : Texture2D
@export_file("*.tscn") var scene_path : String
