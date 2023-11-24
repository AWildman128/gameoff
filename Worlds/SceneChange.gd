extends Area2D
class_name SceneChangeComponent

@export var world: PackedScene


func _ready():
	self.connect("body_entered", _on_area_2d_body_entered)


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if world:
			LevelManager.change_scene(world)
