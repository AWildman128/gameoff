extends State
class_name GrabbedState

@export var entity: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer


func enter():
	var tween = self.create_tween()
	tween.set_loops()
	tween.tween_property(sprite, "position", Vector2(-2,0), 1).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite, "position", Vector2(2,0), 1).set_trans(Tween.TRANS_SINE)
	animation_player.play("RESET")


func physics_update(delta):
	pass
