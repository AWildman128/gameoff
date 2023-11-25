extends Area2D
class_name SceneChangeComponent

@export var unlock_floor: int
@export var world: PackedScene

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")


func _ready():
	self.connect("body_entered", _on_area_2d_body_entered)


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if world:
			LevelManager.change_scene(world)
			save_data.floors[unlock_floor] = true
