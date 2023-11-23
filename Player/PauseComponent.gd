extends Node

@onready var pause_menu = $"../UI/PauseMenu"

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
		
