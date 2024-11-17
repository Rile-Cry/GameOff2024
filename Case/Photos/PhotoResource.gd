extends Resource
class_name Photo

@export var name : String
@export var time : String
@export var description : String

@export var photo_texture : Texture2D
@export var location_texture : Texture2D
@export var glitched : bool = false
@export var is_location : bool = true
@export var scene : PackedScene