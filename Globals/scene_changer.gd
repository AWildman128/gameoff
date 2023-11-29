extends Node

@onready var transition: AnimationPlayer = preload("res://Globals/Transition.tscn").instantiate()
@onready var sound_component: SoundComponent = transition.get_node("SoundComponent")
@onready var tween = self.get_tree().create_tween()

@onready var save_data: SaveData = preload("res://Globals/SaveData.tres")

func _ready():
	save_data.floors[0] = true
	
	self.add_child(transition)
	

func change_scene(target):
	transition.play("ExitLevel")
	sound_component.play("Close")
	await transition.animation_finished
	get_tree().change_scene_to_packed(target)
	transition.play("EnterLevel")
	sound_component.play("Open")
	sound_component.play("Ding", false)


func reload_scene():
	transition.play("ExitLevel")
	sound_component.play("Close")
	await transition.animation_finished
	get_tree().reload_current_scene()
	transition.play("EnterLevel")
	sound_component.play("Open")
	sound_component.play("Ding", false)
