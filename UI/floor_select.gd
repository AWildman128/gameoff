@tool
extends Button
class_name LevelButton

@onready var ui_theme = preload("res://Assets/ui_theme.tres")

@export var world: PackedScene : set = set_world


# Called when the node enters the scene tree for the first time.
func _ready():
	self.theme = ui_theme
	self.connect("pressed", pressed)


func pressed():
	print("Entering Level")
	print(world)
	self.get_tree().change_scene_to_packed(world)


func set_world(w: PackedScene):
	world = w
	
	var new_world = w.instantiate()
	var world_name: String
	
	world_name = new_world.name
	
	self.text = world_name
