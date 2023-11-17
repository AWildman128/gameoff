extends Node
class_name GravityComponent

@export var entity: CharacterBody2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not entity.is_on_floor():
		entity.velocity.y += 20
	else:
		entity.velocity.y = 0

	entity.move_and_slide()
