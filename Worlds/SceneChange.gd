extends Area2D
class_name SceneChangeComponent

@export var unlock_floor: int
@export var world: PackedScene

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")


func _ready():
	self.connect("body_entered", _on_area_2d_body_entered)
	print(self.get_collision_mask_value(1))
	self.set_collision_mask_value(1, true)

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		if world:
			var tween = get_tree().create_tween()
			tween.tween_property(body, "position", self.get_child(0).global_position, 0.1)
			tween.set_loops()
			
			LevelManager.change_scene(world)
			save_data.floors[unlock_floor] = true
