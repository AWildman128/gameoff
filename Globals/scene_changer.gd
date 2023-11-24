extends Node

@onready var transition = ColorRect.new()
@onready var tween = self.get_tree().create_tween()


func _ready():
	transition.color = Color(0,0,0,0)
	transition.set_anchors_preset(Control.PRESET_FULL_RECT)
	self.add_child(transition)
	

func change_scene(target):
	get_tree().change_scene_to_packed(target)
