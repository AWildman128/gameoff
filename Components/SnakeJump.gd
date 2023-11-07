extends Node
class_name SnakeJumpComponent

@export var player: CharacterBody2D
@export_range(1,10, 0.1) var strength: float


func _physics_process(delta):
	if not player.is_on_floor():
		player.velocity.y += 30
	else:
		player.velocity.x = lerp(player.velocity.x, 0.0, 0.3)
	
	if Input.is_action_just_pressed("l_click") and player.is_on_floor():
		var direction = player.global_position.direction_to(player.get_global_mouse_position())
		var distance = player.global_position.distance_to(player.get_global_mouse_position())
		distance = clamp(distance, 10, 60)
		
		player.velocity = direction * strength * 60
	elif Input.is_action_just_released("l_click") and not player.is_on_floor() and player.velocity.y < 0:
		player.velocity = lerp(player.velocity, Vector2.ZERO, 0.5)
		
	player.move_and_slide()
