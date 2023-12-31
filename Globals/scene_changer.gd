extends Node

@onready var transition: AnimationPlayer = preload("res://Globals/Transition.tscn").instantiate()
@onready var tween = self.get_tree().create_tween()

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")

func _ready():
	save_data.floors[0] = true
	
	self.add_child(transition)
	

func change_scene(target):
	transition.play("ExitLevel")
	await transition.animation_finished
	get_tree().change_scene_to_packed(target)
	transition.play("EnterLevel")
