extends Node
class_name State

var pause_update = false

signal transition
signal play_animation(animation)

func enter():
	pass

func enter_children():
	for substate in self.get_children():
		if substate is State:
			substate.enter()
			substate.enter_children()
			print(substate.name)

func update(delta):
	pass

func update_children(delta):
	for substate in self.get_children():
		if substate is State:
			substate.update(delta)
			substate.update_children(delta)

func physics_update(delta):
	pass

func physics_update_children(delta):
	for substate in self.get_children():
		if substate is State:
			substate.physics_update(delta)
			substate.physics_update_children(delta)

func exit():
	pass

func exit_children():
	for substate in self.get_children():
		if substate is State:
			substate.exit()
			substate.exit_children()
