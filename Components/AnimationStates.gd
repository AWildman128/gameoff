extends State
class_name AnimationStateMachine

@export var state: State
@export var animation_player: AnimationPlayer


func enter():
	state.play_animation.connect(do_the_thing)


func do_the_thing(animation):
	animation_player.play(animation)
