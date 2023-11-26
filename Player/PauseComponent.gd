extends Node
class_name PauseComponent

@export var pause_menu: Control

var paused = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pausemenu()
		
		
func pausemenu():
	if paused:
		pause_menu.hide()
		get_tree().paused = !paused
	else:
		pause_menu.show()
		get_tree().paused = !paused
		
	paused = !paused
		
