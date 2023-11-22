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
	
	print(input_type)
