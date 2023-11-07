extends Node
class_name StateMachine

@export var initial_states: Array[State]

var current_states: Array[State]
var states: Dictionary = {}


func _ready():
	for state in get_children():
		if state is State:
			states[state.name.to_lower()] = state
			state.transition.connect(on_child_transitioned)
	
	for state in initial_states:
		current_states.append(state)
	
	if current_states:
		for state in current_states:
			state.enter()


func _process(delta):
	if current_states:
		#print(current_states)
		for state in current_states:
			state.update(delta)
			state.update_children(delta)


func _physics_process(delta):
	if current_states:
		for state in current_states:
			state.physics_update(delta)
			state.physics_update_children(delta)


func on_child_transitioned(state: State, new_state_name: String, replace: bool = true):
	if state not in current_states:
		return
	elif state in current_states and replace:
		state.exit()
		print(state.name + " exited")
		current_states.erase(state)
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	print(new_state.name + " entered")
	new_state.enter()
	current_states.append(new_state)
