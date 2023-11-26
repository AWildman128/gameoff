extends Node

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")


func _exit_tree():
	ResourceSaver.save(save_data, "res://Globals/SaveData.tres")
