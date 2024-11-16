extends Control

const title : PackedScene = preload("res://scenes/UI/Title.tscn")

func switch_to_title():
	get_tree().change_scene_to_packed(title)
