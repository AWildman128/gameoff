extends Node

@export var input_type = KBM

enum {
	KBM,
	CONTROLLER
}

func _input(event):
	if(event is InputEventKey):
		input_type = KBM
	elif(event is InputEventJoypadButton):
		input_type = CONTROLLER
	elif(event is InputEventMouseButton):
		input_type = KBM
	
	if Input.is_action_just_pressed("fullscreen"):
		swap_fullscreen_mode()

func swap_fullscreen_mode():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
