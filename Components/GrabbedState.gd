extends State
class_name GrabbedState

@export var entity: CharacterBody2D
@export var sprite: Sprite2D
@export var animation_player: AnimationPlayer


func enter():
	var tween = self.create_tween()
	tween.set_loops()
	tween.tween_property(sprite, "position", Vector2(-2,0), 0.5).set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite, "position", Vector2(2,0), 0.5).set_trans(Tween.TRANS_SINE)
	animation_player.stop()
	animation_player.play('Grabbed')


func _physics_update(delta):
	entity.move_and_slide()
